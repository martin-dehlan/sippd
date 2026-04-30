-- Phase 2 step 2: route the four cross-user RPCs through public.ratings
-- so personal / group / tasting context flow through one query path.
--
--   drinking_partners  — "people you've tasted with" → group + tasting
--   shared_bottles     — "wines we've both tasted"   → group + tasting
--   taste_match        — "how similar are our tastes" → personal only
--   taste_compass      — "your wine fingerprint"      → personal only
--
-- Region / country / type metadata for taste_match + compass now read
-- from canonical_wine (authoritative) rather than the per-user wines
-- row, so two users with slightly different metadata still bucket the
-- same wine the same way.

-- ── drinking partners ─────────────────────────────────────────────────

create or replace function public.get_top_drinking_partners(
  p_limit int default 5
)
returns table (
  user_id        uuid,
  username       text,
  display_name   text,
  avatar_url     text,
  shared_wines   int
)
language sql
security definer
set search_path = public
stable
as $$
  with my_social as (
    select distinct r.group_id, r.tasting_id, r.canonical_wine_id, r.context
    from public.ratings r
    where r.user_id = auth.uid()
      and r.context in ('group','tasting')
  ),
  partner_social as (
    select distinct r.user_id, r.group_id, r.tasting_id, r.canonical_wine_id, r.context
    from public.ratings r
    where r.user_id <> auth.uid()
      and r.context in ('group','tasting')
  ),
  partner_overlaps as (
    select pc.user_id,
           count(*)::int as shared_wines
    from partner_social pc
    join my_social mc
      on mc.context           = pc.context
     and mc.canonical_wine_id = pc.canonical_wine_id
     and coalesce(mc.group_id::text, '')   = coalesce(pc.group_id::text, '')
     and coalesce(mc.tasting_id::text, '') = coalesce(pc.tasting_id::text, '')
    group by pc.user_id
  )
  select
    po.user_id,
    pr.username,
    pr.display_name,
    pr.avatar_url,
    po.shared_wines
  from partner_overlaps po
  join public.profiles pr on pr.id = po.user_id
  order by po.shared_wines desc, pr.display_name asc nulls last
  limit p_limit;
$$;

grant execute on function public.get_top_drinking_partners(int) to authenticated;

-- ── shared bottles ────────────────────────────────────────────────────

create or replace function public.get_shared_bottles(
  p_other_user_id uuid,
  p_limit         int default 50
)
returns table (
  group_id     uuid,
  wine_id      uuid,
  wine_name    text,
  winery       text,
  region       text,
  country      text,
  type         text,
  vintage      int,
  my_rating    numeric,
  their_rating numeric,
  delta        numeric,
  rated_at     timestamptz
)
language sql
security definer
set search_path = public
stable
as $$
  with my_ratings as (
    select r.group_id, r.tasting_id, r.canonical_wine_id, r.context,
           r.value as my_rating,
           coalesce(r.updated_at, r.created_at) as rated_at
    from public.ratings r
    where r.user_id = auth.uid()
      and r.context in ('group','tasting')
  ),
  their_ratings as (
    select r.group_id, r.tasting_id, r.canonical_wine_id, r.context,
           r.value as their_rating
    from public.ratings r
    where r.user_id = p_other_user_id
      and r.context in ('group','tasting')
  ),
  shared as (
    select
      m.group_id,
      m.canonical_wine_id,
      m.my_rating,
      t.their_rating,
      abs(m.my_rating - t.their_rating)::numeric as delta,
      m.rated_at
    from my_ratings m
    join their_ratings t
      on t.context           = m.context
     and t.canonical_wine_id = m.canonical_wine_id
     and coalesce(t.group_id::text, '')   = coalesce(m.group_id::text, '')
     and coalesce(t.tasting_id::text, '') = coalesce(m.tasting_id::text, '')
  )
  select
    s.group_id,
    -- caller's own wines row for this canonical (for nav). Falls back
    -- to any wines row with this canonical so the result still has
    -- something navigable when the caller doesn't own a personal copy.
    coalesce(
      (select w.id from public.wines w
        where w.canonical_wine_id = s.canonical_wine_id
          and w.user_id = auth.uid()
        limit 1),
      (select w.id from public.wines w
        where w.canonical_wine_id = s.canonical_wine_id
        limit 1)
    ) as wine_id,
    cw.name      as wine_name,
    cw.winery,
    cw.region,
    cw.country,
    cw.type,
    cw.vintage,
    s.my_rating,
    s.their_rating,
    s.delta,
    s.rated_at
  from shared s
  join public.canonical_wine cw on cw.id = s.canonical_wine_id
  order by s.delta desc nulls last, s.rated_at desc nulls last
  limit p_limit;
$$;

grant execute on function public.get_shared_bottles(uuid, int) to authenticated;

-- ── taste compass ─────────────────────────────────────────────────────

create or replace function public.get_taste_compass(
  p_user_id uuid,
  p_top_n   int default 3
)
returns jsonb
language plpgsql
security definer
set search_path = public
stable
as $$
declare
  v_can_view boolean;
  v_result   jsonb;
begin
  v_can_view := (p_user_id = auth.uid()) or exists (
    select 1
    from public.friendships
    where user_id = auth.uid()
      and friend_id = p_user_id
  );

  if not v_can_view then
    return jsonb_build_object(
      'total_count',    0,
      'overall_avg',    null,
      'top_regions',    '[]'::jsonb,
      'top_countries',  '[]'::jsonb,
      'type_breakdown', '[]'::jsonb
    );
  end if;

  with visible as (
    select r.value as rating, cw.type, cw.country, cw.region
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_user_id
      and r.context = 'personal'
      and (
        p_user_id = auth.uid()
        or exists (
          select 1 from public.wines w
          where w.user_id = r.user_id
            and w.canonical_wine_id = r.canonical_wine_id
            and w.visibility <> 'private'
        )
      )
  ),
  totals as (
    select
      count(*)::int                  as total_count,
      round(avg(rating)::numeric, 2) as overall_avg
    from visible
  ),
  regions as (
    select
      region,
      count(*)::int                  as count,
      round(avg(rating)::numeric, 2) as avg_rating
    from visible
    where region is not null
    group by region
    order by count(*) desc, avg(rating) desc
    limit p_top_n
  ),
  countries as (
    select
      country,
      count(*)::int                  as count,
      round(avg(rating)::numeric, 2) as avg_rating
    from visible
    where country is not null
    group by country
    order by count(*) desc, avg(rating) desc
    limit p_top_n
  ),
  types as (
    select
      type,
      count(*)::int                  as count,
      round(avg(rating)::numeric, 2) as avg_rating
    from visible
    where type is not null
    group by type
    order by count(*) desc
  )
  select jsonb_build_object(
    'total_count',    (select total_count from totals),
    'overall_avg',    (select overall_avg from totals),
    'top_regions',    coalesce((select jsonb_agg(r) from regions    r), '[]'::jsonb),
    'top_countries',  coalesce((select jsonb_agg(c) from countries  c), '[]'::jsonb),
    'type_breakdown', coalesce((select jsonb_agg(t) from types      t), '[]'::jsonb)
  )
  into v_result;

  return v_result;
end;
$$;

grant execute on function public.get_taste_compass(uuid, int) to authenticated;

-- ── taste match ───────────────────────────────────────────────────────

create or replace function public.get_taste_match(
  p_other_user_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
stable
as $$
declare
  v_can_view      boolean;
  v_my_count      int;
  v_their_count   int;
  v_overlap_count int;
  v_score         numeric;
  v_confidence    text;
begin
  if p_other_user_id = auth.uid() then
    return jsonb_build_object(
      'score',         null,
      'confidence',    null,
      'overlap_count', 0,
      'my_total',      0,
      'their_total',   0,
      'reason',        'unavailable'
    );
  end if;

  v_can_view := exists (
    select 1
    from public.friendships
    where user_id = auth.uid()
      and friend_id = p_other_user_id
  );

  if not v_can_view then
    return jsonb_build_object(
      'score',         null,
      'confidence',    null,
      'overlap_count', 0,
      'my_total',      0,
      'their_total',   0,
      'reason',        'unavailable'
    );
  end if;

  select count(*) into v_my_count
  from public.ratings
  where user_id = auth.uid()
    and context = 'personal';

  select count(*) into v_their_count
  from public.ratings r
  where r.user_id = p_other_user_id
    and r.context = 'personal'
    and exists (
      select 1 from public.wines w
      where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id
        and w.visibility <> 'private'
    );

  if v_my_count < 5 or v_their_count < 5 then
    return jsonb_build_object(
      'score',         null,
      'confidence',    null,
      'overlap_count', 0,
      'my_total',      v_my_count,
      'their_total',   v_their_count,
      'reason',        'not_enough_ratings'
    );
  end if;

  with mine as (
    select 'region'::text as dim, cw.region as val, r.value as rating
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid()
      and r.context = 'personal'
      and cw.region is not null
    union all
    select 'country', cw.country, r.value
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid()
      and r.context = 'personal'
      and cw.country is not null
    union all
    select 'type', cw.type, r.value
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid()
      and r.context = 'personal'
      and cw.type is not null
  ),
  theirs as (
    select 'region'::text as dim, cw.region as val, r.value as rating
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id
      and r.context = 'personal'
      and cw.region is not null
      and exists (
        select 1 from public.wines w
        where w.user_id = r.user_id
          and w.canonical_wine_id = r.canonical_wine_id
          and w.visibility <> 'private'
      )
    union all
    select 'country', cw.country, r.value
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id
      and r.context = 'personal'
      and cw.country is not null
      and exists (
        select 1 from public.wines w
        where w.user_id = r.user_id
          and w.canonical_wine_id = r.canonical_wine_id
          and w.visibility <> 'private'
      )
    union all
    select 'type', cw.type, r.value
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id
      and r.context = 'personal'
      and cw.type is not null
      and exists (
        select 1 from public.wines w
        where w.user_id = r.user_id
          and w.canonical_wine_id = r.canonical_wine_id
          and w.visibility <> 'private'
      )
  ),
  my_buckets as (
    select dim, val,
           count(*)::int       as cnt,
           avg(rating)::numeric as avg_r
    from mine
    group by dim, val
    having count(*) >= 2
  ),
  their_buckets as (
    select dim, val,
           count(*)::int       as cnt,
           avg(rating)::numeric as avg_r
    from theirs
    group by dim, val
    having count(*) >= 2
  ),
  overlap as (
    select
      least(m.cnt, t.cnt)::numeric as weight,
      abs(m.avg_r - t.avg_r)        as delta
    from my_buckets m
    join their_buckets t
      on m.dim = t.dim
     and m.val = t.val
  ),
  agg as (
    select
      count(*)::int                                   as overlap_count,
      coalesce(sum(weight), 0)::numeric               as total_weight,
      coalesce(sum(delta * weight), 0)::numeric       as weighted_delta_sum
    from overlap
  )
  select
    overlap_count,
    case
      when total_weight > 0 then
        round((1 - weighted_delta_sum / total_weight / 5.0) * 100)
      else null
    end
  into v_overlap_count, v_score
  from agg;

  if v_overlap_count < 3 then
    return jsonb_build_object(
      'score',         null,
      'confidence',    null,
      'overlap_count', v_overlap_count,
      'my_total',      v_my_count,
      'their_total',   v_their_count,
      'reason',        'not_enough_overlap'
    );
  end if;

  if v_overlap_count >= 10 and v_my_count >= 30 and v_their_count >= 30 then
    v_confidence := 'high';
  elsif v_overlap_count >= 5 and v_my_count >= 10 and v_their_count >= 10 then
    v_confidence := 'medium';
  else
    v_confidence := 'low';
  end if;

  v_score := greatest(0, least(100, v_score));

  return jsonb_build_object(
    'score',         v_score,
    'confidence',    v_confidence,
    'overlap_count', v_overlap_count,
    'my_total',      v_my_count,
    'their_total',   v_their_count,
    'reason',        null
  );
end;
$$;

grant execute on function public.get_taste_match(uuid) to authenticated;

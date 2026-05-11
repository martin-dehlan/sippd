-- ============================================================================
-- Unified rating summary + cross-context taste compass / match
-- ============================================================================
-- Pre-launch fix: avg rating + taste personality must reflect the user's full
-- drinking life (personal + group + tasting), not just the personal journal.
--
-- Latest-wins dedup: when the same user rates the same canonical_wine_id in
-- multiple contexts, only the most recently modified rating contributes.
-- Personal wines without canonical_wine_id are counted standalone (no
-- identity key to dedupe on).
--
-- Filters:
--   personal: rating > 0 (0 = "unrated yet" sentinel)
--   tasting:  rating IS NOT NULL, parent state IN ('active','concluded')
--   group:    rating CHECK 0..10 at table level
--
-- Friend-view scope (compass / match): self-view goes unified; friend-view
-- stays personal-only with wines.visibility filter. Reason: group + tasting
-- RLS is scoped to members; bypassing via security definer would leak
-- membership. V2 may add per-context friend visibility.
-- ============================================================================


-- ─── 1. Supporting indexes ────────────────────────────────────────────────

create index if not exists tasting_ratings_user_canonical_idx
  on public.tasting_ratings (user_id, canonical_wine_id);

create index if not exists wines_user_canonical_rated_idx
  on public.wines (user_id, canonical_wine_id, updated_at desc)
  where rating > 0 and canonical_wine_id is not null;


-- ─── 2. get_user_rating_summary ───────────────────────────────────────────
-- Self-only RPC powering the stats screen hero + breakdowns. Returns the
-- deduped, latest-wins aggregate plus context counts for the icon chips.

create or replace function public.get_user_rating_summary(p_user_id uuid)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare v_result jsonb;
begin
  -- Self-only: caller may only request their own summary.
  if p_user_id is null or p_user_id <> auth.uid() then
    return jsonb_build_object(
      'distinct_wine_count', 0,
      'avg_rating', null,
      'personal_count', 0,
      'group_count', 0,
      'tasting_count', 0,
      'by_type', '[]'::jsonb,
      'by_month', '[]'::jsonb,
      'by_country', '[]'::jsonb,
      'by_region', '[]'::jsonb
    );
  end if;

  with
  personal_events as (
    select w.canonical_wine_id,
           w.rating::numeric as value,
           coalesce(w.updated_at, w.created_at) as occurred_at,
           cw.type, cw.country, cw.region,
           'personal'::text as context
    from public.wines w
    join public.canonical_wine cw on cw.id = w.canonical_wine_id
    where w.user_id = p_user_id
      and w.canonical_wine_id is not null
      and w.rating > 0
  ),
  group_events as (
    select gwr.canonical_wine_id,
           gwr.rating::numeric as value,
           coalesce(gwr.updated_at, gwr.created_at) as occurred_at,
           cw.type, cw.country, cw.region,
           'group'::text as context
    from public.group_wine_ratings gwr
    join public.canonical_wine cw on cw.id = gwr.canonical_wine_id
    where gwr.user_id = p_user_id
      and gwr.rating is not null
  ),
  tasting_events as (
    select tr.canonical_wine_id,
           tr.rating::numeric as value,
           tr.created_at as occurred_at,
           cw.type, cw.country, cw.region,
           'tasting'::text as context
    from public.tasting_ratings tr
    join public.canonical_wine cw on cw.id = tr.canonical_wine_id
    join public.group_tastings gt on gt.id = tr.tasting_id
    where tr.user_id = p_user_id
      and tr.rating is not null
      and gt.state in ('active','concluded')
  ),
  all_events as (
    select * from personal_events
    union all
    select * from group_events
    union all
    select * from tasting_events
  ),
  -- Latest-wins per canonical_wine_id across all contexts. Tiebreaker on
  -- ties: context desc puts 'tasting' > 'personal' > 'group' alphabetically;
  -- deterministic only — semantics of ties don't depend on this ordering.
  deduped_canonical as (
    select distinct on (canonical_wine_id)
           canonical_wine_id, value, occurred_at, type, country, region
    from all_events
    order by canonical_wine_id, occurred_at desc, context desc
  ),
  -- Personal rows without a canonical_wine_id can't dedupe — they count
  -- once each as standalone events.
  orphan_personal as (
    select w.rating::numeric as value,
           coalesce(w.updated_at, w.created_at) as occurred_at,
           w.type::text as type,
           w.country, w.region
    from public.wines w
    where w.user_id = p_user_id
      and w.canonical_wine_id is null
      and w.rating > 0
  ),
  unified as (
    select value, occurred_at, type, country, region from deduped_canonical
    union all
    select value, occurred_at, type, country, region from orphan_personal
  ),
  context_counts as (
    select
      (select count(*) from personal_events) +
        (select count(*) from orphan_personal) as personal_c,
      (select count(*) from group_events) as group_c,
      (select count(*) from tasting_events) as tasting_c
  )
  select jsonb_build_object(
    'distinct_wine_count', (select count(*) from unified),
    'avg_rating',          (select round(avg(value)::numeric, 2) from unified),
    'personal_count',      (select personal_c from context_counts),
    'group_count',         (select group_c from context_counts),
    'tasting_count',       (select tasting_c from context_counts),
    'by_type', coalesce((
      select jsonb_agg(jsonb_build_object(
        'type', coalesce(type, 'unknown'),
        'count', c,
        'avg', round(a, 2)) order by c desc)
      from (select type, count(*)::int c, avg(value) a from unified group by type) s
    ), '[]'::jsonb),
    'by_month', coalesce((
      select jsonb_agg(jsonb_build_object(
        'month', m, 'count', c, 'avg', round(a, 2)) order by m desc)
      from (
        select to_char(date_trunc('month', occurred_at), 'YYYY-MM') m,
               count(*)::int c, avg(value) a
        from unified group by 1
      ) s
    ), '[]'::jsonb),
    'by_country', coalesce((
      select jsonb_agg(jsonb_build_object(
        'country', coalesce(country, 'unknown'),
        'count', c,
        'avg', round(a, 2)) order by c desc)
      from (select country, count(*)::int c, avg(value) a from unified group by country) s
    ), '[]'::jsonb),
    'by_region', coalesce((
      select jsonb_agg(jsonb_build_object(
        'region', coalesce(region, 'unknown'),
        'count', c,
        'avg', round(a, 2)) order by c desc)
      from (select region, count(*)::int c, avg(value) a from unified group by region) s
    ), '[]'::jsonb)
  ) into v_result;
  return v_result;
end;
$$;

grant execute on function public.get_user_rating_summary(uuid) to authenticated;


-- ─── 3. get_taste_compass — unified for self-view ─────────────────────────
-- Self-view: unified across all 3 contexts, deduped latest-wins.
-- Friend-view: personal-only with wines.visibility filter (privacy preserved).

create or replace function public.get_taste_compass(p_user_id uuid, p_top_n int default 3)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare v_can_view boolean; v_is_self boolean; v_result jsonb;
begin
  v_is_self := (p_user_id = auth.uid());
  v_can_view := v_is_self or exists (
    select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_user_id
  );
  if not v_can_view then
    return jsonb_build_object('total_count', 0, 'overall_avg', null,
      'top_regions', '[]'::jsonb, 'top_countries', '[]'::jsonb,
      'type_breakdown', '[]'::jsonb);
  end if;

  with raw_events as (
    -- Personal context (always; friend respects visibility).
    select w.canonical_wine_id,
           w.rating::numeric as rating,
           coalesce(w.updated_at, w.created_at) as occurred_at,
           cw.type, cw.country, cw.region,
           'personal'::text as context
    from public.wines w
    join public.canonical_wine cw on cw.id = w.canonical_wine_id
    where w.user_id = p_user_id
      and w.rating > 0
      and (v_is_self or w.visibility <> 'private')
    union all
    -- Group context (self only).
    select gwr.canonical_wine_id, gwr.rating::numeric,
           coalesce(gwr.updated_at, gwr.created_at),
           cw.type, cw.country, cw.region, 'group'
    from public.group_wine_ratings gwr
    join public.canonical_wine cw on cw.id = gwr.canonical_wine_id
    where v_is_self
      and gwr.user_id = p_user_id
      and gwr.rating is not null
    union all
    -- Tasting context (self only).
    select tr.canonical_wine_id, tr.rating::numeric,
           tr.created_at, cw.type, cw.country, cw.region, 'tasting'
    from public.tasting_ratings tr
    join public.canonical_wine cw on cw.id = tr.canonical_wine_id
    join public.group_tastings gt on gt.id = tr.tasting_id
    where v_is_self
      and tr.user_id = p_user_id
      and tr.rating is not null
      and gt.state in ('active','concluded')
  ),
  visible as (
    select distinct on (canonical_wine_id) rating, type, country, region
    from raw_events
    order by canonical_wine_id, occurred_at desc, context desc
  ),
  totals as (
    select count(*)::int as total_count, round(avg(rating)::numeric, 2) as overall_avg
    from visible
  ),
  regions as (
    select region, count(*)::int as count, round(avg(rating)::numeric, 2) as avg_rating
    from visible where region is not null
    group by region order by count(*) desc, avg(rating) desc limit p_top_n
  ),
  countries as (
    select country, count(*)::int as count, round(avg(rating)::numeric, 2) as avg_rating
    from visible where country is not null
    group by country order by count(*) desc, avg(rating) desc limit p_top_n
  ),
  types as (
    select type, count(*)::int as count, round(avg(rating)::numeric, 2) as avg_rating
    from visible where type is not null
    group by type order by count(*) desc
  )
  select jsonb_build_object(
    'total_count', (select total_count from totals),
    'overall_avg', (select overall_avg from totals),
    'top_regions', coalesce((select jsonb_agg(r) from regions r), '[]'::jsonb),
    'top_countries', coalesce((select jsonb_agg(c) from countries c), '[]'::jsonb),
    'type_breakdown', coalesce((select jsonb_agg(t) from types t), '[]'::jsonb)
  ) into v_result;
  return v_result;
end;
$$;


-- ─── 4. get_taste_match — unified for caller ('mine') side ────────────────
-- Caller ('mine') side: unified deduped. Other side: personal-only with
-- visibility filter (current behavior; preserves privacy).
-- Pair logic now matches across contexts: if I rated wine X in a group and
-- friend B rated X personally, the canonical pair still matches.

create or replace function public.get_taste_match(p_other_user_id uuid)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare
  v_can_view boolean;
  v_my_count int; v_their_count int; v_overlap_count int;
  v_bucket_score numeric; v_dna_score numeric;
  v_score numeric;
  v_confidence text;
  v_my_dna jsonb; v_their_dna jsonb;
  v_my_attr int; v_their_attr int; v_dna_dist numeric;
  v_agree_pairs int := 0; v_disagree_pairs int := 0;
begin
  if p_other_user_id = auth.uid() then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', 0, 'their_total', 0, 'reason', 'unavailable');
  end if;
  v_can_view := exists (select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_other_user_id);
  if not v_can_view then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', 0, 'their_total', 0, 'reason', 'unavailable');
  end if;

  -- Caller side: unified deduped distinct canonicals.
  with my_unified as (
    select canonical_wine_id, value, occurred_at, context from (
      select w.canonical_wine_id, w.rating::numeric as value,
             coalesce(w.updated_at, w.created_at) as occurred_at, 'personal' as context
      from public.wines w
      where w.user_id = auth.uid() and w.canonical_wine_id is not null and w.rating > 0
      union all
      select gwr.canonical_wine_id, gwr.rating::numeric,
             coalesce(gwr.updated_at, gwr.created_at), 'group'
      from public.group_wine_ratings gwr
      where gwr.user_id = auth.uid() and gwr.rating is not null
      union all
      select tr.canonical_wine_id, tr.rating::numeric, tr.created_at, 'tasting'
      from public.tasting_ratings tr
      join public.group_tastings gt on gt.id = tr.tasting_id
      where tr.user_id = auth.uid() and tr.rating is not null
        and gt.state in ('active','concluded')
    ) src
  )
  select count(distinct canonical_wine_id) into v_my_count from my_unified;

  -- Their side: personal-only with visibility filter.
  select count(*) into v_their_count from public.ratings r
   where r.user_id = p_other_user_id and r.context = 'personal'
     and exists (
       select 1 from public.wines w where w.user_id = r.user_id
         and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private'
     );

  if v_my_count < 5 or v_their_count < 5 then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', v_my_count, 'their_total', v_their_count,
      'reason', 'not_enough_ratings');
  end if;

  with mine_raw as (
    -- Same unified deduped, but with type/country/region attached.
    select distinct on (raw.canonical_wine_id)
           raw.canonical_wine_id, raw.value as rating, cw.type, cw.country, cw.region
    from (
      select w.canonical_wine_id, w.rating::numeric as value,
             coalesce(w.updated_at, w.created_at) as occurred_at, 'personal' as context
      from public.wines w
      where w.user_id = auth.uid() and w.canonical_wine_id is not null and w.rating > 0
      union all
      select gwr.canonical_wine_id, gwr.rating::numeric,
             coalesce(gwr.updated_at, gwr.created_at), 'group'
      from public.group_wine_ratings gwr
      where gwr.user_id = auth.uid() and gwr.rating is not null
      union all
      select tr.canonical_wine_id, tr.rating::numeric, tr.created_at, 'tasting'
      from public.tasting_ratings tr
      join public.group_tastings gt on gt.id = tr.tasting_id
      where tr.user_id = auth.uid() and tr.rating is not null
        and gt.state in ('active','concluded')
    ) raw
    join public.canonical_wine cw on cw.id = raw.canonical_wine_id
    order by raw.canonical_wine_id, raw.occurred_at desc, raw.context desc
  ),
  mine as (
    select 'region'::text as dim, region as val, rating from mine_raw where region is not null
    union all
    select 'country', country, rating from mine_raw where country is not null
    union all
    select 'type', type, rating from mine_raw where type is not null
  ),
  theirs as (
    select 'region'::text as dim, cw.region as val, r.value as rating
    from public.ratings r join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id and r.context = 'personal' and cw.region is not null
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
    union all
    select 'country', cw.country, r.value from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id and r.context = 'personal' and cw.country is not null
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
    union all
    select 'type', cw.type, r.value from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id and r.context = 'personal' and cw.type is not null
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
  ),
  my_buckets as (
    select dim, val, count(*)::int as cnt, avg(rating)::numeric as avg_r
    from mine group by dim, val having count(*) >= 2
  ),
  their_buckets as (
    select dim, val, count(*)::int as cnt, avg(rating)::numeric as avg_r
    from theirs group by dim, val having count(*) >= 2
  ),
  overlap as (
    select least(m.cnt, t.cnt)::numeric as weight, abs(m.avg_r - t.avg_r) as delta
    from my_buckets m join their_buckets t on m.dim = t.dim and m.val = t.val
  ),
  agg as (
    select count(*)::int as overlap_count,
           coalesce(sum(weight), 0)::numeric as total_weight,
           coalesce(sum(delta * weight), 0)::numeric as weighted_delta_sum
    from overlap
  )
  select overlap_count,
         case when total_weight > 0
              then round((1 - weighted_delta_sum / total_weight / 5.0) * 100)
              else null end
  into v_overlap_count, v_bucket_score from agg;

  if v_overlap_count < 3 then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', v_overlap_count,
      'my_total', v_my_count, 'their_total', v_their_count,
      'reason', 'not_enough_overlap');
  end if;

  v_my_dna    := public.get_user_style_dna(auth.uid());
  v_their_dna := public.get_user_style_dna(p_other_user_id);
  v_my_attr   := coalesce((v_my_dna ->> 'attributed_count')::int, 0);
  v_their_attr:= coalesce((v_their_dna ->> 'attributed_count')::int, 0);

  if v_my_attr >= 3 and v_their_attr >= 3 then
    select sum(abs(coalesce((v_my_dna ->> ax)::numeric, 0)
                  - coalesce((v_their_dna ->> ax)::numeric, 0)))
           / nullif(count(*), 0)::numeric
    into v_dna_dist
    from (values ('body'),('tannin'),('acidity'),('sweetness'),('oak'),('intensity')) as a(ax)
    where (v_my_dna ->> a.ax) is not null and (v_their_dna ->> a.ax) is not null;
    v_dna_score := round((1 - coalesce(v_dna_dist, 1)) * 100);
    v_dna_score := greatest(0, least(100, v_dna_score));
  end if;

  -- Agree/disagree pair count: same-canonical, deduped on caller side.
  with my_canon as (
    select distinct on (canonical_wine_id) canonical_wine_id, value as my_v from (
      select w.canonical_wine_id, w.rating::numeric as value,
             coalesce(w.updated_at, w.created_at) as occurred_at, 'personal' as context
      from public.wines w
      where w.user_id = auth.uid() and w.canonical_wine_id is not null and w.rating > 0
      union all
      select gwr.canonical_wine_id, gwr.rating::numeric,
             coalesce(gwr.updated_at, gwr.created_at), 'group'
      from public.group_wine_ratings gwr
      where gwr.user_id = auth.uid() and gwr.rating is not null
      union all
      select tr.canonical_wine_id, tr.rating::numeric, tr.created_at, 'tasting'
      from public.tasting_ratings tr
      join public.group_tastings gt on gt.id = tr.tasting_id
      where tr.user_id = auth.uid() and tr.rating is not null
        and gt.state in ('active','concluded')
    ) src
    order by canonical_wine_id, occurred_at desc, context desc
  ),
  their_canon as (
    select canonical_wine_id, value as their_v from public.ratings r
    where r.user_id = p_other_user_id and r.context = 'personal'
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
  ),
  pairs as (
    select m.my_v, t.their_v from my_canon m
    join their_canon t on m.canonical_wine_id = t.canonical_wine_id
  )
  select count(*) filter (where abs(my_v - their_v) <= 1)::int,
         count(*) filter (where abs(my_v - their_v) >= 3)::int
    into v_agree_pairs, v_disagree_pairs from pairs;

  -- Score blend (unchanged): bucket score is the spine; DNA adds nuance.
  if v_dna_score is not null then
    v_score := round((v_bucket_score * 0.7) + (v_dna_score * 0.3));
  else
    v_score := round(v_bucket_score);
  end if;

  v_confidence := case
    when v_overlap_count >= 10 then 'high'
    when v_overlap_count >= 5  then 'medium'
    else                            'low'
  end;

  return jsonb_build_object(
    'score', v_score, 'confidence', v_confidence,
    'overlap_count', v_overlap_count,
    'my_total', v_my_count, 'their_total', v_their_count,
    'reason', null,
    'bucket_score', v_bucket_score, 'dna_score', v_dna_score,
    'same_canonical_pairs', v_agree_pairs + v_disagree_pairs,
    'agree_pairs', v_agree_pairs, 'disagree_pairs', v_disagree_pairs
  );
end;
$$;

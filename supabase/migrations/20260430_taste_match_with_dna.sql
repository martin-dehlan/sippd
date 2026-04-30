-- Extends get_taste_match with a Style DNA dimension on top of the
-- existing region/country/type bucket scoring. The composite balances
-- WHAT users drink (buckets) against HOW their palate is built (DNA),
-- then nudges by same-canonical agreement / disagreement so loud
-- preference signals override averaged buckets.
--
-- Confidence is clamped by the weaker side: the user with fewer
-- attributed ratings dictates how confident the match label feels.
--
-- Returns the same shape as before plus a 'breakdown' object so the
-- friend-profile UI can label which dimensions agreed.

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
  v_bucket_score  numeric;
  v_dna_score     numeric;
  v_agree_bonus   numeric := 0;
  v_disagree_pen  numeric := 0;
  v_score         numeric;
  v_confidence    text;
  v_my_dna        jsonb;
  v_their_dna     jsonb;
  v_my_attr       int;
  v_their_attr    int;
  v_dna_dist      numeric;
  v_agree_pairs   int := 0;
  v_disagree_pairs int := 0;
begin
  if p_other_user_id = auth.uid() then
    return jsonb_build_object(
      'score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', 0, 'their_total', 0,
      'reason', 'unavailable'
    );
  end if;

  v_can_view := exists (
    select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_other_user_id
  );
  if not v_can_view then
    return jsonb_build_object(
      'score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', 0, 'their_total', 0,
      'reason', 'unavailable'
    );
  end if;

  -- Personal-rating counts feed the floor check.
  select count(*) into v_my_count
  from public.ratings
  where user_id = auth.uid() and context = 'personal';

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
      'score', null, 'confidence', null,
      'overlap_count', 0,
      'my_total', v_my_count, 'their_total', v_their_count,
      'reason', 'not_enough_ratings'
    );
  end if;

  -- ── Bucket score (region/country/type — same logic as before) ────
  with mine as (
    select 'region'::text as dim, cw.region as val, r.value as rating
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid() and r.context = 'personal'
      and cw.region is not null
    union all
    select 'country', cw.country, r.value
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid() and r.context = 'personal'
      and cw.country is not null
    union all
    select 'type', cw.type, r.value
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid() and r.context = 'personal'
      and cw.type is not null
  ),
  theirs as (
    select 'region'::text as dim, cw.region as val, r.value as rating
    from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id and r.context = 'personal'
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
    where r.user_id = p_other_user_id and r.context = 'personal'
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
    where r.user_id = p_other_user_id and r.context = 'personal'
      and cw.type is not null
      and exists (
        select 1 from public.wines w
        where w.user_id = r.user_id
          and w.canonical_wine_id = r.canonical_wine_id
          and w.visibility <> 'private'
      )
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
    select least(m.cnt, t.cnt)::numeric as weight,
           abs(m.avg_r - t.avg_r) as delta
    from my_buckets m
    join their_buckets t on m.dim = t.dim and m.val = t.val
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
              else null
         end
  into v_overlap_count, v_bucket_score
  from agg;

  if v_overlap_count < 3 then
    return jsonb_build_object(
      'score', null, 'confidence', null,
      'overlap_count', v_overlap_count,
      'my_total', v_my_count, 'their_total', v_their_count,
      'reason', 'not_enough_overlap'
    );
  end if;

  -- ── DNA score via Manhattan distance over the six SAT axes ──────
  v_my_dna    := public.get_user_style_dna(auth.uid());
  v_their_dna := public.get_user_style_dna(p_other_user_id);
  v_my_attr   := coalesce((v_my_dna ->> 'attributed_count')::int, 0);
  v_their_attr:= coalesce((v_their_dna ->> 'attributed_count')::int, 0);

  if v_my_attr >= 3 and v_their_attr >= 3 then
    -- Manhattan distance over present axes, normalised to 0..1.
    select sum(abs(coalesce((v_my_dna ->> ax)::numeric, 0)
                  - coalesce((v_their_dna ->> ax)::numeric, 0)))
           / nullif(count(*), 0)::numeric
    into v_dna_dist
    from (values ('body'),('tannin'),('acidity'),('sweetness'),('oak'),('intensity'))
         as a(ax)
    where (v_my_dna ->> a.ax) is not null
      and (v_their_dna ->> a.ax) is not null;
    v_dna_score := round((1 - coalesce(v_dna_dist, 1)) * 100);
    v_dna_score := greatest(0, least(100, v_dna_score));
  end if;

  -- ── Same-canonical agreement / disagreement adjustments ─────────
  with my_canon as (
    select canonical_wine_id, value as my_v
    from public.ratings
    where user_id = auth.uid() and context = 'personal'
  ),
  their_canon as (
    select canonical_wine_id, value as their_v
    from public.ratings r
    where r.user_id = p_other_user_id and r.context = 'personal'
      and exists (
        select 1 from public.wines w
        where w.user_id = r.user_id
          and w.canonical_wine_id = r.canonical_wine_id
          and w.visibility <> 'private'
      )
  ),
  pairs as (
    select m.my_v, t.their_v
    from my_canon m join their_canon t
      on m.canonical_wine_id = t.canonical_wine_id
  )
  select
    count(*) filter (where abs(my_v - their_v) <= 1)::int,
    count(*) filter (where abs(my_v - their_v) >= 3)::int
  into v_agree_pairs, v_disagree_pairs
  from pairs;

  v_agree_bonus  := least(v_agree_pairs * 1.5, 10)::numeric;
  v_disagree_pen := least(v_disagree_pairs * 1.5, 10)::numeric;

  -- Composite — bucket carries 0.55 weight, DNA 0.45 when present.
  if v_dna_score is null then
    v_score := v_bucket_score;
  else
    v_score := round(0.55 * v_bucket_score + 0.45 * v_dna_score);
  end if;
  v_score := greatest(0, least(100,
    v_score + v_agree_bonus - v_disagree_pen));

  -- Confidence tier — capped by weaker side's DNA confidence.
  if v_overlap_count >= 10 and v_my_count >= 30 and v_their_count >= 30
     and v_my_attr >= 15 and v_their_attr >= 15 then
    v_confidence := 'high';
  elsif v_overlap_count >= 5 and v_my_count >= 10 and v_their_count >= 10
        and v_my_attr >= 5 and v_their_attr >= 5 then
    v_confidence := 'medium';
  else
    v_confidence := 'low';
  end if;

  return jsonb_build_object(
    'score',           v_score,
    'confidence',      v_confidence,
    'overlap_count',   v_overlap_count,
    'my_total',        v_my_count,
    'their_total',     v_their_count,
    'reason',          null,
    'bucket_score',    v_bucket_score,
    'dna_score',       v_dna_score,
    'same_canonical_pairs', v_agree_pairs + v_disagree_pairs,
    'agree_pairs',     v_agree_pairs,
    'disagree_pairs',  v_disagree_pairs
  );
end;
$$;

grant execute on function public.get_taste_match(uuid) to authenticated;

-- Taste Match: weighted abs-diff similarity score between auth.uid() and
-- p_other_user_id, computed across region / country / type buckets. Returns
-- score (0–100), confidence tier ('low' | 'medium' | 'high'), and the raw
-- counts so the client can display an honest signal instead of a fake number.
--
-- Honesty rules (per project_taste_match_design.md):
--   - Hard floor: each user must have ≥5 visible ratings AND ≥3 overlapping
--     buckets. Below floor → score is null + reason explains why.
--   - Per-bucket count must be ≥2 on both sides. Single-rating buckets are
--     noise, not signal.
--   - Weight per bucket = least(count_mine, count_theirs). The weaker side
--     drags confidence down — exactly what we want.
--   - Confidence tiers reflect sample size, not score magnitude:
--       high   = 10+ overlapping buckets AND 30+ ratings each
--       medium = 5+ overlapping buckets AND 10+ ratings each
--       low    = anything that clears the floor but not medium
--
-- Math:
--   score = round((1 - Σ(delta·weight) / Σ(weight) / 5.0) · 100)
--   on a 0–5 rating scale. Bounded to [0, 100].
--
-- Security: definer + auth.uid() check. Friendship verified via
-- public.friendships. Self-call returns 'unavailable' (no point matching
-- yourself).

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
  from public.wines
  where user_id = auth.uid();

  select count(*) into v_their_count
  from public.wines
  where user_id = p_other_user_id
    and visibility <> 'private';

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
    select 'region'::text as dim, region as val, rating
    from public.wines
    where user_id = auth.uid()
      and region is not null
    union all
    select 'country', country, rating
    from public.wines
    where user_id = auth.uid()
      and country is not null
    union all
    select 'type', type, rating
    from public.wines
    where user_id = auth.uid()
  ),
  theirs as (
    select 'region'::text as dim, region as val, rating
    from public.wines
    where user_id = p_other_user_id
      and visibility <> 'private'
      and region is not null
    union all
    select 'country', country, rating
    from public.wines
    where user_id = p_other_user_id
      and visibility <> 'private'
      and country is not null
    union all
    select 'type', type, rating
    from public.wines
    where user_id = p_other_user_id
      and visibility <> 'private'
  ),
  my_buckets as (
    select dim, val,
           count(*)::int     as cnt,
           avg(rating)::numeric as avg_r
    from mine
    group by dim, val
    having count(*) >= 2
  ),
  their_buckets as (
    select dim, val,
           count(*)::int     as cnt,
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

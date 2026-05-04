-- Taste Compass: per-user aggregation of regions, countries and wine types
-- with avg rating per bucket. Returned as a single jsonb payload so the
-- client gets the full compass in one round-trip.
--
-- Visibility:
--   - Caller viewing themselves → all of their wines.
--   - Caller viewing a friend     → wines where visibility <> 'private'.
--   - Caller viewing a stranger   → empty payload (caller cannot enumerate).
--
-- Security: definer + auth.uid()-based check. Friendship is verified via
-- public.friendships (mirrored both directions by trigger), so a one-sided
-- pending request cannot leak data.

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
    select rating, type, country, region
    from public.wines
    where user_id = p_user_id
      and (p_user_id = auth.uid() or visibility <> 'private')
  ),
  totals as (
    select
      count(*)::int                      as total_count,
      round(avg(rating)::numeric, 2)     as overall_avg
    from visible
  ),
  regions as (
    select
      region,
      count(*)::int                      as count,
      round(avg(rating)::numeric, 2)     as avg_rating
    from visible
    where region is not null
    group by region
    order by count(*) desc, avg(rating) desc
    limit p_top_n
  ),
  countries as (
    select
      country,
      count(*)::int                      as count,
      round(avg(rating)::numeric, 2)     as avg_rating
    from visible
    where country is not null
    group by country
    order by count(*) desc, avg(rating) desc
    limit p_top_n
  ),
  types as (
    select
      type,
      count(*)::int                      as count,
      round(avg(rating)::numeric, 2)     as avg_rating
    from visible
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

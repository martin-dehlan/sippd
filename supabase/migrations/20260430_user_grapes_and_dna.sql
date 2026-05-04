-- get_user_top_grapes — top N canonical grapes a user has rated, with
-- count + avg rating. Drives the "Grapes" compass mode.
--
-- Visibility mirrors taste_compass: self always, friends respect
-- the wines.visibility column on the underlying personal entries.

create or replace function public.get_user_top_grapes(
  p_user_id uuid,
  p_limit   int default 7
)
returns table (
  canonical_grape_id uuid,
  grape_name         text,
  grape_color        text,
  count              int,
  avg_rating         numeric
)
language sql
security definer
set search_path = public
stable
as $$
  with visible as (
    select w.canonical_grape_id, w.rating
    from public.wines w
    where w.user_id = p_user_id
      and w.canonical_grape_id is not null
      and (
        p_user_id = auth.uid()
        or exists (
          select 1 from public.friendships f
          where f.user_id = auth.uid() and f.friend_id = p_user_id
        )
      )
      and (p_user_id = auth.uid() or w.visibility <> 'private')
  )
  select
    cg.id  as canonical_grape_id,
    cg.name as grape_name,
    cg.color as grape_color,
    count(v.canonical_grape_id)::int as count,
    round(avg(v.rating)::numeric, 2) as avg_rating
  from visible v
  join public.canonical_grape cg on cg.id = v.canonical_grape_id
  group by cg.id, cg.name, cg.color
  order by count(*) desc, avg(v.rating) desc
  limit p_limit;
$$;

grant execute on function public.get_user_top_grapes(uuid, int) to authenticated;

-- get_user_style_dna — aggregate the user's wine ratings against the
-- canonical grape archetype to produce a 6-axis Style DNA vector.
--
-- Each rated wine contributes its grape's archetype values weighted
-- by (rating / 10). High ratings count more — this is preference,
-- not exposure. Tannin can be null for whites; we average only over
-- non-null contributions per axis.
--
-- Returns one row with body/tannin/acidity/sweetness/oak/intensity
-- in 0..1 plus a confidence score on the same scale (caps at 1 once
-- the user has 20 attributed ratings).

create or replace function public.get_user_style_dna(
  p_user_id uuid
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
    select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_user_id
  );
  if not v_can_view then
    return jsonb_build_object(
      'body', null, 'tannin', null, 'acidity', null,
      'sweetness', null, 'oak', null, 'intensity', null,
      'attributed_count', 0, 'confidence', 0
    );
  end if;

  with attributed as (
    select
      a.body, a.tannin, a.acidity, a.sweetness, a.oak, a.intensity,
      (w.rating / 10.0)::numeric as weight
    from public.wines w
    join public.canonical_grape_archetype a on a.canonical_grape_id = w.canonical_grape_id
    where w.user_id = p_user_id
      and (p_user_id = auth.uid() or w.visibility <> 'private')
      and w.rating is not null
      and w.rating > 0
  ),
  stats as (
    select
      sum(weight)::numeric as total_w,
      sum(body * weight)::numeric / nullif(sum(weight), 0)::numeric as body_w,
      sum(tannin * weight) filter (where tannin is not null)::numeric
        / nullif(sum(weight) filter (where tannin is not null), 0)::numeric as tannin_w,
      sum(acidity * weight)::numeric / nullif(sum(weight), 0)::numeric as acid_w,
      sum(sweetness * weight)::numeric / nullif(sum(weight), 0)::numeric as sweet_w,
      sum(oak * weight)::numeric / nullif(sum(weight), 0)::numeric as oak_w,
      sum(intensity * weight)::numeric / nullif(sum(weight), 0)::numeric as int_w,
      count(*)::int as n
    from attributed
  )
  select jsonb_build_object(
    'body',             round(body_w, 3),
    'tannin',           round(tannin_w, 3),
    'acidity',          round(acid_w, 3),
    'sweetness',        round(sweet_w, 3),
    'oak',              round(oak_w, 3),
    'intensity',        round(int_w, 3),
    'attributed_count', n,
    'confidence',       round(least(1.0, n / 20.0)::numeric, 2)
  )
  into v_result
  from stats;

  return v_result;
end;
$$;

grant execute on function public.get_user_style_dna(uuid) to authenticated;

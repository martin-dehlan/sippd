-- Shared Bottles: list of wines that the caller and p_other_user_id have
-- both rated inside the same shared group/tasting context. Returns each
-- user's score plus the absolute delta so the client can sort by biggest
-- agreement / disagreement without recomputing.
--
-- Match key is (group_id, wine_id) — identical to get_top_drinking_partners.
-- This guarantees we only compare ratings on the same canonical bottle
-- (set by the sharer via group_wines), avoiding name-match phantoms that
-- would otherwise occur because public.wines is per-user.
--
-- Security: definer + auth.uid() filter on my_ratings. The caller can only
-- see overlap rows where they themselves rated, so they cannot enumerate
-- arbitrary other users' tasting history.

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
    select group_id, wine_id, rating, updated_at
    from public.group_wine_ratings
    where user_id = auth.uid()
  ),
  their_ratings as (
    select group_id, wine_id, rating
    from public.group_wine_ratings
    where user_id = p_other_user_id
  ),
  shared as (
    select
      m.group_id,
      m.wine_id,
      m.rating::numeric                  as my_rating,
      t.rating::numeric                  as their_rating,
      abs(m.rating - t.rating)::numeric  as delta,
      m.updated_at                       as rated_at
    from my_ratings m
    join their_ratings t
      on t.group_id = m.group_id
     and t.wine_id  = m.wine_id
  )
  select
    s.group_id,
    s.wine_id,
    w.name      as wine_name,
    w.winery,
    w.region,
    w.country,
    w.type,
    w.vintage,
    s.my_rating,
    s.their_rating,
    s.delta,
    s.rated_at
  from shared s
  join public.wines w on w.id = s.wine_id
  order by s.delta desc nulls last, s.rated_at desc nulls last
  limit p_limit;
$$;

grant execute on function public.get_shared_bottles(uuid, int) to authenticated;

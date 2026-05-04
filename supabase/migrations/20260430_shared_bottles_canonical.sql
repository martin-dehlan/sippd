-- Re-bases shared_bottles join on canonical_wine_id so two users that
-- rated the *same canonical* in the same group are recognised as
-- having tasted the same bottle, even if each rated their own
-- personal wines row (different wine_id, same identity). Wine
-- metadata in the result now comes from canonical_wine for stable
-- naming across users.

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
    select gwr.group_id,
           gwr.wine_id,
           w.canonical_wine_id,
           gwr.rating,
           gwr.updated_at
    from public.group_wine_ratings gwr
    join public.wines w on w.id = gwr.wine_id
    where gwr.user_id = auth.uid()
      and w.canonical_wine_id is not null
  ),
  their_ratings as (
    select gwr.group_id,
           w.canonical_wine_id,
           gwr.rating
    from public.group_wine_ratings gwr
    join public.wines w on w.id = gwr.wine_id
    where gwr.user_id = p_other_user_id
      and w.canonical_wine_id is not null
  ),
  shared as (
    select
      m.group_id,
      m.wine_id,
      m.canonical_wine_id,
      m.rating::numeric                  as my_rating,
      t.rating::numeric                  as their_rating,
      abs(m.rating - t.rating)::numeric  as delta,
      m.updated_at                       as rated_at
    from my_ratings m
    join their_ratings t
      on t.group_id          = m.group_id
     and t.canonical_wine_id = m.canonical_wine_id
  )
  select
    s.group_id,
    s.wine_id,
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

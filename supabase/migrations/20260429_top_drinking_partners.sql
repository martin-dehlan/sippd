-- Returns the caller's top drinking partners — other users they have
-- co-rated wines with inside shared groups. "Co-rated" means both users
-- have a row in public.group_wine_ratings for the same (group_id, wine_id).
--
-- Security: definer + explicit filter on auth.uid(). The function only
-- ever returns rows where the caller themselves has a group_wine_ratings
-- entry, so they can't enumerate strangers — they can only see partners
-- they actually shared a tasting with. Profiles join is also constrained
-- to those partner ids.

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
  with my_ratings as (
    select group_id, wine_id
    from public.group_wine_ratings
    where user_id = auth.uid()
  ),
  partners as (
    select gwr.user_id, count(*)::int as shared_wines
    from public.group_wine_ratings gwr
    join my_ratings mr
      on mr.group_id = gwr.group_id
     and mr.wine_id = gwr.wine_id
    where gwr.user_id <> auth.uid()
    group by gwr.user_id
  )
  select
    p.user_id,
    pr.username,
    pr.display_name,
    pr.avatar_url,
    p.shared_wines
  from partners p
  join public.profiles pr on pr.id = p.user_id
  order by p.shared_wines desc, pr.display_name asc nulls last
  limit p_limit;
$$;

grant execute on function public.get_top_drinking_partners(int) to authenticated;

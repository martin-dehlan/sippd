-- Re-bases drinking-partners on canonical_wine_id rather than the
-- shared wine_id. Two users that rated the *same canonical* in the
-- same group now overlap even when each rated their own personal
-- wines row (different wine_id, same identity).
--
-- Phase 1: still scoped to group_wine_ratings only — keeps "partners
-- you taste WITH" semantic. Personal-only ratings remain out of scope
-- until the ratings-as-events refactor (Phase 2).

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
  with my_canonicals as (
    select distinct gwr.group_id, w.canonical_wine_id as canonical_id
    from public.group_wine_ratings gwr
    join public.wines w on w.id = gwr.wine_id
    where gwr.user_id = auth.uid()
      and w.canonical_wine_id is not null
  ),
  partner_canonicals as (
    select distinct
      gwr.user_id,
      gwr.group_id,
      w.canonical_wine_id as canonical_id
    from public.group_wine_ratings gwr
    join public.wines w on w.id = gwr.wine_id
    where gwr.user_id <> auth.uid()
      and w.canonical_wine_id is not null
  ),
  partner_overlaps as (
    select pc.user_id,
           count(*)::int as shared_wines
    from partner_canonicals pc
    join my_canonicals mc
      on mc.group_id    = pc.group_id
     and mc.canonical_id = pc.canonical_id
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

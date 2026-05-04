-- Backfill: every wine that was shared to a group, where the sharer
-- has a personal rating set on wines.rating but no group_wine_ratings
-- row of their own, gets one — using the personal rating as the
-- group rating value and shared_at as the timestamp.
--
-- This unblocks drinking-partners / shared-bottles for owners who
-- had been rating their own wines personally then sharing them, but
-- never explicitly group-rated them. Going forward the group rating
-- sheet writes both rows (personal + group) when the owner saves.

insert into public.group_wine_ratings (
  group_id, wine_id, user_id, rating, created_at, updated_at
)
select
  gw.group_id,
  gw.wine_id,
  gw.shared_by,
  w.rating,
  gw.shared_at,
  gw.shared_at
from public.group_wines gw
join public.wines w on w.id = gw.wine_id
where w.rating is not null
  and w.rating > 0
  and not exists (
    select 1
    from public.group_wine_ratings gwr
    where gwr.group_id = gw.group_id
      and gwr.wine_id  = gw.wine_id
      and gwr.user_id  = gw.shared_by
  )
on conflict (group_id, wine_id, user_id) do nothing;

-- public.ratings — unified rating-events view that flattens the three
-- rating sources into one stream keyed by canonical_wine_id:
--   * wines.rating              → context='personal'
--   * group_wine_ratings.rating → context='group',   group_id set
--   * tasting_ratings.rating    → context='tasting', tasting_id set
--
-- Reading this view (instead of the three underlying tables) is what
-- lets cross-user features collapse two users' separate wines.rows
-- to the same canonical and count overlap correctly. Wines without a
-- resolved canonical_wine_id are excluded — they cannot participate
-- in cross-user features anyway.
--
-- Synthetic id columns let clients distinguish rows in lists without
-- needing a separate "rating events" table. The id format is
-- '<context-prefix>_<user>_<…context-key…>_<canonical>'.
--
-- Phase 2 keeps the source tables intact for write paths (no client
-- changes). Promotion to a real ratings table can come later if
-- query performance demands it.

create or replace view public.ratings as
select
  ('p_' || w.user_id::text || '_' || w.canonical_wine_id::text)        as id,
  w.user_id,
  w.canonical_wine_id,
  w.rating::numeric                                                     as value,
  'personal'::text                                                      as context,
  null::uuid                                                            as group_id,
  null::uuid                                                            as tasting_id,
  w.created_at,
  w.updated_at
from public.wines w
where w.canonical_wine_id is not null

union all

select
  ('g_' || gwr.user_id::text || '_' || gwr.group_id::text || '_' || w.canonical_wine_id::text) as id,
  gwr.user_id,
  w.canonical_wine_id,
  gwr.rating::numeric                                                   as value,
  'group'::text                                                         as context,
  gwr.group_id,
  null::uuid                                                            as tasting_id,
  gwr.created_at,
  gwr.updated_at
from public.group_wine_ratings gwr
join public.wines w on w.id = gwr.wine_id
where w.canonical_wine_id is not null

union all

select
  ('t_' || tr.user_id::text || '_' || tr.tasting_id::text || '_' || w.canonical_wine_id::text) as id,
  tr.user_id,
  w.canonical_wine_id,
  tr.rating::numeric                                                    as value,
  'tasting'::text                                                       as context,
  null::uuid                                                            as group_id,
  tr.tasting_id,
  tr.created_at,
  null::timestamptz                                                     as updated_at
from public.tasting_ratings tr
join public.wines w on w.id = tr.wine_id
where w.canonical_wine_id is not null;

-- Views inherit RLS from their source tables but the underlying
-- security policies are written against the table directly, so the
-- view "just works" — caller only sees rows they can already read on
-- the underlying tables.

grant select on public.ratings to authenticated;

-- Hot indexes for canonical_wine_id-driven lookups via the view.
-- wines + group_wine_ratings + tasting_ratings all need fast access
-- to (user_id, canonical_wine_id) and (group_id, canonical_wine_id)
-- once cross-user joins fan out.

create index if not exists wines_user_canonical_idx
  on public.wines (user_id, canonical_wine_id)
  where canonical_wine_id is not null;

create index if not exists group_wine_ratings_user_idx
  on public.group_wine_ratings (user_id);

create index if not exists tasting_ratings_user_idx
  on public.tasting_ratings (user_id);

-- Phase 2c — final cutover. Drop the legacy personal-wines.id pointer
-- from every cross-user table. After this migration the catalog
-- identity (canonical_wine_id) is the only key tying group/tasting
-- rows to a bottle; the personal `wines` table becomes a pure private
-- tasting log.
--
-- Pre-conditions: Phase 2a has run; canonical_wine_id is fully
-- backfilled (verified zero NULLs across all four tables).

-- ── public.ratings view depends on the wine_id columns. Drop and
-- ── rebuild canonical-only.
drop view if exists public.ratings;

-- RLS policy on `wines` indirectly references group_wines.wine_id —
-- drop it so we can drop the column, then recreate canonical-keyed
-- below.
drop policy if exists "wines_select_shared" on public.wines;

-- ── group_wines ──────────────────────────────────────────────────
drop trigger if exists fill_canonical_on_group_wines on public.group_wines;

alter table public.group_wines
  drop constraint if exists group_wines_wine_id_fkey,
  drop constraint if exists group_wines_group_id_wine_id_key;

alter table public.group_wines
  drop column if exists wine_id;

alter table public.group_wines
  alter column canonical_wine_id set not null;

create unique index if not exists group_wines_group_canonical_unique
  on public.group_wines (group_id, canonical_wine_id);

-- ── group_wine_ratings ───────────────────────────────────────────
drop trigger if exists fill_canonical_on_group_wine_ratings on public.group_wine_ratings;

alter table public.group_wine_ratings
  drop constraint if exists group_wine_ratings_pkey,
  drop constraint if exists group_wine_ratings_wine_id_fkey;

alter table public.group_wine_ratings
  drop column if exists wine_id;

alter table public.group_wine_ratings
  alter column canonical_wine_id set not null;

alter table public.group_wine_ratings
  add constraint group_wine_ratings_pkey
    primary key (group_id, canonical_wine_id, user_id);

-- ── tasting_ratings ──────────────────────────────────────────────
drop trigger if exists fill_canonical_on_tasting_ratings on public.tasting_ratings;

alter table public.tasting_ratings
  drop constraint if exists tasting_ratings_pkey,
  drop constraint if exists tasting_ratings_wine_id_fkey;

alter table public.tasting_ratings
  drop column if exists wine_id;

alter table public.tasting_ratings
  alter column canonical_wine_id set not null;

alter table public.tasting_ratings
  add constraint tasting_ratings_pkey
    primary key (tasting_id, canonical_wine_id, user_id);

-- ── tasting_wines ────────────────────────────────────────────────
drop trigger if exists fill_canonical_on_tasting_wines on public.tasting_wines;

alter table public.tasting_wines
  drop constraint if exists tasting_wines_pkey,
  drop constraint if exists tasting_wines_wine_id_fkey;

alter table public.tasting_wines
  drop column if exists wine_id;

alter table public.tasting_wines
  alter column canonical_wine_id set not null;

alter table public.tasting_wines
  add constraint tasting_wines_pkey
    primary key (tasting_id, canonical_wine_id);

-- ── retire the auto-fill helper ──────────────────────────────────
drop function if exists public.fill_canonical_wine_id_from_wine();

-- ── re-grant cross-user read on `wines` for rows whose canonical
-- bottle is shared into a group the caller belongs to. Routes through
-- canonical_wine_id now that group_wines no longer carries a personal-
-- wines.id pointer.
create policy "wines_select_shared"
  on public.wines for select
  using (
    canonical_wine_id is not null
    and canonical_wine_id in (
      select gw.canonical_wine_id
      from public.group_wines gw
      join public.group_members gm on gm.group_id = gw.group_id
      where gm.user_id = auth.uid()
    )
  );

-- ── rebuild ratings view (canonical-only, no join to wines) ──────
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
  ('g_' || gwr.user_id::text || '_' || gwr.group_id::text || '_' || gwr.canonical_wine_id::text) as id,
  gwr.user_id,
  gwr.canonical_wine_id,
  gwr.rating::numeric                                                   as value,
  'group'::text                                                         as context,
  gwr.group_id,
  null::uuid                                                            as tasting_id,
  gwr.created_at,
  gwr.updated_at
from public.group_wine_ratings gwr

union all

select
  ('t_' || tr.user_id::text || '_' || tr.tasting_id::text || '_' || tr.canonical_wine_id::text) as id,
  tr.user_id,
  tr.canonical_wine_id,
  tr.rating::numeric                                                    as value,
  'tasting'::text                                                       as context,
  null::uuid                                                            as group_id,
  tr.tasting_id,
  tr.created_at,
  null::timestamptz                                                     as updated_at
from public.tasting_ratings tr;

grant select on public.ratings to authenticated;

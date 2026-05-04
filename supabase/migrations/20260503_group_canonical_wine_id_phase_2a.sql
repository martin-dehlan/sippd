-- Phase 2a — re-base group/tasting tables on canonical_wine_id
--
-- Long-term fix for: deleting a personal wines row cascades through
-- group_wines / group_wine_ratings / tasting_ratings / tasting_wines
-- and obliterates other members' shared bottles + ratings. Fix is to
-- pivot every cross-user table off canonical_wine_id (catalog identity)
-- and let personal wines rows be a private tasting log only.
--
-- This migration is ADDITIVE and SAFE:
--   * adds nullable canonical_wine_id columns
--   * backfills from wines.canonical_wine_id (no rows currently lack it)
--   * adds a fill-on-write trigger so future inserts populate it from wines
--   * adds covering indexes
--
-- Reads, FK changes and PK swaps come in phase 2b/2c.

-- ── group_wines ──────────────────────────────────────────────────
alter table public.group_wines
  add column if not exists canonical_wine_id uuid
    references public.canonical_wine(id) on delete cascade;

update public.group_wines gw
   set canonical_wine_id = w.canonical_wine_id
  from public.wines w
 where w.id = gw.wine_id
   and gw.canonical_wine_id is null
   and w.canonical_wine_id is not null;

create index if not exists group_wines_group_canonical_idx
  on public.group_wines (group_id, canonical_wine_id);

-- ── group_wine_ratings ───────────────────────────────────────────
alter table public.group_wine_ratings
  add column if not exists canonical_wine_id uuid
    references public.canonical_wine(id) on delete cascade;

update public.group_wine_ratings gwr
   set canonical_wine_id = w.canonical_wine_id
  from public.wines w
 where w.id = gwr.wine_id
   and gwr.canonical_wine_id is null
   and w.canonical_wine_id is not null;

create index if not exists group_wine_ratings_group_canonical_idx
  on public.group_wine_ratings (group_id, canonical_wine_id);

create index if not exists group_wine_ratings_user_canonical_idx
  on public.group_wine_ratings (user_id, canonical_wine_id);

-- ── tasting_ratings ──────────────────────────────────────────────
alter table public.tasting_ratings
  add column if not exists canonical_wine_id uuid
    references public.canonical_wine(id) on delete cascade;

update public.tasting_ratings tr
   set canonical_wine_id = w.canonical_wine_id
  from public.wines w
 where w.id = tr.wine_id
   and tr.canonical_wine_id is null
   and w.canonical_wine_id is not null;

create index if not exists tasting_ratings_tasting_canonical_idx
  on public.tasting_ratings (tasting_id, canonical_wine_id);

-- ── tasting_wines ────────────────────────────────────────────────
alter table public.tasting_wines
  add column if not exists canonical_wine_id uuid
    references public.canonical_wine(id) on delete cascade;

update public.tasting_wines tw
   set canonical_wine_id = w.canonical_wine_id
  from public.wines w
 where w.id = tw.wine_id
   and tw.canonical_wine_id is null
   and w.canonical_wine_id is not null;

create index if not exists tasting_wines_tasting_canonical_idx
  on public.tasting_wines (tasting_id, canonical_wine_id);

-- ── auto-fill trigger ────────────────────────────────────────────
-- Any caller that still writes only wine_id will get canonical_wine_id
-- populated from the referenced wines row. Lets us roll out client
-- changes incrementally.
create or replace function public.fill_canonical_wine_id_from_wine()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.canonical_wine_id is null and new.wine_id is not null then
    select w.canonical_wine_id
      into new.canonical_wine_id
      from public.wines w
     where w.id = new.wine_id;
  end if;
  return new;
end;
$$;

drop trigger if exists fill_canonical_on_group_wines on public.group_wines;
create trigger fill_canonical_on_group_wines
  before insert or update of wine_id on public.group_wines
  for each row execute function public.fill_canonical_wine_id_from_wine();

drop trigger if exists fill_canonical_on_group_wine_ratings on public.group_wine_ratings;
create trigger fill_canonical_on_group_wine_ratings
  before insert or update of wine_id on public.group_wine_ratings
  for each row execute function public.fill_canonical_wine_id_from_wine();

drop trigger if exists fill_canonical_on_tasting_ratings on public.tasting_ratings;
create trigger fill_canonical_on_tasting_ratings
  before insert or update of wine_id on public.tasting_ratings
  for each row execute function public.fill_canonical_wine_id_from_wine();

drop trigger if exists fill_canonical_on_tasting_wines on public.tasting_wines;
create trigger fill_canonical_on_tasting_wines
  before insert or update of wine_id on public.tasting_wines
  for each row execute function public.fill_canonical_wine_id_from_wine();

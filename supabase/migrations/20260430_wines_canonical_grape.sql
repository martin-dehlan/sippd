-- Add canonical grape FK + freetext fallback to wines.
-- canonical_grape_id wins for filters / taste-match; grape_freetext is the
-- user's raw entry when no canonical match is selected. Existing wines.grape
-- is backfilled into grape_freetext and kept (legacy) for one release.

alter table public.wines
  add column if not exists canonical_grape_id uuid
    references public.canonical_grape(id) on delete set null,
  add column if not exists grape_freetext text;

create index if not exists wines_canonical_grape_id_idx
  on public.wines (canonical_grape_id);

-- Backfill: copy raw grape into freetext for existing rows. App-level
-- canonical resolution happens lazily on next edit.
update public.wines
   set grape_freetext = grape
 where grape is not null
   and grape <> ''
   and grape_freetext is null;

-- Adds optional `winery` field and a `name_norm` column used for
-- fuzzy-equality matching when a group member tries to share a wine that
-- another member has already shared (dedup-on-share flow).
--
-- The client is authoritative for name_norm and writes it on every
-- insert/update. The algorithm lives in lib/common/utils/name_normalizer.dart.
-- A plain nullable column keeps upsert payloads simple.

alter table public.wines
  add column if not exists winery text;

alter table public.wines
  add column if not exists name_norm text;

create index if not exists wines_name_norm_vintage_idx
  on public.wines (name_norm, vintage);

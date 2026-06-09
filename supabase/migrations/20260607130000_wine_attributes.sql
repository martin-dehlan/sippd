-- Scanner-recognized wine attributes (issue #188).
--
-- Additive only — new nullable columns on `wines`, populated by the label
-- scanner (FastCork) and editable in the add/edit form. Backward-compatible
-- with older app builds that don't know these columns (migration-compat
-- policy).

alter table public.wines add column if not exists serving_temp_c integer;
alter table public.wines add column if not exists decant_minutes  integer;
alter table public.wines add column if not exists abv             real;

-- Add optional wine region column. Cascades from country in the client UI;
-- region keys come from the curated map in lib/common/data/wine_regions.dart
-- so values are intended to be a constrained vocabulary, not free text.
alter table public.wines
  add column if not exists region text;

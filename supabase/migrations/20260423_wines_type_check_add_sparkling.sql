-- Extend wines.type check constraint to include 'sparkling'.
-- WineType enum in app has red/white/rose/sparkling; DB was missing sparkling.
alter table public.wines drop constraint wines_type_check;
alter table public.wines add constraint wines_type_check
  check (type = any (array['red'::text, 'white'::text, 'rose'::text, 'sparkling'::text]));

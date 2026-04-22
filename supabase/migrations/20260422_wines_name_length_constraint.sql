-- Enforce wine name length server-side (1..60 chars).
alter table public.wines
  add constraint wines_name_length
  check (char_length(name) between 1 and 60);

-- Enforce group name length server-side (1..30 chars).
-- Truncate any existing names above the limit before adding the check.
update public.groups
  set name = substring(name from 1 for 30)
  where char_length(name) > 30;

alter table public.groups
  drop constraint if exists groups_name_length;

alter table public.groups
  add constraint groups_name_length
  check (char_length(name) between 1 and 30);

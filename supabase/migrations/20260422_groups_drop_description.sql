-- Drop unused description column from groups.
alter table public.groups drop column if exists description;

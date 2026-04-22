-- Add image_url column to groups (model + UI already expect it).
alter table public.groups add column if not exists image_url text;

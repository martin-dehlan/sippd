-- Wine images storage bucket + RLS policies.
-- Path convention: <user_id>/<uuid>.<ext>  (matches WineImageService).
-- Reads: public (group members / friends fetching wines need to load
-- the photo without per-row signed URLs).
-- Writes: only the owning user (folder name = auth.uid()).
--
-- This bucket existed historically but was created via the Supabase
-- dashboard with no migration. Codifying it here so `supabase db reset`
-- and preview branches reproduce it. `on conflict do nothing` keeps the
-- existing production bucket untouched.

insert into storage.buckets (id, name, public)
values ('wine-images', 'wine-images', true)
on conflict (id) do nothing;

create policy "wine_images_read"
  on storage.objects for select
  using (bucket_id = 'wine-images');

create policy "wine_images_upload"
  on storage.objects for insert
  with check (
    bucket_id = 'wine-images'
    and auth.uid()::text = (storage.foldername(name))[1]
  );

create policy "wine_images_update"
  on storage.objects for update
  using (
    bucket_id = 'wine-images'
    and auth.uid()::text = (storage.foldername(name))[1]
  );

create policy "wine_images_delete"
  on storage.objects for delete
  using (
    bucket_id = 'wine-images'
    and auth.uid()::text = (storage.foldername(name))[1]
  );

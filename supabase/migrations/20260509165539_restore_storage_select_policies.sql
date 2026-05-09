-- Restore the SELECT policies on storage.objects + storage.buckets that the
-- 2026-05-08 security baseline removed. Without them the Supabase storage
-- server's multipart upload code path returns
--   {"statusCode":"403","message":"new row violates row-level security policy"}
-- on every upload (Flutter/Dart SDK uses multipart form-encoding by default).
-- The HTTP wrapper makes it look like an INSERT-policy denial, but the real
-- failure is the storage server's pre-flight SELECT against storage.objects
-- (for upsert/version handling) being denied.
--
-- We also tighten/refresh the wine-images write policies (explicit WITH CHECK
-- on UPDATE so upserts match), and add owner-scoped RLS on the s3_multipart_*
-- bookkeeping tables that the storage server uses internally.

-- 1. storage.buckets — needed so authenticated/anon can resolve buckets
create policy "buckets_authenticated_read"
  on storage.buckets for select
  to public
  using (true);

-- 2. storage.objects — public-read policies per public bucket
create policy "wine_images_read"
  on storage.objects for select
  to public
  using (bucket_id = 'wine-images');

create policy "avatars_read"
  on storage.objects for select
  to public
  using (bucket_id = 'avatars');

create policy "group_images_read"
  on storage.objects for select
  to public
  using (bucket_id = 'group-images');

-- 3. wine_images write policies — recreate with explicit WITH CHECK on UPDATE
--    so INSERT ... ON CONFLICT DO UPDATE (the SDK upsert path) validates
--    correctly. The original policy left WITH CHECK null which fell back to
--    qual against an OLD row that doesn't exist on first upload.
drop policy if exists wine_images_upload on storage.objects;
drop policy if exists wine_images_update on storage.objects;

create policy "wine_images_upload"
  on storage.objects for insert
  to authenticated
  with check (
    bucket_id = 'wine-images'
    and (auth.uid())::text = (storage.foldername(name))[1]
  );

create policy "wine_images_update"
  on storage.objects for update
  to authenticated
  using (
    bucket_id = 'wine-images'
    and (auth.uid())::text = (storage.foldername(name))[1]
  )
  with check (
    bucket_id = 'wine-images'
    and (auth.uid())::text = (storage.foldername(name))[1]
  );

-- 4. s3_multipart_uploads + parts — owner-scoped policies. The storage server
--    writes here for every multipart upload (even small files) and the baseline
--    left these tables with RLS enabled but zero policies, denying everything.
create policy "multipart_owner_rw"
  on storage.s3_multipart_uploads
  for all
  to authenticated
  using (owner_id = (auth.uid())::text)
  with check (owner_id = (auth.uid())::text);

create policy "multipart_parts_owner_rw"
  on storage.s3_multipart_uploads_parts
  for all
  to authenticated
  using (owner_id = (auth.uid())::text)
  with check (owner_id = (auth.uid())::text);

-- Group images storage bucket + RLS policies.
-- Path convention: <group_id>/<uuid>.<ext>
-- Upload/update/delete restricted to members of that group.

insert into storage.buckets (id, name, public)
values ('group-images', 'group-images', true)
on conflict (id) do nothing;

create policy "group_images_read"
  on storage.objects for select
  using (bucket_id = 'group-images');

create policy "group_images_upload"
  on storage.objects for insert
  with check (
    bucket_id = 'group-images'
    and exists (
      select 1 from public.group_members gm
      where gm.group_id::text = (storage.foldername(name))[1]
        and gm.user_id = auth.uid()
    )
  );

create policy "group_images_update"
  on storage.objects for update
  using (
    bucket_id = 'group-images'
    and exists (
      select 1 from public.group_members gm
      where gm.group_id::text = (storage.foldername(name))[1]
        and gm.user_id = auth.uid()
    )
  );

create policy "group_images_delete"
  on storage.objects for delete
  using (
    bucket_id = 'group-images'
    and exists (
      select 1 from public.group_members gm
      where gm.group_id::text = (storage.foldername(name))[1]
        and gm.user_id = auth.uid()
    )
  );

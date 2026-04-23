-- Delete a shared wine from a group. Allowed for:
--   * the user who shared it (group_wines.shared_by)
--   * the group owner (groups.created_by)
-- Other members cannot remove someone else's share.

alter table public.group_wines enable row level security;

drop policy if exists "group_wines_delete_sharer_or_owner" on public.group_wines;
create policy "group_wines_delete_sharer_or_owner"
  on public.group_wines
  for delete
  using (
    auth.uid() = shared_by
    or exists (
      select 1 from public.groups g
      where g.id = group_wines.group_id
        and g.created_by = auth.uid()
    )
  );

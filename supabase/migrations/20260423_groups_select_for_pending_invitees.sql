-- Pending invitees must read the target group row (name, image_url) to
-- render the invitation card. The existing members-only select policy
-- hides it, so the inbox shows "Unknown group".
-- Scope: only groups where the current user has a pending invite.

drop policy if exists "groups_select_pending_invitee" on public.groups;
create policy "groups_select_pending_invitee"
  on public.groups
  for select
  using (
    exists (
      select 1 from public.group_invitations gi
      where gi.group_id   = groups.id
        and gi.invitee_id = auth.uid()
        and gi.status     = 'pending'
    )
  );

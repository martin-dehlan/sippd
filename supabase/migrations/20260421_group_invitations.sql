-- Group invitations: any group member can invite a friend.
-- Invitee accepts/declines from their inbox. Acceptance inserts
-- into group_members client-side after status update.

create table if not exists public.group_invitations (
  id            uuid primary key default gen_random_uuid(),
  group_id      text not null references public.groups(id)    on delete cascade,
  inviter_id    uuid not null references auth.users(id)       on delete cascade,
  invitee_id    uuid not null references auth.users(id)       on delete cascade,
  status        text not null default 'pending'
                check (status in ('pending','accepted','declined')),
  created_at    timestamptz not null default now(),
  responded_at  timestamptz
);

-- Only one active pending invite per (group, invitee).
create unique index if not exists group_invitations_unique_pending_idx
  on public.group_invitations (group_id, invitee_id)
  where status = 'pending';

create index if not exists group_invitations_invitee_idx
  on public.group_invitations (invitee_id, status);

create index if not exists group_invitations_group_idx
  on public.group_invitations (group_id, status);

alter table public.group_invitations enable row level security;

-- View: invites I sent OR received
drop policy if exists "group_invitations_select_self" on public.group_invitations;
create policy "group_invitations_select_self"
  on public.group_invitations
  for select
  using (auth.uid() = inviter_id or auth.uid() = invitee_id);

-- Insert: only as inviter, must be a member of the target group
drop policy if exists "group_invitations_insert_member" on public.group_invitations;
create policy "group_invitations_insert_member"
  on public.group_invitations
  for insert
  with check (
    auth.uid() = inviter_id
    and exists (
      select 1 from public.group_members gm
      where gm.group_id = group_invitations.group_id
        and gm.user_id  = auth.uid()
    )
  );

-- Update: only invitee can change status
drop policy if exists "group_invitations_update_invitee" on public.group_invitations;
create policy "group_invitations_update_invitee"
  on public.group_invitations
  for update
  using (auth.uid() = invitee_id);

-- Delete: either party can clear
drop policy if exists "group_invitations_delete_self" on public.group_invitations;
create policy "group_invitations_delete_self"
  on public.group_invitations
  for delete
  using (auth.uid() = invitee_id or auth.uid() = inviter_id);

-- Allow sender to delete their own friend_requests rows.
--
-- Bug: when a request is declined, friends.api.dart tries to wipe the
-- declined row before re-INSERTing so the receiver gets a fresh push.
-- The DELETE silently no-ops without RLS permission, then the INSERT
-- collides with the unique key on (sender_id, receiver_id) and surfaces
-- as a Postgres error in the client (red banner during friend re-send
-- after rejection).
--
-- Existing policies cover INSERT/SELECT/UPDATE; only DELETE was missing.
-- Receiver still cannot delete — they can only update status to
-- declined/accepted via the existing UPDATE policy.

drop policy if exists friend_requests_sender_delete on public.friend_requests;
create policy friend_requests_sender_delete
  on public.friend_requests
  for delete
  using (auth.uid() = sender_id);

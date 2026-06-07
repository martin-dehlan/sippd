-- SECURITY FIX (release audit #192).
--
-- The `feature_requests_insert` policy only checked `author_id`, so a user
-- could INSERT a row with `moderation_status = 'approved'` and skip the
-- moderation gate (spam straight onto the public board). Pin new
-- submissions to 'pending' in the policy's WITH CHECK.

drop policy if exists "feature_requests_insert" on public.feature_requests;

create policy "feature_requests_insert"
  on public.feature_requests for insert
  to authenticated
  with check (author_id = auth.uid() and moderation_status = 'pending');

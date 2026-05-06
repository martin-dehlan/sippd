-- Add tasting_wines + tasting_ratings to the supabase_realtime
-- publication so the in-app realtime channels can listen for INSERT /
-- UPDATE / DELETE events. RLS still enforces visibility — subscribers
-- only get rows they can SELECT (group membership in both cases via
-- tw_select_members and tr_select_members).
--
-- group_tastings and tasting_attendees are already in the publication
-- but the Dart-side providers were not subscribing; that's wired in
-- the same PR as this migration.

alter publication supabase_realtime add table public.tasting_wines;
alter publication supabase_realtime add table public.tasting_ratings;

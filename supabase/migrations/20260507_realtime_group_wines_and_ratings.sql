-- Add group_wines + group_wine_ratings to the realtime publication so
-- the carousel + per-wine footer + rank map can refresh live without
-- the user having to leave and re-enter the group when another member
-- shares a bottle or rates one.

alter publication supabase_realtime add table public.group_wines;
alter publication supabase_realtime add table public.group_wine_ratings;

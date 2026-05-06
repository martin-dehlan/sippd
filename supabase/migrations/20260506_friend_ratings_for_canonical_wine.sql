-- F1 Friend Ratings Strip — surface friend ratings on wine_detail.
--
-- Returns ratings from the caller's friends for a given canonical_wine_id.
-- Source = public.wines.rating (solo ratings only). Group/tasting ratings
-- intentionally NOT included: those tables are privacy-scoped to group
-- membership, and surfacing them via friendship would erode that boundary.
--
-- Security: invoker (default). RLS on wines, friendships, and profiles
-- already enforces what the caller may read. The explicit EXISTS clause on
-- friendships restricts results to actual friends — without it, RLS would
-- still permit rows from group-mates via wines_select_shared, which would
-- mislabel strangers as "friends" in the UI.

create or replace function public.get_friend_ratings_for_canonical_wine(
  p_canonical_wine_id uuid,
  p_limit             int default 10
)
returns table (
  user_id      uuid,
  display_name text,
  username     text,
  avatar_url   text,
  rating       numeric,
  rated_at     timestamptz
)
language sql
security invoker
set search_path = public
stable
as $$
  select
    w.user_id,
    p.display_name,
    p.username,
    p.avatar_url,
    w.rating::numeric,
    coalesce(w.updated_at, w.created_at) as rated_at
  from public.wines w
  join public.profiles p on p.id = w.user_id
  where w.canonical_wine_id = p_canonical_wine_id
    and w.user_id != auth.uid()
    and exists (
      select 1
      from public.friendships f
      where f.user_id   = auth.uid()
        and f.friend_id = w.user_id
    )
  order by w.rating desc nulls last,
           coalesce(w.updated_at, w.created_at) desc nulls last
  limit p_limit;
$$;

grant execute on function public.get_friend_ratings_for_canonical_wine(uuid, int) to authenticated;

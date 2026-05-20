-- Moment sharing & wine sharing — phase B + C of the Wine Moments
-- rollout. Two RPCs:
--
--  1. get_shared_moments(p_other_user_id)
--     Returns wine_memories rows where the current caller and the
--     other user are both involved. "Involved" = either owner or
--     tagged in companion_user_ids. Sorted most-recent first.
--     Powers the "Eure gemeinsamen Momente" section on friend_profile.
--
--  2. share_wine_to_friend(p_friend_id, p_wine_id)
--     Lets a user push the *wine identity* (canonical_wine + basic
--     attributes) into a friend's personal wines list. No-op if the
--     friend already has a wines row with the same canonical_wine_id.
--     Validates ownership of the source wine + an existing friendship.

-- ─── 1. get_shared_moments ──────────────────────────────────────────
create or replace function public.get_shared_moments(p_other_user_id uuid)
returns setof public.wine_memories
language sql
stable
security definer
set search_path = public
as $$
  select m.*
    from public.wine_memories m
   where (
      -- Caller owns it, other is tagged.
      (m.user_id = auth.uid() and p_other_user_id = any(m.companion_user_ids))
      or
      -- Other owns it, caller is tagged.
      (m.user_id = p_other_user_id and auth.uid() = any(m.companion_user_ids))
   )
   order by m.occurred_at desc, m.created_at desc;
$$;

revoke execute on function public.get_shared_moments(uuid) from public;
grant execute on function public.get_shared_moments(uuid) to authenticated;

-- ─── 2. share_wine_to_friend ────────────────────────────────────────
create or replace function public.share_wine_to_friend(
  p_friend_id uuid,
  p_wine_id   uuid
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_source         public.wines%rowtype;
  v_existing_id    uuid;
  v_new_wine_id    uuid;
  v_friendship_ok  boolean;
begin
  -- 1. Validate ownership of source wine.
  select * into v_source
    from public.wines
   where id = p_wine_id and user_id = auth.uid();
  if not found then
    raise exception 'wine not owned by caller'
      using errcode = 'P0001';
  end if;

  -- 2. Validate friendship (either direction).
  select exists (
    select 1 from public.friendships
     where (user_id = auth.uid() and friend_id = p_friend_id)
        or (user_id = p_friend_id and friend_id = auth.uid())
  ) into v_friendship_ok;
  if not v_friendship_ok then
    raise exception 'not friends with target user'
      using errcode = 'P0001';
  end if;

  -- 3. Look up an existing wines row for the friend matching the same
  --    canonical identity. If found, return it — friend already has
  --    the wine, no copy needed.
  if v_source.canonical_wine_id is not null then
    select id into v_existing_id
      from public.wines
     where user_id = p_friend_id
       and canonical_wine_id = v_source.canonical_wine_id
     limit 1;
    if v_existing_id is not null then
      return v_existing_id;
    end if;
  end if;

  -- 4. Copy core attributes onto a new wines row for the friend. Skip
  --    photo (sender's image_url is allowed only on sender's storage
  --    path under RLS) and rating (friend's rating is theirs to set).
  v_new_wine_id := gen_random_uuid();
  insert into public.wines (
    id, user_id,
    name, name_norm, type, currency,
    country, region, location, latitude, longitude,
    vintage, grape, canonical_grape_id, grape_freetext,
    canonical_wine_id, winery,
    visibility,
    rating
  ) values (
    v_new_wine_id, p_friend_id,
    v_source.name, v_source.name_norm, v_source.type, v_source.currency,
    v_source.country, v_source.region, v_source.location,
    v_source.latitude, v_source.longitude,
    v_source.vintage, v_source.grape, v_source.canonical_grape_id,
    v_source.grape_freetext,
    v_source.canonical_wine_id, v_source.winery,
    'friends',
    0
  );
  return v_new_wine_id;
end;
$$;

revoke execute on function public.share_wine_to_friend(uuid, uuid) from public;
grant execute on function public.share_wine_to_friend(uuid, uuid) to authenticated;

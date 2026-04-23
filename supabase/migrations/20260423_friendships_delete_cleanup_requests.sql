-- Extend mirror-delete trigger to also clear friend_requests rows between
-- the two users. Without this, the old 'accepted' row blocks re-adding
-- the friend (unique(sender_id, receiver_id) -> 23505 on re-send).

create or replace function public.friendships_mirror_delete()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.friendships
  where user_id = old.friend_id
    and friend_id = old.user_id;

  delete from public.friend_requests
  where (sender_id = old.user_id   and receiver_id = old.friend_id)
     or (sender_id = old.friend_id and receiver_id = old.user_id);

  return old;
end;
$$;

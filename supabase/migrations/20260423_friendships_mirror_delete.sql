-- Mirror delete of friendship rows bidirectionally.
-- RLS delete policy only allows auth.uid() = user_id, so the client
-- cannot delete the other user's mirror row. Trigger fills the gap.

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
  return old;
end;
$$;

drop trigger if exists friendships_mirror_delete_trg on public.friendships;

create trigger friendships_mirror_delete_trg
after delete on public.friendships
for each row execute function public.friendships_mirror_delete();

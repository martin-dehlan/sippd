-- delete_my_account v2:
--  1. Transfer ownership of groups with other members to oldest remaining
--     member so co-members do not lose shared wines/ratings/tastings.
--  2. Delete auth.users (cascades profile -> all public.* tables).
--
-- Storage cleanup runs client-side via Storage API before this RPC, because
-- the storage.protect_objects_delete trigger blocks direct DELETEs from SQL,
-- even from SECURITY DEFINER functions.
create or replace function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  uid uuid := auth.uid();
begin
  if uid is null then
    raise exception 'not authenticated';
  end if;

  update public.groups g
     set created_by = (
       select gm.user_id
         from public.group_members gm
        where gm.group_id = g.id
          and gm.user_id <> uid
        order by gm.joined_at asc
        limit 1
     )
   where g.created_by = uid
     and exists (
       select 1 from public.group_members gm
        where gm.group_id = g.id
          and gm.user_id <> uid
     );

  delete from auth.users where id = uid;
end;
$$;

revoke all on function public.delete_my_account() from public;
grant execute on function public.delete_my_account() to authenticated;

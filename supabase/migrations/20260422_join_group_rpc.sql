-- Join-by-invite-code RPC. Bypasses groups RLS (non-members can't SELECT)
-- and inserts membership idempotently. Returns the joined group id.

create or replace function public.join_group_by_invite_code(p_code text)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_group_id uuid;
  v_user_id  uuid := auth.uid();
begin
  if v_user_id is null then
    raise exception 'not authenticated' using errcode = '28000';
  end if;

  select id into v_group_id
  from public.groups
  where invite_code = p_code;

  if v_group_id is null then
    raise exception 'group not found' using errcode = 'P0002';
  end if;

  insert into public.group_members (group_id, user_id, role)
  values (v_group_id, v_user_id, 'member')
  on conflict (group_id, user_id) do nothing;

  return v_group_id;
end;
$$;

revoke all on function public.join_group_by_invite_code(text) from public;
grant execute on function public.join_group_by_invite_code(text) to authenticated;

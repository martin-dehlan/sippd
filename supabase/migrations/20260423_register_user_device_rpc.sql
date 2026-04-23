-- RPC for the client to claim an FCM token as its own. RLS on
-- user_devices prevents a client from transferring ownership directly,
-- so we route through a security-definer function that deletes the
-- prior owner's row before upserting the new one.

create or replace function public.register_user_device(
  p_token    text,
  p_platform text
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then
    raise exception 'not authenticated';
  end if;

  delete from public.user_devices
  where token = p_token
    and user_id <> auth.uid();

  insert into public.user_devices (user_id, token, platform, updated_at)
  values (auth.uid(), p_token, p_platform, now())
  on conflict (token) do update
    set user_id    = excluded.user_id,
        platform   = excluded.platform,
        updated_at = excluded.updated_at;
end;
$$;

grant execute on function public.register_user_device(text, text) to authenticated;

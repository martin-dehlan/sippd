-- Restore notify_push() + the 5 push triggers that were missing from the
-- live database. They are defined in the squashed baseline but somehow
-- absent on prod, so every event that should fan out to FCM (new friend
-- request, group join, shared wine, planned tasting, group invite) silently
-- dropped on the floor.
--
-- vault.secrets already has push_webhook_secret; matches the Edge Function
-- env var of the same name. The push function's `verify_jwt` was also
-- flipped to false in the same hotfix — it does its own webhook-secret
-- check inside the handler, so the gateway-level Bearer requirement was
-- 401'ing every Postgres-trigger call.

create or replace function public.notify_push()
returns trigger
language plpgsql
security definer
set search_path = public, extensions, vault
as $$
declare
  payload jsonb;
  secret  text;
  pk      jsonb;
begin
  select decrypted_secret into secret
  from vault.decrypted_secrets where name = 'push_webhook_secret' limit 1;

  if TG_TABLE_NAME = 'friend_requests'    then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_invitations' then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_tastings'    then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_members'     then pk := jsonb_build_object('group_id', new.group_id, 'user_id', new.user_id);
  elsif TG_TABLE_NAME = 'group_wines'       then pk := jsonb_build_object('id', new.id);
  else pk := '{}'::jsonb;
  end if;

  payload := jsonb_build_object(
    'type',  TG_OP,
    'table', TG_TABLE_NAME,
    'pk',    pk
  );

  perform net.http_post(
    url := 'https://ungvhpffjhnojessifri.supabase.co/functions/v1/push',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-webhook-secret', coalesce(secret, '')
    ),
    body := payload
  );
  return new;
end;
$$;

revoke execute on function public.notify_push() from public;

drop trigger if exists push_friend_requests on public.friend_requests;
create trigger push_friend_requests
  after insert on public.friend_requests
  for each row execute function public.notify_push();

drop trigger if exists push_friend_request_accept on public.friend_requests;
create trigger push_friend_request_accept
  after update on public.friend_requests
  for each row when (old.status is distinct from new.status and new.status = 'accepted')
  execute function public.notify_push();

drop trigger if exists push_group_invitations on public.group_invitations;
create trigger push_group_invitations
  after insert on public.group_invitations
  for each row execute function public.notify_push();

drop trigger if exists push_group_members on public.group_members;
create trigger push_group_members
  after insert on public.group_members
  for each row execute function public.notify_push();

drop trigger if exists push_group_tastings on public.group_tastings;
create trigger push_group_tastings
  after insert on public.group_tastings
  for each row execute function public.notify_push();

drop trigger if exists push_group_wines on public.group_wines;
create trigger push_group_wines
  after insert on public.group_wines
  for each row execute function public.notify_push();

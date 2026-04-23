-- Call the push Edge Function on relevant row inserts.
-- Runs via pg_net; failures do not block the DB write.

create or replace function public.notify_push()
returns trigger
language plpgsql
security definer
set search_path = public, extensions
as $$
declare
  payload jsonb;
begin
  payload := jsonb_build_object(
    'type', TG_OP,
    'table', TG_TABLE_NAME,
    'record', to_jsonb(NEW)
  );
  perform net.http_post(
    url := 'https://ungvhpffjhnojessifri.supabase.co/functions/v1/push',
    headers := jsonb_build_object('Content-Type', 'application/json'),
    body := payload
  );
  return NEW;
end;
$$;

drop trigger if exists push_group_invitations on public.group_invitations;
create trigger push_group_invitations
  after insert on public.group_invitations
  for each row execute function public.notify_push();

drop trigger if exists push_friend_requests on public.friend_requests;
create trigger push_friend_requests
  after insert on public.friend_requests
  for each row execute function public.notify_push();

drop trigger if exists push_group_tastings on public.group_tastings;
create trigger push_group_tastings
  after insert on public.group_tastings
  for each row execute function public.notify_push();

drop trigger if exists push_group_members on public.group_members;
create trigger push_group_members
  after insert on public.group_members
  for each row execute function public.notify_push();

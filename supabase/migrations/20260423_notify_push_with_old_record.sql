-- Extend notify_push to pass old_record on UPDATE and add accept trigger.

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
    'record', to_jsonb(NEW),
    'old_record', case when TG_OP = 'UPDATE' then to_jsonb(OLD) else null end
  );
  perform net.http_post(
    url := 'https://ungvhpffjhnojessifri.supabase.co/functions/v1/push',
    headers := jsonb_build_object('Content-Type', 'application/json'),
    body := payload
  );
  return NEW;
end;
$$;

drop trigger if exists push_friend_request_accept on public.friend_requests;
create trigger push_friend_request_accept
  after update on public.friend_requests
  for each row
  when (old.status is distinct from new.status and new.status = 'accepted')
  execute function public.notify_push();

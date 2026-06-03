-- ============================================================================
-- Badge unlock push notification
-- ============================================================================
-- Milestone "B5". Issue #154 (push side; in-app celebration lives in the app).
-- A push fires only for genuinely new (unseen) awards, so the backfill — which
-- inserts pre-seen rows — never blasts existing users. Respects a new opt-out
-- pref column `badges` (default on), checked by the push Edge Function.
-- ============================================================================

-- Opt-out preference (default on). The Edge Function maps badge_unlocked →
-- this column; users who turn it off get no badge pushes.
alter table public.user_notification_prefs
  add column if not exists badges boolean not null default true;

-- Re-define notify_push() to also envelope user_badges rows. Identical to the
-- restored definition plus the new branch; pk carries the composite key.
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

  if TG_TABLE_NAME = 'friend_requests'      then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_invitations' then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_tastings'    then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_members'     then pk := jsonb_build_object('group_id', new.group_id, 'user_id', new.user_id);
  elsif TG_TABLE_NAME = 'group_wines'       then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'user_badges'       then pk := jsonb_build_object('user_id', new.user_id, 'badge_id', new.badge_id);
  else pk := '{}'::jsonb;
  end if;

  payload := jsonb_build_object('type', TG_OP, 'table', TG_TABLE_NAME, 'pk', pk);

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

-- Only fire for fresh awards (seen_at null). Backfill rows are pre-seen.
drop trigger if exists push_user_badges on public.user_badges;
create trigger push_user_badges
  after insert on public.user_badges
  for each row when (new.seen_at is null)
  execute function public.notify_push();

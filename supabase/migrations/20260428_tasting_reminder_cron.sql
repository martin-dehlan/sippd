-- Server-side tasting reminders. Replaces the client-side AlarmManager
-- approach so we don't need SCHEDULE_EXACT_ALARM grants on Android. The
-- tasting-reminders edge function runs every minute via pg_cron, sends
-- FCM for any tasting whose (scheduled_at - prefHours) has just passed,
-- and stamps reminder_sent_at so it only fires once.

alter table public.group_tastings
  add column if not exists reminder_sent_at timestamptz;

-- Reset reminder_sent_at when scheduled_at moves so the cron picks the
-- new fire time up. Cancellation is implicit: row delete cascades.
create or replace function public.tg_reset_tasting_reminder_on_reschedule()
returns trigger
language plpgsql
as $$
begin
  if NEW.scheduled_at is distinct from OLD.scheduled_at then
    NEW.reminder_sent_at := null;
  end if;
  return NEW;
end;
$$;

drop trigger if exists group_tastings_reset_reminder on public.group_tastings;
create trigger group_tastings_reset_reminder
  before update on public.group_tastings
  for each row execute function public.tg_reset_tasting_reminder_on_reschedule();

-- Index helps the cron query find unsent reminders cheaply once the table
-- grows; partial index keeps it tiny because most rows are sent.
create index if not exists group_tastings_reminder_pending_idx
  on public.group_tastings (scheduled_at)
  where reminder_sent_at is null;

-- Schedule the edge function every minute. Reuses the push_webhook_secret
-- vault entry that the existing notify_push trigger already relies on.
select cron.schedule(
  'tasting_reminders_every_minute',
  '* * * * *',
  $cron$
  select net.http_post(
    url := 'https://ungvhpffjhnojessifri.supabase.co/functions/v1/tasting-reminders',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-webhook-secret', coalesce(
        (select decrypted_secret from vault.decrypted_secrets where name = 'push_webhook_secret' limit 1),
        ''
      )
    ),
    body := '{}'::jsonb
  );
  $cron$
);

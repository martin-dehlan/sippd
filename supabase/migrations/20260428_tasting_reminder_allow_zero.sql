-- Allow tasting_reminder_hours = 0 as a debug-only "30 seconds before"
-- offset (handled in claim_due_tasting_reminders). The production picker
-- only ever shows >= 1; the 0 path exists purely for developers to verify
-- the cron + FCM chain quickly.

alter table public.user_notification_prefs
  drop constraint if exists user_notification_prefs_tasting_reminder_hours_check;

alter table public.user_notification_prefs
  add constraint user_notification_prefs_tasting_reminder_hours_check
  check (tasting_reminder_hours between 0 and 24);

create or replace function public.claim_due_tasting_reminders()
returns table (
  tasting_id uuid,
  user_id uuid,
  tasting_title text,
  group_id uuid
)
language plpgsql
security definer
set search_path = public
as $$
begin
  return query
  with due as (
    select ta.tasting_id, ta.user_id
    from public.tasting_attendees ta
    join public.group_tastings gt on gt.id = ta.tasting_id
    join public.user_notification_prefs np on np.user_id = ta.user_id
    where ta.status in ('going', 'maybe')
      and ta.reminder_sent_at is null
      and gt.scheduled_at > now()
      and np.tasting_reminders = true
      and gt.scheduled_at - (
        case
          when np.tasting_reminder_hours = 0 then interval '30 seconds'
          else np.tasting_reminder_hours * interval '1 hour'
        end
      ) <= now()
    for update of ta skip locked
  ),
  stamped as (
    update public.tasting_attendees ta
    set reminder_sent_at = now()
    from due
    where ta.tasting_id = due.tasting_id and ta.user_id = due.user_id
    returning ta.tasting_id, ta.user_id
  )
  select stamped.tasting_id, stamped.user_id, gt.title, gt.group_id
  from stamped
  join public.group_tastings gt on gt.id = stamped.tasting_id;
end;
$$;

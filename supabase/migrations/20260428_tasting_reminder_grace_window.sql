-- Reminder firing window — cron ticks once per minute, so a tasting that
-- starts on the dot would be skipped on the same minute its scheduled_at
-- matches now() (scheduled_at > now() flips false the moment we hit it).
-- Plus the debug 30s offset is narrower than one cron interval. Grant a
-- 15-minute grace past scheduled_at: better to land a slightly-late
-- "your tasting starts soon" than to silently drop it.

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
      and gt.scheduled_at > now() - interval '15 minutes'
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

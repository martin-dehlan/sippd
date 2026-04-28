-- Send reminders to attendees who said going OR maybe. 'declined' and
-- 'no_response' stay excluded — declined is an explicit no, no_response
-- means the user hasn't engaged with the invite yet.

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
      and gt.scheduled_at - (np.tasting_reminder_hours * interval '1 hour') <= now()
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

-- Partial index needs to match the new WHERE clause to stay useful.
drop index if exists public.tasting_attendees_reminder_pending_idx;

create index tasting_attendees_reminder_pending_idx
  on public.tasting_attendees (tasting_id)
  where reminder_sent_at is null and status in ('going', 'maybe');

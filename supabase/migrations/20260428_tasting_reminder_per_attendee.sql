-- Move reminder tracking from group_tastings (per-tasting) to
-- tasting_attendees (per-attendee-per-tasting). Each user has their own
-- pref offset, so reminders fire at different absolute times for different
-- attendees of the same tasting — coarse per-tasting tracking can't model
-- that. Also adds an atomic FOR UPDATE SKIP LOCKED claim function so
-- concurrent cron invocations can't double-send.

-- Drop old per-tasting infrastructure.
drop trigger if exists group_tastings_reset_reminder on public.group_tastings;
drop function if exists public.tg_reset_tasting_reminder_on_reschedule();
drop index if exists public.group_tastings_reminder_pending_idx;
alter table public.group_tastings drop column if exists reminder_sent_at;

-- Per-attendee tracking.
alter table public.tasting_attendees
  add column if not exists reminder_sent_at timestamptz;

create index if not exists tasting_attendees_reminder_pending_idx
  on public.tasting_attendees (tasting_id)
  where reminder_sent_at is null and status = 'going';

-- When the host moves scheduled_at, every attendee's reminder needs to
-- re-fire at the new time, so wipe their stamps.
create or replace function public.tg_reset_attendee_reminders_on_reschedule()
returns trigger
language plpgsql
as $$
begin
  if NEW.scheduled_at is distinct from OLD.scheduled_at then
    update public.tasting_attendees
    set reminder_sent_at = null
    where tasting_id = NEW.id;
  end if;
  return NEW;
end;
$$;

create trigger group_tastings_reset_attendee_reminders
  after update on public.group_tastings
  for each row execute function public.tg_reset_attendee_reminders_on_reschedule();

-- Atomic claim. Selects every attendee whose reminder is due (per their
-- own user_notification_prefs), locks the rows, stamps reminder_sent_at,
-- and returns the data the edge function needs to send FCM. The edge
-- function reverts the stamp (sets it back to null) on transport failure
-- so the next cron tick retries.
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
    where ta.status = 'going'
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

grant execute on function public.claim_due_tasting_reminders() to service_role;

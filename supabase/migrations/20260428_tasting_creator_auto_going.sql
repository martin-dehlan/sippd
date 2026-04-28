-- Creator of a tasting is implicitly attending — they planned it. Without
-- this, the AFTER INSERT trigger on group_tastings inserts the creator as
-- 'no_response' along with everyone else, which means the reminder cron
-- skips them (the very person most likely to want a reminder).

create or replace function public.handle_tasting_created()
returns trigger
language plpgsql
security definer
as $$
begin
  insert into public.tasting_attendees (tasting_id, user_id, status)
  select
    new.id,
    gm.user_id,
    case when gm.user_id = new.created_by then 'going' else 'no_response' end
  from public.group_members gm
  where gm.group_id = new.group_id
  on conflict do nothing;
  return new;
end;
$$;

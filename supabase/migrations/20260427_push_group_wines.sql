-- Push notification when a wine is shared into a group.
-- Reuses existing public.notify_push() function; new group members
-- still get notified via the group_members trigger from the previous
-- migration, so this only covers wine-share events.

drop trigger if exists push_group_wines on public.group_wines;
create trigger push_group_wines
  after insert on public.group_wines
  for each row execute function public.notify_push();

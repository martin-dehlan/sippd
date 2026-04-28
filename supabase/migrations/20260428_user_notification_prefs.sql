-- User-level notification preferences. One row per profile, auto-seeded with
-- defaults on profile insert so the push edge function and client never have
-- to handle a "missing row" branch.

create table public.user_notification_prefs (
  user_id                  uuid primary key references public.profiles(id) on delete cascade,
  tasting_reminders        boolean  not null default true,
  tasting_reminder_hours   smallint not null default 1
    check (tasting_reminder_hours between 1 and 24),
  friend_activity          boolean  not null default true,
  group_activity           boolean  not null default true,
  group_wine_shared        boolean  not null default true,
  created_at               timestamptz not null default now(),
  updated_at               timestamptz not null default now()
);

alter table public.user_notification_prefs enable row level security;

create policy "user_notification_prefs_own_select"
  on public.user_notification_prefs
  for select
  using (auth.uid() = user_id);

create policy "user_notification_prefs_own_insert"
  on public.user_notification_prefs
  for insert
  with check (auth.uid() = user_id);

create policy "user_notification_prefs_own_update"
  on public.user_notification_prefs
  for update
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- updated_at maintenance.
create or replace function public.tg_user_notification_prefs_set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger user_notification_prefs_set_updated_at
  before update on public.user_notification_prefs
  for each row execute function public.tg_user_notification_prefs_set_updated_at();

-- Auto-seed default row for every new profile.
create or replace function public.tg_seed_user_notification_prefs()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.user_notification_prefs (user_id)
  values (new.id)
  on conflict (user_id) do nothing;
  return new;
end;
$$;

create trigger profiles_seed_user_notification_prefs
  after insert on public.profiles
  for each row execute function public.tg_seed_user_notification_prefs();

-- Backfill existing profiles so the edge function can rely on every recipient
-- having a row.
insert into public.user_notification_prefs (user_id)
select id from public.profiles
on conflict (user_id) do nothing;

-- Service role read access for the push edge function (it filters recipients
-- by category before sending FCM messages).
grant select on public.user_notification_prefs to service_role;

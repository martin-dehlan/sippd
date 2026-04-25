-- Track onboarding completion per account so the quiz fires once per user,
-- not once per device. Replaces the old SharedPreferences-only flag.
alter table public.profiles
  add column if not exists onboarding_completed boolean not null default false;

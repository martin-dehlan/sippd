-- Tightens display_name from 1..40 to 1..30 to match the consumer-app
-- conventions (Instagram, Reddit, Apple ID first/last) and align with
-- the existing onboarding name page cap.
--
-- Trim any over-long row in place before swapping the constraint, since
-- ALTER would otherwise fail with check_violation. (No-op on a fresh
-- DB — the previous migration's 1..40 cap rejected anything longer.)

update public.profiles
   set display_name = substring(display_name from 1 for 30)
 where display_name is not null and char_length(display_name) > 30;

alter table public.profiles
  drop constraint profiles_display_name_length,
  add  constraint profiles_display_name_length
    check (display_name is null or char_length(display_name) between 1 and 30);

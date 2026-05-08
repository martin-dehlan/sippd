-- Defense-in-depth for the identity table that 20260508_text_length_caps.sql
-- skipped. Direct REST/SQL writes to public.profiles currently bypass the
-- UI caps in choose_username (20), edit_profile (display_name 40), and the
-- signup form, because none of these columns have CHECK constraints.

alter table public.profiles
  add constraint profiles_display_name_length
    check (display_name is null or char_length(display_name) between 1 and 40),
  add constraint profiles_username_length
    check (username is null or char_length(username) between 3 and 20),
  add constraint profiles_username_format
    check (username is null or username ~ '^[a-z0-9._]+$'),
  add constraint profiles_avatar_url_length
    check (avatar_url is null or char_length(avatar_url) <= 500);

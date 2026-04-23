-- A given FCM token must belong to exactly one user (account switches on
-- the same device used to leave duplicate rows, causing cross-account pushes).

delete from public.user_devices a
using public.user_devices b
where a.token = b.token
  and a.user_id <> b.user_id
  and a.updated_at < b.updated_at;

delete from public.user_devices a
using public.user_devices b
where a.token = b.token
  and a.user_id <> b.user_id
  and a.created_at < b.created_at;

alter table public.user_devices
  drop constraint if exists user_devices_token_unique;
alter table public.user_devices
  add constraint user_devices_token_unique unique (token);

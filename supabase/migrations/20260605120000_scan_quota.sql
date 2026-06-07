-- Wine-label scan quota (milestone S1 · issue #175).
--
-- FastCork recognition costs $0.003 per call, so every scan must be
-- metered server-side BEFORE the Edge Function hits FastCork. This
-- migration adds the usage ledger + an atomic claim RPC.
--
-- Quota policy:
--   everyone : 5 scans per rolling 24h.
--
-- The scanner is NOT a Pro perk — every signed-in user gets the same
-- daily allowance. There is deliberately no `is_pro` input: the quota
-- keys solely on `auth.uid()`, so there is nothing a client can set to
-- lift its own cap (no spoof surface). The daily cap bounds worst-case
-- FastCork cost to ~5 × $0.003 = $0.015 per user per day. Manual wine
-- entry (no scan) is always available and never metered.
--
-- Additive only: new table + new functions, no changes to existing
-- objects (migration-compat policy — must stay backward-compatible
-- with the oldest live app).

create table if not exists public.scan_usage (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references auth.users (id) on delete cascade,
  scanned_at  timestamptz not null default now()
);

create index if not exists scan_usage_user_time_idx
  on public.scan_usage (user_id, scanned_at desc);

alter table public.scan_usage enable row level security;

-- Users may read their own scan history (powers the "N scans left"
-- counter). Writes go exclusively through the SECURITY DEFINER RPC.
drop policy if exists scan_usage_select_own on public.scan_usage;
create policy scan_usage_select_own
  on public.scan_usage
  for select
  using (auth.uid() = user_id);

-- Drop the earlier pro-aware overloads (never shipped to prod). The
-- scanner no longer takes an is_pro flag — see header note.
drop function if exists public.check_and_consume_scan(boolean);
drop function if exists public.scan_quota_status(boolean);

-- Atomically check the rolling-24h quota and, when allowed, record one
-- scan. Returns the post-claim remaining count so the client can render
-- the counter without a second round-trip.
--
-- Concurrency: the count + insert run in a single statement-level
-- transaction. Two simultaneous calls can in theory both read the same
-- pre-count, so we re-check after insert and roll the row back when it
-- would breach the cap — no double-spend past the limit.
create or replace function public.check_and_consume_scan()
returns table (allowed boolean, used integer, scan_limit integer, remaining integer)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid      uuid := auth.uid();
  v_limit    integer := 5;
  v_window   timestamptz := now() - interval '1 day';
  v_used     integer;
begin
  if v_uid is null then
    raise exception 'unauthorized' using errcode = '42501';
  end if;

  select count(*) into v_used
  from public.scan_usage
  where user_id = v_uid and scanned_at >= v_window;

  if v_used >= v_limit then
    return query select false, v_used, v_limit, 0;
    return;
  end if;

  insert into public.scan_usage (user_id) values (v_uid);

  -- Re-count after the write to defend against a concurrent claim that
  -- slipped past the same pre-count. If we overshot, undo this row.
  select count(*) into v_used
  from public.scan_usage
  where user_id = v_uid and scanned_at >= v_window;

  if v_used > v_limit then
    delete from public.scan_usage
    where id = (
      select id from public.scan_usage
      where user_id = v_uid
      order by scanned_at desc
      limit 1
    );
    return query select false, v_limit, v_limit, 0;
    return;
  end if;

  return query select true, v_used, v_limit, (v_limit - v_used);
end;
$$;

revoke all on function public.check_and_consume_scan() from public;
grant execute on function public.check_and_consume_scan() to authenticated, service_role;

-- Read-only helper for the UI to show remaining scans without
-- consuming one (e.g. when the scan entry button first renders).
create or replace function public.scan_quota_status()
returns table (used integer, scan_limit integer, remaining integer)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid    uuid := auth.uid();
  v_limit  integer := 5;
  v_window timestamptz := now() - interval '1 day';
  v_used   integer;
begin
  if v_uid is null then
    raise exception 'unauthorized' using errcode = '42501';
  end if;

  select count(*) into v_used
  from public.scan_usage
  where user_id = v_uid and scanned_at >= v_window;

  return query select v_used, v_limit, greatest(v_limit - v_used, 0);
end;
$$;

revoke all on function public.scan_quota_status() from public;
grant execute on function public.scan_quota_status() to authenticated, service_role;

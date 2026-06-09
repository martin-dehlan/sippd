-- Pro lifts the daily scan quota: free 5/day, Pro 50/day.
--
-- Pro status is SERVER-VERIFIED via profiles.is_pro, written only by the
-- RevenueCat webhook (service-role). The client never sends a Pro flag, so
-- the quota can't be spoofed. 50 (not unlimited) caps worst-case FastCork
-- cost even for a compromised Pro account.

alter table public.profiles
  add column if not exists is_pro boolean not null default false;

create or replace function public.check_and_consume_scan()
returns table (allowed boolean, used integer, scan_limit integer, remaining integer)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid    uuid := auth.uid();
  v_pro    boolean;
  v_limit  integer;
  v_window timestamptz := now() - interval '1 day';
  v_used   integer;
begin
  if v_uid is null then
    raise exception 'unauthorized' using errcode = '42501';
  end if;

  select is_pro into v_pro from public.profiles where id = v_uid;
  v_limit := case when coalesce(v_pro, false) then 50 else 5 end;

  select count(*) into v_used
  from public.scan_usage
  where user_id = v_uid and scanned_at >= v_window;

  if v_used >= v_limit then
    return query select false, v_used, v_limit, 0;
    return;
  end if;

  insert into public.scan_usage (user_id) values (v_uid);

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

create or replace function public.scan_quota_status()
returns table (used integer, scan_limit integer, remaining integer)
language plpgsql
security definer
set search_path = public
as $$
declare
  v_uid    uuid := auth.uid();
  v_pro    boolean;
  v_limit  integer;
  v_window timestamptz := now() - interval '1 day';
  v_used   integer;
begin
  if v_uid is null then
    raise exception 'unauthorized' using errcode = '42501';
  end if;

  select is_pro into v_pro from public.profiles where id = v_uid;
  v_limit := case when coalesce(v_pro, false) then 50 else 5 end;

  select count(*) into v_used
  from public.scan_usage
  where user_id = v_uid and scanned_at >= v_window;

  return query select v_used, v_limit, greatest(v_limit - v_used, 0);
end;
$$;

revoke all on function public.scan_quota_status() from public;
grant execute on function public.scan_quota_status() to authenticated, service_role;

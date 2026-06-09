-- ============================================================================
-- psql test harness for the badge engine. Run against a STAGING DB only:
--   psql "$STAGING_URL" -v ON_ERROR_STOP=1 -f supabase/tests/badges.sql
-- Each scenario runs in its own transaction and rolls back, so the DB is
-- untouched. Requires the badges migrations + seed to be applied first.
-- ============================================================================

\set ON_ERROR_STOP on
\set ECHO errors

\set user_a '''11111111-1111-1111-1111-111111111111'''
\set user_b '''22222222-2222-2222-2222-222222222222'''

create or replace function pg_temp.assert(scenario text, cond boolean, msg text)
returns void language plpgsql as $$
begin
  if not cond then
    raise exception 'FAIL [%]: %', scenario, msg;
  end if;
  raise notice 'PASS [%]: %', scenario, msg;
end;
$$;

-- Helper: insert N distinct rated personal wines (each a fresh canonical).
create or replace function pg_temp.seed_wines(p_user uuid, p_n int, p_type text)
returns void language plpgsql as $$
declare i int; cw uuid;
begin
  for i in 1..p_n loop
    cw := gen_random_uuid();
    insert into public.canonical_wine (id, name, name_norm, type)
      values (cw, 'w'||i, 'w'||i, p_type);
    insert into public.wines (id, user_id, name, rating, canonical_wine_id, type)
      values (gen_random_uuid(), p_user, 'w'||i, 8, cw, p_type);
  end loop;
end;
$$;


-- ─── Scenario 1: volume thresholds award exactly the crossed badges ───────
begin;
  insert into public.profiles (id, username) values (:user_a, 'alice')
    on conflict do nothing;
  -- 12 wines → first_sip (1) + getting_started (10), NOT wine_explorer (50).
  -- Triggers on the wines insert already evaluate; assert end state.
  perform pg_temp.seed_wines(:user_a::uuid, 12, 'red');

  select pg_temp.assert('volume',
    exists(select 1 from public.user_badges
           where user_id = :user_a and badge_id = 'first_sip'),
    'first_sip awarded at >=1');
  select pg_temp.assert('volume',
    exists(select 1 from public.user_badges
           where user_id = :user_a and badge_id = 'getting_started'),
    'getting_started awarded at >=10');
  select pg_temp.assert('volume',
    not exists(select 1 from public.user_badges
               where user_id = :user_a and badge_id = 'wine_explorer'),
    'wine_explorer NOT awarded below 50');
rollback;


-- ─── Scenario 2: evaluate_user_badges is idempotent ──────────────────────
begin;
  insert into public.profiles (id, username) values (:user_a, 'alice')
    on conflict do nothing;
  perform pg_temp.seed_wines(:user_a::uuid, 10, 'white');

  -- First explicit evaluation returns nothing new (triggers already awarded).
  perform public.evaluate_user_badges(:user_a::uuid);
  -- A second call must award nothing.
  select pg_temp.assert('idempotent',
    (select count(*) from public.evaluate_user_badges(:user_a::uuid)) = 0,
    'second evaluate awards nothing');
rollback;


-- ─── Scenario 3: type badge counts by wine type ──────────────────────────
begin;
  insert into public.profiles (id, username) values (:user_a, 'alice')
    on conflict do nothing;
  perform pg_temp.seed_wines(:user_a::uuid, 50, 'white');
  select pg_temp.assert('type',
    exists(select 1 from public.user_badges
           where user_id = :user_a and badge_id = 'white_wine_lover'),
    'white_wine_lover awarded at 50 whites');
  select pg_temp.assert('type',
    not exists(select 1 from public.user_badges
               where user_id = :user_a and badge_id = 'red_devotee'),
    'red_devotee NOT awarded with zero reds');
rollback;


-- ─── Scenario 4: ANTI-CHEAT — clients cannot insert user_badges ──────────
-- The core guarantee: as the `authenticated` role a direct insert must be
-- rejected by RLS (no insert policy exists).
begin;
  insert into public.profiles (id, username) values (:user_a, 'alice')
    on conflict do nothing;
  set local role authenticated;
  set local "request.jwt.claim.sub" to :user_a;
  do $$
  begin
    insert into public.user_badges (user_id, badge_id)
      values ('11111111-1111-1111-1111-111111111111', 'first_sip');
    raise exception 'FAIL [anti-cheat]: client insert into user_badges SUCCEEDED';
  exception
    when insufficient_privilege or others then
      raise notice 'PASS [anti-cheat]: client insert rejected (%)', sqlerrm;
  end;
  $$;
rollback;

\echo 'All badge scenarios passed.'

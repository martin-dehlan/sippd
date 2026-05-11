-- ============================================================================
-- psql test harness for get_user_rating_summary + unified compass/match.
-- Run against a staging DB (NEVER production):
--   psql "$STAGING_URL" -v ON_ERROR_STOP=1 -f supabase/tests/get_user_rating_summary.sql
-- Each scenario opens its own transaction and rolls back, so the DB is
-- untouched after the run completes.
-- ============================================================================

\set ON_ERROR_STOP on
\set ECHO errors

-- Fixed UUIDs we reuse across scenarios.
\set user_a    '''11111111-1111-1111-1111-111111111111'''
\set user_b    '''22222222-2222-2222-2222-222222222222'''
\set wine_1    '''aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'''
\set wine_2    '''bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb'''
\set wine_3    '''cccccccc-cccc-cccc-cccc-cccccccccccc'''
\set group_1   '''dddddddd-dddd-dddd-dddd-dddddddddddd'''
\set tasting_1 '''eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee'''

-- Helper: assert a key in the RPC payload matches an expected value.
create or replace function pg_temp.expect_equal(
  scenario text, key text, actual jsonb, expected jsonb
) returns void language plpgsql as $$
begin
  if actual is distinct from expected then
    raise exception 'FAIL [%]: expected %=%, got %', scenario, key, expected, actual;
  end if;
  raise notice 'PASS [%]: %=%', scenario, key, actual;
end;
$$;


-- ─── Scenario 1: empty user — avg = null, all counts = 0 ─────────────────
begin;
  set local "request.jwt.claim.sub" to :user_a;
  -- No fixture inserts. User has zero data anywhere.
  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select
    pg_temp.expect_equal('empty', 'avg_rating', (p->'avg_rating'), 'null'::jsonb),
    pg_temp.expect_equal('empty', 'distinct_wine_count', (p->'distinct_wine_count'), '0'::jsonb),
    pg_temp.expect_equal('empty', 'personal_count', (p->'personal_count'), '0'::jsonb)
  from r;
rollback;


-- ─── Scenario 2: same canonical rated personal=8 + group=9 → latest wins ─
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.canonical_wine (id, name, name_norm, type, country, region)
    values (:wine_1, 'Test Wine 1', 'test wine 1', 'red', 'Italy', 'Tuscany');

  -- Personal rating from yesterday.
  insert into public.wines (id, user_id, name, type, rating, canonical_wine_id, created_at, updated_at)
    values (gen_random_uuid(), :user_a, 'Test Wine 1', 'red', 8.0, :wine_1,
            now() - interval '1 day', now() - interval '1 day');

  -- Group rating today (later → wins).
  insert into public.groups (id, name, created_by) values (:group_1, 'TestGroup', :user_a);
  insert into public.group_wine_ratings
    (group_id, user_id, canonical_wine_id, rating, created_at, updated_at)
    values (:group_1, :user_a, :wine_1, 9.0, now(), now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select
    pg_temp.expect_equal('latest_wins', 'distinct_wine_count', (p->'distinct_wine_count'), '1'::jsonb),
    pg_temp.expect_equal('latest_wins', 'avg_rating', (p->'avg_rating'), '9.00'::jsonb),
    pg_temp.expect_equal('latest_wins', 'personal_count', (p->'personal_count'), '1'::jsonb),
    pg_temp.expect_equal('latest_wins', 'group_count', (p->'group_count'), '1'::jsonb)
  from r;
rollback;


-- ─── Scenario 3: triple-rated → tasting (latest) wins, single data point ──
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.canonical_wine (id, name, name_norm, type)
    values (:wine_1, 'Test Wine 1', 'test wine 1', 'red');

  insert into public.wines (id, user_id, name, type, rating, canonical_wine_id, created_at, updated_at)
    values (gen_random_uuid(), :user_a, 'Test Wine 1', 'red', 8.0, :wine_1,
            now() - interval '2 days', now() - interval '2 days');
  insert into public.groups (id, name, created_by) values (:group_1, 'TestGroup', :user_a);
  insert into public.group_wine_ratings
    (group_id, user_id, canonical_wine_id, rating, created_at, updated_at)
    values (:group_1, :user_a, :wine_1, 9.0, now() - interval '1 day', now() - interval '1 day');

  insert into public.group_tastings (id, group_id, title, scheduled_at, created_by, state)
    values (:tasting_1, :group_1, 'T', now(), :user_a, 'concluded');
  insert into public.tasting_ratings (tasting_id, user_id, canonical_wine_id, rating, created_at)
    values (:tasting_1, :user_a, :wine_1, 10.0, now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select
    pg_temp.expect_equal('triple_latest', 'distinct_wine_count', (p->'distinct_wine_count'), '1'::jsonb),
    pg_temp.expect_equal('triple_latest', 'avg_rating', (p->'avg_rating'), '10.00'::jsonb)
  from r;
rollback;


-- ─── Scenario 4: personal rating=0 excluded ──────────────────────────────
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.canonical_wine (id, name, name_norm, type)
    values (:wine_1, 'W', 'w', 'red');
  insert into public.canonical_wine (id, name, name_norm, type)
    values (:wine_2, 'W2', 'w2', 'red');

  -- rating=0 should NOT count
  insert into public.wines (id, user_id, name, type, rating, canonical_wine_id, created_at, updated_at)
    values (gen_random_uuid(), :user_a, 'W', 'red', 0.0, :wine_1, now(), now());
  -- rating=7 should count
  insert into public.wines (id, user_id, name, type, rating, canonical_wine_id, created_at, updated_at)
    values (gen_random_uuid(), :user_a, 'W2', 'red', 7.0, :wine_2, now(), now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select
    pg_temp.expect_equal('rating_zero_excluded', 'distinct_wine_count', (p->'distinct_wine_count'), '1'::jsonb),
    pg_temp.expect_equal('rating_zero_excluded', 'avg_rating', (p->'avg_rating'), '7.00'::jsonb)
  from r;
rollback;


-- ─── Scenario 5: tasting_ratings.rating IS NULL excluded ─────────────────
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.canonical_wine (id, name, name_norm, type)
    values (:wine_1, 'W', 'w', 'red');
  insert into public.groups (id, name, created_by) values (:group_1, 'G', :user_a);
  insert into public.group_tastings (id, group_id, title, scheduled_at, created_by, state)
    values (:tasting_1, :group_1, 'T', now(), :user_a, 'concluded');
  insert into public.tasting_ratings (tasting_id, user_id, canonical_wine_id, rating, created_at)
    values (:tasting_1, :user_a, :wine_1, null, now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select pg_temp.expect_equal('null_tasting_excluded', 'distinct_wine_count',
    (p->'distinct_wine_count'), '0'::jsonb)
  from r;
rollback;


-- ─── Scenario 6: tasting in 'upcoming' state excluded ────────────────────
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.canonical_wine (id, name, name_norm, type) values (:wine_1, 'W', 'w', 'red');
  insert into public.groups (id, name, created_by) values (:group_1, 'G', :user_a);
  insert into public.group_tastings (id, group_id, title, scheduled_at, created_by, state)
    values (:tasting_1, :group_1, 'T', now() + interval '1 day', :user_a, 'upcoming');
  insert into public.tasting_ratings (tasting_id, user_id, canonical_wine_id, rating, created_at)
    values (:tasting_1, :user_a, :wine_1, 8.0, now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select pg_temp.expect_equal('upcoming_tasting_excluded', 'distinct_wine_count',
    (p->'distinct_wine_count'), '0'::jsonb)
  from r;
rollback;


-- ─── Scenario 7: 3 distinct wines averaged ───────────────────────────────
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.canonical_wine (id, name, name_norm, type) values (:wine_1, 'W1', 'w1', 'red');
  insert into public.canonical_wine (id, name, name_norm, type) values (:wine_2, 'W2', 'w2', 'white');
  insert into public.canonical_wine (id, name, name_norm, type) values (:wine_3, 'W3', 'w3', 'sparkling');

  insert into public.wines (id, user_id, name, type, rating, canonical_wine_id, created_at, updated_at)
    values (gen_random_uuid(), :user_a, 'W1', 'red', 6.0, :wine_1, now(), now());
  insert into public.groups (id, name, created_by) values (:group_1, 'G', :user_a);
  insert into public.group_wine_ratings
    (group_id, user_id, canonical_wine_id, rating, created_at, updated_at)
    values (:group_1, :user_a, :wine_2, 8.0, now(), now());
  insert into public.group_tastings (id, group_id, title, scheduled_at, created_by, state)
    values (:tasting_1, :group_1, 'T', now(), :user_a, 'concluded');
  insert into public.tasting_ratings (tasting_id, user_id, canonical_wine_id, rating, created_at)
    values (:tasting_1, :user_a, :wine_3, 10.0, now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select
    pg_temp.expect_equal('three_contexts', 'distinct_wine_count', (p->'distinct_wine_count'), '3'::jsonb),
    pg_temp.expect_equal('three_contexts', 'avg_rating', (p->'avg_rating'), '8.00'::jsonb)
  from r;
rollback;


-- ─── Scenario 8: orphan personal wine (NULL canonical) counted ──────────
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.wines (id, user_id, name, type, rating, canonical_wine_id, created_at, updated_at)
    values (gen_random_uuid(), :user_a, 'NoCanon', 'red', 7.0, null, now(), now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select
    pg_temp.expect_equal('orphan_counted', 'distinct_wine_count', (p->'distinct_wine_count'), '1'::jsonb),
    pg_temp.expect_equal('orphan_counted', 'avg_rating', (p->'avg_rating'), '7.00'::jsonb)
  from r;
rollback;


-- ─── Scenario 9: self-only guard — wrong user_id returns empty payload ──
begin;
  set local "request.jwt.claim.sub" to :user_a;
  with r as (select public.get_user_rating_summary(:user_b::uuid) as p)
  select pg_temp.expect_equal('cross_user_blocked', 'avg_rating', (p->'avg_rating'), 'null'::jsonb)
  from r;
rollback;


-- ─── Scenario 10: same canonical, two groups → still dedupes to one ─────
begin;
  set local "request.jwt.claim.sub" to :user_a;
  insert into public.profiles (id, username) values (:user_a, 'alice') on conflict do nothing;
  insert into public.canonical_wine (id, name, name_norm, type) values (:wine_1, 'W', 'w', 'red');
  insert into public.groups (id, name, created_by)
    values (:group_1, 'G1', :user_a),
           ('99999999-9999-9999-9999-999999999999', 'G2', :user_a);
  insert into public.group_wine_ratings
    (group_id, user_id, canonical_wine_id, rating, created_at, updated_at)
    values
    (:group_1, :user_a, :wine_1, 7.0, now() - interval '1 day', now() - interval '1 day'),
    ('99999999-9999-9999-9999-999999999999', :user_a, :wine_1, 9.0, now(), now());

  with r as (select public.get_user_rating_summary(:user_a::uuid) as p)
  select
    pg_temp.expect_equal('dual_group_dedup', 'distinct_wine_count', (p->'distinct_wine_count'), '1'::jsonb),
    pg_temp.expect_equal('dual_group_dedup', 'avg_rating', (p->'avg_rating'), '9.00'::jsonb),
    pg_temp.expect_equal('dual_group_dedup', 'group_count', (p->'group_count'), '2'::jsonb)
  from r;
rollback;


\echo 'ALL SCENARIOS PASSED'

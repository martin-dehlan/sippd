-- ============================================================================
-- Badge / achievement engine — server-side, anti-cheat
-- ============================================================================
-- GitHub epic: milestone "B1 · Badge Engine". Issues #138-142.
--
-- Source of truth = this DB. Clients can READ their badges but can NEVER
-- write `user_badges` (no INSERT/UPDATE/DELETE policy). Awards happen only
-- inside `evaluate_user_badges()` (SECURITY DEFINER), which recomputes earned
-- badges from the authoritative activity tables. Therefore counts cannot be
-- forged from the client.
--
-- Award rules are data: each `badge_definitions.criterion` jsonb holds
-- `{ "metric": <key>, "gte": <n> }`. Both the award function and the progress
-- function read the SAME metric set (`_badge_metrics`) so the progress bar
-- the user sees matches the rule that awards the badge exactly.
--
-- Unlock display is decoupled from award time via `user_badges.seen_at`:
-- newly-earned rows start unseen (NULL); the celebration UI reads unseen rows
-- and marks them seen. This survives the trigger path (award can happen inside
-- a rating-write txn long before the client renders).
-- ============================================================================


-- ─── 1. Tables ────────────────────────────────────────────────────────────

create table if not exists public.badge_definitions (
  id           text primary key,                  -- stable slug, e.g. white_wine_lover
  category     text not null,                      -- volume|type|geo|grape|social|engagement
  tier         smallint not null default 1,        -- 1..5 within a progression family
  title        text not null,
  description  text not null,
  icon         text not null,                      -- client asset key
  criterion    jsonb not null,                     -- { "metric": <key>, "gte": <n> }
  sort_order   int not null default 0,
  is_active    boolean not null default true,
  created_at   timestamptz not null default now()
);

create table if not exists public.user_badges (
  user_id    uuid not null references public.profiles(id) on delete cascade,
  badge_id   text not null references public.badge_definitions(id) on delete cascade,
  earned_at  timestamptz not null default now(),
  seen_at    timestamptz,                          -- NULL = not yet shown to the user
  primary key (user_id, badge_id)
);

create index if not exists badge_definitions_active_idx
  on public.badge_definitions (category, is_active);
create index if not exists user_badges_user_idx
  on public.user_badges (user_id);
create index if not exists user_badges_unseen_idx
  on public.user_badges (user_id) where seen_at is null;


-- ─── 2. RLS — read-only to clients, awards only via SECURITY DEFINER ──────

alter table public.badge_definitions enable row level security;
alter table public.user_badges       enable row level security;

-- Catalog is readable by any signed-in user. No client write path.
drop policy if exists badge_definitions_select on public.badge_definitions;
create policy badge_definitions_select on public.badge_definitions
  for select to authenticated using (true);

-- A user reads their own badges; friends read each other's EARNED badges
-- (mirrors the friend-visibility pattern used by get_friend_ratings_*).
-- There is deliberately NO insert/update/delete policy: every direct client
-- write is rejected. This is the anti-cheat guarantee.
drop policy if exists user_badges_select on public.user_badges;
create policy user_badges_select on public.user_badges
  for select to authenticated using (
    user_id = auth.uid()
    or exists (
      select 1 from public.friendships
      where user_id = auth.uid() and friend_id = public.user_badges.user_id
    )
  );

grant select on public.badge_definitions to authenticated;
grant select on public.user_badges       to authenticated;


-- ─── 3. _badge_metrics — single authoritative metric set per user ─────────
-- Computes every scalar the 25 badges need, from base tables. Used by BOTH
-- the award function and the progress function. Cross-context unified +
-- latest-wins dedup mirrors get_user_rating_summary so numbers stay consistent
-- with the stats screen.

create or replace function public._badge_metrics(p_user_id uuid)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare
  v jsonb;
  v_old_world text[] := array['france','italy','spain','germany','portugal',
                              'fr','it','es','de','pt'];
  v_new_world text[] := array['united states','usa','us','united states of america',
                              'australia','au','new zealand','nz','chile','cl',
                              'argentina','ar','south africa','za'];
  v_france    text[] := array['france','fr'];
begin
  with
  events as (
    select w.canonical_wine_id, w.rating::numeric as value,
           coalesce(w.updated_at, w.created_at) as occurred_at,
           cw.type, cw.country, cw.region, cw.canonical_grape_id as grape_id,
           'personal'::text as context
    from public.wines w
    join public.canonical_wine cw on cw.id = w.canonical_wine_id
    where w.user_id = p_user_id and w.canonical_wine_id is not null and w.rating > 0
    union all
    select gwr.canonical_wine_id, gwr.rating::numeric,
           coalesce(gwr.updated_at, gwr.created_at),
           cw.type, cw.country, cw.region, cw.canonical_grape_id, 'group'
    from public.group_wine_ratings gwr
    join public.canonical_wine cw on cw.id = gwr.canonical_wine_id
    where gwr.user_id = p_user_id and gwr.rating is not null
    union all
    select tr.canonical_wine_id, tr.rating::numeric, tr.created_at,
           cw.type, cw.country, cw.region, cw.canonical_grape_id, 'tasting'
    from public.tasting_ratings tr
    join public.canonical_wine cw on cw.id = tr.canonical_wine_id
    join public.group_tastings gt on gt.id = tr.tasting_id
    where tr.user_id = p_user_id and tr.rating is not null
      and gt.state in ('active','concluded')
  ),
  dedup as (
    select distinct on (canonical_wine_id)
           value, type, country, region, grape_id
    from events
    order by canonical_wine_id, occurred_at desc, context desc
  ),
  orphan as (
    select w.rating::numeric as value, w.type, w.country, w.region,
           w.canonical_grape_id as grape_id
    from public.wines w
    where w.user_id = p_user_id and w.canonical_wine_id is null and w.rating > 0
  ),
  u as (
    select value, type, country, region, grape_id from dedup
    union all
    select value, type, country, region, grape_id from orphan
  ),
  agg as (
    select
      count(*)::int                                                    as distinct_wines,
      count(*) filter (where type = 'red')::int                        as red,
      count(*) filter (where type = 'white')::int                      as white,
      count(*) filter (where type = 'rose')::int                       as rose,
      count(*) filter (where type = 'sparkling')::int                  as sparkling,
      count(distinct country) filter (where country is not null)::int  as distinct_countries,
      count(*) filter (where lower(trim(country)) = any(v_old_world))::int as old_world,
      count(*) filter (where lower(trim(country)) = any(v_new_world))::int as new_world,
      count(*) filter (where lower(trim(country)) = any(v_france))::int    as france,
      count(distinct grape_id) filter (where grape_id is not null)::int   as distinct_grapes,
      round(avg(value)::numeric, 2)                                    as avg_rating,
      count(value)::int                                                as avg_n
    from u
  ),
  max_region as (
    select coalesce(max(c), 0)::int as v from (
      select count(*) c from u where region is not null group by region
    ) s
  ),
  max_grape as (
    select coalesce(max(c), 0)::int as v from (
      select count(*) c from u where grape_id is not null group by grape_id
    ) s
  ),
  -- Drinking buddies: max shared group/tasting-rated canonicals with any one
  -- other user (approximates get_top_drinking_partners.shared_wines).
  mine_co as (
    select canonical_wine_id from public.group_wine_ratings
      where user_id = p_user_id and canonical_wine_id is not null
    union
    select canonical_wine_id from public.tasting_ratings
      where user_id = p_user_id and canonical_wine_id is not null
  ),
  others_co as (
    select user_id, canonical_wine_id from public.group_wine_ratings
      where user_id <> p_user_id and canonical_wine_id is not null
    union
    select user_id, canonical_wine_id from public.tasting_ratings
      where user_id <> p_user_id and canonical_wine_id is not null
  ),
  max_partner as (
    select coalesce(max(c), 0)::int as v from (
      select o.user_id, count(distinct o.canonical_wine_id) c
      from others_co o join mine_co m on m.canonical_wine_id = o.canonical_wine_id
      group by o.user_id
    ) s
  ),
  social as (
    select
      (select count(*) from public.friendships where user_id = p_user_id)::int as friends,
      (case when exists (select 1 from public.group_members where user_id = p_user_id)
            then 1 else 0 end)                                                  as in_group,
      (case when exists (select 1 from public.group_tastings where created_by = p_user_id)
            then 1 else 0 end)                                                  as hosted,
      (select count(distinct ta.tasting_id)
         from public.tasting_attendees ta
         join public.group_tastings gt on gt.id = ta.tasting_id
        where ta.user_id = p_user_id and ta.status = 'going'
          and gt.state = 'concluded')::int                                     as tastings_attended,
      (select count(*) from public.wines
         where user_id = p_user_id and rating > 0
           and notes is not null and length(trim(notes)) > 0)::int             as notes
  )
  select jsonb_build_object(
    'distinct_wines',     a.distinct_wines,
    'red',                a.red,
    'white',              a.white,
    'rose',               a.rose,
    'sparkling',          a.sparkling,
    'min_type4',          least(a.red, a.white, a.rose, a.sparkling),
    'distinct_countries', a.distinct_countries,
    'old_world',          a.old_world,
    'new_world',          a.new_world,
    'france',             a.france,
    'max_region',         mr.v,
    'distinct_grapes',    a.distinct_grapes,
    'max_grape',          mg.v,
    'max_partner',        mp.v,
    'friends',            s.friends,
    'in_group',           s.in_group,
    'hosted',             s.hosted,
    'tastings_attended',  s.tastings_attended,
    'notes',              s.notes,
    'avg_rating',         coalesce(a.avg_rating, 0),
    'avg_n',              a.avg_n,
    'seasoned_ok',        case when a.avg_n >= 20 and coalesce(a.avg_rating,0) >= 7.5
                               then 1 else 0 end
  ) into v
  from agg a, max_region mr, max_grape mg, max_partner mp, social s;

  return v;
end;
$$;


-- ─── 4. evaluate_user_badges — award newly-qualified badges (idempotent) ──
-- Returns the badge_ids awarded THIS call (empty on a repeat call).

-- p_mark_seen=true inserts rows already seen (used by backfill) so neither
-- the celebration UI nor the push trigger fire for historical awards.
create or replace function public.evaluate_user_badges(
  p_user_id uuid,
  p_mark_seen boolean default false
)
returns setof text
language plpgsql
volatile security definer
set search_path = public
as $$
declare
  m jsonb;
begin
  if p_user_id is null then return; end if;
  m := public._badge_metrics(p_user_id);

  return query
  with qualifying as (
    select d.id
    from public.badge_definitions d
    where d.is_active
      and coalesce((m ->> (d.criterion ->> 'metric'))::numeric, 0)
          >= (d.criterion ->> 'gte')::numeric
  ),
  inserted as (
    insert into public.user_badges (user_id, badge_id, seen_at)
    select p_user_id, q.id, case when p_mark_seen then now() else null end
    from qualifying q
    on conflict (user_id, badge_id) do nothing
    returning badge_id
  )
  select badge_id from inserted;
end;
$$;

revoke all on function public.evaluate_user_badges(uuid) from public, anon, authenticated;


-- Self-serve wrapper for the client's manual refresh / celebration flow.
create or replace function public.evaluate_my_badges()
returns setof text
language sql
volatile security definer
set search_path = public
as $$
  select public.evaluate_user_badges(auth.uid());
$$;

grant execute on function public.evaluate_my_badges() to authenticated;


-- ─── 5. get_user_badge_progress — every active badge + the user's progress ─

create or replace function public.get_user_badge_progress(p_user_id uuid)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare
  m jsonb;
  v_is_self boolean;
  v_can_view boolean;
  v_result jsonb;
begin
  v_is_self := (p_user_id = auth.uid());
  v_can_view := v_is_self or exists (
    select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_user_id
  );
  if not v_can_view then return '[]'::jsonb; end if;

  -- Friend view: only earned badges (no progress leakage).
  if not v_is_self then
    select coalesce(jsonb_agg(jsonb_build_object(
      'badge_id', d.id, 'category', d.category, 'tier', d.tier,
      'title', d.title, 'description', d.description, 'icon', d.icon,
      'earned', true, 'earned_at', ub.earned_at,
      'current', (d.criterion ->> 'gte')::int, 'target', (d.criterion ->> 'gte')::int
    ) order by d.sort_order), '[]'::jsonb)
    into v_result
    from public.user_badges ub
    join public.badge_definitions d on d.id = ub.badge_id
    where ub.user_id = p_user_id and d.is_active;
    return v_result;
  end if;

  m := public._badge_metrics(p_user_id);
  select coalesce(jsonb_agg(jsonb_build_object(
    'badge_id', d.id, 'category', d.category, 'tier', d.tier,
    'title', d.title, 'description', d.description, 'icon', d.icon,
    'earned', ub.user_id is not null,
    'earned_at', ub.earned_at,
    'current', least(coalesce((m ->> (d.criterion ->> 'metric'))::int, 0),
                     (d.criterion ->> 'gte')::int),
    'target', (d.criterion ->> 'gte')::int
  ) order by d.sort_order), '[]'::jsonb)
  into v_result
  from public.badge_definitions d
  left join public.user_badges ub
    on ub.badge_id = d.id and ub.user_id = p_user_id
  where d.is_active;
  return v_result;
end;
$$;

grant execute on function public.get_user_badge_progress(uuid) to authenticated;


-- ─── 6. Unseen-badge surfacing + mark-seen (celebration plumbing) ─────────

create or replace function public.get_unseen_badges()
returns jsonb
language sql
stable security definer
set search_path = public
as $$
  select coalesce(jsonb_agg(jsonb_build_object(
    'badge_id', d.id, 'category', d.category, 'tier', d.tier,
    'title', d.title, 'description', d.description, 'icon', d.icon,
    'earned_at', ub.earned_at
  ) order by ub.earned_at), '[]'::jsonb)
  from public.user_badges ub
  join public.badge_definitions d on d.id = ub.badge_id
  where ub.user_id = auth.uid() and ub.seen_at is null and d.is_active;
$$;

grant execute on function public.get_unseen_badges() to authenticated;

-- Clients may only flip seen_at on their OWN already-earned rows. They still
-- cannot award a badge (no insert path), so anti-cheat holds.
create or replace function public.mark_badges_seen(p_ids text[])
returns void
language sql
volatile security definer
set search_path = public
as $$
  update public.user_badges
     set seen_at = now()
   where user_id = auth.uid() and seen_at is null
     and badge_id = any(p_ids);
$$;

grant execute on function public.mark_badges_seen(text[]) to authenticated;


-- ─── 7. Triggers — award the moment qualifying activity lands ─────────────

create or replace function public.tg_evaluate_badges_for_actor()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  -- Re-evaluate the acting user. Cheap: evaluate only inserts badges they
  -- don't already have. user_badges has no trigger → no recursion.
  perform public.evaluate_user_badges(
    coalesce(NEW.user_id, NEW.created_by)
  );
  return NEW;
end;
$$;

drop trigger if exists trg_badges_on_wine on public.wines;
create trigger trg_badges_on_wine
  after insert or update of rating, notes, canonical_wine_id on public.wines
  for each row execute function public.tg_evaluate_badges_for_actor();

drop trigger if exists trg_badges_on_group_rating on public.group_wine_ratings;
create trigger trg_badges_on_group_rating
  after insert or update of rating on public.group_wine_ratings
  for each row execute function public.tg_evaluate_badges_for_actor();

drop trigger if exists trg_badges_on_tasting_rating on public.tasting_ratings;
create trigger trg_badges_on_tasting_rating
  after insert or update of rating on public.tasting_ratings
  for each row execute function public.tg_evaluate_badges_for_actor();

drop trigger if exists trg_badges_on_friendship on public.friendships;
create trigger trg_badges_on_friendship
  after insert on public.friendships
  for each row execute function public.tg_evaluate_badges_for_actor();

drop trigger if exists trg_badges_on_group_member on public.group_members;
create trigger trg_badges_on_group_member
  after insert on public.group_members
  for each row execute function public.tg_evaluate_badges_for_actor();

drop trigger if exists trg_badges_on_tasting_attendee on public.tasting_attendees;
create trigger trg_badges_on_tasting_attendee
  after insert or update of status on public.tasting_attendees
  for each row execute function public.tg_evaluate_badges_for_actor();

-- group_tastings: host badge keys off created_by.
drop trigger if exists trg_badges_on_tasting_host on public.group_tastings;
create trigger trg_badges_on_tasting_host
  after insert on public.group_tastings
  for each row execute function public.tg_evaluate_badges_for_actor();


-- ─── 8. Backfill — award existing users without a notification storm ──────
-- Marks every backfilled award as already seen so users don't get a 20-badge
-- celebration blast on first launch post-deploy.

create or replace function public.backfill_all_badges()
returns void
language plpgsql
volatile security definer
set search_path = public
as $$
declare r record;
begin
  for r in select id from public.profiles loop
    perform public.evaluate_user_badges(r.id, true);  -- mark seen → no storm
  end loop;
end;
$$;

revoke all on function public.backfill_all_badges() from public, anon, authenticated;

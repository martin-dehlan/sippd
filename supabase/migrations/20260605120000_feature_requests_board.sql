-- Community Roadmap: feature request board (website-facing, shared DB)
-- Additive + isolated: no impact on existing app tables.
-- Surfaces on sippd.xyz/roadmap; auth via shared auth.users (Sippd account).

-- ---------------------------------------------------------------------------
-- Tables
-- ---------------------------------------------------------------------------
create table if not exists public.feature_requests (
  id         uuid        primary key default gen_random_uuid(),
  title      text        not null check (char_length(title) between 3 and 120),
  body       text        check (char_length(body) <= 2000),
  status     text        not null default 'open'
               check (status in ('open', 'planned', 'in_progress', 'shipped')),
  author_id  uuid        not null references auth.users (id) on delete cascade,
  created_at timestamptz not null default now()
);

create table if not exists public.feature_votes (
  request_id uuid        not null references public.feature_requests (id) on delete cascade,
  user_id    uuid        not null references auth.users (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (request_id, user_id) -- one vote per user per request
);

create index if not exists feature_requests_status_idx on public.feature_requests (status);
create index if not exists feature_votes_request_idx    on public.feature_votes (request_id);

-- ---------------------------------------------------------------------------
-- Public read view (vote_count + per-viewer has_voted)
-- security_invoker = on -> respects RLS of the querying role.
-- ---------------------------------------------------------------------------
create or replace view public.feature_requests_public
with (security_invoker = on) as
select
  r.id,
  r.title,
  r.body,
  r.status,
  r.author_id,
  r.created_at,
  count(v.user_id)                          as vote_count,
  coalesce(bool_or(v.user_id = auth.uid()), false) as has_voted
from public.feature_requests r
left join public.feature_votes v on v.request_id = r.id
group by r.id;

grant select on public.feature_requests_public to anon, authenticated;

-- ---------------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------------
alter table public.feature_requests enable row level security;
alter table public.feature_votes    enable row level security;

-- feature_requests: anyone reads; authed users create their own; no user update/delete
-- (status pipeline changed by admin via dashboard / service role in v1)
create policy "feature_requests_read"
  on public.feature_requests for select
  using (true);

create policy "feature_requests_insert"
  on public.feature_requests for insert
  to authenticated
  with check (author_id = auth.uid());

-- feature_votes: anyone reads (for counts); authed users add/remove only their own vote
create policy "feature_votes_read"
  on public.feature_votes for select
  using (true);

create policy "feature_votes_insert"
  on public.feature_votes for insert
  to authenticated
  with check (user_id = auth.uid());

create policy "feature_votes_delete"
  on public.feature_votes for delete
  to authenticated
  using (user_id = auth.uid());

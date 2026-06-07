-- Community Roadmap: moderation gate + abuse hardening
-- Additive on 20260605120000_feature_requests_board.sql.
-- Submissions land 'pending'; only 'approved' rows reach the public board.
-- Moderation in v1 is manual via dashboard / service role (see docs runbook).

-- ---------------------------------------------------------------------------
-- 1. Moderation status (separate from roadmap lifecycle `status`)
-- ---------------------------------------------------------------------------
alter table public.feature_requests
  add column if not exists moderation_status text not null default 'pending'
    check (moderation_status in ('pending', 'approved', 'rejected'));

create index if not exists feature_requests_moderation_idx
  on public.feature_requests (moderation_status);

-- Backfill existing rows (seed/demo) to approved so the board stays populated.
update public.feature_requests
  set moderation_status = 'approved'
  where moderation_status = 'pending';

-- ---------------------------------------------------------------------------
-- 2. Tighten input: title must not be whitespace-only
-- ---------------------------------------------------------------------------
alter table public.feature_requests
  drop constraint if exists feature_requests_title_not_blank;
alter table public.feature_requests
  add constraint feature_requests_title_not_blank check (btrim(title) <> '');

-- ---------------------------------------------------------------------------
-- 3. Public view: approved only
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
  count(v.user_id)                                 as vote_count,
  coalesce(bool_or(v.user_id = auth.uid()), false) as has_voted
from public.feature_requests r
left join public.feature_votes v on v.request_id = r.id
where r.moderation_status = 'approved'
group by r.id;

grant select on public.feature_requests_public to anon, authenticated;

-- ---------------------------------------------------------------------------
-- 4. Tighten read RLS: a row is visible only if approved OR it's your own
--    (anon -> auth.uid() is null -> approved only; submitter sees own pending)
-- ---------------------------------------------------------------------------
drop policy if exists "feature_requests_read" on public.feature_requests;
create policy "feature_requests_read"
  on public.feature_requests for select
  using (moderation_status = 'approved' or author_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 5. Votes only on approved requests
-- ---------------------------------------------------------------------------
drop policy if exists "feature_votes_insert" on public.feature_votes;
create policy "feature_votes_insert"
  on public.feature_votes for insert
  to authenticated
  with check (
    user_id = auth.uid()
    and exists (
      select 1 from public.feature_requests r
      where r.id = request_id
        and r.moderation_status = 'approved'
    )
  );

-- ---------------------------------------------------------------------------
-- 6. Rate limit: max 1 submission per author per trailing 24h
--    security definer so the count spans all rows (not RLS-filtered);
--    search_path pinned to prevent function hijack.
-- ---------------------------------------------------------------------------
create or replace function public.feature_requests_rate_limit()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if (
    select count(*) from public.feature_requests
    where author_id = new.author_id
      and created_at > now() - interval '24 hours'
  ) >= 1 then
    raise exception 'rate_limit: max 1 feature request per 24h'
      using errcode = 'check_violation';
  end if;
  return new;
end;
$$;

drop trigger if exists feature_requests_rate_limit_trg on public.feature_requests;
create trigger feature_requests_rate_limit_trg
  before insert on public.feature_requests
  for each row execute function public.feature_requests_rate_limit();

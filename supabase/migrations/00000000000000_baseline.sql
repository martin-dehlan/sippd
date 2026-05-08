-- ============================================================================
-- Sippd Supabase baseline schema — 2026-05-08
-- ============================================================================
-- Single canonical schema replacing the previous 60+ incremental migrations.
-- Built from a live-DB inventory + bakes in the security audit fixes:
--
--   C1  search_path on every SECURITY DEFINER function (incl. handle_*)
--   C3  register_user_device no longer wipes another user's row on conflict
--   H1  merge_canonical_wines requires loser is solely owned by the caller
--   H2  join_group_by_invite_code rate-limited + min 8-char code
--   H4  notify_push payload trimmed; edge function re-fetches via service role
--   H5  canonical_wine.created_by removed (privacy)
--   profiles_select restricted to authenticated (was open to anon)
--   wine_name_norm UTF-8 ß bug fixed (was 'Ã' replace, now 'ß')
--   group-images / avatars buckets get explicit MIME allowlist
--
-- Pre-launch reset baseline. After this lands, future migrations get real
-- timestamps. The repo migrations BEFORE this one were dashboard-applied +
-- partial — see git history for archaeology.
-- ============================================================================


-- ── 1. Extensions ───────────────────────────────────────────────────────────

create extension if not exists pg_trgm;
create extension if not exists unaccent;
-- pg_net + pg_cron + pgcrypto + supabase_vault are managed by Supabase
-- platform. Listed here for documentation only.


-- ── 2. Helper functions (no table deps) ─────────────────────────────────────

-- Normalize wine identity strings: lowercase + unaccent + ß→ss + collapse
-- whitespace + trim. Used by canonical resolver, wines.name_norm trigger,
-- suggest_canonical_match. Matches Dart side `normalizeName()`.
create or replace function public.normalize_wine_text(input text)
returns text
language sql
immutable
as $$
  select case
    when input is null or btrim(input) = '' then null
    else nullif(
      btrim(
        regexp_replace(
          replace(lower(public.unaccent(input)), 'ß', 'ss'),
          '\s+', ' ', 'g'
        )
      ),
      ''
    )
  end;
$$;

-- wines.name_norm fallback. Used by trigger when caller didn't pre-set it.
-- Matches normalize_wine_text but also strips non-alnum (looser than
-- canonical resolver — gives wider FTS-style matching for personal log).
create or replace function public.wine_name_norm(raw text)
returns text
language sql
immutable
as $$
  select case
    when raw is null then null
    else nullif(
      btrim(
        regexp_replace(
          regexp_replace(
            lower(public.unaccent(replace(raw, 'ß', 'ss'))),
            '[^[:alnum:][:space:]]', ' ', 'g'
          ),
          '\s+', ' ', 'g'
        )
      ),
      ''
    )
  end;
$$;


-- ── 3. Tables (in dependency order) ─────────────────────────────────────────

-- profiles: extends auth.users
create table if not exists public.profiles (
  id                    uuid primary key references auth.users(id) on delete cascade,
  username              text unique,
  display_name          text,
  avatar_url            text,
  onboarding_completed  boolean not null default false,
  taste_level           text check (
    taste_level is null
    or taste_level in ('beginner','curious','enthusiast','pro')
  ),
  goals                 text[] not null default '{}',
  styles                text[] not null default '{}',
  drink_frequency       text check (
    drink_frequency is null
    or drink_frequency in ('weekly','monthly','rare')
  ),
  taste_emoji           text,
  created_at            timestamptz not null default now(),
  updated_at            timestamptz
);

-- canonical_grape: read-only catalog of grape varieties
create table if not exists public.canonical_grape (
  id          uuid primary key default gen_random_uuid(),
  name        text not null unique,
  color       text not null check (color in ('red','white')),
  aliases     text[] not null default '{}',
  created_at  timestamptz not null default now()
);

create index if not exists canonical_grape_name_lower_idx
  on public.canonical_grape (lower(name));
create index if not exists canonical_grape_aliases_gin_idx
  on public.canonical_grape using gin (aliases);

-- canonical_grape_archetype: WSET-aligned style vector per grape
create table if not exists public.canonical_grape_archetype (
  canonical_grape_id   uuid primary key references public.canonical_grape(id) on delete cascade,
  body                 real not null check (body between 0 and 1),
  tannin               real check (tannin is null or tannin between 0 and 1),
  acidity              real not null check (acidity between 0 and 1),
  sweetness            real not null check (sweetness between 0 and 1),
  oak                  real not null check (oak between 0 and 1),
  intensity            real not null check (intensity between 0 and 1),
  typical_aroma_tags   text[] not null default '{}',
  source               text not null default 'curated'
                       check (source in ('curated','llm','expert_user')),
  filled_at            timestamptz not null default now()
);

-- canonical_wine: cross-user wine identity layer.
-- Audit H5: created_by column INTENTIONALLY REMOVED — leaked user enumeration
-- (every authenticated user could SELECT all rows including who first added).
create table if not exists public.canonical_wine (
  id                  uuid primary key default gen_random_uuid(),
  name                text not null,
  name_norm           text not null check (length(name_norm) > 0),
  winery              text,
  winery_norm         text,
  vintage             int,
  type                text check (type in ('red','white','rose','sparkling')),
  country             text,
  region              text,
  canonical_grape_id  uuid references public.canonical_grape(id) on delete set null,
  enriched_at         timestamptz,
  needs_review        boolean not null default false,
  confidence          text not null default 'user'
                      check (confidence in ('user','llm','verified')),
  created_at          timestamptz not null default now()
);

create unique index if not exists canonical_wine_match_key_idx
  on public.canonical_wine (
    name_norm,
    coalesce(winery_norm, ''),
    coalesce(vintage, -1)
  );
create index if not exists canonical_wine_name_norm_trgm_idx
  on public.canonical_wine using gin (name_norm gin_trgm_ops);
create index if not exists canonical_wine_winery_norm_idx
  on public.canonical_wine (winery_norm);

-- canonical_wine_attributes: aggregated WSET style profile per canonical wine
create table if not exists public.canonical_wine_attributes (
  canonical_wine_id   uuid primary key references public.canonical_wine(id) on delete cascade,
  body                real not null check (body between 0 and 1),
  tannin              real check (tannin is null or tannin between 0 and 1),
  acidity             real not null check (acidity between 0 and 1),
  sweetness           real not null check (sweetness between 0 and 1),
  oak                 real not null check (oak between 0 and 1),
  intensity           real not null check (intensity between 0 and 1),
  finish              smallint check (finish between 1 and 3),
  aroma_tags          text[] not null default '{}',
  sample_count        smallint not null default 0,
  source              text not null default 'expert'
                      check (source in ('llm','expert','verified')),
  updated_at          timestamptz not null default now()
);

-- canonical_wine_match_decisions: per-user "linked / different" decisions for
-- Tier 2 fuzzy matches. Avoids re-prompting.
create table if not exists public.canonical_wine_match_decisions (
  id                       uuid primary key default gen_random_uuid(),
  user_id                  uuid not null references auth.users(id) on delete cascade,
  input_name_norm          text not null,
  input_winery_norm        text,
  input_vintage            int,
  candidate_canonical_id   uuid not null references public.canonical_wine(id) on delete cascade,
  decision                 text not null check (decision in ('linked','different')),
  decided_at               timestamptz not null default now()
);

create unique index if not exists canonical_wine_match_decisions_unique_idx
  on public.canonical_wine_match_decisions (
    user_id,
    input_name_norm,
    coalesce(input_winery_norm, ''),
    coalesce(input_vintage, -1),
    candidate_canonical_id
  );

-- groups: wine groups
create table if not exists public.groups (
  id           uuid primary key default gen_random_uuid(),
  name         text not null check (char_length(name) between 1 and 30),
  invite_code  text unique default substr(md5(random()::text), 1, 8),
  created_by   uuid not null references public.profiles(id) on delete cascade,
  image_url    text,
  created_at   timestamptz not null default now()
);

-- group_members
create table if not exists public.group_members (
  group_id   uuid not null references public.groups(id) on delete cascade,
  user_id    uuid not null references public.profiles(id) on delete cascade,
  role       text not null default 'member' check (role in ('owner','admin','member')),
  joined_at  timestamptz not null default now(),
  primary key (group_id, user_id)
);

create index if not exists idx_group_members_user
  on public.group_members (user_id);

-- group_invitations
create table if not exists public.group_invitations (
  id            uuid primary key default gen_random_uuid(),
  group_id      uuid not null references public.groups(id) on delete cascade,
  inviter_id    uuid not null references public.profiles(id) on delete cascade,
  invitee_id    uuid not null references public.profiles(id) on delete cascade,
  status        text not null default 'pending' check (status in ('pending','accepted','declined')),
  created_at    timestamptz not null default now(),
  responded_at  timestamptz,
  check (inviter_id <> invitee_id)
);

create unique index if not exists group_invitations_unique_pending_idx
  on public.group_invitations (group_id, invitee_id) where status = 'pending';
create index if not exists group_invitations_invitee_idx
  on public.group_invitations (invitee_id, status);
create index if not exists group_invitations_group_idx
  on public.group_invitations (group_id, status);

-- group_tastings
create table if not exists public.group_tastings (
  id            uuid primary key default gen_random_uuid(),
  group_id      uuid not null references public.groups(id) on delete cascade,
  title         text not null,
  description   text,
  location      text,
  latitude      double precision,
  longitude     double precision,
  scheduled_at  timestamptz not null,
  created_by    uuid not null references public.profiles(id) on delete cascade,
  is_blind      boolean not null default false,
  is_revealed   boolean not null default false,
  lineup_mode   text not null default 'planned' check (lineup_mode in ('planned','open')),
  state         text not null default 'upcoming' check (state in ('upcoming','active','concluded')),
  started_at    timestamptz,
  ended_at      timestamptz,
  created_at    timestamptz not null default now()
);

create index if not exists group_tastings_state_idx
  on public.group_tastings (state);
create index if not exists tastings_group_id_idx
  on public.group_tastings (group_id, scheduled_at desc);

-- tasting_attendees
create table if not exists public.tasting_attendees (
  tasting_id        uuid not null references public.group_tastings(id) on delete cascade,
  user_id           uuid not null references public.profiles(id) on delete cascade,
  status            text not null default 'no_response'
                    check (status in ('going','maybe','declined','no_response')),
  reminder_sent_at  timestamptz,
  updated_at        timestamptz not null default now(),
  primary key (tasting_id, user_id)
);

create index if not exists tasting_attendees_reminder_pending_idx
  on public.tasting_attendees (tasting_id)
  where reminder_sent_at is null and status in ('going','maybe');

-- tasting_wines (canonical-keyed; wine_id removed in pre-baseline phase 2c)
create table if not exists public.tasting_wines (
  tasting_id          uuid not null references public.group_tastings(id) on delete cascade,
  canonical_wine_id   uuid not null references public.canonical_wine(id) on delete cascade,
  position            int not null default 0,
  primary key (tasting_id, canonical_wine_id)
);

create index if not exists tasting_wines_tasting_canonical_idx
  on public.tasting_wines (tasting_id, canonical_wine_id);

-- tasting_ratings
create table if not exists public.tasting_ratings (
  tasting_id          uuid not null references public.group_tastings(id) on delete cascade,
  user_id             uuid not null references public.profiles(id) on delete cascade,
  canonical_wine_id   uuid not null references public.canonical_wine(id) on delete cascade,
  rating              real,
  notes               text,
  created_at          timestamptz not null default now(),
  primary key (tasting_id, user_id, canonical_wine_id)
);

create index if not exists tasting_ratings_tasting_canonical_idx
  on public.tasting_ratings (tasting_id, canonical_wine_id);
create index if not exists tasting_ratings_user_idx
  on public.tasting_ratings (user_id);

-- friend_requests
create table if not exists public.friend_requests (
  id           uuid primary key default gen_random_uuid(),
  sender_id    uuid not null references public.profiles(id) on delete cascade,
  receiver_id  uuid not null references public.profiles(id) on delete cascade,
  status       text not null default 'pending' check (status in ('pending','accepted','declined')),
  created_at   timestamptz not null default now(),
  unique (sender_id, receiver_id),
  check (sender_id <> receiver_id)
);

-- friendships (mirrored bidirectionally via trigger)
create table if not exists public.friendships (
  user_id    uuid not null references public.profiles(id) on delete cascade,
  friend_id  uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, friend_id),
  check (user_id <> friend_id)
);

-- wines: personal tasting log (canonical-keyed for cross-user features)
create table if not exists public.wines (
  id                  uuid primary key default gen_random_uuid(),
  user_id             uuid not null references public.profiles(id) on delete cascade,
  name                text not null check (char_length(name) between 1 and 60),
  winery              text,
  vintage             int,
  type                text check (type in ('red','white','rose','sparkling')),
  country             text,
  region              text,
  rating              double precision not null default 0,
  notes               text,
  price               double precision,
  currency            text default 'EUR',
  location            text,
  latitude            double precision,
  longitude           double precision,
  image_url           text,
  local_image_path    text,
  label_image_url     text,
  grape               text,
  grape_freetext      text,
  canonical_grape_id  uuid references public.canonical_grape(id) on delete set null,
  canonical_wine_id   uuid references public.canonical_wine(id) on delete set null,
  name_norm           text,
  barcode             text,
  visibility          text not null default 'friends' check (visibility in ('private','friends','public')),
  is_synced           boolean default true,
  created_at          timestamptz not null default now(),
  updated_at          timestamptz
);

create index if not exists idx_wines_user_id on public.wines (user_id);
create index if not exists idx_wines_barcode on public.wines (barcode);
create index if not exists wines_canonical_wine_id_idx on public.wines (canonical_wine_id);
create index if not exists wines_canonical_grape_id_idx on public.wines (canonical_grape_id);
create index if not exists wines_name_norm_vintage_idx on public.wines (name_norm, vintage);
create index if not exists wines_user_canonical_idx
  on public.wines (user_id, canonical_wine_id) where canonical_wine_id is not null;

-- wine_memories
create table if not exists public.wine_memories (
  id                uuid primary key default gen_random_uuid(),
  wine_id           uuid not null references public.wines(id) on delete cascade,
  user_id           uuid not null references public.profiles(id) on delete cascade,
  image_url         text,
  local_image_path  text,
  caption           text,
  created_at        timestamptz not null default now()
);

create index if not exists wine_memories_wine_created_idx
  on public.wine_memories (wine_id, created_at desc);
create index if not exists wine_memories_user_created_idx
  on public.wine_memories (user_id, created_at desc);

-- group_wines (canonical-keyed)
create table if not exists public.group_wines (
  id                 uuid primary key default gen_random_uuid(),
  group_id           uuid not null references public.groups(id) on delete cascade,
  canonical_wine_id  uuid not null references public.canonical_wine(id) on delete cascade,
  shared_by          uuid not null references public.profiles(id) on delete cascade,
  shared_at          timestamptz not null default now(),
  unique (group_id, canonical_wine_id)
);

create index if not exists idx_group_wines_group on public.group_wines (group_id);
create index if not exists group_wines_group_canonical_idx
  on public.group_wines (group_id, canonical_wine_id);

-- group_wine_ratings
create table if not exists public.group_wine_ratings (
  group_id           uuid not null references public.groups(id) on delete cascade,
  user_id            uuid not null references public.profiles(id) on delete cascade,
  canonical_wine_id  uuid not null references public.canonical_wine(id) on delete cascade,
  rating             real check (rating >= 0 and rating <= 10),
  notes              text,
  created_at         timestamptz not null default now(),
  updated_at         timestamptz not null default now(),
  primary key (group_id, canonical_wine_id, user_id)
);

create index if not exists group_wine_ratings_group_canonical_idx
  on public.group_wine_ratings (group_id, canonical_wine_id);
create index if not exists group_wine_ratings_user_canonical_idx
  on public.group_wine_ratings (user_id, canonical_wine_id);
create index if not exists group_wine_ratings_user_idx
  on public.group_wine_ratings (user_id);

-- wine_ratings_extended: WSET style attributes per (user, wine, context)
create table if not exists public.wine_ratings_extended (
  id                  uuid primary key default gen_random_uuid(),
  user_id             uuid not null references auth.users(id) on delete cascade,
  canonical_wine_id   uuid not null references public.canonical_wine(id) on delete cascade,
  context             text not null check (context in ('personal','group','tasting')),
  group_id            uuid references public.groups(id) on delete cascade,
  tasting_id          uuid references public.group_tastings(id) on delete cascade,
  body                smallint check (body between 1 and 5),
  tannin              smallint check (tannin between 1 and 5),
  acidity             smallint check (acidity between 1 and 5),
  sweetness           smallint check (sweetness between 1 and 5),
  oak                 smallint check (oak between 1 and 5),
  finish              smallint check (finish between 1 and 3),
  aroma_tags          text[] not null default '{}',
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now(),
  unique (user_id, canonical_wine_id, context)
);

create index if not exists wine_ratings_extended_canonical_idx
  on public.wine_ratings_extended (canonical_wine_id);

-- user_devices: FCM token registry. Composite PK on (user_id, token) plus
-- separate UNIQUE(token) so no token can belong to two users.
create table if not exists public.user_devices (
  user_id     uuid not null references public.profiles(id) on delete cascade,
  token       text not null unique,
  platform    text not null check (platform in ('ios','android','web')),
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now(),
  primary key (user_id, token)
);

-- user_notification_prefs
create table if not exists public.user_notification_prefs (
  user_id                  uuid primary key references public.profiles(id) on delete cascade,
  tasting_reminders        boolean not null default true,
  tasting_reminder_hours   smallint not null default 1
                           check (tasting_reminder_hours between 0 and 24),
  friend_activity          boolean not null default true,
  group_activity           boolean not null default true,
  group_wine_shared        boolean not null default true,
  created_at               timestamptz not null default now(),
  updated_at               timestamptz not null default now()
);

-- join_attempts: H2 audit fix — invite-code brute-force rate limit
create table if not exists public.join_attempts (
  user_id     uuid not null references auth.users(id) on delete cascade,
  attempted_at timestamptz not null default now()
);
create index if not exists join_attempts_user_time_idx
  on public.join_attempts (user_id, attempted_at desc);


-- ── 4. RLS helper functions ────────────────────────────────────────────────

create or replace function public.is_group_member(gid uuid, uid uuid)
returns boolean
language sql
stable security definer
set search_path = public
as $$
  select exists (
    select 1 from public.group_members
    where group_id = gid and user_id = uid
  );
$$;

create or replace function public.group_role(gid uuid, uid uuid)
returns text
language sql
stable security definer
set search_path = public
as $$
  select role from public.group_members
  where group_id = gid and user_id = uid
  limit 1;
$$;


-- ── 5. RLS policies ────────────────────────────────────────────────────────

alter table public.profiles                        enable row level security;
alter table public.canonical_grape                 enable row level security;
alter table public.canonical_grape_archetype       enable row level security;
alter table public.canonical_wine                  enable row level security;
alter table public.canonical_wine_attributes       enable row level security;
alter table public.canonical_wine_match_decisions  enable row level security;
alter table public.groups                          enable row level security;
alter table public.group_members                   enable row level security;
alter table public.group_invitations               enable row level security;
alter table public.group_tastings                  enable row level security;
alter table public.tasting_attendees               enable row level security;
alter table public.tasting_wines                   enable row level security;
alter table public.tasting_ratings                 enable row level security;
alter table public.friend_requests                 enable row level security;
alter table public.friendships                     enable row level security;
alter table public.wines                           enable row level security;
alter table public.wine_memories                   enable row level security;
alter table public.group_wines                     enable row level security;
alter table public.group_wine_ratings              enable row level security;
alter table public.wine_ratings_extended           enable row level security;
alter table public.user_devices                    enable row level security;
alter table public.user_notification_prefs         enable row level security;
alter table public.join_attempts                   enable row level security;

-- profiles
-- Audit fix: select restricted to authenticated (was open to public/anon).
create policy profiles_select_authenticated on public.profiles
  for select to authenticated using (true);
create policy profiles_insert_self on public.profiles
  for insert to authenticated with check (auth.uid() = id);
create policy profiles_update_self on public.profiles
  for update to authenticated using (auth.uid() = id);

-- canonical_* (read-only catalog)
create policy canonical_grape_select_all on public.canonical_grape
  for select to authenticated using (true);
create policy archetype_select_all on public.canonical_grape_archetype
  for select to authenticated using (true);
create policy canonical_wine_select_all on public.canonical_wine
  for select to authenticated using (true);
create policy wine_attributes_select_all on public.canonical_wine_attributes
  for select to authenticated using (true);
create policy match_decisions_own on public.canonical_wine_match_decisions
  for all to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- groups (members + pending invitees can SELECT)
create policy groups_select on public.groups
  for select to authenticated
  using (id in (select group_id from public.group_members where user_id = auth.uid()));
create policy groups_select_pending_invitee on public.groups
  for select to authenticated
  using (exists (
    select 1 from public.group_invitations gi
    where gi.group_id = groups.id and gi.invitee_id = auth.uid() and gi.status = 'pending'
  ));
create policy groups_insert on public.groups
  for insert to authenticated with check (auth.uid() = created_by);
create policy groups_update on public.groups
  for update to authenticated using (auth.uid() = created_by);
create policy groups_delete on public.groups
  for delete to authenticated using (auth.uid() = created_by);

-- group_members
create policy gm_select on public.group_members
  for select to authenticated
  using (user_id = auth.uid() or public.is_group_member(group_id, auth.uid()));
create policy gm_insert on public.group_members
  for insert to authenticated
  with check (
    user_id = auth.uid()
    or public.group_role(group_id, auth.uid()) in ('owner','admin')
  );
create policy gm_delete on public.group_members
  for delete to authenticated
  using (user_id = auth.uid() or public.group_role(group_id, auth.uid()) = 'owner');

-- group_invitations
create policy group_invitations_select_self on public.group_invitations
  for select to authenticated
  using (auth.uid() = inviter_id or auth.uid() = invitee_id);
create policy group_invitations_insert_member on public.group_invitations
  for insert to authenticated
  with check (
    auth.uid() = inviter_id
    and exists (
      select 1 from public.group_members gm
      where gm.group_id = group_invitations.group_id and gm.user_id = auth.uid()
    )
  );
create policy group_invitations_update_invitee on public.group_invitations
  for update to authenticated using (auth.uid() = invitee_id);
create policy group_invitations_delete_self on public.group_invitations
  for delete to authenticated
  using (auth.uid() = invitee_id or auth.uid() = inviter_id);

-- group_tastings
create policy tastings_select_members on public.group_tastings
  for select to authenticated
  using (exists (
    select 1 from public.group_members gm
    where gm.group_id = group_tastings.group_id and gm.user_id = auth.uid()
  ));
create policy tastings_insert_members on public.group_tastings
  for insert to authenticated
  with check (
    auth.uid() = created_by
    and exists (
      select 1 from public.group_members gm
      where gm.group_id = group_tastings.group_id and gm.user_id = auth.uid()
    )
  );
create policy tastings_update_creator on public.group_tastings
  for update to authenticated using (auth.uid() = created_by);
create policy tastings_delete_creator on public.group_tastings
  for delete to authenticated using (auth.uid() = created_by);

-- tasting_attendees
create policy att_select_members on public.tasting_attendees
  for select to authenticated
  using (exists (
    select 1 from public.group_tastings t
    join public.group_members gm on gm.group_id = t.group_id
    where t.id = tasting_attendees.tasting_id and gm.user_id = auth.uid()
  ));
create policy att_insert_self on public.tasting_attendees
  for insert to authenticated with check (auth.uid() = user_id);
create policy att_update_self on public.tasting_attendees
  for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- tasting_wines (creator manages, members read)
create policy tw_select_members on public.tasting_wines
  for select to authenticated
  using (exists (
    select 1 from public.group_tastings t
    join public.group_members gm on gm.group_id = t.group_id
    where t.id = tasting_wines.tasting_id and gm.user_id = auth.uid()
  ));
create policy tw_insert_creator on public.tasting_wines
  for insert to authenticated
  with check (exists (
    select 1 from public.group_tastings t
    where t.id = tasting_wines.tasting_id and t.created_by = auth.uid()
  ));
create policy tw_delete_creator on public.tasting_wines
  for delete to authenticated
  using (exists (
    select 1 from public.group_tastings t
    where t.id = tasting_wines.tasting_id and t.created_by = auth.uid()
  ));

-- tasting_ratings
create policy tr_select_members on public.tasting_ratings
  for select to authenticated
  using (exists (
    select 1 from public.group_tastings t
    join public.group_members gm on gm.group_id = t.group_id
    where t.id = tasting_ratings.tasting_id and gm.user_id = auth.uid()
  ));
create policy tr_upsert_self on public.tasting_ratings
  for insert to authenticated with check (auth.uid() = user_id);
create policy tr_update_self on public.tasting_ratings
  for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- friend_requests
create policy friend_requests_sender_select on public.friend_requests
  for select to authenticated using (auth.uid() = sender_id);
create policy friend_requests_receiver_select on public.friend_requests
  for select to authenticated using (auth.uid() = receiver_id);
create policy friend_requests_sender_insert on public.friend_requests
  for insert to authenticated with check (auth.uid() = sender_id);
create policy friend_requests_receiver_update on public.friend_requests
  for update to authenticated
  using (auth.uid() = receiver_id) with check (auth.uid() = receiver_id);
create policy friend_requests_sender_delete on public.friend_requests
  for delete to authenticated using (auth.uid() = sender_id);

-- friendships (only own-perspective rows visible; mirror trigger keeps both)
create policy friendships_select_own on public.friendships
  for select to authenticated using (auth.uid() = user_id);
create policy friendships_delete_own on public.friendships
  for delete to authenticated using (auth.uid() = user_id);

-- wines
create policy wines_select_own on public.wines
  for select to authenticated using (auth.uid() = user_id);
create policy wines_select_friends on public.wines
  for select to authenticated using (
    visibility in ('friends','public')
    and exists (
      select 1 from public.friendships f
      where f.user_id = auth.uid() and f.friend_id = wines.user_id
    )
  );
create policy wines_select_shared on public.wines
  for select to authenticated using (
    canonical_wine_id is not null and canonical_wine_id in (
      select gw.canonical_wine_id from public.group_wines gw
      join public.group_members gm on gm.group_id = gw.group_id
      where gm.user_id = auth.uid()
    )
  );
create policy wines_insert on public.wines
  for insert to authenticated with check (auth.uid() = user_id);
create policy wines_update on public.wines
  for update to authenticated using (auth.uid() = user_id);
create policy wines_delete on public.wines
  for delete to authenticated using (auth.uid() = user_id);

-- wine_memories
create policy wine_memories_select_own on public.wine_memories
  for select to authenticated using (auth.uid() = user_id);
create policy wine_memories_insert_own on public.wine_memories
  for insert to authenticated with check (auth.uid() = user_id);
create policy wine_memories_update_own on public.wine_memories
  for update to authenticated using (auth.uid() = user_id);
create policy wine_memories_delete_own on public.wine_memories
  for delete to authenticated using (auth.uid() = user_id);

-- group_wines
create policy gw_select on public.group_wines
  for select to authenticated
  using (group_id in (
    select group_id from public.group_members where user_id = auth.uid()
  ));
create policy gw_insert on public.group_wines
  for insert to authenticated
  with check (
    auth.uid() = shared_by
    and group_id in (
      select group_id from public.group_members where user_id = auth.uid()
    )
  );
create policy gw_delete on public.group_wines
  for delete to authenticated
  using (
    auth.uid() = shared_by
    or group_id in (
      select group_id from public.group_members
      where user_id = auth.uid() and role = 'owner'
    )
  );

-- group_wine_ratings
create policy gwr_select_members on public.group_wine_ratings
  for select to authenticated using (public.is_group_member(group_id, auth.uid()));
create policy gwr_insert_self on public.group_wine_ratings
  for insert to authenticated
  with check (auth.uid() = user_id and public.is_group_member(group_id, auth.uid()));
create policy gwr_update_self on public.group_wine_ratings
  for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy gwr_delete_self on public.group_wine_ratings
  for delete to authenticated using (auth.uid() = user_id);

-- wine_ratings_extended
create policy wine_ratings_extended_select_own on public.wine_ratings_extended
  for select to authenticated using (user_id = auth.uid());
create policy wine_ratings_extended_write_own on public.wine_ratings_extended
  for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- user_devices
create policy ud_select_own on public.user_devices
  for select to authenticated using (auth.uid() = user_id);
create policy ud_insert_own on public.user_devices
  for insert to authenticated with check (auth.uid() = user_id);
create policy ud_update_own on public.user_devices
  for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy ud_delete_own on public.user_devices
  for delete to authenticated using (auth.uid() = user_id);

-- user_notification_prefs
create policy user_notification_prefs_own_select on public.user_notification_prefs
  for select to authenticated using (auth.uid() = user_id);
create policy user_notification_prefs_own_insert on public.user_notification_prefs
  for insert to authenticated with check (auth.uid() = user_id);
create policy user_notification_prefs_own_update on public.user_notification_prefs
  for update to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- join_attempts: select-only own (insert via security-definer RPC)
create policy join_attempts_select_own on public.join_attempts
  for select to authenticated using (auth.uid() = user_id);


-- ── 6. Storage buckets + policies ─────────────────────────────────────────

-- Buckets stay public (wine pics not sensitive). Audit fix M2: MIME allowlist
-- + size limit on every bucket.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values
  ('avatars',      'avatars',      true, 2 * 1024 * 1024,
   array['image/jpeg','image/png','image/webp']),
  ('wine-images',  'wine-images',  true, 5 * 1024 * 1024,
   array['image/jpeg','image/png','image/webp']),
  ('group-images', 'group-images', true, 2 * 1024 * 1024,
   array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set
  public            = excluded.public,
  file_size_limit   = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

-- avatars: path = <user_id>/<file>
create policy avatars_read on storage.objects
  for select using (bucket_id = 'avatars');
create policy avatars_upload on storage.objects
  for insert
  with check (bucket_id = 'avatars' and auth.uid()::text = (storage.foldername(name))[1]);
create policy avatars_update on storage.objects
  for update
  using (bucket_id = 'avatars' and auth.uid()::text = (storage.foldername(name))[1]);
create policy avatars_delete on storage.objects
  for delete
  using (bucket_id = 'avatars' and auth.uid()::text = (storage.foldername(name))[1]);

-- wine-images: path = <user_id>/<file>
create policy wine_images_read on storage.objects
  for select using (bucket_id = 'wine-images');
create policy wine_images_upload on storage.objects
  for insert
  with check (bucket_id = 'wine-images' and auth.uid()::text = (storage.foldername(name))[1]);
create policy wine_images_update on storage.objects
  for update
  using (bucket_id = 'wine-images' and auth.uid()::text = (storage.foldername(name))[1]);
create policy wine_images_delete on storage.objects
  for delete
  using (bucket_id = 'wine-images' and auth.uid()::text = (storage.foldername(name))[1]);

-- group-images: path = <group_id>/<file>; member-only writes
create policy group_images_read on storage.objects
  for select using (bucket_id = 'group-images');
create policy group_images_upload on storage.objects
  for insert
  with check (
    bucket_id = 'group-images'
    and exists (
      select 1 from public.group_members gm
      where gm.group_id::text = (storage.foldername(name))[1] and gm.user_id = auth.uid()
    )
  );
create policy group_images_update on storage.objects
  for update
  using (
    bucket_id = 'group-images'
    and exists (
      select 1 from public.group_members gm
      where gm.group_id::text = (storage.foldername(name))[1] and gm.user_id = auth.uid()
    )
  );
create policy group_images_delete on storage.objects
  for delete
  using (
    bucket_id = 'group-images'
    and exists (
      select 1 from public.group_members gm
      where gm.group_id::text = (storage.foldername(name))[1] and gm.user_id = auth.uid()
    )
  );


-- ── 7. RPCs ────────────────────────────────────────────────────────────────

-- Resolve / upsert canonical wine identity (Tier 1 exact match).
create or replace function public.resolve_canonical_wine(
  p_name text, p_winery text, p_vintage int, p_type text,
  p_country text, p_region text, p_canonical_grape_id uuid,
  p_user_id uuid -- legacy param kept for trigger compatibility; not stored
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_name_norm   text;
  v_winery_norm text;
  v_id          uuid;
begin
  v_name_norm   := public.normalize_wine_text(p_name);
  v_winery_norm := public.normalize_wine_text(p_winery);

  if v_name_norm is null or length(v_name_norm) < 3 then
    return null;
  end if;

  select id into v_id from public.canonical_wine
  where name_norm = v_name_norm
    and coalesce(winery_norm, '') = coalesce(v_winery_norm, '')
    and coalesce(vintage, -1) = coalesce(p_vintage, -1)
  limit 1;

  if v_id is not null then return v_id; end if;

  insert into public.canonical_wine (
    name, name_norm, winery, winery_norm, vintage,
    type, country, region, canonical_grape_id, confidence
  ) values (
    btrim(p_name), v_name_norm,
    nullif(btrim(coalesce(p_winery, '')), ''), v_winery_norm,
    p_vintage, p_type, p_country, p_region, p_canonical_grape_id,
    'user'
  )
  on conflict (name_norm, coalesce(winery_norm, ''), coalesce(vintage, -1))
    do nothing
  returning id into v_id;

  if v_id is null then
    select id into v_id from public.canonical_wine
    where name_norm = v_name_norm
      and coalesce(winery_norm, '') = coalesce(v_winery_norm, '')
      and coalesce(vintage, -1) = coalesce(p_vintage, -1);
  end if;

  return v_id;
end;
$$;

-- Tier 2 fuzzy match suggestions (trigram).
create or replace function public.suggest_canonical_match(
  p_name text, p_winery text, p_vintage integer
)
returns table(candidate_id uuid, name text, winery text, vintage int,
              similarity numeric, is_exact boolean)
language sql
stable security definer
set search_path = public
as $$
  with input_norm as (
    select public.normalize_wine_text(p_name)   as name_norm,
           public.normalize_wine_text(p_winery) as winery_norm,
           p_vintage as vintage
  ),
  exact_match as (
    select cw.id, cw.name, cw.winery, cw.vintage, 1.0::numeric, true
    from public.canonical_wine cw cross join input_norm i
    where i.name_norm is not null
      and cw.name_norm = i.name_norm
      and coalesce(cw.winery_norm, '') = coalesce(i.winery_norm, '')
      and coalesce(cw.vintage, -1) = coalesce(i.vintage, -1)
    limit 1
  ),
  fuzzy_matches as (
    select cw.id, cw.name, cw.winery, cw.vintage,
           similarity(cw.name_norm, i.name_norm)::numeric, false
    from public.canonical_wine cw cross join input_norm i
    where i.name_norm is not null
      and not exists (select 1 from exact_match)
      and similarity(cw.name_norm, i.name_norm) >= 0.6
      and (cw.winery_norm is null or i.winery_norm is null
           or cw.winery_norm = i.winery_norm)
      and not (cw.name_norm = i.name_norm
        and coalesce(cw.winery_norm, '') = coalesce(i.winery_norm, '')
        and coalesce(cw.vintage, -1) = coalesce(i.vintage, -1))
      and not exists (
        select 1 from public.canonical_wine_match_decisions d
        where d.user_id = auth.uid()
          and d.input_name_norm = i.name_norm
          and coalesce(d.input_winery_norm, '') = coalesce(i.winery_norm, '')
          and coalesce(d.input_vintage, -1) = coalesce(i.vintage, -1)
          and d.candidate_canonical_id = cw.id
          and d.decision = 'different'
      )
    order by similarity(cw.name_norm, i.name_norm) desc, cw.created_at desc
    limit 3
  )
  select * from exact_match
  union all
  select * from fuzzy_matches;
$$;

-- Record user's Tier 2 decision.
create or replace function public.record_canonical_match_decision(
  p_input_name text, p_input_winery text, p_input_vintage int,
  p_candidate_id uuid, p_decision text
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_name_norm   text;
  v_winery_norm text;
begin
  if auth.uid() is null then raise exception 'auth required'; end if;
  if p_decision not in ('linked','different') then
    raise exception 'invalid decision: %', p_decision;
  end if;
  v_name_norm   := public.normalize_wine_text(p_input_name);
  v_winery_norm := public.normalize_wine_text(p_input_winery);
  if v_name_norm is null then return; end if;

  insert into public.canonical_wine_match_decisions (
    user_id, input_name_norm, input_winery_norm, input_vintage,
    candidate_canonical_id, decision
  ) values (
    auth.uid(), v_name_norm, v_winery_norm, p_input_vintage,
    p_candidate_id, p_decision
  )
  on conflict (
    user_id, input_name_norm,
    coalesce(input_winery_norm, ''), coalesce(input_vintage, -1),
    candidate_canonical_id
  ) do update set decision = excluded.decision, decided_at = now();
end;
$$;

-- Tier 3 manual canonical merge.
-- Audit fix H1: caller must own the LOSER canonical AND no other user must
-- have wines pointing at the loser. Stops cross-user data corruption where
-- one user merges canonicals affecting strangers' personal logs.
create or replace function public.merge_canonical_wines(
  p_loser_id uuid, p_winner_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_caller uuid := auth.uid();
  v_caller_owns_loser boolean;
  v_other_users_count int;
begin
  if v_caller is null then raise exception 'auth required'; end if;
  if p_loser_id = p_winner_id then
    raise exception 'cannot merge a canonical with itself';
  end if;
  if not exists (select 1 from public.canonical_wine where id = p_loser_id) then
    raise exception 'loser canonical not found';
  end if;
  if not exists (select 1 from public.canonical_wine where id = p_winner_id) then
    raise exception 'winner canonical not found';
  end if;

  -- Caller must own a wine pointing at loser.
  select exists (
    select 1 from public.wines
    where canonical_wine_id = p_loser_id and user_id = v_caller
  ) into v_caller_owns_loser;
  if not v_caller_owns_loser then
    raise exception 'caller does not own a wine pointing at loser canonical';
  end if;

  -- No OTHER user may have a wine on the loser. Otherwise their log would
  -- silently re-point to a canonical they didn't pick.
  select count(*) into v_other_users_count
  from (
    select distinct user_id from public.wines
    where canonical_wine_id = p_loser_id and user_id <> v_caller
  ) o;
  if v_other_users_count > 0 then
    raise exception 'cannot merge: % other user(s) also reference the loser canonical',
      v_other_users_count;
  end if;

  update public.wines set canonical_wine_id = p_winner_id
   where canonical_wine_id = p_loser_id;

  delete from public.canonical_wine_match_decisions
   where candidate_canonical_id = p_loser_id;

  delete from public.canonical_wine where id = p_loser_id;
end;
$$;

-- Find merge candidates for the caller (Tier 3 cleanup helper).
create or replace function public.find_canonical_merge_candidates(
  p_min_similarity numeric default 0.6,
  p_limit int default 50
)
returns table(loser_id uuid, winner_id uuid, loser_name text, winner_name text,
              loser_winery text, winner_winery text, loser_vintage int,
              winner_vintage int, similarity numeric)
language sql
stable security definer
set search_path = public
as $$
  with my_canonicals as (
    select distinct canonical_wine_id from public.wines
    where user_id = auth.uid() and canonical_wine_id is not null
  )
  select a.id, b.id, a.name, b.name, a.winery, b.winery,
         a.vintage, b.vintage,
         similarity(a.name_norm, b.name_norm)::numeric
  from public.canonical_wine a
  join public.canonical_wine b on a.id < b.id
  where similarity(a.name_norm, b.name_norm) >= p_min_similarity
    and (a.winery_norm is null or b.winery_norm is null
         or a.winery_norm = b.winery_norm)
    and (
      exists (select 1 from my_canonicals m where m.canonical_wine_id = a.id)
      or
      exists (select 1 from my_canonicals m where m.canonical_wine_id = b.id)
    )
  order by similarity(a.name_norm, b.name_norm) desc, a.name asc
  limit p_limit;
$$;

create or replace function public.find_unenriched_canonicals(
  p_only_needs_review boolean default false,
  p_limit int default 100
)
returns table(id uuid, name text, winery text, vintage int, type text,
              country text, region text, needs_review boolean,
              enriched_at timestamptz, wine_count int)
language sql
stable security definer
set search_path = public
as $$
  select cw.id, cw.name, cw.winery, cw.vintage, cw.type, cw.country, cw.region,
         cw.needs_review, cw.enriched_at,
         (select count(*)::int from public.wines w where w.canonical_wine_id = cw.id)
  from public.canonical_wine cw
  where (cw.type is null or cw.country is null or cw.region is null)
    and (not p_only_needs_review or cw.needs_review)
  order by cw.needs_review desc,
           (select count(*) from public.wines w where w.canonical_wine_id = cw.id) desc,
           cw.created_at asc
  limit p_limit;
$$;

-- Group invite-code redemption.
-- Audit fix H2: rate-limit (10 attempts/min per user) + min code length 8.
create or replace function public.join_group_by_invite_code(p_code text)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_group_id uuid;
  v_user_id  uuid := auth.uid();
  v_attempts int;
begin
  if v_user_id is null then
    raise exception 'not authenticated' using errcode = '28000';
  end if;
  if p_code is null or length(p_code) < 8 then
    raise exception 'invite code too short' using errcode = 'P0001';
  end if;

  -- Rate limit
  select count(*) into v_attempts
  from public.join_attempts
  where user_id = v_user_id and attempted_at > now() - interval '1 minute';
  if v_attempts >= 10 then
    raise exception 'too many attempts; try again in a minute' using errcode = 'P0001';
  end if;
  insert into public.join_attempts (user_id) values (v_user_id);

  select id into v_group_id from public.groups where invite_code = p_code;
  if v_group_id is null then
    raise exception 'group not found' using errcode = 'P0002';
  end if;

  insert into public.group_members (group_id, user_id, role)
  values (v_group_id, v_user_id, 'member')
  on conflict (group_id, user_id) do nothing;

  return v_group_id;
end;
$$;

-- Register an FCM token for the calling user.
-- Audit fix C3: NO LONGER deletes another user's row on token reuse.
-- A token is bound to (user_id, token); the unique constraint on token
-- still ensures one user per token, but conflicts now raise instead of
-- silently hijacking the prior owner.
create or replace function public.register_user_device(
  p_token text, p_platform text
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_existing_owner uuid;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;

  select user_id into v_existing_owner
  from public.user_devices where token = p_token;

  if v_existing_owner is not null and v_existing_owner <> auth.uid() then
    -- Token belongs to a different user. Real cause is usually a stale row
    -- after device hand-off. Refuse the registration; the legitimate owner
    -- (or app on first launch after sign-out) must call unregister first.
    raise exception 'token already registered to another user'
      using errcode = 'P0001';
  end if;

  insert into public.user_devices (user_id, token, platform, updated_at)
  values (auth.uid(), p_token, p_platform, now())
  on conflict (token) do update
    set platform   = excluded.platform,
        updated_at = excluded.updated_at
    where user_devices.user_id = auth.uid();
end;
$$;

-- Unregister a device token for the calling user.
create or replace function public.unregister_user_device(p_token text)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  delete from public.user_devices
  where token = p_token and user_id = auth.uid();
end;
$$;

-- Account self-deletion. Transfers group ownership to oldest remaining
-- member; cascades through profiles → all public.* rows.
create or replace function public.delete_my_account()
returns void
language plpgsql
security definer
set search_path = public, auth
as $$
declare
  uid uuid := auth.uid();
begin
  if uid is null then raise exception 'not authenticated'; end if;

  update public.groups g
     set created_by = (
       select gm.user_id from public.group_members gm
        where gm.group_id = g.id and gm.user_id <> uid
        order by gm.joined_at asc limit 1
     )
   where g.created_by = uid
     and exists (
       select 1 from public.group_members gm
        where gm.group_id = g.id and gm.user_id <> uid
     );

  delete from auth.users where id = uid;
end;
$$;

-- Aggregate a canonical wine's WSET attributes from wine_ratings_extended.
create or replace function public.aggregate_wine_attributes(p_canonical_wine_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare v_n int;
begin
  select count(*) into v_n
  from public.wine_ratings_extended
  where canonical_wine_id = p_canonical_wine_id;

  if v_n < 3 then
    delete from public.canonical_wine_attributes
      where canonical_wine_id = p_canonical_wine_id and source = 'expert';
    return;
  end if;

  with numerics as (
    select
      avg((body - 1) / 4.0)::real                                as body_n,
      (avg((tannin - 1) / 4.0) filter (where tannin is not null))::real as tannin_n,
      avg((acidity - 1) / 4.0)::real                             as acid_n,
      avg((sweetness - 1) / 4.0)::real                           as sweet_n,
      avg((oak - 1) / 4.0)::real                                 as oak_n,
      (avg(finish) filter (where finish is not null))::real      as finish_avg,
      count(*)::int                                              as n
    from public.wine_ratings_extended
    where canonical_wine_id = p_canonical_wine_id
  ),
  tag_counts as (
    select tag, count(*) as cnt
    from public.wine_ratings_extended,
         lateral unnest(aroma_tags) as tag
    where canonical_wine_id = p_canonical_wine_id
    group by tag having count(*) >= 2
  ),
  tag_arr as (
    select coalesce(array_agg(tag order by cnt desc), '{}'::text[]) as tags
    from tag_counts
  )
  insert into public.canonical_wine_attributes (
    canonical_wine_id, body, tannin, acidity, sweetness, oak, intensity,
    finish, aroma_tags, sample_count, source, updated_at
  )
  select
    p_canonical_wine_id,
    coalesce(body_n,    0.5),
    tannin_n,
    coalesce(acid_n,    0.55),
    coalesce(sweet_n,   0.05),
    coalesce(oak_n,     0.3),
    least(1.0, greatest(0.0, ((coalesce(body_n, 0.5) + coalesce(oak_n, 0.3)) / 2 + 0.1)))::real,
    case when finish_avg is null then null else round(finish_avg)::smallint end,
    (select tags from tag_arr),
    n, 'expert', now()
  from numerics
  on conflict (canonical_wine_id) do update set
    body = excluded.body, tannin = excluded.tannin, acidity = excluded.acidity,
    sweetness = excluded.sweetness, oak = excluded.oak, intensity = excluded.intensity,
    finish = excluded.finish, aroma_tags = excluded.aroma_tags,
    sample_count = excluded.sample_count, source = excluded.source,
    updated_at = now();
end;
$$;

-- Per-user style DNA vector aggregated from rated wines.
create or replace function public.get_user_style_dna(p_user_id uuid)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare v_can_view boolean; v_result jsonb;
begin
  v_can_view := (p_user_id = auth.uid()) or exists (
    select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_user_id
  );
  if not v_can_view then
    return jsonb_build_object('body', null, 'tannin', null, 'acidity', null,
      'sweetness', null, 'oak', null, 'intensity', null,
      'attributed_count', 0, 'confidence', 0);
  end if;

  with attributed as (
    select
      coalesce(cwa.body,      cga.body)      as body,
      coalesce(cwa.tannin,    cga.tannin)    as tannin,
      coalesce(cwa.acidity,   cga.acidity)   as acidity,
      coalesce(cwa.sweetness, cga.sweetness) as sweetness,
      coalesce(cwa.oak,       cga.oak)       as oak,
      coalesce(cwa.intensity, cga.intensity) as intensity,
      (w.rating / 10.0)::numeric             as weight
    from public.wines w
    left join public.canonical_wine_attributes cwa on cwa.canonical_wine_id = w.canonical_wine_id
    left join public.canonical_grape_archetype cga on cga.canonical_grape_id = w.canonical_grape_id
    where w.user_id = p_user_id
      and (p_user_id = auth.uid() or w.visibility <> 'private')
      and w.rating is not null and w.rating > 0
      and (cwa.canonical_wine_id is not null or cga.canonical_grape_id is not null)
  ),
  stats as (
    select
      sum(weight)::numeric as total_w,
      sum(body * weight)::numeric / nullif(sum(weight), 0)::numeric as body_w,
      sum(tannin * weight) filter (where tannin is not null)::numeric
        / nullif(sum(weight) filter (where tannin is not null), 0)::numeric as tannin_w,
      sum(acidity * weight)::numeric / nullif(sum(weight), 0)::numeric as acid_w,
      sum(sweetness * weight)::numeric / nullif(sum(weight), 0)::numeric as sweet_w,
      sum(oak * weight)::numeric / nullif(sum(weight), 0)::numeric as oak_w,
      sum(intensity * weight)::numeric / nullif(sum(weight), 0)::numeric as int_w,
      count(*)::int as n
    from attributed
  )
  select jsonb_build_object(
    'body', round(body_w, 3), 'tannin', round(tannin_w, 3),
    'acidity', round(acid_w, 3), 'sweetness', round(sweet_w, 3),
    'oak', round(oak_w, 3), 'intensity', round(int_w, 3),
    'attributed_count', n,
    'confidence', round(least(1.0, n / 20.0)::numeric, 2)
  ) into v_result from stats;

  return v_result;
end;
$$;

-- Friend-pair taste similarity score (0–100).
create or replace function public.get_taste_match(p_other_user_id uuid)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare
  v_can_view boolean;
  v_my_count int; v_their_count int; v_overlap_count int;
  v_bucket_score numeric; v_dna_score numeric;
  v_agree_bonus numeric := 0; v_disagree_pen numeric := 0; v_score numeric;
  v_confidence text;
  v_my_dna jsonb; v_their_dna jsonb;
  v_my_attr int; v_their_attr int; v_dna_dist numeric;
  v_agree_pairs int := 0; v_disagree_pairs int := 0;
begin
  if p_other_user_id = auth.uid() then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', 0, 'their_total', 0, 'reason', 'unavailable');
  end if;
  v_can_view := exists (select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_other_user_id);
  if not v_can_view then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', 0, 'their_total', 0, 'reason', 'unavailable');
  end if;

  select count(*) into v_my_count from public.ratings
   where user_id = auth.uid() and context = 'personal';
  select count(*) into v_their_count from public.ratings r
   where r.user_id = p_other_user_id and r.context = 'personal'
     and exists (
       select 1 from public.wines w where w.user_id = r.user_id
         and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private'
     );
  if v_my_count < 5 or v_their_count < 5 then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', 0, 'my_total', v_my_count, 'their_total', v_their_count,
      'reason', 'not_enough_ratings');
  end if;

  with mine as (
    select 'region'::text as dim, cw.region as val, r.value as rating
    from public.ratings r join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid() and r.context = 'personal' and cw.region is not null
    union all
    select 'country', cw.country, r.value from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid() and r.context = 'personal' and cw.country is not null
    union all
    select 'type', cw.type, r.value from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = auth.uid() and r.context = 'personal' and cw.type is not null
  ),
  theirs as (
    select 'region'::text as dim, cw.region as val, r.value as rating
    from public.ratings r join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id and r.context = 'personal' and cw.region is not null
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
    union all
    select 'country', cw.country, r.value from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id and r.context = 'personal' and cw.country is not null
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
    union all
    select 'type', cw.type, r.value from public.ratings r
    join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_other_user_id and r.context = 'personal' and cw.type is not null
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
  ),
  my_buckets as (
    select dim, val, count(*)::int as cnt, avg(rating)::numeric as avg_r
    from mine group by dim, val having count(*) >= 2
  ),
  their_buckets as (
    select dim, val, count(*)::int as cnt, avg(rating)::numeric as avg_r
    from theirs group by dim, val having count(*) >= 2
  ),
  overlap as (
    select least(m.cnt, t.cnt)::numeric as weight, abs(m.avg_r - t.avg_r) as delta
    from my_buckets m join their_buckets t on m.dim = t.dim and m.val = t.val
  ),
  agg as (
    select count(*)::int as overlap_count,
           coalesce(sum(weight), 0)::numeric as total_weight,
           coalesce(sum(delta * weight), 0)::numeric as weighted_delta_sum
    from overlap
  )
  select overlap_count,
         case when total_weight > 0
              then round((1 - weighted_delta_sum / total_weight / 5.0) * 100)
              else null end
  into v_overlap_count, v_bucket_score from agg;

  if v_overlap_count < 3 then
    return jsonb_build_object('score', null, 'confidence', null,
      'overlap_count', v_overlap_count,
      'my_total', v_my_count, 'their_total', v_their_count,
      'reason', 'not_enough_overlap');
  end if;

  v_my_dna    := public.get_user_style_dna(auth.uid());
  v_their_dna := public.get_user_style_dna(p_other_user_id);
  v_my_attr   := coalesce((v_my_dna ->> 'attributed_count')::int, 0);
  v_their_attr:= coalesce((v_their_dna ->> 'attributed_count')::int, 0);

  if v_my_attr >= 3 and v_their_attr >= 3 then
    select sum(abs(coalesce((v_my_dna ->> ax)::numeric, 0)
                  - coalesce((v_their_dna ->> ax)::numeric, 0)))
           / nullif(count(*), 0)::numeric
    into v_dna_dist
    from (values ('body'),('tannin'),('acidity'),('sweetness'),('oak'),('intensity')) as a(ax)
    where (v_my_dna ->> a.ax) is not null and (v_their_dna ->> a.ax) is not null;
    v_dna_score := round((1 - coalesce(v_dna_dist, 1)) * 100);
    v_dna_score := greatest(0, least(100, v_dna_score));
  end if;

  with my_canon as (
    select canonical_wine_id, value as my_v from public.ratings
    where user_id = auth.uid() and context = 'personal'
  ),
  their_canon as (
    select canonical_wine_id, value as their_v from public.ratings r
    where r.user_id = p_other_user_id and r.context = 'personal'
      and exists (select 1 from public.wines w where w.user_id = r.user_id
        and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private')
  ),
  pairs as (
    select m.my_v, t.their_v from my_canon m
    join their_canon t on m.canonical_wine_id = t.canonical_wine_id
  )
  select count(*) filter (where abs(my_v - their_v) <= 1)::int,
         count(*) filter (where abs(my_v - their_v) >= 3)::int
  into v_agree_pairs, v_disagree_pairs from pairs;

  v_agree_bonus  := least(v_agree_pairs * 1.5, 10)::numeric;
  v_disagree_pen := least(v_disagree_pairs * 1.5, 10)::numeric;

  if v_dna_score is null then v_score := v_bucket_score;
  else v_score := round(0.55 * v_bucket_score + 0.45 * v_dna_score); end if;
  v_score := greatest(0, least(100, v_score + v_agree_bonus - v_disagree_pen));

  if v_overlap_count >= 10 and v_my_count >= 30 and v_their_count >= 30
     and v_my_attr >= 15 and v_their_attr >= 15 then v_confidence := 'high';
  elsif v_overlap_count >= 5 and v_my_count >= 10 and v_their_count >= 10
        and v_my_attr >= 5 and v_their_attr >= 5 then v_confidence := 'medium';
  else v_confidence := 'low'; end if;

  return jsonb_build_object(
    'score', v_score, 'confidence', v_confidence,
    'overlap_count', v_overlap_count,
    'my_total', v_my_count, 'their_total', v_their_count,
    'reason', null,
    'bucket_score', v_bucket_score, 'dna_score', v_dna_score,
    'same_canonical_pairs', v_agree_pairs + v_disagree_pairs,
    'agree_pairs', v_agree_pairs, 'disagree_pairs', v_disagree_pairs
  );
end;
$$;

create or replace function public.get_taste_compass(p_user_id uuid, p_top_n int default 3)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare v_can_view boolean; v_result jsonb;
begin
  v_can_view := (p_user_id = auth.uid()) or exists (
    select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_user_id
  );
  if not v_can_view then
    return jsonb_build_object('total_count', 0, 'overall_avg', null,
      'top_regions', '[]'::jsonb, 'top_countries', '[]'::jsonb,
      'type_breakdown', '[]'::jsonb);
  end if;

  with visible as (
    select r.value as rating, cw.type, cw.country, cw.region
    from public.ratings r join public.canonical_wine cw on cw.id = r.canonical_wine_id
    where r.user_id = p_user_id and r.context = 'personal'
      and (p_user_id = auth.uid() or exists (
        select 1 from public.wines w where w.user_id = r.user_id
          and w.canonical_wine_id = r.canonical_wine_id and w.visibility <> 'private'
      ))
  ),
  totals as (
    select count(*)::int as total_count, round(avg(rating)::numeric, 2) as overall_avg
    from visible
  ),
  regions as (
    select region, count(*)::int as count, round(avg(rating)::numeric, 2) as avg_rating
    from visible where region is not null
    group by region order by count(*) desc, avg(rating) desc limit p_top_n
  ),
  countries as (
    select country, count(*)::int as count, round(avg(rating)::numeric, 2) as avg_rating
    from visible where country is not null
    group by country order by count(*) desc, avg(rating) desc limit p_top_n
  ),
  types as (
    select type, count(*)::int as count, round(avg(rating)::numeric, 2) as avg_rating
    from visible where type is not null
    group by type order by count(*) desc
  )
  select jsonb_build_object(
    'total_count', (select total_count from totals),
    'overall_avg', (select overall_avg from totals),
    'top_regions', coalesce((select jsonb_agg(r) from regions r), '[]'::jsonb),
    'top_countries', coalesce((select jsonb_agg(c) from countries c), '[]'::jsonb),
    'type_breakdown', coalesce((select jsonb_agg(t) from types t), '[]'::jsonb)
  ) into v_result;
  return v_result;
end;
$$;

create or replace function public.get_top_drinking_partners(p_limit int default 5)
returns table(user_id uuid, username text, display_name text,
              avatar_url text, shared_wines int)
language sql
stable security definer
set search_path = public
as $$
  with my_social as (
    select distinct r.group_id, r.tasting_id, r.canonical_wine_id, r.context
    from public.ratings r
    where r.user_id = auth.uid() and r.context in ('group','tasting')
  ),
  partner_social as (
    select distinct r.user_id, r.group_id, r.tasting_id, r.canonical_wine_id, r.context
    from public.ratings r
    where r.user_id <> auth.uid() and r.context in ('group','tasting')
  ),
  partner_overlaps as (
    select pc.user_id, count(*)::int as shared_wines
    from partner_social pc
    join my_social mc
      on mc.context = pc.context
     and mc.canonical_wine_id = pc.canonical_wine_id
     and coalesce(mc.group_id::text, '')   = coalesce(pc.group_id::text, '')
     and coalesce(mc.tasting_id::text, '') = coalesce(pc.tasting_id::text, '')
    group by pc.user_id
  )
  select po.user_id, pr.username, pr.display_name, pr.avatar_url, po.shared_wines
  from partner_overlaps po
  join public.profiles pr on pr.id = po.user_id
  order by po.shared_wines desc, pr.display_name asc nulls last
  limit p_limit;
$$;

create or replace function public.get_shared_bottles(
  p_other_user_id uuid, p_limit int default 50
)
returns table(group_id uuid, wine_id uuid, wine_name text, winery text,
              region text, country text, type text, vintage int,
              my_rating numeric, their_rating numeric, delta numeric,
              rated_at timestamptz)
language sql
stable security definer
set search_path = public
as $$
  with my_ratings as (
    select r.group_id, r.tasting_id, r.canonical_wine_id, r.context,
           r.value as my_rating,
           coalesce(r.updated_at, r.created_at) as rated_at
    from public.ratings r
    where r.user_id = auth.uid() and r.context in ('group','tasting')
  ),
  their_ratings as (
    select r.group_id, r.tasting_id, r.canonical_wine_id, r.context,
           r.value as their_rating
    from public.ratings r
    where r.user_id = p_other_user_id and r.context in ('group','tasting')
  ),
  shared as (
    select m.group_id, m.canonical_wine_id, m.my_rating, t.their_rating,
           abs(m.my_rating - t.their_rating)::numeric as delta, m.rated_at
    from my_ratings m
    join their_ratings t
      on t.context = m.context
     and t.canonical_wine_id = m.canonical_wine_id
     and coalesce(t.group_id::text, '')   = coalesce(m.group_id::text, '')
     and coalesce(t.tasting_id::text, '') = coalesce(m.tasting_id::text, '')
  )
  select s.group_id,
         coalesce(
           (select w.id from public.wines w
            where w.canonical_wine_id = s.canonical_wine_id and w.user_id = auth.uid()
            limit 1),
           (select w.id from public.wines w
            where w.canonical_wine_id = s.canonical_wine_id limit 1)
         ),
         cw.name, cw.winery, cw.region, cw.country, cw.type, cw.vintage,
         s.my_rating, s.their_rating, s.delta, s.rated_at
  from shared s join public.canonical_wine cw on cw.id = s.canonical_wine_id
  order by s.delta desc nulls last, s.rated_at desc nulls last
  limit p_limit;
$$;

create or replace function public.get_user_top_grapes(
  p_user_id uuid, p_limit int default 7
)
returns table(canonical_grape_id uuid, grape_name text, grape_color text,
              count int, avg_rating numeric)
language sql
stable security definer
set search_path = public
as $$
  with visible as (
    select w.canonical_grape_id, w.rating
    from public.wines w
    where w.user_id = p_user_id and w.canonical_grape_id is not null
      and (p_user_id = auth.uid() or exists (
        select 1 from public.friendships f
        where f.user_id = auth.uid() and f.friend_id = p_user_id))
      and (p_user_id = auth.uid() or w.visibility <> 'private')
  )
  select cg.id, cg.name, cg.color,
         count(v.canonical_grape_id)::int,
         round(avg(v.rating)::numeric, 2)
  from visible v join public.canonical_grape cg on cg.id = v.canonical_grape_id
  group by cg.id, cg.name, cg.color
  order by count(*) desc, avg(v.rating) desc
  limit p_limit;
$$;

-- Friend ratings for a canonical wine. INVOKER (RLS enforces friend visibility
-- via wines + friendships base tables).
create or replace function public.get_friend_ratings_for_canonical_wine(
  p_canonical_wine_id uuid, p_limit int default 10
)
returns table(user_id uuid, display_name text, username text,
              avatar_url text, rating numeric, rated_at timestamptz)
language sql
stable
set search_path = public
as $$
  select w.user_id, p.display_name, p.username, p.avatar_url,
         w.rating::numeric, coalesce(w.updated_at, w.created_at)
  from public.wines w
  join public.profiles p on p.id = w.user_id
  where w.canonical_wine_id = p_canonical_wine_id
    and w.user_id <> auth.uid()
    and exists (
      select 1 from public.friendships f
      where f.user_id = auth.uid() and f.friend_id = w.user_id
    )
  order by w.rating desc nulls last,
           coalesce(w.updated_at, w.created_at) desc nulls last
  limit p_limit;
$$;

-- Tasting reminder claim (called by cron edge function).
create or replace function public.claim_due_tasting_reminders()
returns table(tasting_id uuid, user_id uuid, tasting_title text, group_id uuid)
language plpgsql
security definer
set search_path = public
as $$
begin
  return query
  with due as (
    select ta.tasting_id, ta.user_id
    from public.tasting_attendees ta
    join public.group_tastings gt on gt.id = ta.tasting_id
    join public.user_notification_prefs np on np.user_id = ta.user_id
    where ta.status in ('going','maybe')
      and ta.reminder_sent_at is null
      and gt.scheduled_at > now() - interval '15 minutes'
      and np.tasting_reminders = true
      and gt.scheduled_at - (
        case when np.tasting_reminder_hours = 0 then interval '30 seconds'
             else np.tasting_reminder_hours * interval '1 hour' end
      ) <= now()
    for update of ta skip locked
  ),
  stamped as (
    update public.tasting_attendees ta set reminder_sent_at = now()
    from due where ta.tasting_id = due.tasting_id and ta.user_id = due.user_id
    returning ta.tasting_id, ta.user_id
  )
  select stamped.tasting_id, stamped.user_id, gt.title, gt.group_id
  from stamped join public.group_tastings gt on gt.id = stamped.tasting_id;
end;
$$;


-- ── 8. Trigger functions (definer + search_path everywhere) ────────────────

-- Audit fix C1: ALL handle_* functions now have search_path set.

-- Auto-create profile on auth.users insert.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, display_name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'display_name', split_part(new.email, '@', 1))
  );
  return new;
end;
$$;

-- Owner is auto-added to group_members.
create or replace function public.handle_new_group()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.group_members (group_id, user_id, role)
  values (new.id, new.created_by, 'owner');
  return new;
end;
$$;

-- Friend request acceptance creates mirrored friendships.
create or replace function public.handle_friend_request_accepted()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.status = 'accepted' and old.status = 'pending' then
    insert into public.friendships (user_id, friend_id)
      values (new.sender_id, new.receiver_id) on conflict do nothing;
    insert into public.friendships (user_id, friend_id)
      values (new.receiver_id, new.sender_id) on conflict do nothing;
  end if;
  return new;
end;
$$;

-- Tasting creator + group members get an attendee row on tasting create.
create or replace function public.handle_tasting_created()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.tasting_attendees (tasting_id, user_id, status)
  select new.id, gm.user_id,
    case when gm.user_id = new.created_by then 'going' else 'no_response' end
  from public.group_members gm
  where gm.group_id = new.group_id
  on conflict do nothing;
  return new;
end;
$$;

-- friendships delete cascades to mirror + cleans up old friend_requests.
create or replace function public.friendships_mirror_delete()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  delete from public.friendships
   where user_id = old.friend_id and friend_id = old.user_id;
  delete from public.friend_requests
   where (sender_id = old.user_id   and receiver_id = old.friend_id)
      or (sender_id = old.friend_id and receiver_id = old.user_id);
  return old;
end;
$$;

-- Push notify trigger. Audit fix H4: payload is a thin envelope only —
-- {type, table, primary_key}. The edge function looks up details via
-- service-role client. Avoids leaking row contents over pg_net + logs.
-- Webhook secret is read from supabase_vault.
create or replace function public.notify_push()
returns trigger
language plpgsql
security definer
set search_path = public, extensions, vault
as $$
declare
  payload jsonb;
  secret  text;
  pk      jsonb;
begin
  select decrypted_secret into secret
  from vault.decrypted_secrets where name = 'push_webhook_secret' limit 1;

  -- Build a primary-key envelope per table — edge function re-fetches.
  if TG_TABLE_NAME = 'friend_requests'    then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_invitations' then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_tastings'    then pk := jsonb_build_object('id', new.id);
  elsif TG_TABLE_NAME = 'group_members'     then pk := jsonb_build_object('group_id', new.group_id, 'user_id', new.user_id);
  elsif TG_TABLE_NAME = 'group_wines'       then pk := jsonb_build_object('id', new.id);
  else pk := '{}'::jsonb;
  end if;

  payload := jsonb_build_object(
    'type',  TG_OP,
    'table', TG_TABLE_NAME,
    'pk',    pk
  );

  perform net.http_post(
    url := 'https://ungvhpffjhnojessifri.supabase.co/functions/v1/push',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'x-webhook-secret', coalesce(secret, '')
    ),
    body := payload
  );
  return new;
end;
$$;

-- BEFORE-trigger: wines_set_name_norm fills name_norm if caller didn't.
create or replace function public.wines_set_name_norm()
returns trigger
language plpgsql
as $$
begin
  if new.name_norm is null or new.name_norm = '' then
    new.name_norm := public.wine_name_norm(new.name);
  end if;
  return new;
end;
$$;

-- BEFORE-trigger: resolve canonical_wine_id on insert / preserve on update
-- unless caller explicitly reassigns. Anti-pollution from autosave.
create or replace function public.wines_resolve_canonical_trigger()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if TG_OP = 'INSERT' then
    if new.canonical_wine_id is null then
      new.canonical_wine_id := public.resolve_canonical_wine(
        new.name, new.winery, new.vintage, new.type,
        new.country, new.region, new.canonical_grape_id, new.user_id
      );
    end if;
  elsif TG_OP = 'UPDATE' then
    if new.canonical_wine_id is not null
       and new.canonical_wine_id is distinct from old.canonical_wine_id then
      -- Explicit reassignment: trust caller (Tier 3 merge / Same-wine modal).
      null;
    elsif old.canonical_wine_id is not null then
      new.canonical_wine_id := old.canonical_wine_id;
    elsif new.canonical_wine_id is null
       and (new.name    is distinct from old.name
         or new.winery  is distinct from old.winery
         or new.vintage is distinct from old.vintage) then
      new.canonical_wine_id := public.resolve_canonical_wine(
        new.name, new.winery, new.vintage, new.type,
        new.country, new.region, new.canonical_grape_id, new.user_id
      );
    end if;
  end if;
  return new;
end;
$$;

create or replace function public.wine_ratings_extended_aggregate_trigger()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  perform public.aggregate_wine_attributes(
    coalesce(new.canonical_wine_id, old.canonical_wine_id)
  );
  return null;
end;
$$;

create or replace function public.tg_seed_user_notification_prefs()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.user_notification_prefs (user_id) values (new.id)
  on conflict (user_id) do nothing;
  return new;
end;
$$;

create or replace function public.tg_user_notification_prefs_set_updated_at()
returns trigger
language plpgsql
as $$
begin new.updated_at := now(); return new; end;
$$;

create or replace function public.tg_reset_attendee_reminders_on_reschedule()
returns trigger
language plpgsql
as $$
begin
  if new.scheduled_at is distinct from old.scheduled_at then
    update public.tasting_attendees
       set reminder_sent_at = null
     where tasting_id = new.id;
  end if;
  return new;
end;
$$;


-- ── 9. Triggers ────────────────────────────────────────────────────────────

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

drop trigger if exists on_group_created on public.groups;
create trigger on_group_created
  after insert on public.groups
  for each row execute function public.handle_new_group();

drop trigger if exists on_friend_request_accepted on public.friend_requests;
create trigger on_friend_request_accepted
  after update on public.friend_requests
  for each row execute function public.handle_friend_request_accepted();

drop trigger if exists on_tasting_created on public.group_tastings;
create trigger on_tasting_created
  after insert on public.group_tastings
  for each row execute function public.handle_tasting_created();

drop trigger if exists friendships_mirror_delete_trg on public.friendships;
create trigger friendships_mirror_delete_trg
  after delete on public.friendships
  for each row execute function public.friendships_mirror_delete();

drop trigger if exists profiles_seed_user_notification_prefs on public.profiles;
create trigger profiles_seed_user_notification_prefs
  after insert on public.profiles
  for each row execute function public.tg_seed_user_notification_prefs();

drop trigger if exists user_notification_prefs_set_updated_at on public.user_notification_prefs;
create trigger user_notification_prefs_set_updated_at
  before update on public.user_notification_prefs
  for each row execute function public.tg_user_notification_prefs_set_updated_at();

drop trigger if exists group_tastings_reset_attendee_reminders on public.group_tastings;
create trigger group_tastings_reset_attendee_reminders
  after update on public.group_tastings
  for each row execute function public.tg_reset_attendee_reminders_on_reschedule();

drop trigger if exists wines_name_norm_trg on public.wines;
create trigger wines_name_norm_trg
  before insert or update on public.wines
  for each row execute function public.wines_set_name_norm();

drop trigger if exists wines_resolve_canonical on public.wines;
create trigger wines_resolve_canonical
  before insert or update on public.wines
  for each row execute function public.wines_resolve_canonical_trigger();

drop trigger if exists wine_ratings_extended_aggregate on public.wine_ratings_extended;
create trigger wine_ratings_extended_aggregate
  after insert or update or delete on public.wine_ratings_extended
  for each row execute function public.wine_ratings_extended_aggregate_trigger();

drop trigger if exists push_friend_requests on public.friend_requests;
create trigger push_friend_requests
  after insert on public.friend_requests
  for each row execute function public.notify_push();

drop trigger if exists push_friend_request_accept on public.friend_requests;
create trigger push_friend_request_accept
  after update on public.friend_requests
  for each row when (old.status is distinct from new.status and new.status = 'accepted')
  execute function public.notify_push();

drop trigger if exists push_group_invitations on public.group_invitations;
create trigger push_group_invitations
  after insert on public.group_invitations
  for each row execute function public.notify_push();

drop trigger if exists push_group_members on public.group_members;
create trigger push_group_members
  after insert on public.group_members
  for each row execute function public.notify_push();

drop trigger if exists push_group_tastings on public.group_tastings;
create trigger push_group_tastings
  after insert on public.group_tastings
  for each row execute function public.notify_push();

drop trigger if exists push_group_wines on public.group_wines;
create trigger push_group_wines
  after insert on public.group_wines
  for each row execute function public.notify_push();


-- ── 10. View(s) ────────────────────────────────────────────────────────────

-- Flattens personal + group + tasting ratings keyed on canonical_wine_id.
-- security_invoker so RLS on base tables applies to caller.
create or replace view public.ratings
with (security_invoker = true) as
select ('p_' || w.user_id::text || '_' || w.canonical_wine_id::text) as id,
       w.user_id, w.canonical_wine_id,
       w.rating::numeric as value, 'personal'::text as context,
       null::uuid as group_id, null::uuid as tasting_id,
       w.created_at, w.updated_at
from public.wines w where w.canonical_wine_id is not null
union all
select ('g_' || gwr.user_id::text || '_' || gwr.group_id::text || '_' || gwr.canonical_wine_id::text),
       gwr.user_id, gwr.canonical_wine_id,
       gwr.rating::numeric, 'group',
       gwr.group_id, null::uuid,
       gwr.created_at, gwr.updated_at
from public.group_wine_ratings gwr
union all
select ('t_' || tr.user_id::text || '_' || tr.tasting_id::text || '_' || tr.canonical_wine_id::text),
       tr.user_id, tr.canonical_wine_id,
       tr.rating::numeric, 'tasting',
       null::uuid, tr.tasting_id,
       tr.created_at, null::timestamptz
from public.tasting_ratings tr;


-- ── 11. Realtime publications ──────────────────────────────────────────────

alter publication supabase_realtime add table public.friend_requests;
alter publication supabase_realtime add table public.friendships;
alter publication supabase_realtime add table public.group_invitations;
alter publication supabase_realtime add table public.group_members;
alter publication supabase_realtime add table public.group_tastings;
alter publication supabase_realtime add table public.group_wine_ratings;
alter publication supabase_realtime add table public.group_wines;
alter publication supabase_realtime add table public.groups;
alter publication supabase_realtime add table public.tasting_attendees;
alter publication supabase_realtime add table public.tasting_ratings;
alter publication supabase_realtime add table public.tasting_wines;


-- ── 12. Cron jobs ──────────────────────────────────────────────────────────

-- Tasting reminder fan-out, every minute. Edge function reads
-- claim_due_tasting_reminders + sends FCM.
select cron.schedule(
  'tasting_reminders_every_minute',
  '* * * * *',
  $cron$
    select net.http_post(
      url := 'https://ungvhpffjhnojessifri.supabase.co/functions/v1/tasting-reminders',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'x-webhook-secret', coalesce(
          (select decrypted_secret from vault.decrypted_secrets
            where name = 'push_webhook_secret' limit 1),
          ''
        )
      ),
      body := '{}'::jsonb
    );
  $cron$
);


-- ── 13. Grants ─────────────────────────────────────────────────────────────

revoke all on function public.delete_my_account()                  from public;
revoke all on function public.join_group_by_invite_code(text)      from public;
revoke all on function public.merge_canonical_wines(uuid, uuid)    from public;
revoke all on function public.register_user_device(text, text)     from public;
revoke all on function public.unregister_user_device(text)         from public;

grant execute on function public.delete_my_account()                  to authenticated;
grant execute on function public.join_group_by_invite_code(text)      to authenticated;
grant execute on function public.register_user_device(text, text)     to authenticated;
grant execute on function public.unregister_user_device(text)         to authenticated;
grant execute on function public.merge_canonical_wines(uuid, uuid)    to authenticated;
grant execute on function public.find_canonical_merge_candidates(numeric, int) to authenticated;
grant execute on function public.find_unenriched_canonicals(boolean, int) to authenticated;
grant execute on function public.suggest_canonical_match(text, text, int) to authenticated;
grant execute on function public.record_canonical_match_decision(text, text, int, uuid, text) to authenticated;
grant execute on function public.get_taste_match(uuid)              to authenticated;
grant execute on function public.get_taste_compass(uuid, int)       to authenticated;
grant execute on function public.get_top_drinking_partners(int)     to authenticated;
grant execute on function public.get_shared_bottles(uuid, int)      to authenticated;
grant execute on function public.get_user_top_grapes(uuid, int)     to authenticated;
grant execute on function public.get_user_style_dna(uuid)           to authenticated;
grant execute on function public.get_friend_ratings_for_canonical_wine(uuid, int) to authenticated;
grant execute on function public.claim_due_tasting_reminders()      to service_role;

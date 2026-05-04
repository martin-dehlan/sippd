-- Canonical wine identity layer. Cross-user dedup of "the same bottle"
-- so multi-user features (drinking-partners, taste-match, compass,
-- shared-bottles) join via stable id rather than fragile string matches.
--
-- Phase 1: pure algorithmic. Resolution is name_norm + winery_norm +
-- vintage exact match (NULL vintage = legitimate non-vintage identity).
-- A separate decisions table records "no, different wine" picks so a
-- user is not prompted twice for the same near-match.

create extension if not exists pg_trgm;
create extension if not exists unaccent;

-- Idempotent normalisation used both by indexes and the resolution
-- trigger. Lowercase + unaccent + ß→ss + collapse whitespace.
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

create table if not exists public.canonical_wine (
  id                  uuid        primary key default gen_random_uuid(),
  name                text        not null,
  name_norm           text        not null check (length(name_norm) > 0),
  winery              text,
  winery_norm         text,
  vintage             int,
  type                text        check (type in ('red','white','rose','sparkling')),
  country             text,
  region              text,
  canonical_grape_id  uuid        references public.canonical_grape(id) on delete set null,
  enriched_at         timestamptz,
  needs_review        boolean     not null default false,
  confidence          text        not null default 'user'
                                  check (confidence in ('user','llm','verified')),
  created_at          timestamptz not null default now(),
  created_by          uuid        references auth.users(id) on delete set null
);

-- Match key. NULL winery / NULL vintage are valid (unknown winery; NV
-- bottle). COALESCE to sentinels so the unique index treats them as
-- equal across rows.
create unique index if not exists canonical_wine_match_key_idx
  on public.canonical_wine (
    name_norm,
    coalesce(winery_norm, ''),
    coalesce(vintage, -1)
  );

-- Trigram support for Tier 2 fuzzy "same wine?" suggestions.
create index if not exists canonical_wine_name_norm_trgm_idx
  on public.canonical_wine using gin (name_norm gin_trgm_ops);

create index if not exists canonical_wine_winery_norm_idx
  on public.canonical_wine (winery_norm);

alter table public.canonical_wine enable row level security;

-- Anyone authenticated can read the catalog. Writes only happen via
-- SECURITY DEFINER trigger when a user inserts into wines, so end
-- users have no direct write path.
drop policy if exists "canonical_wine_select_all" on public.canonical_wine;
create policy "canonical_wine_select_all"
  on public.canonical_wine for select
  to authenticated
  using (true);

-- ── Match-decisions ──────────────────────────────────────────────────
-- Records each user's "linked / different" choice on a Tier-2 fuzzy
-- candidate so we never re-prompt for the same input pair. Per-user
-- because two people can legitimately disagree on whether two near-
-- matches are the same wine.

create table if not exists public.canonical_wine_match_decisions (
  id                       uuid        primary key default gen_random_uuid(),
  user_id                  uuid        not null references auth.users(id) on delete cascade,
  input_name_norm          text        not null,
  input_winery_norm        text,
  input_vintage            int,
  candidate_canonical_id   uuid        not null references public.canonical_wine(id) on delete cascade,
  decision                 text        not null check (decision in ('linked','different')),
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

alter table public.canonical_wine_match_decisions enable row level security;

drop policy if exists "match_decisions_own" on public.canonical_wine_match_decisions;
create policy "match_decisions_own"
  on public.canonical_wine_match_decisions
  for all
  to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

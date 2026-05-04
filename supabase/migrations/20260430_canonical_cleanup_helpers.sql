-- Phase 1.5 cleanup helpers. Used by:
--   * Tier 3 manual-merge UI (find_canonical_merge_candidates)
--   * Ad-hoc LLM cleanup runs (find_unenriched_canonicals,
--     find_canonical_merge_candidates) triggered via Claude Code MCP
--     against this DB. No production cron / API contract — the user
--     pulls the trigger when the catalog feels noisy.

-- Returns canonical pairs that look like the same wine: trigram
-- similarity ≥ 0.6 on name_norm, same winery_norm (or both null),
-- and the caller has at least one wines row pointing at either side
-- so they can act on the merge. Sorted strongest → weakest.

create or replace function public.find_canonical_merge_candidates(
  p_min_similarity numeric default 0.6,
  p_limit          int     default 50
)
returns table (
  loser_id    uuid,
  winner_id   uuid,
  loser_name  text,
  winner_name text,
  loser_winery  text,
  winner_winery text,
  loser_vintage  int,
  winner_vintage int,
  similarity     numeric
)
language sql
security definer
set search_path = public
stable
as $$
  with my_canonicals as (
    select distinct canonical_wine_id
    from public.wines
    where user_id = auth.uid()
      and canonical_wine_id is not null
  ),
  pairs as (
    select
      a.id   as loser_id,
      b.id   as winner_id,
      a.name as loser_name,
      b.name as winner_name,
      a.winery  as loser_winery,
      b.winery  as winner_winery,
      a.vintage  as loser_vintage,
      b.vintage  as winner_vintage,
      similarity(a.name_norm, b.name_norm)::numeric as similarity
    from public.canonical_wine a
    join public.canonical_wine b on a.id < b.id
    where similarity(a.name_norm, b.name_norm) >= p_min_similarity
      and (
        a.winery_norm is null
        or b.winery_norm is null
        or a.winery_norm = b.winery_norm
      )
      and (
        exists (select 1 from my_canonicals m where m.canonical_wine_id = a.id)
        or
        exists (select 1 from my_canonicals m where m.canonical_wine_id = b.id)
      )
  )
  select * from pairs
  order by similarity desc, loser_name asc
  limit p_limit;
$$;

grant execute on function public.find_canonical_merge_candidates(numeric, int) to authenticated;

-- Returns canonicals that have NULL country / region / type so the
-- ad-hoc LLM run knows what to enrich. needs_review filter so the
-- caller can prioritise rows already flagged for human or LLM
-- attention.

create or replace function public.find_unenriched_canonicals(
  p_only_needs_review boolean default false,
  p_limit int default 100
)
returns table (
  id          uuid,
  name        text,
  winery      text,
  vintage     int,
  type        text,
  country     text,
  region      text,
  needs_review boolean,
  enriched_at timestamptz,
  wine_count  int
)
language sql
security definer
set search_path = public
stable
as $$
  select
    cw.id,
    cw.name,
    cw.winery,
    cw.vintage,
    cw.type,
    cw.country,
    cw.region,
    cw.needs_review,
    cw.enriched_at,
    (select count(*)::int from public.wines w where w.canonical_wine_id = cw.id) as wine_count
  from public.canonical_wine cw
  where (
    cw.type    is null
    or cw.country is null
    or cw.region  is null
  )
    and (not p_only_needs_review or cw.needs_review)
  order by
    cw.needs_review desc,
    (select count(*) from public.wines w where w.canonical_wine_id = cw.id) desc,
    cw.created_at asc
  limit p_limit;
$$;

grant execute on function public.find_unenriched_canonicals(boolean, int) to authenticated;

-- Tier 2 fuzzy match support. Two pieces:
--   1. suggest_canonical_match(name, winery, vintage) — returns the
--      Tier 1 exact match if one exists, otherwise up to 3 Tier 2
--      fuzzy candidates (trigram ≥ 0.6, same winery_norm when both
--      sides have one) that the user hasn't already declined.
--   2. Updates the wines trigger so an explicit canonical_wine_id
--      passed by the client is respected — letting the user link a
--      new wines row to a fuzzy candidate they confirmed.

create or replace function public.suggest_canonical_match(
  p_name    text,
  p_winery  text,
  p_vintage int
)
returns table (
  candidate_id uuid,
  name         text,
  winery       text,
  vintage      int,
  similarity   numeric,
  is_exact     boolean
)
language sql
security definer
set search_path = public
stable
as $$
  with input_norm as (
    select
      public.normalize_wine_text(p_name)   as name_norm,
      public.normalize_wine_text(p_winery) as winery_norm,
      p_vintage                            as vintage
  ),
  exact_match as (
    select
      cw.id   as candidate_id,
      cw.name,
      cw.winery,
      cw.vintage,
      1.0::numeric as similarity,
      true         as is_exact
    from public.canonical_wine cw
    cross join input_norm i
    where i.name_norm is not null
      and cw.name_norm = i.name_norm
      and coalesce(cw.winery_norm, '') = coalesce(i.winery_norm, '')
      and coalesce(cw.vintage, -1)     = coalesce(i.vintage, -1)
    limit 1
  ),
  fuzzy_matches as (
    select
      cw.id  as candidate_id,
      cw.name,
      cw.winery,
      cw.vintage,
      similarity(cw.name_norm, i.name_norm)::numeric as similarity,
      false  as is_exact
    from public.canonical_wine cw
    cross join input_norm i
    where i.name_norm is not null
      and not exists (select 1 from exact_match)
      and similarity(cw.name_norm, i.name_norm) >= 0.6
      and (
        cw.winery_norm is null
        or i.winery_norm is null
        or cw.winery_norm = i.winery_norm
      )
      and not (
        cw.name_norm = i.name_norm
        and coalesce(cw.winery_norm, '') = coalesce(i.winery_norm, '')
        and coalesce(cw.vintage, -1)     = coalesce(i.vintage, -1)
      )
      and not exists (
        select 1 from public.canonical_wine_match_decisions d
        where d.user_id                = auth.uid()
          and d.input_name_norm        = i.name_norm
          and coalesce(d.input_winery_norm, '') = coalesce(i.winery_norm, '')
          and coalesce(d.input_vintage, -1)     = coalesce(i.vintage, -1)
          and d.candidate_canonical_id = cw.id
          and d.decision               = 'different'
      )
    order by similarity(cw.name_norm, i.name_norm) desc, cw.created_at desc
    limit 3
  )
  select candidate_id, name, winery, vintage, similarity, is_exact
  from exact_match
  union all
  select candidate_id, name, winery, vintage, similarity, is_exact
  from fuzzy_matches;
$$;

grant execute on function public.suggest_canonical_match(text, text, int) to authenticated;

-- Records a Tier 2 decision so we never re-prompt the user for the
-- same input pair. Use insert-or-update because a user might pick
-- "different" once then later realise it's the same wine.

create or replace function public.record_canonical_match_decision(
  p_input_name    text,
  p_input_winery  text,
  p_input_vintage int,
  p_candidate_id  uuid,
  p_decision      text
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
  if auth.uid() is null then
    raise exception 'auth required';
  end if;
  if p_decision not in ('linked','different') then
    raise exception 'invalid decision: %', p_decision;
  end if;

  v_name_norm   := public.normalize_wine_text(p_input_name);
  v_winery_norm := public.normalize_wine_text(p_input_winery);

  if v_name_norm is null then
    return;
  end if;

  insert into public.canonical_wine_match_decisions (
    user_id, input_name_norm, input_winery_norm, input_vintage,
    candidate_canonical_id, decision
  ) values (
    auth.uid(), v_name_norm, v_winery_norm, p_input_vintage,
    p_candidate_id, p_decision
  )
  on conflict (
    user_id, input_name_norm,
    coalesce(input_winery_norm, ''),
    coalesce(input_vintage, -1),
    candidate_canonical_id
  ) do update set
    decision   = excluded.decision,
    decided_at = now();
end;
$$;

grant execute on function public.record_canonical_match_decision(text, text, int, uuid, text) to authenticated;

-- ── Trigger update ──────────────────────────────────────────────────
-- Respect an explicit canonical_wine_id passed by the client (e.g. the
-- user linked a fuzzy candidate). Only auto-resolve when the field
-- is left null.

create or replace function public.wines_resolve_canonical_trigger()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if TG_OP = 'INSERT' then
    if NEW.canonical_wine_id is null then
      NEW.canonical_wine_id := public.resolve_canonical_wine(
        NEW.name, NEW.winery, NEW.vintage, NEW.type,
        NEW.country, NEW.region, NEW.canonical_grape_id,
        NEW.user_id
      );
    end if;
  elsif TG_OP = 'UPDATE' then
    if NEW.name    is distinct from OLD.name
       or NEW.winery  is distinct from OLD.winery
       or NEW.vintage is distinct from OLD.vintage
       or NEW.canonical_wine_id is null then
      NEW.canonical_wine_id := public.resolve_canonical_wine(
        NEW.name, NEW.winery, NEW.vintage, NEW.type,
        NEW.country, NEW.region, NEW.canonical_grape_id,
        NEW.user_id
      );
    end if;
  end if;
  return NEW;
end;
$$;

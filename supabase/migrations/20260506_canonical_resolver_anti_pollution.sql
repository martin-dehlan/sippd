-- Anti-pollution hardening for the canonical_wine resolver.
--
-- Problem (verified 2026-05-06): wine_edit.screen runs WineForm with
-- autoSave: true (500ms debounce). Every settled keystroke sends an
-- UPDATE on public.wines, which fires wines_resolve_canonical_trigger,
-- which calls resolve_canonical_wine, which always inserts a new
-- canonical_wine row when the (name_norm, winery_norm, vintage) triplet
-- has no exact match. Result: 14 canonical rows for a single bottle of
-- Krug Grande Cuvée — one per partial typing.
--
-- Two fixes here:
--
-- 1. Trigger preserves OLD.canonical_wine_id on UPDATE. Once a wine has
--    been resolved, autosave-driven name/winery/vintage flux can no
--    longer churn a new canonical. Re-resolution still happens when
--    canonical_wine_id was previously NULL (e.g. legacy rows pre-Phase 1).
--    Genuine identity changes happen via Tier 3 manual merge in Profile,
--    not via free-form edit.
--
-- 2. resolve_canonical_wine rejects inputs shorter than 3 characters
--    (post-normalize). Defends against the "K", "Kr", "Kru" tail of any
--    accidental UPDATE path that bypasses fix #1.

-- ── Fix 1: trigger preserves linked canonical on UPDATE ──────────────
create or replace function public.wines_resolve_canonical_trigger()
returns trigger
language plpgsql
security definer
set search_path = public
as $function$
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
    -- Preserve a previously-linked canonical regardless of edits to
    -- name / winery / vintage. Only re-resolve when the wine never had
    -- a canonical (legacy / null state).
    if OLD.canonical_wine_id is not null then
      NEW.canonical_wine_id := OLD.canonical_wine_id;
    elsif NEW.canonical_wine_id is null
       and (NEW.name    is distinct from OLD.name
         or NEW.winery  is distinct from OLD.winery
         or NEW.vintage is distinct from OLD.vintage) then
      NEW.canonical_wine_id := public.resolve_canonical_wine(
        NEW.name, NEW.winery, NEW.vintage, NEW.type,
        NEW.country, NEW.region, NEW.canonical_grape_id,
        NEW.user_id
      );
    end if;
  end if;
  return NEW;
end;
$function$;

-- ── Fix 2: minimum normalized name length in resolver ────────────────
create or replace function public.resolve_canonical_wine(
  p_name              text,
  p_winery            text,
  p_vintage           integer,
  p_type              text,
  p_country           text,
  p_region            text,
  p_canonical_grape_id uuid,
  p_user_id           uuid
)
returns uuid
language plpgsql
security definer
set search_path = public
as $function$
declare
  v_name_norm   text;
  v_winery_norm text;
  v_id          uuid;
begin
  v_name_norm   := public.normalize_wine_text(p_name);
  v_winery_norm := public.normalize_wine_text(p_winery);

  -- Guard: never seed a canonical from a stub. Three chars is the
  -- minimum that conveys identity ("Krug", "Cab", "Pol", etc).
  if v_name_norm is null or length(v_name_norm) < 3 then
    return null;
  end if;

  select id into v_id
  from public.canonical_wine
  where name_norm = v_name_norm
    and coalesce(winery_norm, '') = coalesce(v_winery_norm, '')
    and coalesce(vintage, -1) = coalesce(p_vintage, -1)
  limit 1;

  if v_id is not null then
    return v_id;
  end if;

  insert into public.canonical_wine (
    name, name_norm, winery, winery_norm, vintage,
    type, country, region, canonical_grape_id,
    confidence, created_by
  ) values (
    btrim(p_name), v_name_norm,
    nullif(btrim(coalesce(p_winery, '')), ''), v_winery_norm,
    p_vintage, p_type, p_country, p_region, p_canonical_grape_id,
    'user', p_user_id
  )
  on conflict (name_norm, coalesce(winery_norm, ''), coalesce(vintage, -1))
    do nothing
  returning id into v_id;

  if v_id is null then
    select id into v_id
    from public.canonical_wine
    where name_norm = v_name_norm
      and coalesce(winery_norm, '') = coalesce(v_winery_norm, '')
      and coalesce(vintage, -1) = coalesce(p_vintage, -1);
  end if;

  return v_id;
end;
$function$;

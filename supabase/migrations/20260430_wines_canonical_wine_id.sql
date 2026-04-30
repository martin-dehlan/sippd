-- Wires every wines row to a canonical_wine. The trigger keeps the FK
-- in sync on insert and on edits that change name / winery / vintage,
-- so a user renaming "krug" → "Krug Brut" automatically rebinds. Old
-- canonicals that nobody references any longer become orphans and can
-- be GC'd later — kept for audit.

alter table public.wines
  add column if not exists canonical_wine_id uuid
    references public.canonical_wine(id) on delete set null;

create index if not exists wines_canonical_wine_id_idx
  on public.wines (canonical_wine_id);

-- ── Resolver ────────────────────────────────────────────────────────
-- Find-or-create a canonical_wine for the given user-input fields.
-- Returns NULL when the wine has no usable name (won't participate in
-- multi-user features). SECURITY DEFINER so the trigger can write to
-- canonical_wine without granting per-user write permissions.

create or replace function public.resolve_canonical_wine(
  p_name               text,
  p_winery             text,
  p_vintage            int,
  p_type               text,
  p_country            text,
  p_region             text,
  p_canonical_grape_id uuid,
  p_user_id            uuid
) returns uuid
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

  if v_name_norm is null then
    return null;
  end if;

  -- Tier 1 exact match: name_norm + winery_norm + vintage (NULL-safe)
  select id into v_id
  from public.canonical_wine
  where name_norm = v_name_norm
    and coalesce(winery_norm, '') = coalesce(v_winery_norm, '')
    and coalesce(vintage, -1) = coalesce(p_vintage, -1)
  limit 1;

  if v_id is not null then
    return v_id;
  end if;

  -- Miss → create. ON CONFLICT guards against parallel inserts of the
  -- same identity (race between two clients adding the same wine).
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
    -- conflict raced — fetch the row that won
    select id into v_id
    from public.canonical_wine
    where name_norm = v_name_norm
      and coalesce(winery_norm, '') = coalesce(v_winery_norm, '')
      and coalesce(vintage, -1) = coalesce(p_vintage, -1);
  end if;

  return v_id;
end;
$$;

-- ── Trigger ─────────────────────────────────────────────────────────
-- Re-resolves canonical_wine_id whenever a wines row is inserted, or
-- when name / winery / vintage change on update, or when the column
-- ended up null (e.g. backfill miss). Other column edits (rating,
-- notes, photo, location) leave the canonical link untouched.

create or replace function public.wines_resolve_canonical_trigger()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if TG_OP = 'INSERT' then
    NEW.canonical_wine_id := public.resolve_canonical_wine(
      NEW.name, NEW.winery, NEW.vintage, NEW.type,
      NEW.country, NEW.region, NEW.canonical_grape_id,
      NEW.user_id
    );
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

drop trigger if exists wines_resolve_canonical on public.wines;
create trigger wines_resolve_canonical
  before insert or update on public.wines
  for each row execute function public.wines_resolve_canonical_trigger();

-- ── Backfill ────────────────────────────────────────────────────────
-- Resolve every existing wine. The trigger short-circuits because
-- name/winery/vintage are unchanged AND canonical_wine_id becomes
-- non-null in the same statement, so it does not re-run.

update public.wines w
   set canonical_wine_id = public.resolve_canonical_wine(
     w.name, w.winery, w.vintage, w.type,
     w.country, w.region, w.canonical_grape_id,
     w.user_id
   )
 where canonical_wine_id is null;

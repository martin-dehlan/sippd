-- Refinement of wines_resolve_canonical_trigger: distinguish IMPLICIT
-- edits (autosave-driven) from EXPLICIT canonical reassignments
-- (Tier 3 merge, admin cleanup). Implicit = preserve OLD; explicit =
-- respect the new value.
--
-- Surfaced 2026-05-06 during admin cleanup of polluted Krug canonicals:
-- the previous tightening (preserve-OLD-on-update) blocked legitimate
-- explicit re-assignment paths. This version keeps autosave-pollution
-- protection while letting authorised reassignment flows through.

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
    if NEW.canonical_wine_id is not null
       and NEW.canonical_wine_id is distinct from OLD.canonical_wine_id then
      null;
    elsif OLD.canonical_wine_id is not null then
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

-- Backfills `name_norm` on rows inserted before the column existed and
-- enforces the invariant server-side via a trigger. The client computes
-- name_norm in lib/common/utils/name_normalizer.dart for local Drift
-- writes; the trigger is a safety net for any path that bypasses the
-- Dart pipeline (admin edits, future SQL migrations, other clients).

create extension if not exists unaccent;

-- SQL approximation of normalizeName() in name_normalizer.dart.
-- Keep in sync with the Dart algorithm:
--   lower → ß→ss → strip diacritics → non-alnum→space → collapse whitespace
create or replace function public.wine_name_norm(raw text)
returns text
language sql
immutable
as $$
  select case
    when raw is null then null
    else trim(
      regexp_replace(
        regexp_replace(
          lower(unaccent(replace(raw, 'ß', 'ss'))),
          '[^[:alnum:][:space:]]', ' ', 'g'
        ),
        '\s+', ' ', 'g'
      )
    )
  end;
$$;

-- Backfill existing rows once.
update public.wines
set name_norm = public.wine_name_norm(name)
where name_norm is null;

-- Trigger: auto-sync name_norm whenever name changes and caller didn't
-- supply its own name_norm. Keeps Dart client authoritative on writes
-- that include name_norm, but prevents nulls on writes that don't.
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

drop trigger if exists wines_name_norm_trg on public.wines;
create trigger wines_name_norm_trg
  before insert or update of name, name_norm on public.wines
  for each row execute function public.wines_set_name_norm();

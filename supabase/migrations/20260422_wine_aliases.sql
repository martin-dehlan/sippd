-- Wine aliases: per-user mapping from a local wine id to a canonical
-- wine id. Created when a member opts "same wine" in the dedup-on-share
-- dialog. A user can only alias their own wines; the canonical target can
-- be any wine visible to them under existing wine RLS.
--
-- `source` is a discriminator so future merge flows (manual_merge,
-- admin_merge, duplicate_detection) can coexist with share_match without
-- another migration.

create table if not exists public.wine_aliases (
  user_id            uuid not null references public.profiles(id) on delete cascade,
  local_wine_id      uuid not null references public.wines(id)    on delete cascade,
  canonical_wine_id  uuid not null references public.wines(id)    on delete cascade,
  source             text not null default 'share_match'
                     check (source in ('share_match','manual_merge','admin_merge','duplicate_detection')),
  created_at         timestamptz not null default now(),
  primary key (user_id, local_wine_id),
  check (local_wine_id <> canonical_wine_id)
);

-- Reverse lookup: "all my local wines aliased to canonical X"
create index if not exists wine_aliases_user_canonical_idx
  on public.wine_aliases (user_id, canonical_wine_id);

-- Global lookup: "who else aliased to this canonical"
create index if not exists wine_aliases_canonical_idx
  on public.wine_aliases (canonical_wine_id);

alter table public.wine_aliases enable row level security;

drop policy if exists "wine_aliases_select_self" on public.wine_aliases;
create policy "wine_aliases_select_self"
  on public.wine_aliases
  for select
  using (auth.uid() = user_id);

drop policy if exists "wine_aliases_insert_self_owning_local" on public.wine_aliases;
create policy "wine_aliases_insert_self_owning_local"
  on public.wine_aliases
  for insert
  with check (
    auth.uid() = user_id
    and exists (
      select 1 from public.wines w
      where w.id = wine_aliases.local_wine_id
        and w.user_id = auth.uid()
    )
  );

drop policy if exists "wine_aliases_delete_self" on public.wine_aliases;
create policy "wine_aliases_delete_self"
  on public.wine_aliases
  for delete
  using (auth.uid() = user_id);

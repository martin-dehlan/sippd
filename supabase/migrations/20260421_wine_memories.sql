-- Replaces single memory image columns on `wines` with a dedicated
-- `wine_memories` table so each wine can have many memories over time.
-- Beta wipe: existing memory_image_url / memory_local_image_path data is dropped.

alter table public.wines drop column if exists memory_image_url;
alter table public.wines drop column if exists memory_local_image_path;

create table if not exists public.wine_memories (
  id                 uuid primary key default gen_random_uuid(),
  wine_id            uuid not null references public.wines(id)    on delete cascade,
  user_id            uuid not null references public.profiles(id) on delete cascade,
  image_url          text,
  local_image_path   text,
  caption            text,
  created_at         timestamptz not null default now()
);

-- Feed: memories for a wine in reverse-chronological order
create index if not exists wine_memories_wine_created_idx
  on public.wine_memories (wine_id, created_at desc);

-- Profile feed: a user's memories across wines
create index if not exists wine_memories_user_created_idx
  on public.wine_memories (user_id, created_at desc);

alter table public.wine_memories enable row level security;

drop policy if exists "wine_memories_select_own" on public.wine_memories;
create policy "wine_memories_select_own"
  on public.wine_memories
  for select
  using (auth.uid() = user_id);

drop policy if exists "wine_memories_insert_own" on public.wine_memories;
create policy "wine_memories_insert_own"
  on public.wine_memories
  for insert
  with check (auth.uid() = user_id);

drop policy if exists "wine_memories_update_own" on public.wine_memories;
create policy "wine_memories_update_own"
  on public.wine_memories
  for update
  using (auth.uid() = user_id);

drop policy if exists "wine_memories_delete_own" on public.wine_memories;
create policy "wine_memories_delete_own"
  on public.wine_memories
  for delete
  using (auth.uid() = user_id);

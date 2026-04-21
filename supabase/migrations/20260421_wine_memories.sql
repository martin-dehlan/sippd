-- Replaces single memory image columns on `wines` with a dedicated
-- `wine_memories` table. Beta wipe: existing memory_image_url /
-- memory_local_image_path data is dropped.

-- 1) Drop old columns from wines
alter table public.wines drop column if exists memory_image_url;
alter table public.wines drop column if exists memory_local_image_path;

-- 2) Create wine_memories table
create table if not exists public.wine_memories (
  id                  text primary key,
  wine_id             text not null references public.wines(id) on delete cascade,
  user_id             uuid not null references auth.users(id)  on delete cascade,
  image_url           text,
  local_image_path    text,
  created_at          timestamptz not null default now()
);

create index if not exists wine_memories_wine_id_idx
  on public.wine_memories (wine_id);

create index if not exists wine_memories_user_id_idx
  on public.wine_memories (user_id);

-- 3) RLS
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

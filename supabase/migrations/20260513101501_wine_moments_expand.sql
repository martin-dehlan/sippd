-- Wine Moments — phase 1 (data layer)
--
-- Extends wine_memories with rich context fields (occasion, place,
-- companions, food, note) so a "memory" becomes a true journal moment.
-- Adds wine_memory_photos sibling table so a single moment can hold up
-- to 10 photos. Existing image_url / local_image_path columns on
-- wine_memories stay during phase 1 + 2 for back-compat; cleanup +
-- removal lands in phase 3.
--
-- Naming: DB stays "wine_memories"/"wine_memory_photos" (kept to avoid
-- code churn — Strategy A). UX label moves to "Moments" in 5 locales.
--
-- See project_wine_moments_design.md memory for full design.

-- ─── 1. Extend wine_memories with moment fields ─────────────────────
-- occurred_at added nullable first so we can back-fill from created_at
-- before flipping NOT NULL. Other cols are either nullable or default
-- to a literal so the ADD COLUMN can be one-shot.
alter table public.wine_memories
  add column if not exists occurred_at         timestamptz,
  add column if not exists occasion            text,
  add column if not exists place_name          text,
  add column if not exists place_lat           double precision,
  add column if not exists place_lng           double precision,
  add column if not exists food_paired         text,
  add column if not exists companion_user_ids  uuid[] not null default '{}',
  add column if not exists note                text,
  add column if not exists visibility          text not null default 'friends',
  add column if not exists updated_at          timestamptz not null default now();

-- Back-fill occurred_at = created_at for existing rows, then make it
-- NOT NULL with default now() for inserts from here on.
update public.wine_memories
   set occurred_at = created_at
 where occurred_at is null;

alter table public.wine_memories
  alter column occurred_at set not null,
  alter column occurred_at set default now();

-- Length caps consistent with existing text caps migration policy.
alter table public.wine_memories
  add constraint wine_memories_occasion_len    check (occasion    is null or length(occasion)    <= 50),
  add constraint wine_memories_place_name_len  check (place_name  is null or length(place_name)  <= 120),
  add constraint wine_memories_food_paired_len check (food_paired is null or length(food_paired) <= 200),
  add constraint wine_memories_note_len        check (note        is null or length(note)        <= 1000),
  add constraint wine_memories_visibility_ck   check (visibility in ('private', 'friends', 'public'));

-- Index for timeline reads (most-recent first per user).
create index if not exists wine_memories_user_occurred_idx
  on public.wine_memories (user_id, occurred_at desc);

-- ─── 2. wine_memory_photos sibling table ────────────────────────────
create table if not exists public.wine_memory_photos (
  id               uuid primary key default gen_random_uuid(),
  memory_id        uuid not null references public.wine_memories(id) on delete cascade,
  storage_path     text not null,
  position         int  not null default 0,
  created_at       timestamptz not null default now(),
  constraint wine_memory_photos_storage_path_len check (length(storage_path) <= 500)
);

create index if not exists wine_memory_photos_memory_idx
  on public.wine_memory_photos (memory_id, position);

-- Enforce 10-photo cap per moment via trigger (cheaper than per-row check).
create or replace function public.enforce_wine_memory_photos_cap()
returns trigger
language plpgsql
as $$
begin
  if (
    select count(*) from public.wine_memory_photos
     where memory_id = new.memory_id
  ) >= 10 then
    raise exception 'wine_memory_photos cap reached (10 per memory)';
  end if;
  return new;
end;
$$;

create trigger wine_memory_photos_cap_trg
  before insert on public.wine_memory_photos
  for each row execute function public.enforce_wine_memory_photos_cap();

-- ─── 3. RLS ─────────────────────────────────────────────────────────
alter table public.wine_memory_photos enable row level security;

-- 3a. Extend wine_memories SELECT policies for visibility-aware reads.
-- Existing wine_memories_select_own stays. Add friend + companion read.
create policy wine_memories_select_friends on public.wine_memories
  for select to authenticated using (
    visibility in ('friends', 'public')
    and exists (
      select 1 from public.friendships f
       where f.user_id = auth.uid() and f.friend_id = wine_memories.user_id
    )
  );

create policy wine_memories_select_tagged on public.wine_memories
  for select to authenticated using (
    auth.uid() = any (companion_user_ids)
  );

-- 3b. wine_memory_photos: read inherits from parent wine_memories.
create policy wine_memory_photos_select_via_memory on public.wine_memory_photos
  for select to authenticated using (
    exists (
      select 1 from public.wine_memories m
       where m.id = wine_memory_photos.memory_id
         and (
              m.user_id = auth.uid()
           or (m.visibility in ('friends', 'public') and exists (
                select 1 from public.friendships f
                 where f.user_id = auth.uid() and f.friend_id = m.user_id
              ))
           or auth.uid() = any (m.companion_user_ids)
         )
    )
  );

create policy wine_memory_photos_insert_own on public.wine_memory_photos
  for insert to authenticated with check (
    exists (
      select 1 from public.wine_memories m
       where m.id = wine_memory_photos.memory_id and m.user_id = auth.uid()
    )
  );

create policy wine_memory_photos_update_own on public.wine_memory_photos
  for update to authenticated
  using (
    exists (
      select 1 from public.wine_memories m
       where m.id = wine_memory_photos.memory_id and m.user_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from public.wine_memories m
       where m.id = wine_memory_photos.memory_id and m.user_id = auth.uid()
    )
  );

create policy wine_memory_photos_delete_own on public.wine_memory_photos
  for delete to authenticated using (
    exists (
      select 1 from public.wine_memories m
       where m.id = wine_memory_photos.memory_id and m.user_id = auth.uid()
    )
  );

-- ─── 4. Grants ──────────────────────────────────────────────────────
grant select, insert, update, delete on public.wine_memory_photos to authenticated;

-- ─── 5. updated_at trigger ──────────────────────────────────────────
create or replace function public.touch_wine_memories_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

drop trigger if exists wine_memories_touch_updated_at on public.wine_memories;
create trigger wine_memories_touch_updated_at
  before update on public.wine_memories
  for each row execute function public.touch_wine_memories_updated_at();

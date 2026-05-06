-- Tasting lifecycle: phase-aware tastings (upcoming → active → concluded)
-- and lineup-mode (planned vs open) so the same screen can serve all
-- friends-group tasting personas — pre-bought home tasting, everyone-
-- brings, and external venue (winery / restaurant). State transitions
-- are explicit (host-driven), never auto-flipped.

alter table public.group_tastings
  add column if not exists lineup_mode text not null default 'planned',
  add column if not exists state       text not null default 'upcoming',
  add column if not exists started_at  timestamptz,
  add column if not exists ended_at    timestamptz;

-- Constrain enums.
alter table public.group_tastings
  add constraint group_tastings_lineup_mode_check
    check (lineup_mode in ('planned','open'));

alter table public.group_tastings
  add constraint group_tastings_state_check
    check (state in ('upcoming','active','concluded'));

-- Sort tastings by state quickly (active first in lists, then upcoming,
-- then concluded — index supports cheap filter+sort).
create index if not exists group_tastings_state_idx
  on public.group_tastings (state);

-- Backfill: any row with started_at set but state still 'upcoming' is
-- already running. ended_at set → concluded. (Defensive — current rows
-- should all be 'upcoming'.)
update public.group_tastings
   set state = 'concluded'
 where ended_at is not null
   and state    = 'upcoming';

update public.group_tastings
   set state = 'active'
 where started_at is not null
   and ended_at   is null
   and state      = 'upcoming';

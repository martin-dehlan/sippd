-- Phase 4 Pro feature: per-rating expert perceptions (5-pt sliders for
-- body/tannin/acid/sweet/oak, 3-pt finish, aroma tag chips). These
-- aggregate into canonical_wine_attributes once ≥3 expert entries
-- exist for a wine, refining the Style DNA fallback chain.

create table if not exists public.canonical_wine_attributes (
  canonical_wine_id  uuid        primary key references public.canonical_wine(id) on delete cascade,
  body               real        not null check (body between 0 and 1),
  tannin             real        check (tannin is null or tannin between 0 and 1),
  acidity            real        not null check (acidity between 0 and 1),
  sweetness          real        not null check (sweetness between 0 and 1),
  oak                real        not null check (oak between 0 and 1),
  intensity          real        not null check (intensity between 0 and 1),
  finish             smallint    check (finish between 1 and 3),
  aroma_tags         text[]      not null default '{}',
  sample_count       smallint    not null default 0,
  source             text        not null default 'expert'
                                 check (source in ('llm','expert','verified')),
  updated_at         timestamptz not null default now()
);

alter table public.canonical_wine_attributes enable row level security;
drop policy if exists "wine_attributes_select_all" on public.canonical_wine_attributes;
create policy "wine_attributes_select_all"
  on public.canonical_wine_attributes for select
  to authenticated using (true);

create table if not exists public.wine_ratings_extended (
  id                   uuid        primary key default gen_random_uuid(),
  user_id              uuid        not null references auth.users(id) on delete cascade,
  canonical_wine_id    uuid        not null references public.canonical_wine(id) on delete cascade,
  context              text        not null check (context in ('personal','group','tasting')),
  group_id             uuid        references public.groups(id) on delete cascade,
  tasting_id           uuid        references public.group_tastings(id) on delete cascade,
  body                 smallint    check (body between 1 and 5),
  tannin               smallint    check (tannin between 1 and 5),
  acidity              smallint    check (acidity between 1 and 5),
  sweetness            smallint    check (sweetness between 1 and 5),
  oak                  smallint    check (oak between 1 and 5),
  finish               smallint    check (finish between 1 and 3),
  aroma_tags           text[]      not null default '{}',
  created_at           timestamptz not null default now(),
  updated_at           timestamptz not null default now()
);

-- Plain triple unique — group_id / tasting_id stay as metadata so the
-- Supabase upsert client can match the onConflict spec without
-- needing expression-index matching.
alter table public.wine_ratings_extended
  drop constraint if exists wine_ratings_extended_user_wine_context_unique;
alter table public.wine_ratings_extended
  add constraint wine_ratings_extended_user_wine_context_unique
  unique (user_id, canonical_wine_id, context);

create index if not exists wine_ratings_extended_canonical_idx
  on public.wine_ratings_extended (canonical_wine_id);

alter table public.wine_ratings_extended enable row level security;
drop policy if exists "wine_ratings_extended_select_own" on public.wine_ratings_extended;
create policy "wine_ratings_extended_select_own"
  on public.wine_ratings_extended for select
  to authenticated using (user_id = auth.uid());
drop policy if exists "wine_ratings_extended_write_own" on public.wine_ratings_extended;
create policy "wine_ratings_extended_write_own"
  on public.wine_ratings_extended for all
  to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

-- Aggregation — recompute canonical_wine_attributes from all expert
-- entries when n ≥ 3. 5-pt scale maps to 0..1 via (v-1)/4. Tannin
-- only counted when at least one entry has it set. Aroma_tags = union
-- of tags appearing in at least 2 entries.

create or replace function public.aggregate_wine_attributes(
  p_canonical_wine_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  v_n int;
begin
  select count(*) into v_n
  from public.wine_ratings_extended
  where canonical_wine_id = p_canonical_wine_id;

  if v_n < 3 then
    delete from public.canonical_wine_attributes
      where canonical_wine_id = p_canonical_wine_id and source = 'expert';
    return;
  end if;

  with numerics as (
    select
      avg((body - 1) / 4.0)::real                                as body_n,
      (avg((tannin - 1) / 4.0) filter (where tannin is not null))::real as tannin_n,
      avg((acidity - 1) / 4.0)::real                             as acid_n,
      avg((sweetness - 1) / 4.0)::real                           as sweet_n,
      avg((oak - 1) / 4.0)::real                                 as oak_n,
      (avg(finish) filter (where finish is not null))::real      as finish_avg,
      count(*)::int                                              as n
    from public.wine_ratings_extended
    where canonical_wine_id = p_canonical_wine_id
  ),
  tag_counts as (
    select tag, count(*) as cnt
    from public.wine_ratings_extended,
         lateral unnest(aroma_tags) as tag
    where canonical_wine_id = p_canonical_wine_id
    group by tag
    having count(*) >= 2
  ),
  tag_arr as (
    select coalesce(array_agg(tag order by cnt desc), '{}'::text[]) as tags
    from tag_counts
  )
  insert into public.canonical_wine_attributes (
    canonical_wine_id, body, tannin, acidity, sweetness, oak, intensity,
    finish, aroma_tags, sample_count, source, updated_at
  )
  select
    p_canonical_wine_id,
    coalesce(body_n,    0.5),
    tannin_n,
    coalesce(acid_n,    0.55),
    coalesce(sweet_n,   0.05),
    coalesce(oak_n,     0.3),
    -- intensity not directly captured; approximate from oak + body
    least(1.0, greatest(0.0, ((coalesce(body_n, 0.5) + coalesce(oak_n, 0.3)) / 2 + 0.1)))::real,
    case when finish_avg is null then null
         else round(finish_avg)::smallint end,
    (select tags from tag_arr),
    n, 'expert', now()
  from numerics
  on conflict (canonical_wine_id) do update set
    body         = excluded.body,
    tannin       = excluded.tannin,
    acidity      = excluded.acidity,
    sweetness    = excluded.sweetness,
    oak          = excluded.oak,
    intensity    = excluded.intensity,
    finish       = excluded.finish,
    aroma_tags   = excluded.aroma_tags,
    sample_count = excluded.sample_count,
    source       = excluded.source,
    updated_at   = now();
end;
$$;

create or replace function public.wine_ratings_extended_aggregate_trigger()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  -- Re-aggregate the affected canonical after every change.
  perform public.aggregate_wine_attributes(
    coalesce(NEW.canonical_wine_id, OLD.canonical_wine_id)
  );
  return null;
end;
$$;

drop trigger if exists wine_ratings_extended_aggregate
  on public.wine_ratings_extended;
create trigger wine_ratings_extended_aggregate
  after insert or update or delete on public.wine_ratings_extended
  for each row execute function public.wine_ratings_extended_aggregate_trigger();

-- ── Update get_user_style_dna to prefer wine_attributes ─────────────
-- Falls back to canonical_grape_archetype when no per-wine entry
-- exists yet. Keeps existing rating-weighted aggregation.

create or replace function public.get_user_style_dna(
  p_user_id uuid
)
returns jsonb
language plpgsql
security definer
set search_path = public
stable
as $$
declare
  v_can_view boolean;
  v_result   jsonb;
begin
  v_can_view := (p_user_id = auth.uid()) or exists (
    select 1 from public.friendships
    where user_id = auth.uid() and friend_id = p_user_id
  );
  if not v_can_view then
    return jsonb_build_object(
      'body', null, 'tannin', null, 'acidity', null,
      'sweetness', null, 'oak', null, 'intensity', null,
      'attributed_count', 0, 'confidence', 0
    );
  end if;

  with attributed as (
    -- Prefer per-wine attributes when present, else grape archetype.
    select
      coalesce(cwa.body,      cga.body)      as body,
      coalesce(cwa.tannin,    cga.tannin)    as tannin,
      coalesce(cwa.acidity,   cga.acidity)   as acidity,
      coalesce(cwa.sweetness, cga.sweetness) as sweetness,
      coalesce(cwa.oak,       cga.oak)       as oak,
      coalesce(cwa.intensity, cga.intensity) as intensity,
      (w.rating / 10.0)::numeric             as weight
    from public.wines w
    left join public.canonical_wine_attributes cwa
      on cwa.canonical_wine_id = w.canonical_wine_id
    left join public.canonical_grape_archetype cga
      on cga.canonical_grape_id = w.canonical_grape_id
    where w.user_id = p_user_id
      and (p_user_id = auth.uid() or w.visibility <> 'private')
      and w.rating is not null
      and w.rating > 0
      and (cwa.canonical_wine_id is not null
           or cga.canonical_grape_id is not null)
  ),
  stats as (
    select
      sum(weight)::numeric as total_w,
      sum(body * weight)::numeric / nullif(sum(weight), 0)::numeric as body_w,
      sum(tannin * weight) filter (where tannin is not null)::numeric
        / nullif(sum(weight) filter (where tannin is not null), 0)::numeric as tannin_w,
      sum(acidity * weight)::numeric / nullif(sum(weight), 0)::numeric as acid_w,
      sum(sweetness * weight)::numeric / nullif(sum(weight), 0)::numeric as sweet_w,
      sum(oak * weight)::numeric / nullif(sum(weight), 0)::numeric as oak_w,
      sum(intensity * weight)::numeric / nullif(sum(weight), 0)::numeric as int_w,
      count(*)::int as n
    from attributed
  )
  select jsonb_build_object(
    'body',             round(body_w, 3),
    'tannin',           round(tannin_w, 3),
    'acidity',          round(acid_w, 3),
    'sweetness',        round(sweet_w, 3),
    'oak',              round(oak_w, 3),
    'intensity',        round(int_w, 3),
    'attributed_count', n,
    'confidence',       round(least(1.0, n / 20.0)::numeric, 2)
  )
  into v_result
  from stats;

  return v_result;
end;
$$;

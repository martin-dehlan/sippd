-- Badge audit fixes:
--  1. Old/New-World country lists were incomplete — wines from e.g. Austria,
--     Greece, Canada, Uruguay never counted. Expand both lists (+ ISO codes).
--  2. Grape metrics only counted canonical_grape_id, so free-text grapes were
--     invisible. Count a free-text grape (wines.grape) when no canonical id —
--     key = canonical id, else the normalized free-text name.
--  3. Lower the steepest grape thresholds now that free-text counts.

create or replace function public._badge_metrics(p_user_id uuid)
returns jsonb
language plpgsql
stable security definer
set search_path = public
as $$
declare
  v jsonb;
  v_old_world text[] := array[
    'france','italy','spain','germany','portugal','austria','greece','hungary',
    'switzerland','romania','georgia','croatia','slovenia','czechia',
    'czech republic','bulgaria','moldova','slovakia','north macedonia',
    'fr','it','es','de','pt','at','gr','hu','ch','ro','ge','hr','si','cz','bg',
    'md','sk','mk'];
  v_new_world text[] := array[
    'united states','usa','us','united states of america','australia',
    'new zealand','chile','argentina','south africa','canada','uruguay',
    'brazil','mexico','china','india','japan',
    'au','nz','cl','ar','za','ca','uy','br','mx','cn','in','jp'];
  v_france    text[] := array['france','fr'];
begin
  with
  events as (
    select w.canonical_wine_id, w.rating::numeric as value,
           coalesce(w.updated_at, w.created_at) as occurred_at,
           cw.type, cw.country, cw.region,
           coalesce(cw.canonical_grape_id::text, nullif(lower(trim(w.grape)), ''))
             as grape_key,
           'personal'::text as context
    from public.wines w
    join public.canonical_wine cw on cw.id = w.canonical_wine_id
    where w.user_id = p_user_id and w.canonical_wine_id is not null and w.rating > 0
    union all
    select gwr.canonical_wine_id, gwr.rating::numeric,
           coalesce(gwr.updated_at, gwr.created_at),
           cw.type, cw.country, cw.region, cw.canonical_grape_id::text, 'group'
    from public.group_wine_ratings gwr
    join public.canonical_wine cw on cw.id = gwr.canonical_wine_id
    where gwr.user_id = p_user_id and gwr.rating is not null
    union all
    select tr.canonical_wine_id, tr.rating::numeric, tr.created_at,
           cw.type, cw.country, cw.region, cw.canonical_grape_id::text, 'tasting'
    from public.tasting_ratings tr
    join public.canonical_wine cw on cw.id = tr.canonical_wine_id
    join public.group_tastings gt on gt.id = tr.tasting_id
    where tr.user_id = p_user_id and tr.rating is not null
      and gt.state in ('active','concluded')
  ),
  dedup as (
    select distinct on (canonical_wine_id)
           value, type, country, region, grape_key
    from events
    order by canonical_wine_id, occurred_at desc, context desc
  ),
  orphan as (
    select w.rating::numeric as value, w.type, w.country, w.region,
           coalesce(w.canonical_grape_id::text, nullif(lower(trim(w.grape)), ''))
             as grape_key
    from public.wines w
    where w.user_id = p_user_id and w.canonical_wine_id is null and w.rating > 0
  ),
  u as (
    select value, type, country, region, grape_key from dedup
    union all
    select value, type, country, region, grape_key from orphan
  ),
  agg as (
    select
      count(*)::int                                                    as distinct_wines,
      count(*) filter (where type = 'red')::int                        as red,
      count(*) filter (where type = 'white')::int                      as white,
      count(*) filter (where type = 'rose')::int                       as rose,
      count(*) filter (where type = 'sparkling')::int                  as sparkling,
      count(distinct country) filter (where country is not null)::int  as distinct_countries,
      count(*) filter (where lower(trim(country)) = any(v_old_world))::int as old_world,
      count(*) filter (where lower(trim(country)) = any(v_new_world))::int as new_world,
      count(*) filter (where lower(trim(country)) = any(v_france))::int    as france,
      count(distinct grape_key) filter (where grape_key is not null)::int as distinct_grapes,
      round(avg(value)::numeric, 2)                                    as avg_rating,
      count(value)::int                                                as avg_n
    from u
  ),
  max_region as (
    select coalesce(max(c), 0)::int as v from (
      select count(*) c from u where region is not null group by region
    ) s
  ),
  max_grape as (
    select coalesce(max(c), 0)::int as v from (
      select count(*) c from u where grape_key is not null group by grape_key
    ) s
  ),
  mine_co as (
    select canonical_wine_id from public.group_wine_ratings
      where user_id = p_user_id and canonical_wine_id is not null
    union
    select canonical_wine_id from public.tasting_ratings
      where user_id = p_user_id and canonical_wine_id is not null
  ),
  others_co as (
    select user_id, canonical_wine_id from public.group_wine_ratings
      where user_id <> p_user_id and canonical_wine_id is not null
    union
    select user_id, canonical_wine_id from public.tasting_ratings
      where user_id <> p_user_id and canonical_wine_id is not null
  ),
  max_partner as (
    select coalesce(max(c), 0)::int as v from (
      select o.user_id, count(distinct o.canonical_wine_id) c
      from others_co o join mine_co m on m.canonical_wine_id = o.canonical_wine_id
      group by o.user_id
    ) s
  ),
  social as (
    select
      (select count(*) from public.friendships where user_id = p_user_id)::int as friends,
      (case when exists (select 1 from public.group_members where user_id = p_user_id)
            then 1 else 0 end)                                                  as in_group,
      (case when exists (select 1 from public.group_tastings where created_by = p_user_id)
            then 1 else 0 end)                                                  as hosted,
      (select count(distinct ta.tasting_id)
         from public.tasting_attendees ta
         join public.group_tastings gt on gt.id = ta.tasting_id
        where ta.user_id = p_user_id and ta.status = 'going'
          and gt.state = 'concluded')::int                                     as tastings_attended,
      (select count(*) from public.wines
         where user_id = p_user_id and rating > 0
           and notes is not null and length(trim(notes)) > 0)::int             as notes
  )
  select jsonb_build_object(
    'distinct_wines',     a.distinct_wines,
    'red',                a.red,
    'white',              a.white,
    'rose',               a.rose,
    'sparkling',          a.sparkling,
    'min_type4',          least(a.red, a.white, a.rose, a.sparkling),
    'distinct_countries', a.distinct_countries,
    'old_world',          a.old_world,
    'new_world',          a.new_world,
    'france',             a.france,
    'max_region',         mr.v,
    'distinct_grapes',    a.distinct_grapes,
    'max_grape',          mg.v,
    'max_partner',        mp.v,
    'friends',            s.friends,
    'in_group',           s.in_group,
    'hosted',             s.hosted,
    'tastings_attended',  s.tastings_attended,
    'notes',              s.notes,
    'avg_rating',         coalesce(a.avg_rating, 0),
    'avg_n',              a.avg_n,
    'seasoned_ok',        case when a.avg_n >= 20 and coalesce(a.avg_rating,0) >= 7.5
                               then 1 else 0 end
  ) into v
  from agg a, max_region mr, max_grape mg, max_partner mp, social s;

  return v;
end;
$$;

-- Lower the steepest grape thresholds now that free-text grapes count.
update public.badge_definitions
   set criterion = jsonb_set(criterion, '{gte}', '18')
 where id = 'grape_connoisseur';
update public.badge_definitions
   set criterion = jsonb_set(criterion, '{gte}', '20')
 where id = 'single_variety_devotee';

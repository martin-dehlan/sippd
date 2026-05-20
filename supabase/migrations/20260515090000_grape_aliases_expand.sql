-- Expand canonical_grape.aliases with common German + international
-- synonyms reported in the wild. Dedupe-safe (uses distinct unnest).
-- Note: Tinta de Toro and Ugni Blanc kept as separate canonical entries
-- (distinct archetype profiles from Tempranillo / Trebbiano).

create or replace function pg_temp.add_grape_aliases(p_name text, p_new text[])
returns void
language sql
as $$
  update public.canonical_grape
  set aliases = (
    select coalesce(array_agg(distinct a order by a), array[]::text[])
    from unnest(coalesce(aliases, array[]::text[]) || p_new) a
  )
  where name = p_name;
$$;

select pg_temp.add_grape_aliases('Pinot Noir', array[
  'frühburgunder','fruhburgunder',
  'blauer spätburgunder','blauer spatburgunder'
]);

select pg_temp.add_grape_aliases('Pinot Gris', array[
  'grauer burgunder'
]);

select pg_temp.add_grape_aliases('Pinot Blanc', array[
  'weißer burgunder','weisser burgunder'
]);

select pg_temp.add_grape_aliases('Gewürztraminer', array[
  'roter traminer'
]);

select pg_temp.add_grape_aliases('Zweigelt', array[
  'blauer zweigelt','rotburger'
]);

select pg_temp.add_grape_aliases('Riesling', array[
  'weißer riesling','weisser riesling','white riesling'
]);

select pg_temp.add_grape_aliases('Cabernet Sauvignon', array[
  'cab'
]);

select pg_temp.add_grape_aliases('Tempranillo', array[
  'tinta fina'
]);

select pg_temp.add_grape_aliases('Sangiovese', array[
  'sangiovese grosso','sangioveto'
]);

select pg_temp.add_grape_aliases('Malbec', array[
  'pressac'
]);

select pg_temp.add_grape_aliases('Nebbiolo', array[
  'picoutener'
]);

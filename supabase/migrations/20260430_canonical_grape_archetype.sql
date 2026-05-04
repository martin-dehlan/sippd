-- Style archetype per canonical grape — drives the Style DNA radar
-- and the user wine-personality calculation. Six WSET-aligned axes
-- on 0..1 scales (tannin nullable for whites). Curated seed below
-- reflects typical varietal character; expert ratings will refine
-- per-wine attributes downstream and crowdsource-correct edge cases.

create table if not exists public.canonical_grape_archetype (
  canonical_grape_id   uuid        primary key references public.canonical_grape(id) on delete cascade,
  body                 real        not null check (body between 0 and 1),
  tannin               real        check (tannin is null or tannin between 0 and 1),
  acidity              real        not null check (acidity between 0 and 1),
  sweetness            real        not null check (sweetness between 0 and 1),
  oak                  real        not null check (oak between 0 and 1),
  intensity            real        not null check (intensity between 0 and 1),
  typical_aroma_tags   text[]      not null default '{}',
  source               text        not null default 'curated'
                                   check (source in ('curated','llm','expert_user')),
  filled_at            timestamptz not null default now()
);

alter table public.canonical_grape_archetype enable row level security;

drop policy if exists "archetype_select_all" on public.canonical_grape_archetype;
create policy "archetype_select_all"
  on public.canonical_grape_archetype for select
  to authenticated using (true);

-- Seed. Values reflect typical varietal expression (a Cab from Napa
-- and one from Bordeaux still both have Cabernet's high tannin / full
-- body skeleton; per-wine refinement happens later). Tannin is null
-- for whites since the dimension doesn't apply.

with seed(name, body, tannin, acidity, sweetness, oak, intensity) as (values
  -- International reds
  ('Cabernet Sauvignon', 0.85, 0.85, 0.6,  0.0,  0.7,  0.75),
  ('Merlot',             0.55, 0.45, 0.5,  0.0,  0.5,  0.55),
  ('Pinot Noir',         0.3,  0.3,  0.7,  0.0,  0.4,  0.5),
  ('Syrah',              0.8,  0.7,  0.55, 0.0,  0.6,  0.75),
  ('Malbec',             0.75, 0.65, 0.5,  0.0,  0.55, 0.7),
  ('Cabernet Franc',     0.65, 0.6,  0.6,  0.0,  0.5,  0.6),
  ('Grenache',           0.55, 0.4,  0.45, 0.0,  0.3,  0.6),
  ('Mourvèdre',          0.7,  0.7,  0.55, 0.0,  0.4,  0.65),
  ('Carignan',           0.55, 0.7,  0.65, 0.0,  0.3,  0.6),
  ('Cinsault',           0.4,  0.3,  0.55, 0.0,  0.2,  0.45),
  ('Petit Verdot',       0.85, 0.85, 0.55, 0.0,  0.7,  0.75),
  ('Petite Sirah',       0.9,  0.9,  0.55, 0.0,  0.7,  0.8),
  ('Zinfandel',          0.75, 0.5,  0.5,  0.05, 0.5,  0.75),
  ('Carménère',          0.6,  0.5,  0.5,  0.0,  0.5,  0.6),
  ('Tannat',             0.85, 0.95, 0.55, 0.0,  0.65, 0.75),
  ('Marselan',           0.75, 0.7,  0.55, 0.0,  0.6,  0.7),
  ('Pinot Meunier',      0.4,  0.3,  0.65, 0.0,  0.2,  0.5),
  ('Gamay',              0.3,  0.25, 0.7,  0.0,  0.15, 0.5),
  -- Italy reds
  ('Sangiovese',         0.55, 0.6,  0.7,  0.0,  0.4,  0.6),
  ('Nebbiolo',           0.65, 0.85, 0.8,  0.0,  0.45, 0.7),
  ('Barbera',            0.5,  0.4,  0.85, 0.0,  0.3,  0.55),
  ('Dolcetto',           0.5,  0.55, 0.6,  0.0,  0.2,  0.5),
  ('Aglianico',          0.7,  0.8,  0.7,  0.0,  0.5,  0.7),
  ('Montepulciano',      0.55, 0.55, 0.55, 0.0,  0.3,  0.55),
  ('Corvina',            0.55, 0.5,  0.7,  0.0,  0.4,  0.6),
  ('Rondinella',         0.5,  0.45, 0.65, 0.0,  0.35, 0.5),
  ('Lambrusco',          0.5,  0.4,  0.65, 0.2,  0.1,  0.55),
  ('Negroamaro',         0.65, 0.6,  0.55, 0.0,  0.4,  0.6),
  ('Nero d''Avola',      0.65, 0.55, 0.5,  0.0,  0.4,  0.6),
  ('Sagrantino',         0.85, 0.95, 0.65, 0.0,  0.55, 0.8),
  ('Teroldego',          0.65, 0.65, 0.65, 0.0,  0.45, 0.65),
  ('Lagrein',            0.65, 0.7,  0.6,  0.0,  0.45, 0.65),
  ('Schiava',            0.25, 0.2,  0.65, 0.0,  0.1,  0.4),
  ('Refosco',            0.6,  0.65, 0.7,  0.0,  0.35, 0.6),
  ('Freisa',             0.5,  0.7,  0.7,  0.0,  0.3,  0.55),
  ('Bonarda',            0.55, 0.5,  0.6,  0.0,  0.3,  0.55),
  ('Brachetto',          0.3,  0.2,  0.6,  0.6,  0.0,  0.7),
  ('Frappato',           0.3,  0.3,  0.7,  0.0,  0.1,  0.5),
  -- Spain reds
  ('Tempranillo',        0.6,  0.55, 0.55, 0.0,  0.6,  0.6),
  ('Mencía',             0.55, 0.55, 0.7,  0.0,  0.4,  0.6),
  ('Bobal',              0.6,  0.6,  0.55, 0.0,  0.4,  0.6),
  ('Graciano',           0.7,  0.7,  0.7,  0.0,  0.5,  0.7),
  ('Garnacha Tintorera', 0.7,  0.7,  0.55, 0.0,  0.4,  0.65),
  ('Listán Negro',       0.5,  0.4,  0.65, 0.0,  0.3,  0.55),
  -- Portugal reds
  ('Touriga Nacional',   0.85, 0.85, 0.6,  0.0,  0.55, 0.85),
  ('Touriga Franca',     0.7,  0.7,  0.6,  0.0,  0.45, 0.7),
  ('Tinta Barroca',      0.7,  0.6,  0.55, 0.0,  0.4,  0.65),
  ('Trincadeira',        0.65, 0.6,  0.55, 0.0,  0.4,  0.6),
  ('Castelão',           0.65, 0.55, 0.55, 0.0,  0.4,  0.6),
  ('Baga',               0.6,  0.85, 0.7,  0.0,  0.3,  0.65),
  -- Germany / Austria reds
  ('Dornfelder',         0.6,  0.5,  0.55, 0.05, 0.3,  0.6),
  ('Blaufränkisch',      0.6,  0.6,  0.7,  0.0,  0.4,  0.65),
  ('Zweigelt',           0.5,  0.45, 0.6,  0.0,  0.3,  0.55),
  ('Sankt Laurent',      0.55, 0.5,  0.6,  0.0,  0.35, 0.55),
  ('Portugieser',        0.4,  0.35, 0.55, 0.05, 0.2,  0.45),
  -- Other reds
  ('Pinotage',           0.7,  0.65, 0.55, 0.0,  0.5,  0.7),
  ('Xinomavro',          0.65, 0.85, 0.8,  0.0,  0.45, 0.7),
  ('Agiorgitiko',        0.55, 0.5,  0.55, 0.0,  0.4,  0.55),
  ('Saperavi',           0.7,  0.7,  0.65, 0.0,  0.45, 0.7),
  ('Kadarka',            0.5,  0.4,  0.6,  0.0,  0.3,  0.5),
  ('Tinta de Toro',      0.7,  0.7,  0.55, 0.0,  0.6,  0.7),
  ('Pais',               0.4,  0.4,  0.6,  0.0,  0.1,  0.5),
  ('Concord',            0.5,  0.3,  0.55, 0.15, 0.0,  0.55),
  -- International whites (tannin null)
  ('Chardonnay',         0.65, null, 0.55, 0.0,  0.55, 0.6),
  ('Sauvignon Blanc',    0.4,  null, 0.85, 0.0,  0.15, 0.7),
  ('Riesling',           0.4,  null, 0.85, 0.2,  0.05, 0.85),
  ('Pinot Gris',         0.5,  null, 0.5,  0.1,  0.15, 0.6),
  ('Pinot Blanc',        0.5,  null, 0.6,  0.0,  0.15, 0.5),
  ('Gewürztraminer',     0.55, null, 0.45, 0.2,  0.05, 0.95),
  ('Chenin Blanc',       0.55, null, 0.7,  0.15, 0.3,  0.65),
  ('Sémillon',           0.65, null, 0.5,  0.1,  0.4,  0.6),
  ('Viognier',           0.7,  null, 0.45, 0.05, 0.4,  0.85),
  ('Muscat Blanc',       0.5,  null, 0.55, 0.3,  0.0,  0.9),
  ('Muscat of Alexandria',0.5, null, 0.5,  0.3,  0.0,  0.85),
  ('Muscat Ottonel',     0.45, null, 0.55, 0.25, 0.0,  0.85),
  ('Marsanne',           0.7,  null, 0.4,  0.0,  0.4,  0.6),
  ('Roussanne',          0.65, null, 0.5,  0.0,  0.35, 0.65),
  ('Picpoul',            0.4,  null, 0.85, 0.0,  0.05, 0.5),
  ('Bourboulenc',        0.5,  null, 0.55, 0.0,  0.05, 0.5),
  ('Aligoté',            0.4,  null, 0.8,  0.0,  0.1,  0.45),
  ('Ugni Blanc',         0.35, null, 0.85, 0.0,  0.0,  0.35),
  ('Colombard',          0.4,  null, 0.7,  0.0,  0.0,  0.4),
  ('Folle Blanche',      0.4,  null, 0.85, 0.0,  0.0,  0.45),
  ('Petit Manseng',      0.55, null, 0.85, 0.2,  0.2,  0.85),
  ('Gros Manseng',       0.5,  null, 0.85, 0.05, 0.15, 0.7),
  ('Mauzac',             0.45, null, 0.6,  0.05, 0.05, 0.55),
  -- Italy whites
  ('Garganega',          0.5,  null, 0.65, 0.0,  0.15, 0.55),
  ('Trebbiano',          0.4,  null, 0.7,  0.0,  0.1,  0.4),
  ('Vermentino',         0.45, null, 0.7,  0.0,  0.1,  0.55),
  ('Friulano',           0.5,  null, 0.65, 0.0,  0.15, 0.55),
  ('Cortese',            0.4,  null, 0.7,  0.0,  0.1,  0.5),
  ('Greco',              0.55, null, 0.65, 0.0,  0.15, 0.65),
  ('Falanghina',         0.5,  null, 0.6,  0.0,  0.1,  0.55),
  ('Fiano',              0.55, null, 0.55, 0.0,  0.2,  0.7),
  ('Verdicchio',         0.5,  null, 0.7,  0.0,  0.15, 0.6),
  ('Pecorino',           0.55, null, 0.65, 0.0,  0.1,  0.6),
  ('Grechetto',          0.5,  null, 0.6,  0.0,  0.15, 0.55),
  ('Arneis',             0.55, null, 0.55, 0.0,  0.1,  0.6),
  ('Glera',              0.4,  null, 0.65, 0.15, 0.0,  0.55),
  ('Ribolla Gialla',     0.5,  null, 0.7,  0.0,  0.2,  0.55),
  ('Malvasia',           0.5,  null, 0.55, 0.1,  0.1,  0.7),
  -- Spain / Portugal whites
  ('Albariño',           0.45, null, 0.8,  0.0,  0.1,  0.6),
  ('Verdejo',            0.45, null, 0.75, 0.0,  0.1,  0.55),
  ('Godello',            0.5,  null, 0.7,  0.0,  0.2,  0.6),
  ('Loureiro',           0.4,  null, 0.85, 0.0,  0.05, 0.55),
  ('Treixadura',         0.5,  null, 0.7,  0.0,  0.15, 0.6),
  ('Macabeo',            0.4,  null, 0.55, 0.0,  0.15, 0.45),
  ('Xarel·lo',           0.5,  null, 0.65, 0.0,  0.1,  0.55),
  ('Parellada',          0.4,  null, 0.6,  0.0,  0.05, 0.4),
  ('Pedro Ximénez',      0.85, null, 0.4,  0.95, 0.55, 0.95),
  ('Palomino',           0.45, null, 0.55, 0.0,  0.55, 0.45),
  ('Encruzado',          0.5,  null, 0.65, 0.0,  0.25, 0.55),
  ('Antão Vaz',          0.55, null, 0.55, 0.0,  0.2,  0.6),
  ('Arinto',             0.45, null, 0.85, 0.0,  0.1,  0.55),
  ('Fernão Pires',       0.5,  null, 0.6,  0.0,  0.1,  0.65),
  ('Bical',              0.45, null, 0.7,  0.0,  0.15, 0.55),
  ('Verdelho',           0.55, null, 0.6,  0.05, 0.2,  0.6),
  ('Sercial',            0.5,  null, 0.85, 0.0,  0.4,  0.6),
  -- Germany / Austria whites
  ('Müller-Thurgau',     0.4,  null, 0.5,  0.1,  0.05, 0.5),
  ('Silvaner',           0.5,  null, 0.6,  0.0,  0.15, 0.5),
  ('Scheurebe',          0.5,  null, 0.7,  0.15, 0.0,  0.85),
  ('Bacchus',            0.4,  null, 0.55, 0.05, 0.0,  0.7),
  ('Kerner',             0.45, null, 0.7,  0.1,  0.0,  0.65),
  ('Elbling',            0.35, null, 0.85, 0.0,  0.0,  0.4),
  ('Ortega',             0.45, null, 0.4,  0.15, 0.0,  0.65),
  ('Huxelrebe',          0.45, null, 0.55, 0.2,  0.0,  0.7),
  ('Faberrebe',          0.4,  null, 0.55, 0.1,  0.0,  0.55),
  ('Grüner Veltliner',   0.5,  null, 0.7,  0.0,  0.1,  0.65),
  ('Roter Veltliner',    0.5,  null, 0.6,  0.0,  0.1,  0.55),
  ('Welschriesling',     0.4,  null, 0.65, 0.05, 0.0,  0.5),
  ('Neuburger',          0.5,  null, 0.55, 0.0,  0.1,  0.5),
  -- Eastern Europe / Greece whites
  ('Furmint',            0.55, null, 0.85, 0.1,  0.2,  0.7),
  ('Hárslevelű',         0.5,  null, 0.7,  0.15, 0.15, 0.7),
  ('Irsai Olivér',       0.4,  null, 0.55, 0.05, 0.0,  0.7),
  ('Assyrtiko',          0.55, null, 0.85, 0.0,  0.15, 0.7),
  ('Moschofilero',       0.45, null, 0.7,  0.0,  0.05, 0.65),
  ('Roditis',            0.45, null, 0.6,  0.0,  0.05, 0.5),
  ('Robola',             0.5,  null, 0.7,  0.0,  0.1,  0.55),
  ('Vidiano',            0.55, null, 0.6,  0.0,  0.15, 0.6),
  ('Savatiano',          0.4,  null, 0.55, 0.0,  0.05, 0.45),
  ('Rkatsiteli',         0.5,  null, 0.7,  0.0,  0.1,  0.5),
  -- N. America hybrids
  ('Vidal Blanc',        0.5,  null, 0.7,  0.2,  0.05, 0.7),
  ('Seyval Blanc',       0.45, null, 0.7,  0.0,  0.1,  0.5),
  -- Sparkling blend slot
  ('Champagne Blend',    0.45, null, 0.85, 0.05, 0.1,  0.65)
)
insert into public.canonical_grape_archetype (
  canonical_grape_id, body, tannin, acidity, sweetness, oak, intensity
)
select cg.id, s.body, s.tannin, s.acidity, s.sweetness, s.oak, s.intensity
from seed s
join public.canonical_grape cg on cg.name = s.name
on conflict (canonical_grape_id) do update set
  body       = excluded.body,
  tannin     = excluded.tannin,
  acidity    = excluded.acidity,
  sweetness  = excluded.sweetness,
  oak        = excluded.oak,
  intensity  = excluded.intensity,
  source     = 'curated',
  filled_at  = now();

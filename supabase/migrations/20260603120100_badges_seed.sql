-- ============================================================================
-- Badge catalog seed — 25 definitions
-- ============================================================================
-- Milestone "B2 · Badge Catalog". Issue #144.
-- criterion = { "metric": <_badge_metrics key>, "gte": <threshold> }.
-- Idempotent: re-running updates copy/criterion in place.
-- ============================================================================

insert into public.badge_definitions
  (id, category, tier, title, description, icon, criterion, sort_order)
values
  -- Volume (distinct rated wines)
  ('first_sip',          'volume', 1, 'First Sip',            'Rate your first wine',                      'first_sip',          '{"metric":"distinct_wines","gte":1}',   10),
  ('getting_started',    'volume', 2, 'Getting Started',      'Rate 10 wines',                             'getting_started',    '{"metric":"distinct_wines","gte":10}',  20),
  ('wine_explorer',      'volume', 3, 'Wine Explorer',        'Rate 50 wines',                             'wine_explorer',      '{"metric":"distinct_wines","gte":50}',  30),
  ('cellar_master',      'volume', 4, 'Cellar Master',        'Rate 100 wines',                            'cellar_master',      '{"metric":"distinct_wines","gte":100}', 40),
  ('connoisseur',        'volume', 5, 'Connoisseur',          'Rate 250 wines',                            'connoisseur',        '{"metric":"distinct_wines","gte":250}', 50),

  -- Type
  ('red_devotee',        'type',   1, 'Red Devotee',          'Rate 50 red wines',                         'red_devotee',        '{"metric":"red","gte":50}',             60),
  ('white_wine_lover',   'type',   1, 'White Wine Lover',     'Rate 50 white wines',                       'white_wine_lover',   '{"metric":"white","gte":50}',           70),
  ('bubbly_enthusiast',  'type',   1, 'Bubbly Enthusiast',    'Rate 15 sparkling wines',                   'bubbly_enthusiast',  '{"metric":"sparkling","gte":15}',       80),
  ('rose_all_day',       'type',   1, 'Rosé All Day',         'Rate 15 rosé wines',                        'rose_all_day',       '{"metric":"rose","gte":15}',            90),
  ('balanced_palate',    'type',   2, 'Balanced Palate',      'Rate 10+ of each type: red, white, rosé, sparkling', 'balanced_palate', '{"metric":"min_type4","gte":10}', 100),

  -- Geography
  ('globetrotter',       'geo',    2, 'Globetrotter',         'Rate wines from 10 different countries',    'globetrotter',       '{"metric":"distinct_countries","gte":10}', 110),
  ('old_world_scholar',  'geo',    2, 'Old World Scholar',    'Rate 25 wines from France, Italy, Spain, Germany or Portugal', 'old_world_scholar', '{"metric":"old_world","gte":25}', 120),
  ('new_world_pioneer',  'geo',    2, 'New World Pioneer',    'Rate 25 wines from the US, Australia, NZ, Chile, Argentina or South Africa', 'new_world_pioneer', '{"metric":"new_world","gte":25}', 130),
  ('regional_specialist','geo',    3, 'Regional Specialist',  'Rate 15 wines from a single region',        'regional_specialist','{"metric":"max_region","gte":15}',      140),
  ('france_aficionado',  'geo',    2, 'France Aficionado',    'Rate 25 French wines',                      'france_aficionado',  '{"metric":"france","gte":25}',          150),

  -- Grape
  ('grape_curious',      'grape',  1, 'Grape Curious',        'Rate 10 different grape varieties',         'grape_curious',      '{"metric":"distinct_grapes","gte":10}', 160),
  ('grape_connoisseur',  'grape',  3, 'Grape Connoisseur',    'Rate 30 different grape varieties',         'grape_connoisseur',  '{"metric":"distinct_grapes","gte":30}', 170),
  ('single_variety_devotee','grape',2,'Single-Variety Devotee','Rate 25 wines of one grape variety',       'single_variety_devotee','{"metric":"max_grape","gte":25}',    180),

  -- Social
  ('joiner',             'social', 1, 'Joiner',               'Join your first group',                     'joiner',             '{"metric":"in_group","gte":1}',         190),
  ('tasting_regular',    'social', 2, 'Tasting Regular',      'Attend 5 concluded tastings',               'tasting_regular',    '{"metric":"tastings_attended","gte":5}',200),
  ('host',               'social', 2, 'The Host',             'Host a tasting',                            'host',               '{"metric":"hosted","gte":1}',           210),
  ('social_sipper',      'social', 1, 'Social Sipper',        'Have 5 friends',                            'social_sipper',      '{"metric":"friends","gte":5}',          220),
  ('drinking_buddies',   'social', 2, 'Drinking Buddies',     'Share 10 wines with one tasting partner',   'drinking_buddies',   '{"metric":"max_partner","gte":10}',     230),

  -- Engagement / quality
  ('the_critic',         'engagement', 2, 'The Critic',       'Rate 25 wines with tasting notes',          'the_critic',         '{"metric":"notes","gte":25}',           240),
  ('seasoned_taster',    'engagement', 3, 'Seasoned Taster',  'Keep a 7.5+ average across 20+ wines',      'seasoned_taster',    '{"metric":"seasoned_ok","gte":1}',      250)
on conflict (id) do update set
  category    = excluded.category,
  tier        = excluded.tier,
  title       = excluded.title,
  description = excluded.description,
  icon        = excluded.icon,
  criterion   = excluded.criterion,
  sort_order  = excluded.sort_order,
  is_active   = true;

-- Defense-in-depth: cap user-entered text columns server-side so the
-- DB rejects bypass attempts (direct REST/SQL) that skip UI maxLength.
-- Limits chosen to match UI caps in the same PR.

alter table public.wines
  add constraint wines_winery_length
    check (winery is null or char_length(winery) <= 100),
  add constraint wines_region_length
    check (region is null or char_length(region) <= 80),
  add constraint wines_country_length
    check (country is null or char_length(country) <= 80),
  add constraint wines_location_length
    check (location is null or char_length(location) <= 120),
  add constraint wines_grape_length
    check (grape is null or char_length(grape) <= 60),
  add constraint wines_grape_freetext_length
    check (grape_freetext is null or char_length(grape_freetext) <= 60),
  add constraint wines_notes_length
    check (notes is null or char_length(notes) <= 2000);

alter table public.group_wine_ratings
  add constraint group_wine_ratings_notes_length
    check (notes is null or char_length(notes) <= 2000);

alter table public.tasting_ratings
  add constraint tasting_ratings_notes_length
    check (notes is null or char_length(notes) <= 2000);

alter table public.group_tastings
  add constraint group_tastings_title_length
    check (char_length(title) between 1 and 80),
  add constraint group_tastings_description_length
    check (description is null or char_length(description) <= 1000),
  add constraint group_tastings_location_length
    check (location is null or char_length(location) <= 120);

alter table public.wine_memories
  add constraint wine_memories_caption_length
    check (caption is null or char_length(caption) <= 1000);

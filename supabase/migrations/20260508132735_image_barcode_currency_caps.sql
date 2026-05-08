-- Closes the remaining gaps from the 2026-05-08 input-cap audit. Image
-- URL columns and barcode/currency had no CHECK constraints, so direct
-- REST PATCH could overwrite them with arbitrary-length payloads even
-- though the UI flows always populate them via Supabase Storage URLs
-- and validated barcode scanner output.
--
-- Image URL: 500 chars is generous (Storage URLs are ~150).
-- Barcode:   14 covers EAN-13 / UPC-A / ITF-14 — the longest standard.
-- Currency:  ISO 4217 = three uppercase letters.

alter table public.wines
  add constraint wines_image_url_length
    check (image_url is null or char_length(image_url) <= 500),
  add constraint wines_label_image_url_length
    check (label_image_url is null or char_length(label_image_url) <= 500),
  add constraint wines_local_image_path_length
    check (local_image_path is null or char_length(local_image_path) <= 500),
  add constraint wines_barcode_length
    check (barcode is null or char_length(barcode) <= 14),
  add constraint wines_currency_format
    check (currency is null or currency ~ '^[A-Z]{3}$');

alter table public.wine_memories
  add constraint wine_memories_image_url_length
    check (image_url is null or char_length(image_url) <= 500),
  add constraint wine_memories_local_image_path_length
    check (local_image_path is null or char_length(local_image_path) <= 500);

alter table public.groups
  add constraint groups_image_url_length
    check (image_url is null or char_length(image_url) <= 500);

-- Defense-in-depth on the shared marketing-assets bucket. The marketing
-- automation pipeline (sippd-marketing repo) uploads JPEG/PNG hero
-- images, markdown briefs, and mp4 reels — all server-side via
-- service-role today, so default-deny RLS already blocks authed/anon
-- writes. These limits cap blast radius if a service-role token ever
-- leaks or an edge function forgets to validate input.
--
-- 50 MB covers the longest reel the publisher is expected to produce
-- (current largest object: ~9 MB). MIME allow-list mirrors the file
-- types already in the bucket plus webp/svg/text-plain headroom.

update storage.buckets
   set file_size_limit = 52428800,
       allowed_mime_types = array[
         'image/jpeg',
         'image/png',
         'image/webp',
         'image/svg+xml',
         'text/markdown',
         'text/plain',
         'video/mp4'
       ]
 where id = 'marketing-assets';

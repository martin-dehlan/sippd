-- PostgREST's exposed-schemas list (Dashboard → API Settings) references
-- `marketing` so the sippd-marketing repo can hit its own tables without
-- crossing the public boundary. The schema itself lives in that repo's
-- migrations, but if a baseline rebuild lands here before sippd-marketing
-- has provisioned anything, PostgREST's schema-cache reload fails with
-- `schema "marketing" does not exist` and returns 503/PGRST002 to every
-- REST request — taking the live app down. Owning an empty schema here
-- is the belt-and-braces fix: harmless if marketing later adds tables,
-- prevents the outage if it doesn't.
create schema if not exists marketing;

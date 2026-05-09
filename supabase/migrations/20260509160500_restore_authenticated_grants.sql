-- The 2026-05-08 security baseline squash revoked privileges from the
-- public role but only re-granted SELECT to authenticated for `ratings`.
-- Every other public table ended up with NULL relacl, which means the
-- `authenticated` role hits PostgreSQL's table-level GRANT check (42501,
-- "permission denied") *before* RLS ever runs. Drift-backed flows hid
-- this because local data served the UI; network-only flows (groups,
-- friend search) exposed it as a raw PostgrestException.
--
-- RLS still gates which rows each user can see. GRANT just opens the
-- door so RLS can do its job.

grant select, insert, update, delete on
  public.canonical_grape,
  public.canonical_grape_archetype,
  public.canonical_wine,
  public.canonical_wine_attributes,
  public.canonical_wine_match_decisions,
  public.friend_requests,
  public.friendships,
  public.group_invitations,
  public.group_members,
  public.group_tastings,
  public.group_wine_ratings,
  public.group_wines,
  public.groups,
  public.join_attempts,
  public.profiles,
  public.tasting_attendees,
  public.tasting_ratings,
  public.tasting_wines,
  public.user_devices,
  public.user_notification_prefs,
  public.wine_memories,
  public.wine_ratings_extended,
  public.wines
to authenticated;

-- Future tables created in this schema also get authenticated grants
-- automatically, so the next migration won't have to remember.
alter default privileges in schema public
  grant select, insert, update, delete on tables to authenticated;

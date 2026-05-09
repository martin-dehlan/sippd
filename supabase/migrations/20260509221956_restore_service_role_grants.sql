-- service_role needs the same DML grants on user-data tables that
-- authenticated has — Edge Functions (push, etc.) refetch rows via the
-- service-role client, and PostgreSQL still requires a table-level GRANT
-- before service_role's RLS bypass kicks in. The 2026-05-08 baseline
-- squash stripped these alongside the authenticated grants.

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
to service_role;

alter default privileges in schema public
  grant select, insert, update, delete on tables to service_role;

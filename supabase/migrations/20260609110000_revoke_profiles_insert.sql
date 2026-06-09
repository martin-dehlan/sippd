-- SECURITY FIX (pre-prod audit).
--
-- 20260607160000_harden_profiles_is_pro revoked UPDATE on profiles (so a user
-- can't flip their own is_pro) but left INSERT granted. A user whose profile
-- row doesn't exist yet — a failed/missing handle_new_user, or a deleted
-- profile — could then INSERT their own profiles row with is_pro = true and
-- self-grant Pro for free.
--
-- The profile row is created by the handle_new_user trigger (SECURITY
-- DEFINER) on signup; the client only ever UPDATEs its profile, never
-- INSERTs. So revoke INSERT on profiles from end-user roles entirely — is_pro
-- stays writable only by the service role (the RevenueCat webhook).

revoke insert on public.profiles from authenticated, anon;

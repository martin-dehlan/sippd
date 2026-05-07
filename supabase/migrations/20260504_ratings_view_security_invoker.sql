-- Fix Supabase lint "Security Definer View" on public.ratings.
--
-- PG 15+ views default to security_invoker = false, meaning they run with
-- the view-owner's privileges and bypass the querying user's RLS. Flipping
-- to security_invoker makes the view honor the caller's RLS policies on
-- the base tables (wines, group_wine_ratings, tasting_ratings).
--
-- All three base tables already have correct SELECT policies tied to
-- auth.uid() (own rows, friends, group membership), so this change is
-- purely a security tightening — no behavioral change for legitimate
-- callers.

alter view public.ratings set (security_invoker = true);

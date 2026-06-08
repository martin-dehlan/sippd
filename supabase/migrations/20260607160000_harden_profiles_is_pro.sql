-- SECURITY FIX (audit #191, CRITICAL).
--
-- The `profiles_update_self` RLS policy has no column restriction and
-- `authenticated` held a column-level UPDATE grant on `is_pro`, so any
-- signed-in user could PATCH their own row `{"is_pro": true}` via PostgREST
-- and self-grant Pro (50 scans/day + every paywalled feature). That defeats
-- the whole point of server-verified Pro.
--
-- Fix: make `is_pro` writable ONLY by the service role (the RevenueCat
-- webhook). Revoke the blanket UPDATE and re-grant every OTHER profile
-- column to authenticated; the per-row RLS policy still applies.

revoke update on public.profiles from authenticated, anon;

grant update (
  username,
  display_name,
  avatar_url,
  onboarding_completed,
  taste_level,
  goals,
  styles,
  drink_frequency,
  taste_emoji,
  updated_at
) on public.profiles to authenticated;

-- Defense-in-depth: scan_usage is written only through the SECURITY DEFINER
-- quota RPC. RLS already denies direct writes, but drop the unused grants
-- so a future policy change can't accidentally expose quota tampering.
revoke insert, update, delete, truncate
  on public.scan_usage from authenticated, anon;

// RevenueCat webhook → mirror Pro entitlement into profiles.is_pro.
//
// RevenueCat calls this on subscription lifecycle events. We verify the
// shared Authorization header (set identically here and in the RevenueCat
// dashboard), then flip profiles.is_pro for the event's app_user_id, which
// the app sets to the Supabase auth user id. Written with the service-role
// key so it bypasses RLS — the client can never set its own Pro status.
//
// Deploy WITHOUT JWT verification (RevenueCat can't send a Supabase JWT):
//   supabase functions deploy revenuecat-webhook --no-verify-jwt --project-ref <ref>
//
// Required secrets:
//   SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY  (auto-provisioned)
//   REVENUECAT_WEBHOOK_AUTH  — the shared Authorization header value.

import { createClient } from 'npm:@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SERVICE_ROLE = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const WEBHOOK_AUTH = Deno.env.get('REVENUECAT_WEBHOOK_AUTH');

// Events that mean the entitlement is now active vs. gone. CANCELLATION /
// BILLING_ISSUE keep Pro until the subscription actually EXPIRES.
const GRANT = new Set([
  'INITIAL_PURCHASE',
  'RENEWAL',
  'PRODUCT_CHANGE',
  'UNCANCELLATION',
  'NON_RENEWING_PURCHASE',
  'SUBSCRIPTION_EXTENDED',
]);
const REVOKE = new Set(['EXPIRATION']);

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return new Response('method_not_allowed', { status: 405 });
  }
  // Auth: RevenueCat sends the exact Authorization header we configured.
  if (!WEBHOOK_AUTH || req.headers.get('Authorization') !== WEBHOOK_AUTH) {
    return new Response('unauthorized', { status: 401 });
  }

  let payload: any;
  try {
    payload = await req.json();
  } catch {
    return new Response('bad_request', { status: 400 });
  }

  const event = payload?.event ?? {};
  const type = event.type as string | undefined;
  const appUserId = event.app_user_id as string | undefined;

  // Always 200 for events we don't act on, so RevenueCat doesn't retry.
  if (!type || !appUserId) return new Response('ignored', { status: 200 });
  let isPro: boolean | null = null;
  if (GRANT.has(type)) isPro = true;
  else if (REVOKE.has(type)) isPro = false;
  if (isPro === null) return new Response('ignored', { status: 200 });

  // app_user_id is the Supabase auth uid for signed-in purchasers; an
  // anonymous RevenueCat id simply matches no profile row (no-op).
  const supabase = createClient(SUPABASE_URL, SERVICE_ROLE);
  const { error } = await supabase
    .from('profiles')
    .update({ is_pro: isPro })
    .eq('id', appUserId);

  if (error) {
    console.log('[revenuecat-webhook] update failed:', error.message);
    return new Response('db_error', { status: 500 });
  }
  return new Response('ok', { status: 200 });
});

// deno-lint-ignore-file no-explicit-any
//
// Deployed to: https://ungvhpffjhnojessifri.supabase.co/functions/v1/tasting-reminders
// Invoked by pg_cron every minute (see migration 20260428_tasting_reminder_cron.sql).
//
// Per-attendee reminders: every user with status='going' on a tasting receives
// a push at (scheduled_at - their own pref hours), respecting their personal
// user_notification_prefs.tasting_reminders flag. The Postgres
// claim_due_tasting_reminders() function holds a FOR UPDATE SKIP LOCKED claim
// while stamping reminder_sent_at, so two cron ticks cannot double-send. We
// revert the stamp for any (tasting_id, user_id) whose FCM transport failed
// so the next tick retries.
//
// Required env (Supabase Edge Function secrets):
//   FIREBASE_SERVICE_ACCOUNT — full service-account JSON as string
//   PUSH_WEBHOOK_SECRET      — shared secret with the cron job
//   FCM_PROJECT_ID           — optional, defaults to sippd-6e06e

import { createClient } from 'npm:@supabase/supabase-js@2';
import { JWT } from 'npm:google-auth-library@9';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const FCM_PROJECT_ID = Deno.env.get('FCM_PROJECT_ID') ?? 'sippd-6e06e';
const WEBHOOK_SECRET = Deno.env.get('PUSH_WEBHOOK_SECRET');
const FIREBASE_SERVICE_ACCOUNT = Deno.env.get('FIREBASE_SERVICE_ACCOUNT');

if (!WEBHOOK_SECRET) {
  throw new Error('PUSH_WEBHOOK_SECRET env var is required');
}

const BRAND_COLOR = '#8B1E3F';

let cachedJwtClient: JWT | null = null;
function getJwtClient(): JWT {
  if (cachedJwtClient) return cachedJwtClient;
  if (!FIREBASE_SERVICE_ACCOUNT) {
    throw new Error('FIREBASE_SERVICE_ACCOUNT env var is missing');
  }
  const sa = JSON.parse(FIREBASE_SERVICE_ACCOUNT);
  cachedJwtClient = new JWT({
    email: sa.client_email,
    key: sa.private_key,
    scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
  });
  return cachedJwtClient;
}

interface DueReminder {
  tasting_id: string;
  user_id: string;
  tasting_title: string;
  group_id: string;
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return new Response('method not allowed', { status: 405 });
  }
  const got = req.headers.get('x-webhook-secret');
  if (got !== WEBHOOK_SECRET) {
    return new Response('unauthorized', { status: 401 });
  }

  const admin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY);

  // Atomic claim — stamps reminder_sent_at for every due (attendee, tasting)
  // pair and returns the rows we need to deliver. Revert pending below.
  const { data: claimed, error: claimErr } = await admin.rpc(
    'claim_due_tasting_reminders',
  );
  if (claimErr) {
    console.error('claim_due_tasting_reminders failed', claimErr);
    return new Response(`db error: ${claimErr.message}`, { status: 500 });
  }
  const due = (claimed ?? []) as DueReminder[];
  if (due.length === 0) {
    return new Response(JSON.stringify({ due: 0 }), {
      status: 200,
      headers: { 'content-type': 'application/json' },
    });
  }

  // Fetch every recipient's device tokens in a single round-trip.
  const recipientIds = [...new Set(due.map((d) => d.user_id))];
  const { data: deviceRows } = await admin
    .from('user_devices')
    .select('user_id, token')
    .in('user_id', recipientIds);
  const tokensByUser = new Map<string, string[]>();
  for (const d of deviceRows ?? []) {
    const arr = tokensByUser.get(d.user_id as string) ?? [];
    arr.push(d.token as string);
    tokensByUser.set(d.user_id as string, arr);
  }

  let accessToken: string | null | undefined;
  try {
    const r = await getJwtClient().getAccessToken();
    accessToken = r.token;
  } catch (e) {
    console.error('OAuth error', e);
    // The claim has already stamped — revert all so the next tick retries.
    await revertStamps(admin, due);
    return new Response(`oauth error: ${e}`, { status: 500 });
  }
  if (!accessToken) {
    await revertStamps(admin, due);
    return new Response('no access token', { status: 500 });
  }

  const fcmUrl = `https://fcm.googleapis.com/v1/projects/${FCM_PROJECT_ID}/messages:send`;
  let sent = 0;
  let failed = 0;
  const invalidTokens: string[] = [];
  // Reminders that failed transport entirely (no token delivered) — revert
  // their stamp so the next cron tick retries.
  const toRevert: DueReminder[] = [];

  for (const reminder of due) {
    const tokens = tokensByUser.get(reminder.user_id) ?? [];
    if (tokens.length === 0) {
      // No device registered. Stamp stays so we don't keep checking — when
      // the user installs the app and registers a device, the reminder is
      // simply lost. Acceptable: alternative is to keep retrying forever.
      continue;
    }

    let anySent = false;
    await Promise.all(
      tokens.map(async (token) => {
        const body = {
          message: {
            token,
            notification: {
              title: 'Tasting reminder',
              body: reminder.tasting_title,
            },
            data: {
              type: 'tasting_reminder',
              tasting_id: reminder.tasting_id,
            },
            android: {
              priority: 'HIGH',
              notification: {
                icon: 'ic_notification',
                color: BRAND_COLOR,
                notification_priority: 'PRIORITY_MAX',
                default_sound: true,
                default_vibrate_timings: true,
                tag: `tasting_reminder:${reminder.tasting_id}`,
              },
            },
            apns: {
              headers: { 'apns-priority': '10' },
              payload: {
                aps: {
                  sound: 'default',
                  'mutable-content': 1,
                  'thread-id': `group:${reminder.group_id}`,
                },
              },
            },
          },
        };
        const res = await fetch(fcmUrl, {
          method: 'POST',
          headers: {
            Authorization: `Bearer ${accessToken}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(body),
        });
        if (res.ok) {
          anySent = true;
          sent++;
        } else {
          failed++;
          const txt = await res.text();
          console.error(
            `FCM error ${res.status} for ${token.slice(0, 20)}: ${txt.slice(0, 200)}`,
          );
          if (res.status === 404 || res.status === 400) {
            invalidTokens.push(token);
          }
        }
      }),
    );

    if (!anySent) {
      // Every token for this recipient failed — revert so next tick retries.
      toRevert.push(reminder);
    }
  }

  if (invalidTokens.length > 0) {
    await admin.from('user_devices').delete().in('token', invalidTokens);
  }
  if (toRevert.length > 0) {
    await revertStamps(admin, toRevert);
  }

  return new Response(
    JSON.stringify({
      due: due.length,
      sent,
      failed,
      reverted: toRevert.length,
      invalid_tokens_removed: invalidTokens.length,
    }),
    { status: 200, headers: { 'content-type': 'application/json' } },
  );
});

async function revertStamps(
  admin: ReturnType<typeof createClient>,
  rows: DueReminder[],
): Promise<void> {
  // The composite key (tasting_id, user_id) doesn't compose into a single
  // .in() filter; do per-row updates. Volume is small (size of `due`).
  await Promise.all(
    rows.map((r) =>
      admin
        .from('tasting_attendees')
        .update({ reminder_sent_at: null })
        .eq('tasting_id', r.tasting_id)
        .eq('user_id', r.user_id),
    ),
  );
}

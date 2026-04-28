// deno-lint-ignore-file no-explicit-any
//
// Deployed to: https://ungvhpffjhnojessifri.supabase.co/functions/v1/tasting-reminders
// Invoked by pg_cron every minute (see migration 20260428_tasting_reminder_cron.sql).
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
  id: string;
  title: string;
  recipientId: string;
  groupId: string;
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
  const now = new Date();

  // Pull every unsent reminder that hasn't already passed scheduled_at.
  // Partial index group_tastings_reminder_pending_idx keeps this cheap
  // even at scale.
  const { data: tastings, error: tastingsErr } = await admin
    .from('group_tastings')
    .select('id, title, scheduled_at, created_by, group_id')
    .gt('scheduled_at', now.toISOString())
    .is('reminder_sent_at', null);
  if (tastingsErr) {
    console.error('group_tastings query failed', tastingsErr);
    return new Response(`db error: ${tastingsErr.message}`, { status: 500 });
  }
  if (!tastings || tastings.length === 0) {
    return new Response(JSON.stringify({ checked: 0 }), {
      status: 200,
      headers: { 'content-type': 'application/json' },
    });
  }

  const userIds = [
    ...new Set(tastings.map((t: any) => t.created_by as string)),
  ];
  const { data: prefRows } = await admin
    .from('user_notification_prefs')
    .select('user_id, tasting_reminders, tasting_reminder_hours')
    .in('user_id', userIds);
  const prefsByUser = new Map<
    string,
    { tasting_reminders: boolean; tasting_reminder_hours: number }
  >();
  for (const p of prefRows ?? []) {
    prefsByUser.set(p.user_id as string, {
      tasting_reminders: p.tasting_reminders as boolean,
      tasting_reminder_hours: p.tasting_reminder_hours as number,
    });
  }

  const due: DueReminder[] = [];
  for (const t of tastings as any[]) {
    const pref = prefsByUser.get(t.created_by);
    if (!pref?.tasting_reminders) continue;
    const offsetMs = pref.tasting_reminder_hours * 60 * 60 * 1000;
    const reminderAtMs = new Date(t.scheduled_at).getTime() - offsetMs;
    if (reminderAtMs <= now.getTime()) {
      due.push({
        id: t.id as string,
        title: t.title as string,
        recipientId: t.created_by as string,
        groupId: t.group_id as string,
      });
    }
  }

  if (due.length === 0) {
    return new Response(
      JSON.stringify({ checked: tastings.length, due: 0 }),
      {
        status: 200,
        headers: { 'content-type': 'application/json' },
      },
    );
  }

  const recipientIds = [...new Set(due.map((d) => d.recipientId))];
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
    return new Response(`oauth error: ${e}`, { status: 500 });
  }
  if (!accessToken) {
    return new Response('no access token', { status: 500 });
  }

  const fcmUrl = `https://fcm.googleapis.com/v1/projects/${FCM_PROJECT_ID}/messages:send`;
  let sent = 0;
  let failed = 0;
  const invalidTokens: string[] = [];
  const stampedIds: string[] = [];

  for (const reminder of due) {
    const tokens = tokensByUser.get(reminder.recipientId) ?? [];
    if (tokens.length === 0) {
      // Recipient has no devices registered — nothing to deliver. Stamp the
      // tasting so we don't re-check it on every cron tick.
      stampedIds.push(reminder.id);
      continue;
    }

    let anySent = false;
    await Promise.all(
      tokens.map(async (token) => {
        const body = {
          message: {
            token,
            notification: { title: 'Tasting reminder', body: reminder.title },
            data: {
              type: 'tasting_reminder',
              tasting_id: reminder.id,
            },
            android: {
              priority: 'HIGH',
              notification: {
                icon: 'ic_notification',
                color: BRAND_COLOR,
                notification_priority: 'PRIORITY_MAX',
                default_sound: true,
                default_vibrate_timings: true,
                tag: `tasting_reminder:${reminder.id}`,
              },
            },
            apns: {
              headers: { 'apns-priority': '10' },
              payload: {
                aps: {
                  sound: 'default',
                  'mutable-content': 1,
                  'thread-id': `group:${reminder.groupId}`,
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

    if (anySent) {
      stampedIds.push(reminder.id);
    }
  }

  if (invalidTokens.length > 0) {
    await admin.from('user_devices').delete().in('token', invalidTokens);
  }
  if (stampedIds.length > 0) {
    await admin
      .from('group_tastings')
      .update({ reminder_sent_at: now.toISOString() })
      .in('id', stampedIds);
  }

  return new Response(
    JSON.stringify({
      checked: tastings.length,
      due: due.length,
      sent,
      failed,
      invalid_tokens_removed: invalidTokens.length,
      stamped: stampedIds.length,
    }),
    { status: 200, headers: { 'content-type': 'application/json' } },
  );
});

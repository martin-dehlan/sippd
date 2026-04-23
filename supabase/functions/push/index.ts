// deno-lint-ignore-file no-explicit-any
//
// Deployed to: https://ungvhpffjhnojessifri.supabase.co/functions/v1/push
// Called by Postgres triggers on friend_requests, group_tastings, group_members, group_invitations.
// Required env (Supabase Edge Function secrets):
//   FIREBASE_SERVICE_ACCOUNT — full service-account JSON as string
//   PUSH_WEBHOOK_SECRET      — shared secret; must match vault secret
//                              'push_webhook_secret' read by notify_push trigger
//   FCM_PROJECT_ID           — optional, defaults to sippd-6e06e

import { createClient } from 'npm:@supabase/supabase-js@2';
import { JWT } from 'npm:google-auth-library@9';

interface WebhookPayload {
  type: 'INSERT' | 'UPDATE' | 'DELETE';
  table: string;
  record: Record<string, any>;
  old_record?: Record<string, any>;
}

interface PushMessage {
  recipients: string[];
  title: string;
  body: string;
  data?: Record<string, string>;
  /** Android notification tag. Same tag replaces an older notification
   *  instead of stacking — prevents spam on re-sent events. */
  tag?: string;
  /** iOS grouping key; all notifications with the same thread_id collapse
   *  into one stack on the lock screen. */
  threadId?: string;
}

// Brand color for the small-icon tint in the status bar. Matches the
// notification_color defined in android/app/src/main/res/values/colors.xml.
const BRAND_COLOR = '#8B1E3F';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const FCM_PROJECT_ID = Deno.env.get('FCM_PROJECT_ID') ?? 'sippd-6e06e';
const WEBHOOK_SECRET = Deno.env.get('PUSH_WEBHOOK_SECRET');
const FIREBASE_SERVICE_ACCOUNT = Deno.env.get('FIREBASE_SERVICE_ACCOUNT');

if (!WEBHOOK_SECRET) {
  throw new Error('PUSH_WEBHOOK_SECRET env var is required');
}

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

async function resolvePush(
  admin: ReturnType<typeof createClient>,
  payload: WebhookPayload,
): Promise<PushMessage | null> {
  const { table, type, record } = payload;

  if (
    table === 'friend_requests' &&
    type === 'UPDATE' &&
    record.status === 'accepted' &&
    payload.old_record?.status !== 'accepted'
  ) {
    const { data: accepter } = await admin
      .from('profiles')
      .select('display_name, username')
      .eq('id', record.receiver_id)
      .maybeSingle();
    const name = accepter?.display_name || accepter?.username || 'Someone';
    return {
      recipients: [record.sender_id],
      title: 'Friend request accepted',
      body: `${name} accepted your friend request`,
      data: {
        type: 'friend_request_accepted',
        user_id: record.receiver_id,
        request_id: record.id,
      },
      tag: `friend_accept:${record.receiver_id}`,
      threadId: 'friends',
    };
  }

  if (type !== 'INSERT') return null;

  if (table === 'friend_requests' && record.status === 'pending') {
    const { data: sender } = await admin
      .from('profiles')
      .select('display_name, username')
      .eq('id', record.sender_id)
      .maybeSingle();
    const name = sender?.display_name || sender?.username || 'Someone';
    return {
      recipients: [record.receiver_id],
      title: 'New friend request',
      body: `${name} wants to be your friend`,
      data: { type: 'friend_request', request_id: record.id },
      tag: `friend_request:${record.sender_id}`,
      threadId: 'friends',
    };
  }

  if (table === 'group_tastings') {
    const { data: members } = await admin
      .from('group_members')
      .select('user_id')
      .eq('group_id', record.group_id);
    const recipients = (members ?? [])
      .map((m: any) => m.user_id as string)
      .filter((id: string) => id !== record.created_by);
    if (recipients.length === 0) return null;
    const { data: group } = await admin
      .from('groups')
      .select('name')
      .eq('id', record.group_id)
      .maybeSingle();
    return {
      recipients,
      title: 'New tasting planned',
      body: `${record.title} — ${group?.name ?? 'your group'}`,
      data: { type: 'tasting_created', tasting_id: record.id },
      tag: `tasting:${record.id}`,
      threadId: `group:${record.group_id}`,
    };
  }

  if (table === 'group_members') {
    // Creator is auto-inserted as 'owner' on group create. Only notify real joins.
    if (record.role === 'owner') return null;
    const { data: group } = await admin
      .from('groups')
      .select('name')
      .eq('id', record.group_id)
      .maybeSingle();
    return {
      recipients: [record.user_id],
      title: 'Joined group',
      body: `Welcome to ${group?.name ?? 'the group'}`,
      data: { type: 'group_joined', group_id: record.group_id },
      tag: `group_joined:${record.group_id}`,
      threadId: `group:${record.group_id}`,
    };
  }

  if (table === 'group_invitations' && record.status === 'pending') {
    const [{ data: inviter }, { data: group }] = await Promise.all([
      admin
        .from('profiles')
        .select('display_name, username')
        .eq('id', record.inviter_id)
        .maybeSingle(),
      admin
        .from('groups')
        .select('name')
        .eq('id', record.group_id)
        .maybeSingle(),
    ]);
    const name = inviter?.display_name || inviter?.username || 'Someone';
    return {
      recipients: [record.invitee_id],
      title: 'Group invitation',
      body: `${name} invited you to ${group?.name ?? 'a group'}`,
      data: {
        type: 'group_invitation',
        invitation_id: record.id,
        group_id: record.group_id,
      },
      tag: `group_invite:${record.id}`,
      threadId: `group:${record.group_id}`,
    };
  }

  return null;
}

async function sendToTokens(
  accessToken: string,
  msg: PushMessage,
  tokens: string[],
): Promise<{
  sent: number;
  failed: number;
  invalidTokens: string[];
  fcmResponses: Array<{ token: string; status: number; body: string }>;
}> {
  let sent = 0;
  let failed = 0;
  const invalidTokens: string[] = [];
  const fcmResponses: Array<{ token: string; status: number; body: string }> =
    [];
  const url = `https://fcm.googleapis.com/v1/projects/${FCM_PROJECT_ID}/messages:send`;

  await Promise.all(
    tokens.map(async (token) => {
      const body = {
        message: {
          token,
          notification: { title: msg.title, body: msg.body },
          data: msg.data ?? {},
          android: {
            priority: 'HIGH',
            notification: {
              icon: 'ic_notification',
              color: BRAND_COLOR,
              notification_priority: 'PRIORITY_MAX',
              default_sound: true,
              default_vibrate_timings: true,
              ...(msg.tag ? { tag: msg.tag } : {}),
            },
          },
          apns: {
            headers: { 'apns-priority': '10' },
            payload: {
              aps: {
                sound: 'default',
                'mutable-content': 1,
                ...(msg.threadId ? { 'thread-id': msg.threadId } : {}),
              },
            },
          },
        },
      };
      const res = await fetch(url, {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(body),
      });
      const txt = await res.text();
      const tokenPreview = token.slice(0, 20);
      fcmResponses.push({
        token: tokenPreview,
        status: res.status,
        body: txt.slice(0, 400),
      });
      if (res.ok) {
        sent++;
      } else {
        failed++;
        console.error(`FCM error ${res.status} for ${tokenPreview}: ${txt}`);
        if (res.status === 404 || res.status === 400) {
          invalidTokens.push(token);
        }
      }
    }),
  );
  return { sent, failed, invalidTokens, fcmResponses };
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return new Response('method not allowed', { status: 405 });
  }

  const got = req.headers.get('x-webhook-secret');
  if (got !== WEBHOOK_SECRET) {
    return new Response('unauthorized', { status: 401 });
  }

  let payload: WebhookPayload;
  try {
    payload = (await req.json()) as WebhookPayload;
  } catch {
    return new Response('bad json', { status: 400 });
  }

  const admin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY);
  const push = await resolvePush(admin, payload);
  if (!push) {
    return new Response(JSON.stringify({ skipped: true }), { status: 200 });
  }

  const { data: deviceRows } = await admin
    .from('user_devices')
    .select('token')
    .in('user_id', push.recipients);
  const tokens = (deviceRows ?? []).map((r: any) => r.token as string);
  if (tokens.length === 0) {
    return new Response(JSON.stringify({ skipped: 'no tokens' }), { status: 200 });
  }

  let accessTokenResponse: { token: string | null | undefined };
  try {
    accessTokenResponse = await getJwtClient().getAccessToken();
  } catch (e) {
    console.error('OAuth error', e);
    return new Response(`oauth error: ${e}`, { status: 500 });
  }
  const accessToken = accessTokenResponse.token;
  if (!accessToken) {
    return new Response('no access token', { status: 500 });
  }

  const result = await sendToTokens(accessToken, push, tokens);

  if (result.invalidTokens.length > 0) {
    await admin
      .from('user_devices')
      .delete()
      .in('token', result.invalidTokens);
  }

  return new Response(
    JSON.stringify({
      payload_table: payload.table,
      recipients: push.recipients.length,
      tokens: tokens.length,
      sent: result.sent,
      failed: result.failed,
      removed_invalid: result.invalidTokens.length,
      fcm: result.fcmResponses,
    }),
    { status: 200, headers: { 'content-type': 'application/json' } },
  );
});

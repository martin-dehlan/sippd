// deno-lint-ignore-file no-explicit-any
//
// Deployed to: https://ungvhpffjhnojessifri.supabase.co/functions/v1/push
// Called by Postgres triggers on friend_requests, group_tastings, group_members,
// group_invitations, group_wines.
//
// IMPORTANT: deploy with `--no-verify-jwt` (or `verify_jwt = false` in
// supabase/config.toml). The Postgres trigger authenticates via the
// `x-webhook-secret` header check below — the gateway-level Bearer
// requirement would otherwise 401 every trigger call.
//
// Audit fix H4 (2026-05-08):
//   * Trigger now sends only {type, table, pk} (primary key envelope).
//     This function re-fetches the row via service-role client with an
//     explicit allow-list of fields. Reduces blast radius of payload leak
//     through pg_net + edge-function logs.
//
// Required env (Supabase Edge Function secrets):
//   FIREBASE_SERVICE_ACCOUNT — full service-account JSON as string
//   PUSH_WEBHOOK_SECRET      — shared secret; must match vault secret
//                              'push_webhook_secret' read by notify_push trigger
//   FCM_PROJECT_ID           — optional, defaults to sippd-6e06e

import { createClient } from 'npm:@supabase/supabase-js@2';
import { JWT } from 'npm:google-auth-library@9';

interface ThinPayload {
  type: 'INSERT' | 'UPDATE' | 'DELETE';
  table: string;
  pk: Record<string, string>;
}

interface PushMessage {
  recipients: string[];
  title: string;
  body: string;
  data?: Record<string, string>;
  tag?: string;
  threadId?: string;
}

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

function prefColumnForPushType(type: string | undefined): string | null {
  switch (type) {
    case 'friend_request':
    case 'friend_request_accepted':
      return 'friend_activity';
    case 'group_invitation':
    case 'group_joined':
    case 'tasting_created':
      return 'group_activity';
    case 'group_wine_shared':
      return 'group_wine_shared';
    default:
      return null;
  }
}

async function resolvePush(
  admin: ReturnType<typeof createClient>,
  payload: ThinPayload,
): Promise<PushMessage | null> {
  const { table, type, pk } = payload;

  // friend_requests UPDATE → status = 'accepted'
  if (table === 'friend_requests' && type === 'UPDATE') {
    const { data: req } = await admin
      .from('friend_requests')
      .select('id, sender_id, receiver_id, status')
      .eq('id', pk.id)
      .maybeSingle();
    if (!req || req.status !== 'accepted') return null;
    const { data: accepter } = await admin
      .from('profiles')
      .select('display_name, username')
      .eq('id', req.receiver_id)
      .maybeSingle();
    const name = accepter?.display_name || accepter?.username || 'Someone';
    return {
      recipients: [req.sender_id],
      title: 'Friend request accepted',
      body: `${name} accepted your friend request`,
      data: {
        type: 'friend_request_accepted',
        user_id: req.receiver_id,
        request_id: req.id,
      },
      tag: `friend_accept:${req.receiver_id}`,
      threadId: 'friends',
    };
  }

  if (type !== 'INSERT') return null;

  if (table === 'friend_requests') {
    const { data: req } = await admin
      .from('friend_requests')
      .select('id, sender_id, receiver_id, status')
      .eq('id', pk.id)
      .maybeSingle();
    if (!req || req.status !== 'pending') return null;
    const { data: sender } = await admin
      .from('profiles')
      .select('display_name, username')
      .eq('id', req.sender_id)
      .maybeSingle();
    const name = sender?.display_name || sender?.username || 'Someone';
    return {
      recipients: [req.receiver_id],
      title: 'New friend request',
      body: `${name} wants to be your friend`,
      data: { type: 'friend_request', request_id: req.id },
      tag: `friend_request:${req.sender_id}`,
      threadId: 'friends',
    };
  }

  if (table === 'group_tastings') {
    const { data: t } = await admin
      .from('group_tastings')
      .select('id, group_id, title, created_by')
      .eq('id', pk.id)
      .maybeSingle();
    if (!t) return null;
    const { data: members } = await admin
      .from('group_members')
      .select('user_id')
      .eq('group_id', t.group_id);
    const recipients = (members ?? [])
      .map((m: any) => m.user_id as string)
      .filter((id: string) => id !== t.created_by);
    if (recipients.length === 0) return null;
    const { data: group } = await admin
      .from('groups')
      .select('name')
      .eq('id', t.group_id)
      .maybeSingle();
    return {
      recipients,
      title: 'New tasting planned',
      body: `${t.title} — ${group?.name ?? 'your group'}`,
      data: { type: 'tasting_created', tasting_id: t.id },
      tag: `tasting:${t.id}`,
      threadId: `group:${t.group_id}`,
    };
  }

  if (table === 'group_wines') {
    const { data: gw } = await admin
      .from('group_wines')
      .select('id, group_id, canonical_wine_id, shared_by')
      .eq('id', pk.id)
      .maybeSingle();
    if (!gw) return null;
    const { data: members } = await admin
      .from('group_members')
      .select('user_id')
      .eq('group_id', gw.group_id);
    const recipients = (members ?? [])
      .map((m: any) => m.user_id as string)
      .filter((id: string) => id !== gw.shared_by);
    if (recipients.length === 0) return null;
    const [{ data: wine }, { data: group }, { data: sharer }] = await Promise.all([
      admin
        .from('canonical_wine')
        .select('name, winery')
        .eq('id', gw.canonical_wine_id)
        .maybeSingle(),
      admin
        .from('groups')
        .select('name')
        .eq('id', gw.group_id)
        .maybeSingle(),
      admin
        .from('profiles')
        .select('display_name, username')
        .eq('id', gw.shared_by)
        .maybeSingle(),
    ]);
    const sharerName =
      (sharer as any)?.display_name || (sharer as any)?.username || 'Someone';
    const wineName = (wine as any)?.name ?? 'a wine';
    const winery = (wine as any)?.winery as string | null | undefined;
    const groupName = (group as any)?.name ?? 'your group';
    return {
      recipients,
      title: `${sharerName} shared a wine`,
      body: winery
        ? `${wineName} · ${winery} — ${groupName}`
        : `${wineName} — ${groupName}`,
      data: {
        type: 'group_wine_shared',
        group_id: gw.group_id as string,
        canonical_wine_id: gw.canonical_wine_id as string,
      },
      tag: `group_wine:${gw.group_id}:${gw.canonical_wine_id}`,
      threadId: `group:${gw.group_id}`,
    };
  }

  if (table === 'group_members') {
    const { data: gm } = await admin
      .from('group_members')
      .select('group_id, user_id, role')
      .eq('group_id', pk.group_id)
      .eq('user_id', pk.user_id)
      .maybeSingle();
    if (!gm || gm.role === 'owner') return null;
    const { data: group } = await admin
      .from('groups')
      .select('name')
      .eq('id', gm.group_id)
      .maybeSingle();
    return {
      recipients: [gm.user_id],
      title: 'Joined group',
      body: `Welcome to ${group?.name ?? 'the group'}`,
      data: { type: 'group_joined', group_id: gm.group_id },
      tag: `group_joined:${gm.group_id}`,
      threadId: `group:${gm.group_id}`,
    };
  }

  if (table === 'group_invitations') {
    const { data: gi } = await admin
      .from('group_invitations')
      .select('id, group_id, inviter_id, invitee_id, status')
      .eq('id', pk.id)
      .maybeSingle();
    if (!gi || gi.status !== 'pending') return null;
    const [{ data: inviter }, { data: group }] = await Promise.all([
      admin
        .from('profiles')
        .select('display_name, username')
        .eq('id', gi.inviter_id)
        .maybeSingle(),
      admin
        .from('groups')
        .select('name')
        .eq('id', gi.group_id)
        .maybeSingle(),
    ]);
    const name = inviter?.display_name || inviter?.username || 'Someone';
    return {
      recipients: [gi.invitee_id],
      title: 'Group invitation',
      body: `${name} invited you to ${group?.name ?? 'a group'}`,
      data: {
        type: 'group_invitation',
        invitation_id: gi.id,
        group_id: gi.group_id,
      },
      tag: `group_invite:${gi.id}`,
      threadId: `group:${gi.group_id}`,
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
}> {
  let sent = 0;
  let failed = 0;
  const invalidTokens: string[] = [];
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
      if (res.ok) {
        sent++;
      } else {
        failed++;
        // Audit M1/L5: do not log token contents in error path.
        const txt = await res.text();
        console.error(`FCM error ${res.status}: ${txt.slice(0, 200)}`);
        if (res.status === 404 || res.status === 400) {
          invalidTokens.push(token);
        }
      }
    }),
  );
  return { sent, failed, invalidTokens };
}

Deno.serve(async (req) => {
  if (req.method !== 'POST') {
    return new Response('method not allowed', { status: 405 });
  }

  const got = req.headers.get('x-webhook-secret');
  if (got !== WEBHOOK_SECRET) {
    return new Response('unauthorized', { status: 401 });
  }

  let payload: ThinPayload;
  try {
    payload = (await req.json()) as ThinPayload;
  } catch {
    return new Response('bad json', { status: 400 });
  }
  if (!payload?.type || !payload?.table || !payload?.pk) {
    return new Response('bad payload', { status: 400 });
  }

  const admin = createClient(SUPABASE_URL, SERVICE_ROLE_KEY);
  const push = await resolvePush(admin, payload);
  if (!push) {
    return new Response(JSON.stringify({ skipped: true }), { status: 200 });
  }

  const prefColumn = prefColumnForPushType(push.data?.type);
  if (prefColumn) {
    const { data: prefRows } = await admin
      .from('user_notification_prefs')
      .select(`user_id, ${prefColumn}`)
      .in('user_id', push.recipients);
    const allowed = new Set(
      (prefRows ?? [])
        .filter((r: any) => r[prefColumn] === true)
        .map((r: any) => r.user_id as string),
    );
    push.recipients = push.recipients.filter((id) => allowed.has(id));
    if (push.recipients.length === 0) {
      return new Response(
        JSON.stringify({ skipped: 'all recipients muted' }),
        { status: 200 },
      );
    }
  }

  const { data: deviceRows } = await admin
    .from('user_devices')
    .select('token')
    .in('user_id', push.recipients);
  const tokens = (deviceRows ?? []).map((r: any) => r.token as string);
  if (tokens.length === 0) {
    return new Response(JSON.stringify({ skipped: 'no tokens' }), {
      status: 200,
    });
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
    }),
    { status: 200, headers: { 'content-type': 'application/json' } },
  );
});

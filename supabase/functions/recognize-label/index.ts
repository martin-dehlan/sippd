// deno-lint-ignore-file no-explicit-any
//
// Deployed to: https://<project>.supabase.co/functions/v1/recognize-label
// Milestone S1 · issues #174 (proxy) + #175 (quota).
//
// Wine-label recognition proxy. The mobile client uploads a label photo;
// this function meters the per-user quota, calls the FastCork
// recognition API with a SERVER-HELD key, and returns normalized wine
// fields. The FastCork key never reaches the client (it would leak in
// the app binary).
//
// Flow:
//   1. Verify the Supabase JWT (reject anon).
//   2. check_and_consume_scan() — atomic quota claim BEFORE any paid
//      call. Quota exceeded → 429 scan_quota_exceeded, no FastCork hit.
//   3. POST the image to FastCork /v1/analyze (Bearer key).
//   4. Normalize the response → { result, quota }.
//
// When FASTCORK_API_KEY is unset we return a deterministic MOCK result
// so the whole stack (app → function → quota → UI) can be built and
// tested before the $5 key is provisioned. Set FASTCORK_MOCK=off to
// force a hard error instead of mocking.
//
// Required env (Supabase Edge Function secrets):
//   FASTCORK_API_KEY — fc-... recognition key (optional until live)
//   FASTCORK_MOCK    — 'off' to disable the mock fallback (optional)

import { createClient } from 'npm:@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const ANON_KEY = Deno.env.get('SUPABASE_ANON_KEY')!;
const FASTCORK_API_KEY = Deno.env.get('FASTCORK_API_KEY');
const FASTCORK_MOCK = (Deno.env.get('FASTCORK_MOCK') ?? 'auto').toLowerCase();
const FASTCORK_URL = 'https://fastcork.com/v1/analyze';

const CORS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
};

interface NormalizedScan {
  producer: string | null;
  wineName: string | null;
  vintage: number | null;
  appellation: string | null;
  country: string | null;
  region: string | null;
  grapes: string[];
  tastingNotes: string | null;
  servingTempC: number | null;
  decantMinutes: number | null;
  foodPairings: string[];
}

function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...CORS, 'Content-Type': 'application/json' },
  });
}

function err(code: string, status: number, extra: Record<string, unknown> = {}) {
  return json({ error: code, ...extra }, status);
}

// FastCork payloads are loosely shaped; pull fields defensively.
function normalize(raw: any): NormalizedScan {
  const num = (v: any): number | null =>
    v === null || v === undefined || v === '' ? null : Number(v) || null;
  const arr = (v: any): string[] =>
    Array.isArray(v) ? v.map((x) => String(x)).filter(Boolean) : [];
  const str = (v: any): string | null =>
    v === null || v === undefined || v === '' ? null : String(v);

  return {
    producer: str(raw.producer ?? raw.winery),
    wineName: str(raw.name ?? raw.wine_name ?? raw.cuvee),
    vintage: num(raw.vintage ?? raw.year),
    appellation: str(raw.appellation ?? raw.region),
    country: str(raw.country),
    region: str(raw.region ?? raw.appellation),
    grapes: arr(raw.grapes ?? raw.grape_varieties ?? raw.varietals),
    tastingNotes: str(raw.tasting_notes ?? raw.tastingNotes ?? raw.notes),
    servingTempC: num(raw.serving_temperature ?? raw.serving_temp),
    decantMinutes: num(raw.decanting_duration ?? raw.decant_minutes),
    foodPairings: arr(raw.food_pairings ?? raw.foodPairing ?? raw.pairings),
  };
}

function mockResult(): NormalizedScan {
  // Deterministic stand-in so the app can be wired before the key lands.
  return {
    producer: 'Château Mock',
    wineName: 'Grand Cuvée',
    vintage: 2019,
    appellation: 'Saint-Émilion Grand Cru',
    country: 'France',
    region: 'Bordeaux',
    grapes: ['Merlot', 'Cabernet Franc'],
    tastingNotes: 'Plum, cedar, soft tannins. (mock recognition)',
    servingTempC: 17,
    decantMinutes: 60,
    foodPairings: ['Lamb', 'Aged cheese'],
  };
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: CORS });
  if (req.method !== 'POST') return err('method_not_allowed', 405);

  const authHeader = req.headers.get('Authorization');
  if (!authHeader) return err('unauthorized', 401);

  // Per-request client carrying the caller's JWT so RLS + auth.uid()
  // resolve to the actual user inside the quota RPC.
  const supabase = createClient(SUPABASE_URL, ANON_KEY, {
    global: { headers: { Authorization: authHeader } },
  });

  const {
    data: { user },
    error: authErr,
  } = await supabase.auth.getUser();
  if (authErr || !user) return err('unauthorized', 401);

  // Parse JSON body: base64 image + optional lang + is_pro hint.
  // (Client sends JSON so supabase-js `functions.invoke` carries the
  // JWT automatically; we re-encode to multipart for FastCork below.)
  let imageBytes: Uint8Array | null = null;
  let lang = 'en';
  let isPro = false;
  try {
    const body = await req.json();
    const b64 = (body.image_base64 as string) ?? '';
    if (b64) imageBytes = Uint8Array.from(atob(b64), (c) => c.charCodeAt(0));
    lang = (body.lang as string) || 'en';
    isPro = body.is_pro === true;
  } catch {
    return err('bad_request', 400, { message: 'expected JSON body' });
  }
  if (!imageBytes || imageBytes.length === 0) {
    return err('bad_request', 400, { message: 'missing image_base64' });
  }

  // 1. Quota claim BEFORE any paid call.
  const { data: quotaRows, error: quotaErr } = await supabase.rpc(
    'check_and_consume_scan',
    { p_is_pro: isPro },
  );
  if (quotaErr) return err('server_error', 500, { message: quotaErr.message });
  const quota = Array.isArray(quotaRows) ? quotaRows[0] : quotaRows;
  if (!quota || quota.allowed !== true) {
    return err('scan_quota_exceeded', 429, {
      quota: {
        used: quota?.used ?? quota?.scan_limit ?? 0,
        limit: quota?.scan_limit ?? 0,
        remaining: 0,
      },
    });
  }
  const quotaOut = {
    used: quota.used,
    limit: quota.scan_limit,
    remaining: quota.remaining,
  };

  // 2. Recognition. Mock when no key (unless explicitly disabled).
  if (!FASTCORK_API_KEY) {
    if (FASTCORK_MOCK === 'off') {
      return err('recognition_unavailable', 503, {
        message: 'FASTCORK_API_KEY not configured',
      });
    }
    return json({ result: mockResult(), quota: quotaOut, mock: true });
  }

  try {
    const upstream = new FormData();
    upstream.append(
      'file',
      new Blob([imageBytes], { type: 'image/jpeg' }),
      'label.jpg',
    );
    upstream.append('lang', lang);

    const res = await fetch(FASTCORK_URL, {
      method: 'POST',
      headers: { Authorization: `Bearer ${FASTCORK_API_KEY}` },
      body: upstream,
    });

    if (!res.ok) {
      const body = await res.text();
      // Map upstream failures to clean client codes.
      if (res.status === 401 || res.status === 403) {
        return err('recognition_unavailable', 503, { message: 'upstream auth' });
      }
      if (res.status === 422 || res.status === 404) {
        return err('label_not_recognized', 422);
      }
      return err('recognition_failed', 502, {
        upstreamStatus: res.status,
        message: body.slice(0, 200),
      });
    }

    const raw = await res.json();
    return json({ result: normalize(raw), quota: quotaOut });
  } catch (e) {
    return err('recognition_failed', 502, { message: String(e) });
  }
});

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

// Hard cap on the inbound image. The client downscales to 1600px / q85
// (well under 1 MB), so this only exists to stop a hand-crafted request
// from sending a huge payload to abuse function memory / egress. 8 MB of
// binary ≈ ceil(8MiB/3)*4 base64 chars.
const MAX_IMAGE_BYTES = 8 * 1024 * 1024;
const MAX_B64_LEN = Math.ceil(MAX_IMAGE_BYTES / 3) * 4;

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
  // FastCork's `wine_type` (red | white | rose | sparkling) — lets the
  // client preselect the correct type instead of guessing from grape.
  wineType: string | null;
  aroma: string | null;
  abv: number | null;
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

// Map FastCork's real response into our normalized shape.
//
// FastCork returns: { success, id, results: [ { full_wine_name, vintage,
// grape_variety, winery, region, tasting_notes, food_pairing,
// serving_temperature_celcius_range: {min_temp,max_temp}, ... } ] }.
// The wine fields live in results[0] with snake_case names — earlier this
// read them top-level, so every field came back null (→ false "no match").
function normalize(raw: any): NormalizedScan {
  const num = (v: any): number | null =>
    v === null || v === undefined || v === '' ? null : Number(v) || null;
  const str = (v: any): string | null =>
    v === null || v === undefined || v === '' ? null : String(v);
  // Treat FastCork's "unknown" placeholders as absent.
  const clean = (v: any): string | null => {
    const s = str(v);
    if (!s) return null;
    const low = s.trim().toLowerCase();
    return low === 'unknown' ||
        low === 'n/a' ||
        low === 'no information available'
      ? null
      : s.trim();
  };
  // Split a "Merlot, Cabernet" / "Fish and cheese" string into a list.
  const list = (v: any): string[] => {
    if (Array.isArray(v)) return v.map((x) => String(x).trim()).filter(Boolean);
    const s = str(v);
    if (!s) return [];
    return s
      .split(/,|;|\band\b|&/i)
      .map((x) => x.trim())
      .filter((x) => x && x.toLowerCase() !== 'unknown');
  };

  const r = Array.isArray(raw?.results) && raw.results.length > 0
    ? raw.results[0]
    : raw ?? {};

  // FastCork's region is often "Sub-region, Country" — split the trailing
  // country out when we don't have an explicit one.
  let region = clean(r.region);
  let country = clean(r.country);
  if (region && !country && region.includes(',')) {
    const parts = region.split(',').map((p: string) => p.trim());
    country = parts.pop() ?? null;
    region = parts.join(', ') || null;
  }

  const temp = r.serving_temperature_celcius_range;
  const servingTempC = temp
    ? num(temp.max_temp ?? temp.min_temp)
    : num(r.serving_temperature ?? r.serving_temp);

  return {
    producer: clean(r.winery ?? r.producer),
    wineName: clean(r.full_wine_name ?? r.name ?? r.wine_name ?? r.cuvee),
    vintage: num(r.vintage ?? r.year),
    appellation: clean(r.appellation),
    country,
    region,
    grapes: list(r.grape_variety ?? r.grapes ?? r.grape_varieties ?? r.varietals),
    tastingNotes: clean(r.tasting_notes ?? r.tastingNotes ?? r.notes),
    servingTempC,
    decantMinutes: num(r.decanting_time_minutes ?? r.decanting_duration),
    foodPairings: list(r.food_pairing ?? r.food_pairings ?? r.pairings),
    wineType: clean(r.wine_type ?? r.type),
    aroma: clean(r.aroma),
    abv: num(r.alc_percentage ?? r.abv ?? r.alcohol),
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
    wineType: 'red',
    aroma: 'Blackcurrant, cedar, vanilla',
    abv: 13.5,
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

  // Only verified accounts may spend a (paid) scan. Email confirmation is
  // required on signup, so this blocks scripted unconfirmed sign-ups from
  // amplifying FastCork cost across throwaway accounts.
  if (!user.email_confirmed_at) {
    return err('email_not_confirmed', 403);
  }

  // Parse JSON body: base64 image + optional lang.
  // (Client sends JSON so supabase-js `functions.invoke` carries the
  // JWT automatically; we re-encode to multipart for FastCork below.)
  // There is intentionally no `is_pro` input — the quota keys solely on
  // the authenticated user, so a client cannot lift its own cap.
  let imageBytes: Uint8Array | null = null;
  let lang = 'en';
  try {
    const body = await req.json();
    const b64 = (body.image_base64 as string) ?? '';
    // Reject oversized payloads BEFORE allocating/decoding them.
    if (b64.length > MAX_B64_LEN) {
      return err('payload_too_large', 413, { message: 'image too large' });
    }
    if (b64) imageBytes = Uint8Array.from(atob(b64), (c) => c.charCodeAt(0));
    lang = (body.lang as string) || 'en';
  } catch {
    return err('bad_request', 400, { message: 'expected JSON body' });
  }
  if (!imageBytes || imageBytes.length === 0) {
    return err('bad_request', 400, { message: 'missing image_base64' });
  }

  // ─── DEV-ONLY MOCK ─────────────────────────────────────────────────
  // Set secret FASTCORK_MOCK=on to return a deterministic result without
  // spending a FastCork credit OR a quota slot — unlimited local testing.
  // REMOVE this block (and mockResult() below) before shipping to prod to
  // keep the function lean.
  if (FASTCORK_MOCK === 'on' || FASTCORK_MOCK === 'force') {
    return json({
      result: mockResult(),
      quota: { used: 0, limit: 5, remaining: 5 },
      mock: true,
    });
  }
  // ───────────────────────────────────────────────────────────────────

  // 1. Quota claim BEFORE any paid call. Keyed on auth.uid() inside the
  // SECURITY DEFINER RPC — no client-supplied input affects the cap.
  const { data: quotaRows, error: quotaErr } = await supabase.rpc(
    'check_and_consume_scan',
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

# Sippd External Interface Reference

Sippd is a mobile app, not a server. It exposes **no public REST API** of its
own. Its externally visible interfaces are:

1. The deep-link / universal-link surface that other apps and the web can use
   to open content in the app.
2. The Supabase backend surface (Auth, Postgres + RPC, Storage, Realtime)
   that the app talks to. This is access-controlled by Row-Level Security and
   is not a public API — it is documented here so reviewers understand the
   trust boundary.

The production homepage is <https://sippd.xyz>. The Android package id is
`xyz.sippd.app`; the iOS bundle id is the App Store target.

---

## 1. Deep links and universal links

### 1.1 Custom URL scheme

The app registers the custom scheme **`io.sippd://`** (with `sippd://` also
reserved). Inbound links are routed by `go_router`; the handler lives in
`lib/main.dart` and the route table in the feature `*.routes.dart` files.

| Link | Opens | Notes |
|---|---|---|
| `io.sippd://login-callback/` | Auth callback | Supabase magic-link / OAuth PKCE redirect target |
| `sippd://app/wines/{wineId}` | A wine detail | `wineId` is a UUID |
| `sippd://app/groups/{groupId}` | A group | `groupId` is a UUID |

### 1.2 Universal links (HTTPS)

The app claims `https://sippd.xyz/*` via Apple App Site Association
(`/.well-known/apple-app-site-association`) and Android App Links
(`/.well-known/assetlinks.json`). A matching `https://sippd.xyz/...` URL opens
the app directly when installed, and falls back to the website otherwise.

`FlutterDeepLinkingEnabled` is set in `ios/Runner/Info.plist`; the Android
intent filters are in `android/app/src/main/AndroidManifest.xml`.

---

## 2. Supabase backend surface

All backend access goes through `supabase_flutter` using the project's
**anon** key plus the authenticated user's JWT. Every table and RPC is
guarded by Row-Level Security; the anon key alone grants nothing beyond what
RLS policies permit for the current session.

### 2.1 Auth

- Email magic-link and OAuth (Apple, Google) via Supabase Auth.
- Redirect target: `io.sippd://login-callback/`.
- Passwords (where used) are stored and hashed by Supabase Auth (Argon2id);
  the app never sees plaintext passwords.

### 2.2 Data (Postgres + RPC)

The app reads and writes through Drift locally and syncs to Supabase tables
including `wines`, `canonical_wine`, `groups`, `group_members`,
`group_wines`, `group_wine_ratings`, `group_tastings`, `tasting_wines`,
`tasting_ratings`, `tasting_attendees`, `friends`, and profile tables.

Cross-user aggregates are computed by SECURITY-DEFINER RPCs (examples):

| RPC | Purpose |
|---|---|
| `get_user_rating_summary` | Per-user rating stats (avg, count) |
| `get_taste_compass` | Style-DNA axes for the taste compass |
| `get_taste_match` | Confidence-tiered match-% between two users |
| `resolve_canonical_wine` | Map a free-text wine to a canonical identity |

RLS policies live in `supabase/migrations/`. The canonical-wine identity
layer and the taste-match scoring model are described in the project README.

### 2.3 Storage

- Buckets hold wine photos and share-card images.
- Uploads are MIME- and size-capped; reads are scoped by RLS / signed URLs.
- A `PendingImageUploadsDao` outbox retries failed uploads on launch and on
  connectivity changes so a wine never silently loses its `image_url`.

### 2.4 Realtime

During an active group tasting, the app opens filtered
`postgres_changes` subscriptions on `group_tastings`, `tasting_wines`,
`tasting_ratings`, and `tasting_attendees`, filtered by `tasting_id`. RLS
filters events by group membership, so a subscriber only receives changes to
rows it could already `SELECT`.

---

## 3. Third-party services

| Service | Use | Transport |
|---|---|---|
| Supabase | Auth, Postgres, Storage, Realtime | HTTPS / WSS |
| Firebase Cloud Messaging | Push notifications | HTTPS |
| RevenueCat | Subscription / paywall entitlements | HTTPS |
| Resend | Transactional email (server-side) | HTTPS |
| Nominatim (OSM) | Reverse-geocoding for venue/region tagging | HTTPS |

All network traffic is HTTPS/TLS. The app implements no custom cryptography;
all crypto is delegated to platform and vendor libraries.

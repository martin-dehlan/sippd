# Sippd

> A quiet wine journal — local-first, offline, no ads, no feed.

**[Google Play](https://play.google.com/store/apps/details?id=xyz.sippd.app)** · **[TestFlight (iOS Beta)](https://testflight.apple.com/join/1e9GnmAD)** · **[sippd.xyz](https://sippd.xyz)**

<p align="center">
  <img src="https://sippd.xyz/screenshots/clean/rate.jpeg" width="220" alt="Rate a bottle in seconds" />
  <img src="https://sippd.xyz/screenshots/clean/groups.jpeg" width="220" alt="Private groups with friends" />
  <img src="https://sippd.xyz/screenshots/clean/stats.jpeg" width="220" alt="Your wine journey, visualised" />
</p>

Wine ranking & sharing app built with Flutter. Rate, organize, and share wines with friends in groups — local-first, offline-ready, syncs through Supabase.

Built after a trip through South African wine country, after one too many ad-stuffed screens in the existing apps. Local-first by design — your bottles, your device.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![Riverpod](https://img.shields.io/badge/State-Riverpod-7c4dff)
![License](https://img.shields.io/badge/license-Private-lightgrey)

---

## Features

- **Wine ranking** — rate, photograph, and tag wines
- **Groups** — share ratings and wine lists with friends
- **Local-first** — Drift (SQLite) is the source of truth, Supabase syncs in the background
- **Offline-ready** — full functionality without network; changes sync when back online
- **Location & maps** — tag wines with venue/region via GPS
- **Push notifications** — Firebase Messaging for group activity
- **Deep linking** — open wines and groups directly via `sippd://` scheme

---

## Tech Stack

| Layer | Tech |
|-------|------|
| UI | Flutter, Material 3, `google_fonts` |
| State | Riverpod (code-gen) |
| Local DB | Drift + SQLite |
| Backend | Supabase (Auth, Postgres, Storage, Realtime) |
| Push | Firebase Messaging + `flutter_local_notifications` |
| Navigation | `go_router` |
| Networking | Dio |
| Models | Freezed + `json_serializable` |
| Maps | `flutter_map` + Nominatim |

---

## Architecture

```
Domain (pure Dart) → Data (Supabase/Drift) → Controller (Riverpod) → Presentation (UI)
```

Feature-based — each feature (`wines`, `auth`, `groups`, `tastings`,
`taste_match`, `friends`, `share_cards`, `paywall`) is self-contained
with its own `domain/`, `data/`, `controller/`, `presentation/`. The
domain layer is pure Dart (no Flutter, no Riverpod, no external
imports). See [`CLAUDE.md`](./CLAUDE.md) and
[`.claude/RULES/`](./.claude/RULES/) for the full conventions.

A few specific patterns worth flagging — they're the parts that took
real architectural thought rather than autopilot scaffolding:

### Local-first sync (Drift = source of truth, Supabase = sync backend)

Wines, ratings, group memberships, tasting state, and profile data
are written to Drift first and emitted to the UI from there. The
repository layer fires the corresponding Supabase write in the
background; if the network call fails, the local row stands and a
later sync picks it up. Image uploads have a dedicated
`PendingImageUploadsDao` outbox that retries on launch and on
connectivity flips so a failed photo upload never silently leaves
a wine without an `image_url`.

```
UI ← Drift (synchronous read) ← repository.updateWine(local)
                                          ↓ background
                                     Supabase upsert
                                          ↓ on failure
                                     stays local + outbox retry
```

The full surface lives in `lib/features/*/data/repositories/` and
`lib/common/database/`.

### Canonical wine identity

`public.wines` mixes "wine identity" (an abstract bottle anyone
might rate) with "wine entry" (a per-user instance). That mix breaks
every cross-user feature — drinking partners, taste-match, shared
bottles — because string-matching on names fails on accents, typos,
and NV-vs-vintage drift.

Phase 1 of the canonical-wine architecture (shipped) introduces:

- `public.canonical_wine` — server-side catalog keyed by
  `(name_norm, winery_norm, vintage)` with a `confidence` flag
- `wines.canonical_wine_id` — FK that backfills via a
  `BEFORE INSERT/UPDATE` trigger calling `resolve_canonical_wine()`
- A Tier-2 fuzzy-match modal in `wine_form` that asks "Same wine?"
  before inserting a near-duplicate (similarity ≥ 0.6 via `pg_trgm`)
- A `ratings` view that unions `wines.rating`,
  `group_wine_ratings.rating`, and `tasting_ratings.rating` so all
  cross-user RPCs query one logical surface

The trigger is hardened against autosave-driven pollution (preserves
`OLD.canonical_wine_id` on UPDATE; rejects `name_norm` shorter than
3 chars). Migration files in `supabase/migrations/`.

### Honest-first taste-match

Match-% is built around three constraints we wrote down before any
math:

1. **Confidence-tiered, never naked.** Every score ships with a
   sample-size + overlap-count badge, and the UI maps score colour
   to confidence so a "Strong" 87% reads visibly differently from
   a "Solid" 72% or a low-confidence early signal.
2. **No naive cosine.** Direction-only similarity over averaged
   preference vectors lies through its teeth on sparse rating data.
   The RPC blends three signals — region/country/type bucket
   overlap (weighted Δrating), Style-DNA Manhattan distance over
   six WSET-aligned axes, and a same-canonical agreement bonus —
   then clamps confidence by `min(both users' attributed counts)`.
3. **Sample minimums are gates, not warnings.** Below the floor
   (5 ratings each, 3 bucket overlap), the UI returns a
   "not_enough_overlap" empty-state, not a confident-looking
   number. Better to say nothing than to lie politely.

`get_taste_match()` lives in `supabase/migrations/...taste_match*.sql`;
the consuming widgets are under
`lib/features/taste_match/presentation/`.

### Realtime sync for tastings

During an active group tasting, every attendee's screen needs to
reflect adds, ratings, RSVPs, and host state-transitions in real
time. Rather than polling, five Riverpod providers each open a
filtered Supabase postgres-changes subscription and call
`ref.invalidateSelf()` on any event:

| Provider | Source table | Filter | Effect |
|---|---|---|---|
| `tastingDetailProvider` | `group_tastings` | `id` | Start / End / edit broadcasts |
| `tastingWinesProvider` | `tasting_wines` | `tasting_id` | Lineup add / remove |
| `tastingWineRatingsProvider` | `tasting_ratings` | `tasting_id` | Avg pill recompute |
| `tastingRecapEntriesProvider` | `tasting_ratings` | `tasting_id` | Recap chips refresh |
| `tastingAttendeesProvider` | `tasting_attendees` | `tasting_id` | RSVP cluster + `canAdd` rule |

Channel cleanup runs from `ref.onDispose`. RLS already filters by
group membership, so subscribers only get events for rows they
could `SELECT` — no application-level access checking needed on the
push path.

---

## Getting Started

### Prerequisites

- Flutter SDK `^3.11.4`
- Dart `^3.x`
- Xcode (for iOS builds)
- Android Studio / Android SDK (for Android builds)
- A Supabase project
- A Firebase project (for push notifications)

### Setup

```bash
# Clone
git clone https://github.com/martin-dehlan/sippd.git
cd sippd

# Install dependencies
flutter pub get

# Generate code (Freezed, Riverpod, Drift)
dart run build_runner build --delete-conflicting-outputs

# Set up env
cp .env.example .env
# Fill in SUPABASE_URL, SUPABASE_ANON_KEY, etc.
```

### Run

```bash
# iOS simulator / Android emulator / connected device
flutter run

# Pick a device
flutter devices
flutter run -d <device-id>
```

---

## Development

### Code generation

```bash
# One-shot
dart run build_runner build --delete-conflicting-outputs

# Watch mode (recommended while coding)
dart run build_runner watch --delete-conflicting-outputs
```

### Lint & format

```bash
dart format .
flutter analyze
```

### Testing

```bash
# Unit + widget tests
flutter test

# Integration tests
flutter test integration_test/
```

### Branding

App icons and splash screens are generated from assets:

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

---

## Project Structure

```
lib/
├── common/           # Cross-feature: database, theme, routes, utils, widgets
├── core/             # App-level config
├── features/
│   ├── wines/        # Wine ranking, photos, filtering
│   ├── auth/         # Supabase auth
│   └── groups/       # Group wine lists, shared ratings
└── main.dart
```

Each feature:
```
features/<feature>/
├── data/             # Models, API, DAO, Repo impl
├── domain/           # Entities, Repo interfaces, Use cases
├── controller/       # All Riverpod providers
└── presentation/     # Screens & widgets
```

---

## Conventions

- Files: `name.type.dart` (e.g. `wine.model.dart`, `wine_list.screen.dart`)
- No fixed spacing — all sizing via `MediaQuery` (see `lib/common/utils/responsive.dart`)
- Colors only from `Theme.of(context).colorScheme`
- All providers centralized in `controller/<feature>.provider.dart`
- Domain layer is pure Dart — no Flutter, no Riverpod imports

---

## Database

Drift is the source of truth on-device; Supabase is the sync backend
(Auth + Postgres + Storage + Realtime). The schema currently sits at
`schemaVersion = 1` with no in-place migrations — this is an
intentional pre-launch reset that consolidates earlier 1→6 migrations
into a single baseline. Existing TestFlight/beta installs need a
fresh install to pick up the v1 schema; that's compatible with the
data-wipe scheduled for the 1.0 store launch.

The Supabase migrations live under `supabase/migrations/` and document
the production schema (RLS policies, functions, realtime publications).

---

## License

See [LICENSE](./LICENSE) — source-available for review and study, not
licensed for production / commercial reuse without permission.

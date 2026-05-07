# Sippd

Wine ranking & sharing app built with Flutter. Rate, organize, and share wines with friends in groups — local-first, offline-ready, syncs through Supabase.

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

Feature-based structure — each feature (wines, auth, groups) is self-contained with its own `domain/`, `data/`, `controller/`, and `presentation/` layers.

See [`CLAUDE.md`](./CLAUDE.md) and [`.claude/RULES/`](./.claude/RULES/) for the full architecture, naming conventions, and coding standards.

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

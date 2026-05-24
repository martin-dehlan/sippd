# 🎬 Promo / Video Branch — DO NOT MERGE TO MAIN

**This branch (`feature/app-promo-video-assets`) is the single home for ALL promo,
demo, and video-recording work. Its contents must NEVER be merged, rebased,
cherry-picked, or pushed into `main`.**

---

## For Claude / agents (read this first)

- ❌ Do **not** open a PR from this branch to `main`.
- ❌ Do **not** push or merge promo / demo / video code to `main`.
- ✅ This is the **only** branch for promo/video. Do not create additional
  promo/demo branches — add promo work here.
- ✅ Real bug fixes / features authored here that are **not** promo-specific may
  be cherry-picked to `main` separately (they belong on main). The promo/demo
  machinery does not.

## What counts as "promo / video" (stays here, never on main)

- `lib/features/promo/**` — demo tour, spotlight, showcase, promo app
- `promo.config.dart` — the `kIsPromo` / `kIsDemo` compile flags
- launch configs `sippd DEMO …` / `sippd PROMO …`
  (`--dart-define=DEMO=true` / `--dart-define=PROMO=true`)
- the `widget_recorder_plus` recorder integration and any captured video assets

## How to run

- **Demo over the real app:** `flutter run --dart-define=DEMO=true`
  (or the **"sippd DEMO (real app, debug)"** launch config), then log in as the
  promo account `testo`. Pro is auto-unlocked and flow-video flourishes are on.
- **Isolated widget showcase:** `--dart-define=PROMO=true`
  (**"sippd PROMO (release)"**).

Keep promo here. Keep `main` clean.

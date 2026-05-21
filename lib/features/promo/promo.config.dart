/// Compile-time flag that switches the app into "promo asset" mode.
///
/// Enable with:
///
/// ```sh
/// flutter run --release --dart-define=PROMO=true
/// ```
///
/// Because this is a `const` resolved from the environment at compile
/// time, every branch guarded by `if (kIsPromo)` is dead code in a normal
/// build and the Dart tree-shaker strips the entire promo UI from
/// production binaries.
///
/// NOTE: the `widget_recorder_plus` native plugin still links into prod
/// (Flutter has no per-flavor plugin gating without build flavors) — only
/// the Dart promo screens are excluded.
const bool kIsPromo = bool.fromEnvironment('PROMO', defaultValue: false);

/// Compile-time flag for "demo" recordings of the REAL app.
///
/// Enable with:
///
/// ```sh
/// flutter run --dart-define=DEMO=true
/// ```
///
/// Unlike [kIsPromo] (which boots the isolated widget showcase), a demo
/// build runs the normal app — real login, real data — but turns on
/// flow-video flourishes on the real screens (more pronounced staggered
/// entrances, highlight beats) so a screen recording already looks
/// finished, with minimal editing. Production never sees these: `kIsDemo`
/// is a `const false` there, so every `if (kIsDemo)` branch is tree-shaken.
const bool kIsDemo = bool.fromEnvironment('DEMO', defaultValue: false);

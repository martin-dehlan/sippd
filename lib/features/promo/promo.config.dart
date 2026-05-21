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

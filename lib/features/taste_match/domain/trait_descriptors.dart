import '../../../common/l10n/generated/app_localizations.dart';
import 'entities/user_style_dna.entity.dart';

/// Shared trait language for any surface that has to render a single
/// axis as human-readable copy. Lives in domain so widgets in
/// `taste_match/presentation/` AND share-cards in
/// `share_cards/presentation/` can both pull from one source instead
/// of duplicating switch tables that drift over time.

const _kAxes = <String>[
  'body',
  'tannin',
  'acidity',
  'sweetness',
  'oak',
  'intensity',
];

/// Localized axis label (Body, Tannin, …). Pass the active
/// [AppLocalizations]; falls back to the raw key for unknown axes.
String traitLabel(String axis, AppLocalizations l) => switch (axis) {
  'body' => l.tasteTraitBody,
  'tannin' => l.tasteTraitTannin,
  'acidity' => l.tasteTraitAcidity,
  'sweetness' => l.tasteTraitSweetness,
  'oak' => l.tasteTraitOak,
  'intensity' => l.tasteTraitIntensity,
  _ => axis,
};

/// Translates a normalized 0..1 axis value into the human descriptor
/// that taste_traits surfaces to the user. Buckets match the existing
/// in-app copy 1:1 — keep these in sync if either ever moves.
String traitDescriptor(String axis, double v, AppLocalizations l) =>
    switch (axis) {
      'body' => v < 0.4
          ? l.tasteTraitBodyLow
          : v < 0.65
          ? l.tasteTraitBodyMid
          : l.tasteTraitBodyHigh,
      'tannin' => v < 0.4
          ? l.tasteTraitTanninLow
          : v < 0.65
          ? l.tasteTraitTanninMid
          : l.tasteTraitTanninHigh,
      'acidity' => v < 0.4
          ? l.tasteTraitAcidityLow
          : v < 0.65
          ? l.tasteTraitAcidityMid
          : l.tasteTraitAcidityHigh,
      'sweetness' => v < 0.15
          ? l.tasteTraitSweetnessLow
          : v < 0.4
          ? l.tasteTraitSweetnessMid
          : l.tasteTraitSweetnessHigh,
      'oak' => v < 0.3
          ? l.tasteTraitOakLow
          : v < 0.55
          ? l.tasteTraitOakMid
          : l.tasteTraitOakHigh,
      'intensity' => v < 0.4
          ? l.tasteTraitIntensityLow
          : v < 0.7
          ? l.tasteTraitIntensityMid
          : l.tasteTraitIntensityHigh,
      _ => '',
    };

/// Returns the user's axes ranked by distance from neutral (0.5),
/// most-opinionated first. The top entries are what makes someone's
/// taste actually distinctive — they're the right candidates for any
/// "what defines me" callout.
List<(String, double)> rankedTraits(UserStyleDna? dna) {
  final entries = _kAxes
      .map((k) => (k, (dna?.values[k] ?? 0.5).clamp(0.0, 1.0)))
      .toList();
  entries.sort((a, b) {
    final da = (a.$2 - 0.5).abs();
    final db = (b.$2 - 0.5).abs();
    return db.compareTo(da);
  });
  return entries;
}

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

const _kLabels = {
  'body': 'Body',
  'tannin': 'Tannin',
  'acidity': 'Acidity',
  'sweetness': 'Sweetness',
  'oak': 'Oak',
  'intensity': 'Intensity',
};

String traitLabel(String axis) => _kLabels[axis] ?? axis;

/// Translates a normalized 0..1 axis value into the human descriptor
/// that taste_traits surfaces to the user. Buckets match the existing
/// in-app copy 1:1 — keep these in sync if either ever moves.
String traitDescriptor(String axis, double v) => switch (axis) {
  'body' =>
    v < 0.4
        ? 'Light, easy-drinking'
        : v < 0.65
        ? 'Balanced'
        : 'Bold, full-bodied',
  'tannin' =>
    v < 0.4
        ? 'Soft, low-grip'
        : v < 0.65
        ? 'Medium grip'
        : 'Grippy, structured',
  'acidity' =>
    v < 0.4
        ? 'Soft, round'
        : v < 0.65
        ? 'Balanced'
        : 'Crisp, bright',
  'sweetness' =>
    v < 0.15
        ? 'Bone dry'
        : v < 0.4
        ? 'Off-dry'
        : 'Sweet-leaning',
  'oak' =>
    v < 0.3
        ? 'Unoaked, fresh'
        : v < 0.55
        ? 'Touch of oak'
        : 'Oak-forward',
  'intensity' =>
    v < 0.4
        ? 'Subtle aromatics'
        : v < 0.7
        ? 'Expressive'
        : 'Bold, aromatic',
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

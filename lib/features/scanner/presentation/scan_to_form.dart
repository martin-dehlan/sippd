import '../../wines/domain/entities/wine.entity.dart';
import '../../wines/presentation/widgets/wine_form.widget.dart';
import '../domain/entities/scan_result.entity.dart';

/// Maps a recognized label into the add-wine form's prefill payload.
/// Every field is editable downstream — recognition is never trusted
/// blind. Grape resolution (canonical id vs free-text) and wine type
/// are decided by the caller (which has ref access for the canonical
/// grape lookup) and passed in.
WineFormData scanToFormData(
  ScanResultEntity r, {
  String? canonicalGrapeId,
  String? grapeDisplay,
  WineType type = WineType.red,
}) {
  final grape = grapeDisplay ?? (r.grapes.isNotEmpty ? r.grapes.first : null);
  // Aroma descriptors live under tasting notes (no standalone field) —
  // fold FastCork's aroma into the notes prefill.
  final notesParts = <String>[
    if (r.tastingNotes != null && r.tastingNotes!.trim().isNotEmpty)
      r.tastingNotes!.trim(),
    if (r.aroma != null && r.aroma!.trim().isNotEmpty) r.aroma!.trim(),
  ];
  return WineFormData(
    name: r.displayName ?? '',
    rating: 5.0,
    type: type,
    vintage: r.vintage,
    grape: grape,
    canonicalGrapeId: canonicalGrapeId,
    grapeFreetext: canonicalGrapeId == null ? grape : null,
    winery: r.producer,
    country: r.country,
    region: r.region ?? r.appellation,
    notes: notesParts.isEmpty ? null : notesParts.join('\n'),
    servingTempC: r.servingTempC,
    decantMinutes: r.decantMinutes,
    abv: r.abv,
  );
}

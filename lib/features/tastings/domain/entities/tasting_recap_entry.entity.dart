import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasting_recap_entry.entity.freezed.dart';

/// One submitted rating in a tasting, joined with the rater's profile.
/// Multiple entries per wine, multiple per user — the recap section
/// groups them by canonical_wine_id to render the per-wine breakdown.
@freezed
class TastingRecapEntry with _$TastingRecapEntry {
  const factory TastingRecapEntry({
    required String userId,
    required String canonicalWineId,
    required double rating,
    String? displayName,
    String? username,
    String? avatarUrl,
  }) = _TastingRecapEntry;
}

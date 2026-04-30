import 'package:freezed_annotation/freezed_annotation.dart';

part 'canonical_merge_pair.entity.freezed.dart';

/// One row from find_canonical_merge_candidates(). Wines that look
/// similar enough to be the same identity but live as separate
/// canonical_wine rows. The user picks which side to keep when
/// confirming the merge.
@freezed
class CanonicalMergePair with _$CanonicalMergePair {
  const factory CanonicalMergePair({
    required String loserId,
    required String winnerId,
    required String loserName,
    required String winnerName,
    String? loserWinery,
    String? winnerWinery,
    int? loserVintage,
    int? winnerVintage,
    required double similarity,
  }) = _CanonicalMergePair;
}

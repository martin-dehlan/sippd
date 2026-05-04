import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/taste_match.entity.dart';

part 'taste_match.model.freezed.dart';
part 'taste_match.model.g.dart';

@freezed
class TasteMatchModel with _$TasteMatchModel {
  const factory TasteMatchModel({
    int? score,
    String? confidence,
    @JsonKey(name: 'overlap_count') @Default(0) int overlapCount,
    @JsonKey(name: 'my_total') @Default(0) int myTotal,
    @JsonKey(name: 'their_total') @Default(0) int theirTotal,
    String? reason,
    @JsonKey(name: 'bucket_score') int? bucketScore,
    @JsonKey(name: 'dna_score') int? dnaScore,
    @JsonKey(name: 'same_canonical_pairs') @Default(0) int sameCanonicalPairs,
    @JsonKey(name: 'agree_pairs') @Default(0) int agreePairs,
    @JsonKey(name: 'disagree_pairs') @Default(0) int disagreePairs,
  }) = _TasteMatchModel;

  factory TasteMatchModel.fromJson(Map<String, dynamic> json) =>
      _$TasteMatchModelFromJson(json);
}

extension TasteMatchModelX on TasteMatchModel {
  TasteMatchEntity toEntity() => TasteMatchEntity(
        score: score,
        confidence: _confidenceFromString(confidence),
        overlapCount: overlapCount,
        myTotal: myTotal,
        theirTotal: theirTotal,
        reason: _reasonFromString(reason),
        bucketScore: bucketScore,
        dnaScore: dnaScore,
        sameCanonicalPairs: sameCanonicalPairs,
        agreePairs: agreePairs,
        disagreePairs: disagreePairs,
      );
}

MatchConfidence? _confidenceFromString(String? raw) {
  switch (raw) {
    case 'low':
      return MatchConfidence.low;
    case 'medium':
      return MatchConfidence.medium;
    case 'high':
      return MatchConfidence.high;
    default:
      return null;
  }
}

MatchUnavailableReason? _reasonFromString(String? raw) {
  switch (raw) {
    case 'unavailable':
      return MatchUnavailableReason.unavailable;
    case 'not_enough_ratings':
      return MatchUnavailableReason.notEnoughRatings;
    case 'not_enough_overlap':
      return MatchUnavailableReason.notEnoughOverlap;
    default:
      return null;
  }
}

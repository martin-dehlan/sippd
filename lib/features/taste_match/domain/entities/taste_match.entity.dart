import 'package:freezed_annotation/freezed_annotation.dart';

part 'taste_match.entity.freezed.dart';

enum MatchConfidence { low, medium, high }

enum MatchUnavailableReason {
  unavailable,
  notEnoughRatings,
  notEnoughOverlap,
}

@freezed
class TasteMatchEntity with _$TasteMatchEntity {
  const factory TasteMatchEntity({
    int? score,
    MatchConfidence? confidence,
    @Default(0) int overlapCount,
    @Default(0) int myTotal,
    @Default(0) int theirTotal,
    MatchUnavailableReason? reason,
    int? bucketScore,
    int? dnaScore,
    @Default(0) int sameCanonicalPairs,
    @Default(0) int agreePairs,
    @Default(0) int disagreePairs,
  }) = _TasteMatchEntity;

  const TasteMatchEntity._();

  bool get hasScore => score != null && confidence != null;
  bool get hasDna => dnaScore != null;
}

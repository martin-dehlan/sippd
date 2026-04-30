import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_style_dna.entity.freezed.dart';

/// User's six-axis WSET-aligned Style DNA. Values are 0..1; tannin
/// can be null when the user has rated no reds. attributedCount is
/// the number of rated wines whose grape archetype was joinable
/// (i.e. fed into the aggregation). Confidence is clamped to 1 once
/// attributedCount reaches 20.
@freezed
class UserStyleDna with _$UserStyleDna {
  const factory UserStyleDna({
    required Map<String, double> values,
    required int attributedCount,
    required double confidence,
  }) = _UserStyleDna;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_summary.model.freezed.dart';
part 'rating_summary.model.g.dart';

/// Payload of the `get_user_rating_summary` RPC. Headline avg + counts +
/// type/month/region/country breakdowns, all already deduped server-side
/// (latest-wins per canonical_wine_id across personal/group/tasting).
@freezed
class RatingSummaryModel with _$RatingSummaryModel {
  const factory RatingSummaryModel({
    @JsonKey(name: 'distinct_wine_count') @Default(0) int distinctWineCount,
    @JsonKey(name: 'avg_rating', fromJson: _nullableDouble) double? avgRating,
    @JsonKey(name: 'personal_count') @Default(0) int personalCount,
    @JsonKey(name: 'group_count') @Default(0) int groupCount,
    @JsonKey(name: 'tasting_count') @Default(0) int tastingCount,
    @JsonKey(name: 'by_type') @Default([]) List<RatingTypeBucketModel> byType,
    @JsonKey(name: 'by_month')
    @Default([])
    List<RatingMonthBucketModel> byMonth,
    @JsonKey(name: 'by_country')
    @Default([])
    List<RatingRegionBucketModel> byCountry,
    @JsonKey(name: 'by_region')
    @Default([])
    List<RatingRegionBucketModel> byRegion,
  }) = _RatingSummaryModel;

  factory RatingSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$RatingSummaryModelFromJson(json);

  factory RatingSummaryModel.empty() => const RatingSummaryModel();
}

@freezed
class RatingTypeBucketModel with _$RatingTypeBucketModel {
  const factory RatingTypeBucketModel({
    required String type,
    required int count,
    @JsonKey(fromJson: _toDouble) required double avg,
  }) = _RatingTypeBucketModel;

  factory RatingTypeBucketModel.fromJson(Map<String, dynamic> json) =>
      _$RatingTypeBucketModelFromJson(json);
}

@freezed
class RatingMonthBucketModel with _$RatingMonthBucketModel {
  const factory RatingMonthBucketModel({
    required String month,
    required int count,
    @JsonKey(fromJson: _toDouble) required double avg,
  }) = _RatingMonthBucketModel;

  factory RatingMonthBucketModel.fromJson(Map<String, dynamic> json) =>
      _$RatingMonthBucketModelFromJson(json);
}

@freezed
class RatingRegionBucketModel with _$RatingRegionBucketModel {
  const factory RatingRegionBucketModel({
    String? region,
    String? country,
    required int count,
    @JsonKey(fromJson: _toDouble) required double avg,
  }) = _RatingRegionBucketModel;

  factory RatingRegionBucketModel.fromJson(Map<String, dynamic> json) =>
      _$RatingRegionBucketModelFromJson(json);
}

// PG `round(numeric, 2)` round-trips as either int (8) or double (8.5)
// depending on whether the value happens to be whole — coerce explicitly.
double _toDouble(Object? v) => v is num ? v.toDouble() : 0.0;
double? _nullableDouble(Object? v) => v is num ? v.toDouble() : null;

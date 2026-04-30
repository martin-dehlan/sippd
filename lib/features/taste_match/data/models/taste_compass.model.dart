import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/taste_compass.entity.dart';

part 'taste_compass.model.freezed.dart';
part 'taste_compass.model.g.dart';

@freezed
class CompassBucketModel with _$CompassBucketModel {
  const factory CompassBucketModel({
    @JsonKey(name: 'region') String? region,
    @JsonKey(name: 'country') String? country,
    @JsonKey(name: 'type') String? type,
    required int count,
    @JsonKey(name: 'avg_rating') required double avgRating,
  }) = _CompassBucketModel;

  factory CompassBucketModel.fromJson(Map<String, dynamic> json) =>
      _$CompassBucketModelFromJson(json);
}

extension CompassBucketModelX on CompassBucketModel {
  CompassBucket toEntity() => CompassBucket(
        label: region ?? country ?? type ?? '',
        count: count,
        avgRating: avgRating,
      );
}

@freezed
class TasteCompassModel with _$TasteCompassModel {
  const factory TasteCompassModel({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'overall_avg') double? overallAvg,
    @JsonKey(name: 'top_regions')
    @Default([])
    List<CompassBucketModel> topRegions,
    @JsonKey(name: 'top_countries')
    @Default([])
    List<CompassBucketModel> topCountries,
    @JsonKey(name: 'type_breakdown')
    @Default([])
    List<CompassBucketModel> typeBreakdown,
  }) = _TasteCompassModel;

  factory TasteCompassModel.fromJson(Map<String, dynamic> json) =>
      _$TasteCompassModelFromJson(json);
}

extension TasteCompassModelX on TasteCompassModel {
  TasteCompassEntity toEntity() => TasteCompassEntity(
        totalCount: totalCount,
        overallAvg: overallAvg,
        topRegions: topRegions.map((b) => b.toEntity()).toList(),
        topCountries: topCountries.map((b) => b.toEntity()).toList(),
        typeBreakdown: typeBreakdown.map((b) => b.toEntity()).toList(),
      );
}

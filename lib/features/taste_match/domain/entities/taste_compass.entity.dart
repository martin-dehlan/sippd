import 'package:freezed_annotation/freezed_annotation.dart';

part 'taste_compass.entity.freezed.dart';

@freezed
class CompassBucket with _$CompassBucket {
  const factory CompassBucket({
    required String label,
    required int count,
    required double avgRating,
  }) = _CompassBucket;
}

@freezed
class TasteCompassEntity with _$TasteCompassEntity {
  const factory TasteCompassEntity({
    required int totalCount,
    double? overallAvg,
    @Default([]) List<CompassBucket> topRegions,
    @Default([]) List<CompassBucket> topCountries,
    @Default([]) List<CompassBucket> typeBreakdown,
  }) = _TasteCompassEntity;

  const TasteCompassEntity._();

  bool get isEmpty => totalCount == 0;
  bool get hasMinimumData => totalCount >= 5;
}

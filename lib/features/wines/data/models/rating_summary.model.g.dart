// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_summary.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RatingSummaryModelImpl _$$RatingSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$RatingSummaryModelImpl(
  distinctWineCount: (json['distinct_wine_count'] as num?)?.toInt() ?? 0,
  avgRating: _nullableDouble(json['avg_rating']),
  personalCount: (json['personal_count'] as num?)?.toInt() ?? 0,
  groupCount: (json['group_count'] as num?)?.toInt() ?? 0,
  tastingCount: (json['tasting_count'] as num?)?.toInt() ?? 0,
  byType:
      (json['by_type'] as List<dynamic>?)
          ?.map(
            (e) => RatingTypeBucketModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  byMonth:
      (json['by_month'] as List<dynamic>?)
          ?.map(
            (e) => RatingMonthBucketModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  byCountry:
      (json['by_country'] as List<dynamic>?)
          ?.map(
            (e) => RatingRegionBucketModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  byRegion:
      (json['by_region'] as List<dynamic>?)
          ?.map(
            (e) => RatingRegionBucketModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$RatingSummaryModelImplToJson(
  _$RatingSummaryModelImpl instance,
) => <String, dynamic>{
  'distinct_wine_count': instance.distinctWineCount,
  'avg_rating': instance.avgRating,
  'personal_count': instance.personalCount,
  'group_count': instance.groupCount,
  'tasting_count': instance.tastingCount,
  'by_type': instance.byType,
  'by_month': instance.byMonth,
  'by_country': instance.byCountry,
  'by_region': instance.byRegion,
};

_$RatingTypeBucketModelImpl _$$RatingTypeBucketModelImplFromJson(
  Map<String, dynamic> json,
) => _$RatingTypeBucketModelImpl(
  type: json['type'] as String,
  count: (json['count'] as num).toInt(),
  avg: _toDouble(json['avg']),
);

Map<String, dynamic> _$$RatingTypeBucketModelImplToJson(
  _$RatingTypeBucketModelImpl instance,
) => <String, dynamic>{
  'type': instance.type,
  'count': instance.count,
  'avg': instance.avg,
};

_$RatingMonthBucketModelImpl _$$RatingMonthBucketModelImplFromJson(
  Map<String, dynamic> json,
) => _$RatingMonthBucketModelImpl(
  month: json['month'] as String,
  count: (json['count'] as num).toInt(),
  avg: _toDouble(json['avg']),
);

Map<String, dynamic> _$$RatingMonthBucketModelImplToJson(
  _$RatingMonthBucketModelImpl instance,
) => <String, dynamic>{
  'month': instance.month,
  'count': instance.count,
  'avg': instance.avg,
};

_$RatingRegionBucketModelImpl _$$RatingRegionBucketModelImplFromJson(
  Map<String, dynamic> json,
) => _$RatingRegionBucketModelImpl(
  region: json['region'] as String?,
  country: json['country'] as String?,
  count: (json['count'] as num).toInt(),
  avg: _toDouble(json['avg']),
);

Map<String, dynamic> _$$RatingRegionBucketModelImplToJson(
  _$RatingRegionBucketModelImpl instance,
) => <String, dynamic>{
  'region': instance.region,
  'country': instance.country,
  'count': instance.count,
  'avg': instance.avg,
};

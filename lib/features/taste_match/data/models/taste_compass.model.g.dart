// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taste_compass.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompassBucketModelImpl _$$CompassBucketModelImplFromJson(
  Map<String, dynamic> json,
) => _$CompassBucketModelImpl(
  region: json['region'] as String?,
  country: json['country'] as String?,
  type: json['type'] as String?,
  count: (json['count'] as num).toInt(),
  avgRating: (json['avg_rating'] as num).toDouble(),
);

Map<String, dynamic> _$$CompassBucketModelImplToJson(
  _$CompassBucketModelImpl instance,
) => <String, dynamic>{
  'region': instance.region,
  'country': instance.country,
  'type': instance.type,
  'count': instance.count,
  'avg_rating': instance.avgRating,
};

_$TasteCompassModelImpl _$$TasteCompassModelImplFromJson(
  Map<String, dynamic> json,
) => _$TasteCompassModelImpl(
  totalCount: (json['total_count'] as num).toInt(),
  overallAvg: (json['overall_avg'] as num?)?.toDouble(),
  topRegions:
      (json['top_regions'] as List<dynamic>?)
          ?.map((e) => CompassBucketModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  topCountries:
      (json['top_countries'] as List<dynamic>?)
          ?.map((e) => CompassBucketModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  typeBreakdown:
      (json['type_breakdown'] as List<dynamic>?)
          ?.map((e) => CompassBucketModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TasteCompassModelImplToJson(
  _$TasteCompassModelImpl instance,
) => <String, dynamic>{
  'total_count': instance.totalCount,
  'overall_avg': instance.overallAvg,
  'top_regions': instance.topRegions,
  'top_countries': instance.topCountries,
  'type_breakdown': instance.typeBreakdown,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_bottle.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SharedBottleModelImpl _$$SharedBottleModelImplFromJson(
  Map<String, dynamic> json,
) => _$SharedBottleModelImpl(
  groupId: json['group_id'] as String,
  wineId: json['wine_id'] as String,
  wineName: json['wine_name'] as String,
  winery: json['winery'] as String?,
  region: json['region'] as String?,
  country: json['country'] as String?,
  type: json['type'] as String,
  vintage: (json['vintage'] as num?)?.toInt(),
  myRating: (json['my_rating'] as num).toDouble(),
  theirRating: (json['their_rating'] as num).toDouble(),
  delta: (json['delta'] as num).toDouble(),
  ratedAt: json['rated_at'] == null
      ? null
      : DateTime.parse(json['rated_at'] as String),
);

Map<String, dynamic> _$$SharedBottleModelImplToJson(
  _$SharedBottleModelImpl instance,
) => <String, dynamic>{
  'group_id': instance.groupId,
  'wine_id': instance.wineId,
  'wine_name': instance.wineName,
  'winery': instance.winery,
  'region': instance.region,
  'country': instance.country,
  'type': instance.type,
  'vintage': instance.vintage,
  'my_rating': instance.myRating,
  'their_rating': instance.theirRating,
  'delta': instance.delta,
  'rated_at': instance.ratedAt?.toIso8601String(),
};

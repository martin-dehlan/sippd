// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_wine_rating.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupWineRatingModelImpl _$$GroupWineRatingModelImplFromJson(
  Map<String, dynamic> json,
) => _$GroupWineRatingModelImpl(
  groupId: json['group_id'] as String,
  wineId: json['wine_id'] as String,
  userId: json['user_id'] as String,
  rating: (json['rating'] as num).toDouble(),
  notes: json['notes'] as String?,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$GroupWineRatingModelImplToJson(
  _$GroupWineRatingModelImpl instance,
) => <String, dynamic>{
  'group_id': instance.groupId,
  'wine_id': instance.wineId,
  'user_id': instance.userId,
  'rating': instance.rating,
  'notes': instance.notes,
  'updated_at': instance.updatedAt.toIso8601String(),
};

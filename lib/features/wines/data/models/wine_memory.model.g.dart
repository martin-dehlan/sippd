// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_memory.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WineMemoryModelImpl _$$WineMemoryModelImplFromJson(
  Map<String, dynamic> json,
) => _$WineMemoryModelImpl(
  id: json['id'] as String,
  wineId: json['wine_id'] as String,
  userId: json['user_id'] as String,
  imageUrl: json['image_url'] as String?,
  localImagePath: json['local_image_path'] as String?,
  caption: json['caption'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  occurredAt: json['occurred_at'] == null
      ? null
      : DateTime.parse(json['occurred_at'] as String),
  occasion: json['occasion'] as String?,
  placeName: json['place_name'] as String?,
  placeLat: (json['place_lat'] as num?)?.toDouble(),
  placeLng: (json['place_lng'] as num?)?.toDouble(),
  foodPaired: json['food_paired'] as String?,
  companionUserIds:
      (json['companion_user_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  note: json['note'] as String?,
  visibility: json['visibility'] as String? ?? 'friends',
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$WineMemoryModelImplToJson(
  _$WineMemoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'wine_id': instance.wineId,
  'user_id': instance.userId,
  'image_url': instance.imageUrl,
  'local_image_path': instance.localImagePath,
  'caption': instance.caption,
  'created_at': instance.createdAt.toIso8601String(),
  'occurred_at': instance.occurredAt?.toIso8601String(),
  'occasion': instance.occasion,
  'place_name': instance.placeName,
  'place_lat': instance.placeLat,
  'place_lng': instance.placeLng,
  'food_paired': instance.foodPaired,
  'companion_user_ids': instance.companionUserIds,
  'note': instance.note,
  'visibility': instance.visibility,
  'updated_at': instance.updatedAt?.toIso8601String(),
};

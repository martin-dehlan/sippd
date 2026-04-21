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
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$WineMemoryModelImplToJson(
  _$WineMemoryModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'wine_id': instance.wineId,
  'user_id': instance.userId,
  'image_url': instance.imageUrl,
  'local_image_path': instance.localImagePath,
  'created_at': instance.createdAt.toIso8601String(),
};

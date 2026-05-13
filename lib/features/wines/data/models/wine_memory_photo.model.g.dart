// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_memory_photo.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WineMemoryPhotoModelImpl _$$WineMemoryPhotoModelImplFromJson(
  Map<String, dynamic> json,
) => _$WineMemoryPhotoModelImpl(
  id: json['id'] as String,
  memoryId: json['memory_id'] as String,
  storagePath: json['storage_path'] as String,
  position: (json['position'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$WineMemoryPhotoModelImplToJson(
  _$WineMemoryPhotoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'memory_id': instance.memoryId,
  'storage_path': instance.storagePath,
  'position': instance.position,
  'created_at': instance.createdAt.toIso8601String(),
};

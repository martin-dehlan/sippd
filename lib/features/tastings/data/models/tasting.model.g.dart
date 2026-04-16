// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasting.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TastingModelImpl _$$TastingModelImplFromJson(Map<String, dynamic> json) =>
    _$TastingModelImpl(
      id: json['id'] as String,
      groupId: json['group_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      scheduledAt: DateTime.parse(json['scheduled_at'] as String),
      createdBy: json['created_by'] as String,
      isBlind: json['is_blind'] as bool? ?? false,
      isRevealed: json['is_revealed'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$TastingModelImplToJson(_$TastingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'title': instance.title,
      'description': instance.description,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'scheduled_at': instance.scheduledAt.toIso8601String(),
      'created_by': instance.createdBy,
      'is_blind': instance.isBlind,
      'is_revealed': instance.isRevealed,
      'created_at': instance.createdAt.toIso8601String(),
    };

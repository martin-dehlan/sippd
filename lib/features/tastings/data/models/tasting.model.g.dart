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
      state: json['state'] as String? ?? 'upcoming',
      lineupMode: json['lineup_mode'] as String? ?? 'planned',
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] == null
          ? null
          : DateTime.parse(json['ended_at'] as String),
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
      'state': instance.state,
      'lineup_mode': instance.lineupMode,
      'started_at': instance.startedAt?.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

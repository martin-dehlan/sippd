// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BadgeModelImpl _$$BadgeModelImplFromJson(Map<String, dynamic> json) =>
    _$BadgeModelImpl(
      badgeId: json['badge_id'] as String,
      category: json['category'] as String,
      tier: (json['tier'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      earned: json['earned'] as bool? ?? false,
      earnedAt: json['earned_at'] == null
          ? null
          : DateTime.parse(json['earned_at'] as String),
      current: (json['current'] as num?)?.toInt() ?? 0,
      target: (json['target'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$BadgeModelImplToJson(_$BadgeModelImpl instance) =>
    <String, dynamic>{
      'badge_id': instance.badgeId,
      'category': instance.category,
      'tier': instance.tier,
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
      'earned': instance.earned,
      'earned_at': instance.earnedAt?.toIso8601String(),
      'current': instance.current,
      'target': instance.target,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_prefs.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationPrefsModelImpl _$$NotificationPrefsModelImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationPrefsModelImpl(
  userId: json['user_id'] as String,
  tastingReminders: json['tasting_reminders'] as bool,
  tastingReminderHours: (json['tasting_reminder_hours'] as num).toInt(),
  friendActivity: json['friend_activity'] as bool,
  groupActivity: json['group_activity'] as bool,
  groupWineShared: json['group_wine_shared'] as bool,
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$$NotificationPrefsModelImplToJson(
  _$NotificationPrefsModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'tasting_reminders': instance.tastingReminders,
  'tasting_reminder_hours': instance.tastingReminderHours,
  'friend_activity': instance.friendActivity,
  'group_activity': instance.groupActivity,
  'group_wine_shared': instance.groupWineShared,
  'updated_at': instance.updatedAt.toIso8601String(),
};

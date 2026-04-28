import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_prefs.entity.freezed.dart';

@freezed
class NotificationPrefsEntity with _$NotificationPrefsEntity {
  const factory NotificationPrefsEntity({
    required String userId,
    required bool tastingReminders,
    required int tastingReminderHours,
    required bool friendActivity,
    required bool groupActivity,
    required bool groupWineShared,
    required DateTime updatedAt,
  }) = _NotificationPrefsEntity;

  factory NotificationPrefsEntity.defaults(String userId) =>
      NotificationPrefsEntity(
        userId: userId,
        tastingReminders: true,
        tastingReminderHours: 1,
        friendActivity: true,
        groupActivity: true,
        groupWineShared: true,
        updatedAt: DateTime.now(),
      );
}

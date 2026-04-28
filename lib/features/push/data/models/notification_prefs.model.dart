import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/database/database.dart';
import '../../domain/entities/notification_prefs.entity.dart';

part 'notification_prefs.model.freezed.dart';
part 'notification_prefs.model.g.dart';

@freezed
class NotificationPrefsModel with _$NotificationPrefsModel {
  const factory NotificationPrefsModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'tasting_reminders') required bool tastingReminders,
    @JsonKey(name: 'tasting_reminder_hours')
    required int tastingReminderHours,
    @JsonKey(name: 'friend_activity') required bool friendActivity,
    @JsonKey(name: 'group_activity') required bool groupActivity,
    @JsonKey(name: 'group_wine_shared') required bool groupWineShared,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _NotificationPrefsModel;

  factory NotificationPrefsModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPrefsModelFromJson(json);
}

extension NotificationPrefsModelX on NotificationPrefsModel {
  NotificationPrefsEntity toEntity() => NotificationPrefsEntity(
    userId: userId,
    tastingReminders: tastingReminders,
    tastingReminderHours: tastingReminderHours,
    friendActivity: friendActivity,
    groupActivity: groupActivity,
    groupWineShared: groupWineShared,
    updatedAt: updatedAt,
  );
}

extension NotificationPrefsEntityX on NotificationPrefsEntity {
  NotificationPrefsModel toModel() => NotificationPrefsModel(
    userId: userId,
    tastingReminders: tastingReminders,
    tastingReminderHours: tastingReminderHours,
    friendActivity: friendActivity,
    groupActivity: groupActivity,
    groupWineShared: groupWineShared,
    updatedAt: updatedAt,
  );

  NotificationPrefsTableData toTableData() => NotificationPrefsTableData(
    userId: userId,
    tastingReminders: tastingReminders,
    tastingReminderHours: tastingReminderHours,
    friendActivity: friendActivity,
    groupActivity: groupActivity,
    groupWineShared: groupWineShared,
    updatedAt: updatedAt,
  );
}

extension NotificationPrefsTableDataX on NotificationPrefsTableData {
  NotificationPrefsEntity toEntity() => NotificationPrefsEntity(
    userId: userId,
    tastingReminders: tastingReminders,
    tastingReminderHours: tastingReminderHours,
    friendActivity: friendActivity,
    groupActivity: groupActivity,
    groupWineShared: groupWineShared,
    updatedAt: updatedAt,
  );
}

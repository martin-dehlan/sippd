import '../entities/notification_prefs.entity.dart';

abstract class NotificationPrefsRepository {
  Stream<NotificationPrefsEntity> watchPrefs(String userId);
  Future<NotificationPrefsEntity> getPrefs(String userId);
  Future<void> updatePrefs(NotificationPrefsEntity prefs);
}

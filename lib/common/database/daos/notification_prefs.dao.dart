import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/notification_prefs.table.dart';

part 'notification_prefs.dao.g.dart';

@DriftAccessor(tables: [NotificationPrefsTable])
class NotificationPrefsDao extends DatabaseAccessor<AppDatabase>
    with _$NotificationPrefsDaoMixin {
  NotificationPrefsDao(super.db);

  Future<NotificationPrefsTableData?> getByUser(String userId) {
    return (select(notificationPrefsTable)
          ..where((p) => p.userId.equals(userId)))
        .getSingleOrNull();
  }

  Stream<NotificationPrefsTableData?> watchByUser(String userId) {
    return (select(notificationPrefsTable)
          ..where((p) => p.userId.equals(userId)))
        .watchSingleOrNull();
  }

  Future<void> upsert(NotificationPrefsTableData data) {
    return into(notificationPrefsTable).insertOnConflictUpdate(data);
  }
}

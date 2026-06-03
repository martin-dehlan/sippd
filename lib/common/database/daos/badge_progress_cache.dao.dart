import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/badge_progress_cache.table.dart';

part 'badge_progress_cache.dao.g.dart';

@DriftAccessor(tables: [BadgeProgressCacheTable])
class BadgeProgressCacheDao extends DatabaseAccessor<AppDatabase>
    with _$BadgeProgressCacheDaoMixin {
  BadgeProgressCacheDao(super.db);

  Future<BadgeProgressCacheData?> getByUser(String userId) {
    return (select(
      badgeProgressCacheTable,
    )..where((t) => t.userId.equals(userId))).getSingleOrNull();
  }

  Future<void> upsert(String userId, String payload, DateTime fetchedAt) {
    return into(badgeProgressCacheTable).insertOnConflictUpdate(
      BadgeProgressCacheData(
        userId: userId,
        payload: payload,
        fetchedAt: fetchedAt,
      ),
    );
  }
}

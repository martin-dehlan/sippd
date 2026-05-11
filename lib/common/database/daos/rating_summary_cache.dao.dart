import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/rating_summary_cache.table.dart';

part 'rating_summary_cache.dao.g.dart';

@DriftAccessor(tables: [RatingSummaryCacheTable])
class RatingSummaryCacheDao extends DatabaseAccessor<AppDatabase>
    with _$RatingSummaryCacheDaoMixin {
  RatingSummaryCacheDao(super.db);

  Future<RatingSummaryCacheData?> getByUser(String userId) {
    return (select(ratingSummaryCacheTable)
          ..where((t) => t.userId.equals(userId)))
        .getSingleOrNull();
  }

  Future<void> upsert(String userId, String payload, DateTime fetchedAt) {
    return into(ratingSummaryCacheTable).insertOnConflictUpdate(
      RatingSummaryCacheData(
        userId: userId,
        payload: payload,
        fetchedAt: fetchedAt,
      ),
    );
  }
}

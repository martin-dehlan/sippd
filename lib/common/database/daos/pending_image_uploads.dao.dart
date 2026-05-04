import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/pending_image_uploads.table.dart';

part 'pending_image_uploads.dao.g.dart';

@DriftAccessor(tables: [PendingImageUploadsTable])
class PendingImageUploadsDao extends DatabaseAccessor<AppDatabase>
    with _$PendingImageUploadsDaoMixin {
  PendingImageUploadsDao(super.db);

  /// Bound on retries before we give up. Five retries with exponential
  /// backoff (starting at ~30s) covers a multi-hour offline window
  /// without burning battery.
  static const maxAttempts = 5;

  Future<List<PendingImageUploadData>> due(DateTime now) async {
    final rows = await select(pendingImageUploadsTable).get();
    return rows.where((r) {
      if (r.attempts >= maxAttempts) return false;
      if (r.lastErrorAt == null) return true;
      final waitSeconds = 30 * (1 << (r.attempts - 1).clamp(0, 6));
      return now.difference(r.lastErrorAt!).inSeconds >= waitSeconds;
    }).toList();
  }

  Future<void> enqueue(String wineId, String localPath) {
    return into(pendingImageUploadsTable).insertOnConflictUpdate(
      PendingImageUploadData(
        wineId: wineId,
        localPath: localPath,
        attempts: 0,
        lastErrorAt: null,
        queuedAt: DateTime.now(),
      ),
    );
  }

  Future<void> recordFailure(String wineId) {
    return customStatement(
      'UPDATE pending_image_uploads '
      'SET attempts = attempts + 1, last_error_at = ? '
      'WHERE wine_id = ?',
      [DateTime.now().toIso8601String(), wineId],
    );
  }

  Future<void> remove(String wineId) {
    return (delete(pendingImageUploadsTable)
          ..where((p) => p.wineId.equals(wineId)))
        .go();
  }
}

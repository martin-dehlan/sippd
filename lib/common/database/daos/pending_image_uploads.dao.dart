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
    final List<PendingImageUploadData> rows;
    try {
      rows = await select(pendingImageUploadsTable).get();
    } on FormatException {
      // Self-heal: a corrupt row (e.g. legacy v5 ISO-string in a
      // DateTime column) would otherwise soft-brick every flusher
      // pass. Cheaper to drop the queue than to leave the user with
      // permanently-stuck uploads. The v5→v6 schema migration
      // already handles the known-bad upgrade path; this catch
      // covers any future schema/serialization drift.
      await delete(pendingImageUploadsTable).go();
      return const [];
    }
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

  Future<void> recordFailure(String wineId) async {
    // Two-step instead of a raw UPDATE so Drift owns DateTime
    // serialization. The previous customStatement wrote an ISO string
    // into a column Drift reads back as an int → FormatException on
    // the next due() call.
    final row = await (select(pendingImageUploadsTable)
          ..where((p) => p.wineId.equals(wineId)))
        .getSingleOrNull();
    if (row == null) return;
    await (update(pendingImageUploadsTable)
          ..where((p) => p.wineId.equals(wineId)))
        .write(PendingImageUploadsTableCompanion(
      attempts: Value(row.attempts + 1),
      lastErrorAt: Value(DateTime.now()),
    ));
  }

  Future<void> remove(String wineId) {
    return (delete(pendingImageUploadsTable)
          ..where((p) => p.wineId.equals(wineId)))
        .go();
  }
}

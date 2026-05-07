import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/database/database.dart';

import '../../../helpers/fake_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = makeFakeDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  group('PendingImageUploadsDao', () {
    test('enqueue inserts a fresh row with attempts=0', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');

      final due = await db.pendingImageUploadsDao.due(DateTime(2026));
      expect(due, hasLength(1));
      expect(due.first.wineId, 'wine-1');
      expect(due.first.localPath, '/tmp/a.jpg');
      expect(due.first.attempts, 0);
      expect(due.first.lastErrorAt, isNull);
    });

    test('enqueue is upsert — same wineId replaces local path', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/old.jpg');
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/new.jpg');

      final due = await db.pendingImageUploadsDao.due(DateTime(2026));
      expect(due, hasLength(1));
      expect(due.first.localPath, '/tmp/new.jpg');
    });

    test('recordFailure increments attempts and stamps lastErrorAt', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');

      await db.pendingImageUploadsDao.recordFailure('wine-1');
      var due = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(hours: 1)),
      );
      expect(due, hasLength(1));
      expect(due.first.attempts, 1);
      expect(due.first.lastErrorAt, isNotNull);

      await db.pendingImageUploadsDao.recordFailure('wine-1');
      due = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(hours: 1)),
      );
      expect(due.first.attempts, 2);
    });

    test('due respects exponential backoff window', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');
      await db.pendingImageUploadsDao.recordFailure('wine-1');

      // Just after the failure → not due yet (30s window for attempt 1).
      final tooSoon = await db.pendingImageUploadsDao.due(DateTime.now());
      expect(
        tooSoon,
        isEmpty,
        reason: 'first attempt should wait 30s before retry',
      );

      // Past the 30s window → due again.
      final later = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(seconds: 31)),
      );
      expect(later, hasLength(1));
    });

    test('due drops rows past maxAttempts', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');
      for (var i = 0; i < 5; i++) {
        await db.pendingImageUploadsDao.recordFailure('wine-1');
      }

      // Even with all the time in the world, a row that hit
      // maxAttempts must not be retried again.
      final due = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(days: 365)),
      );
      expect(due, isEmpty);
    });

    test('remove deletes the row', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');
      await db.pendingImageUploadsDao.remove('wine-1');

      final due = await db.pendingImageUploadsDao.due(DateTime(2026));
      expect(due, isEmpty);
    });

    test('multiple wines coexist independently', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');
      await db.pendingImageUploadsDao.enqueue('wine-2', '/tmp/b.jpg');
      await db.pendingImageUploadsDao.recordFailure('wine-1');

      final due = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(minutes: 5)),
      );
      expect(due.map((r) => r.wineId), containsAll(['wine-1', 'wine-2']));
    });

    test('due self-heals when a row has a corrupted DateTime '
        '(legacy v5 ISO-string)', () async {
      // Simulate the pre-fix corruption directly via raw SQL so we
      // exercise the defensive read path even though the migration
      // already cleared this on real upgrades.
      await db.customStatement(
        "INSERT INTO pending_image_uploads "
        "(wine_id, local_path, attempts, last_error_at, queued_at) "
        "VALUES (?, ?, 1, '2026-05-04T10:00:00.000', 0)",
        ['wine-broken', '/tmp/a.jpg'],
      );

      // Without self-heal this would throw FormatException and
      // soft-brick every future flush. With it, the table is wiped
      // and an empty list returned.
      final due = await db.pendingImageUploadsDao.due(DateTime(2099));
      expect(due, isEmpty);

      // Confirm the table is now empty (heal completed).
      final remaining = await db
          .customSelect('SELECT COUNT(*) as c FROM pending_image_uploads')
          .getSingle();
      expect(remaining.read<int>('c'), 0);
    });
  });
}

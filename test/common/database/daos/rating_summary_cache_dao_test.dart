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

  group('RatingSummaryCacheDao', () {
    test('returns null when no row cached', () async {
      final row = await db.ratingSummaryCacheDao.getByUser('user-1');
      expect(row, isNull);
    });

    test('upsert stores payload and fetchedAt', () async {
      final now = DateTime(2026, 5, 11, 12);
      await db.ratingSummaryCacheDao.upsert('user-1', '{"avg":8.4}', now);
      final row = await db.ratingSummaryCacheDao.getByUser('user-1');
      expect(row, isNotNull);
      expect(row!.payload, '{"avg":8.4}');
      expect(row.fetchedAt, now);
    });

    test('upsert overwrites previous row for same user (latest wins)', () async {
      await db.ratingSummaryCacheDao.upsert(
        'user-1',
        '{"avg":7.0}',
        DateTime(2026, 5, 10),
      );
      await db.ratingSummaryCacheDao.upsert(
        'user-1',
        '{"avg":8.4}',
        DateTime(2026, 5, 11),
      );
      final row = await db.ratingSummaryCacheDao.getByUser('user-1');
      expect(row!.payload, '{"avg":8.4}');
    });

    test('isolates by user_id', () async {
      await db.ratingSummaryCacheDao.upsert(
        'user-1',
        '{"avg":7.0}',
        DateTime(2026, 5, 10),
      );
      await db.ratingSummaryCacheDao.upsert(
        'user-2',
        '{"avg":9.0}',
        DateTime(2026, 5, 10),
      );
      final a = await db.ratingSummaryCacheDao.getByUser('user-1');
      final b = await db.ratingSummaryCacheDao.getByUser('user-2');
      expect(a!.payload, '{"avg":7.0}');
      expect(b!.payload, '{"avg":9.0}');
    });
  });
}

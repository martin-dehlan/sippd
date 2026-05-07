import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/database/database.dart';
import 'package:sippd/features/wines/data/models/wine.model.dart';
import 'package:sippd/features/wines/data/services/outbox_flusher.service.dart';

import '../../../../helpers/fake_database.dart';
import '../../../../helpers/mocks.dart';

void main() {
  setUpAll(registerTestFallbacks);

  late AppDatabase db;
  late MockWineImageService imageService;
  late MockWineSupabaseApi api;
  late MockAnalyticsService analytics;

  setUp(() {
    db = makeFakeDatabase();
    imageService = MockWineImageService();
    api = MockWineSupabaseApi();
    analytics = MockAnalyticsService();
  });

  tearDown(() async {
    await db.close();
  });

  OutboxFlusher buildFlusher({
    String? userId = 'user-1',
    MockWineImageService? svc,
    MockWineSupabaseApi? srv,
  }) {
    return OutboxFlusher(
      outbox: db.pendingImageUploadsDao,
      winesDao: db.winesDao,
      imageService: svc ?? imageService,
      api: srv ?? api,
      userId: userId,
      analytics: analytics,
    );
  }

  Future<void> seedWine(String id, {String? imageUrl}) async {
    await db.winesDao.insertWine(
      WineTableData(
        id: id,
        name: 'Pinot',
        rating: 8,
        type: 'red',
        currency: 'EUR',
        visibility: 'friends',
        userId: 'user-1',
        imageUrl: imageUrl,
        createdAt: DateTime(2026),
      ),
    );
  }

  group('OutboxFlusher.flush', () {
    test(
      'uploads, updates wine row, mirrors to Supabase, removes outbox',
      () async {
        await seedWine('wine-1');
        await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');

        when(
          () => imageService.uploadImage(
            userId: any(named: 'userId'),
            filePath: any(named: 'filePath'),
          ),
        ).thenAnswer((_) async => 'https://cdn/a.jpg');
        when(() => api.upsertWine(any())).thenAnswer((_) async {});

        await buildFlusher().flush();

        // Outbox drained.
        final remaining = await db.pendingImageUploadsDao.due(DateTime(2099));
        expect(remaining, isEmpty);

        // Local wine row carries the resolved URL.
        final updated = await db.winesDao.getWineById('wine-1');
        expect(updated?.imageUrl, 'https://cdn/a.jpg');

        // Supabase received the mirrored upsert with the URL.
        final captured = verify(() => api.upsertWine(captureAny())).captured;
        expect(captured, hasLength(1));
        expect((captured.single as WineModel).imageUrl, 'https://cdn/a.jpg');
      },
    );

    test('upload failure → recordFailure + analytics + row stays', () async {
      await seedWine('wine-1');
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');

      when(
        () => imageService.uploadImage(
          userId: any(named: 'userId'),
          filePath: any(named: 'filePath'),
        ),
      ).thenThrow(StateError('storage 500'));
      when(
        () => analytics.syncFailed(any(), error: any(named: 'error')),
      ).thenAnswer((_) async {});

      await buildFlusher().flush();

      // Outbox row still present, attempts incremented.
      final due = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(days: 1)),
      );
      expect(due, hasLength(1));
      expect(due.first.attempts, 1);

      // Wine row left untouched.
      final wine = await db.winesDao.getWineById('wine-1');
      expect(wine?.imageUrl, isNull);

      // Supabase NOT called (upload failed before reaching it).
      verifyNever(() => api.upsertWine(any()));

      // Telemetry captured the swallow.
      verify(
        () => analytics.syncFailed(
          'outbox_image_upload',
          error: any(named: 'error'),
        ),
      ).called(1);
    });

    test('no-op when imageService is null', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');
      final flusher = OutboxFlusher(
        outbox: db.pendingImageUploadsDao,
        winesDao: db.winesDao,
        imageService: null,
        api: api,
        userId: 'user-1',
        analytics: analytics,
      );

      await flusher.flush();

      verifyNever(() => api.upsertWine(any()));
      final due = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(days: 1)),
      );
      expect(due, hasLength(1), reason: 'untouched when service unavailable');
    });

    test('no-op when userId is null (signed-out)', () async {
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');
      final flusher = buildFlusher(userId: null);

      await flusher.flush();

      verifyNever(
        () => imageService.uploadImage(
          userId: any(named: 'userId'),
          filePath: any(named: 'filePath'),
        ),
      );
    });

    test('drains multiple due rows in one pass', () async {
      await seedWine('wine-1');
      await seedWine('wine-2');
      await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');
      await db.pendingImageUploadsDao.enqueue('wine-2', '/tmp/b.jpg');

      when(
        () => imageService.uploadImage(
          userId: any(named: 'userId'),
          filePath: any(named: 'filePath'),
        ),
      ).thenAnswer((inv) async {
        final path = inv.namedArguments[const Symbol('filePath')] as String;
        return 'https://cdn/${path.split('/').last}';
      });
      when(() => api.upsertWine(any())).thenAnswer((_) async {});

      await buildFlusher().flush();

      final remaining = await db.pendingImageUploadsDao.due(DateTime(2099));
      expect(remaining, isEmpty);
      expect(
        (await db.winesDao.getWineById('wine-1'))?.imageUrl,
        'https://cdn/a.jpg',
      );
      expect(
        (await db.winesDao.getWineById('wine-2'))?.imageUrl,
        'https://cdn/b.jpg',
      );
    });

    test(
      'skips silently when wine row was deleted between enqueue + flush',
      () async {
        // Outbox rows can outlive the wine they reference (user deletes
        // the wine before an upload retry succeeds). The flusher must
        // not crash, and must still drain the outbox row.
        await db.pendingImageUploadsDao.enqueue('ghost', '/tmp/a.jpg');

        when(
          () => imageService.uploadImage(
            userId: any(named: 'userId'),
            filePath: any(named: 'filePath'),
          ),
        ).thenAnswer((_) async => 'https://cdn/a.jpg');

        await buildFlusher().flush();

        verifyNever(() => api.upsertWine(any()));
        final due = await db.pendingImageUploadsDao.due(DateTime(2099));
        expect(
          due,
          isEmpty,
          reason: 'orphan outbox row should still be removed after upload',
        );
      },
    );
  });
}

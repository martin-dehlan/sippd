import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/database/database.dart';
import 'package:sippd/features/wines/data/models/wine.mapper.dart';
import 'package:sippd/features/wines/data/repositories/wine.repository.impl.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

import '../../../../helpers/fake_database.dart';
import '../../../../helpers/mocks.dart';

void main() {
  setUpAll(registerTestFallbacks);

  late AppDatabase db;
  late MockWineSupabaseApi api;
  late MockWineImageService imageService;
  late MockAnalyticsService analytics;

  setUp(() {
    db = makeFakeDatabase();
    api = MockWineSupabaseApi();
    imageService = MockWineImageService();
    analytics = MockAnalyticsService();

    // Default stubs — individual tests override.
    when(() => api.fetchWines(any())).thenAnswer((_) async => []);
    when(() => api.upsertWine(any())).thenAnswer((_) async {});
    when(() => api.deleteWine(any())).thenAnswer((_) async {});
    when(() => api.fetchWineById(any())).thenAnswer((_) async => null);
    when(
      () => analytics.syncFailed(any(), error: any(named: 'error')),
    ).thenAnswer((_) async {});
  });

  tearDown(() async {
    await db.close();
  });

  WineRepositoryImpl buildRepo({String? userId = 'user-1'}) {
    return WineRepositoryImpl(
      dao: db.winesDao,
      api: api,
      userId: userId,
      imageService: imageService,
      analytics: analytics,
      outbox: db.pendingImageUploadsDao,
    );
  }

  WineEntity buildEntity({
    String id = 'wine-1',
    String? imageUrl,
    String? localPath,
  }) => WineEntity(
    id: id,
    name: 'Pinot',
    rating: 8,
    type: WineType.red,
    userId: 'user-1',
    imageUrl: imageUrl,
    localImagePath: localPath,
    createdAt: DateTime(2026),
  );

  group('addWine', () {
    test(
      'writes locally first then syncs to Supabase with normalized name',
      () async {
        final repo = buildRepo();

        await repo.addWine(buildEntity());

        // Local row exists with name_norm populated.
        final local = await db.winesDao.getWineById('wine-1');
        expect(local, isNotNull);
        expect(local!.nameNorm, 'pinot');

        // Wait for fire-and-forget sync.
        await Future<void>.delayed(Duration.zero);
        verify(() => api.upsertWine(any())).called(1);
      },
    );

    test('local write survives Supabase sync failure', () async {
      when(() => api.upsertWine(any())).thenThrow(StateError('500'));
      final repo = buildRepo();

      await repo.addWine(buildEntity());
      await Future<void>.delayed(Duration.zero);

      final local = await db.winesDao.getWineById('wine-1');
      expect(local, isNotNull, reason: 'local-first survives sync failure');
      verify(
        () => analytics.syncFailed('wine_upsert', error: any(named: 'error')),
      ).called(1);
    });

    test('image upload failure enqueues outbox row', () async {
      when(
        () => imageService.uploadImage(
          userId: any(named: 'userId'),
          filePath: any(named: 'filePath'),
        ),
      ).thenThrow(StateError('storage offline'));
      final repo = buildRepo();

      await repo.addWine(buildEntity(localPath: '/tmp/a.jpg'));
      await Future<void>.delayed(Duration.zero);

      final due = await db.pendingImageUploadsDao.due(
        DateTime.now().add(const Duration(days: 1)),
      );
      expect(due, hasLength(1));
      expect(due.first.localPath, '/tmp/a.jpg');
      verify(
        () => analytics.syncFailed(
          'wine_image_upload',
          error: any(named: 'error'),
        ),
      ).called(1);
    });

    test(
      'image upload success persists URL locally + drops outbox row',
      () async {
        // Pre-existing outbox row from a previous failed attempt.
        await db.pendingImageUploadsDao.enqueue('wine-1', '/tmp/a.jpg');

        when(
          () => imageService.uploadImage(
            userId: any(named: 'userId'),
            filePath: any(named: 'filePath'),
          ),
        ).thenAnswer((_) async => 'https://cdn/a.jpg');
        final repo = buildRepo();

        await repo.addWine(buildEntity(localPath: '/tmp/a.jpg'));
        await Future<void>.delayed(Duration.zero);

        final local = await db.winesDao.getWineById('wine-1');
        expect(local?.imageUrl, 'https://cdn/a.jpg');

        final due = await db.pendingImageUploadsDao.due(DateTime(2099));
        expect(due, isEmpty);
      },
    );

    test('skips upload when imageUrl already present', () async {
      final repo = buildRepo();
      await repo.addWine(
        buildEntity(
          imageUrl: 'https://cdn/existing.jpg',
          localPath: '/tmp/a.jpg',
        ),
      );
      await Future<void>.delayed(Duration.zero);

      verifyNever(
        () => imageService.uploadImage(
          userId: any(named: 'userId'),
          filePath: any(named: 'filePath'),
        ),
      );
    });
  });

  group('getWines', () {
    test('returns local rows immediately, sync runs in background', () async {
      // Pre-seed two local wines.
      await db.winesDao.insertWine(
        buildEntity(id: 'a').copyWith(name: 'A').toTableData(),
      );
      await db.winesDao.insertWine(
        buildEntity(id: 'b').copyWith(name: 'B').toTableData(),
      );

      final result = await buildRepo().getWines();
      expect(result.map((w) => w.id), containsAll(['a', 'b']));
    });

    test('returns local rows even when remote fetch errors', () async {
      when(() => api.fetchWines(any())).thenThrow(StateError('offline'));
      await db.winesDao.insertWine(buildEntity(id: 'cached').toTableData());

      final result = await buildRepo().getWines();
      expect(result, hasLength(1));
      expect(result.first.id, 'cached');
    });

    test('skips remote sync when no userId', () async {
      final result = await buildRepo(userId: null).getWines();
      expect(result, isEmpty);
      verifyNever(() => api.fetchWines(any()));
    });
  });

  group('deleteWine', () {
    test('removes local row and forwards to Supabase', () async {
      await db.winesDao.insertWine(buildEntity().toTableData());

      await buildRepo().deleteWine('wine-1');

      expect(await db.winesDao.getWineById('wine-1'), isNull);
      verify(() => api.deleteWine('wine-1')).called(1);
    });

    test('local delete persists even when Supabase fails', () async {
      when(() => api.deleteWine(any())).thenThrow(StateError('500'));
      await db.winesDao.insertWine(buildEntity().toTableData());

      await buildRepo().deleteWine('wine-1');

      expect(await db.winesDao.getWineById('wine-1'), isNull);
      verify(
        () => analytics.syncFailed('wine_delete', error: any(named: 'error')),
      ).called(1);
    });
  });

  group('updateWine', () {
    test('persists locally + syncs', () async {
      await db.winesDao.insertWine(buildEntity().toTableData());
      final repo = buildRepo();

      await repo.updateWine(buildEntity().copyWith(rating: 9.5));
      await Future<void>.delayed(Duration.zero);

      final local = await db.winesDao.getWineById('wine-1');
      expect(local?.rating, 9.5);
      verify(() => api.upsertWine(any())).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/database/database.dart';
import 'package:sippd/features/groups/controller/group_ratings.provider.dart';
import 'package:sippd/features/groups/data/models/group_wine_rating.model.dart';
import 'package:sippd/features/wines/data/repositories/wine.repository.impl.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

import '../helpers/fake_database.dart';
import '../helpers/mocks.dart';

/// In-process integration: real Drift + mocked Supabase. Walks the
/// canonical-wine pipeline that ships into groups:
///   1. Owner adds a wine via WineRepository → it lands in Drift.
///   2. Owner edits the rating.
///   3. A second user (member) "rates" the same canonical bottle
///      via group_wine_ratings.
///   4. mergeGroupRatings dedupes the owner from member rows and
///      synthesizes the owner's rating from their personal log.
///   5. computeGroupWineRanks averages owner + member ratings to
///      produce a stable rank — even if the owner adds an explicit
///      group_wine_ratings row themselves (idempotent).
///
/// This catches regressions in any individual layer (mappers, repo,
/// merge logic) by exercising them all together.
void main() {
  setUpAll(registerTestFallbacks);

  late AppDatabase db;
  late MockWineSupabaseApi api;
  late MockWineImageService imageService;
  late MockAnalyticsService analytics;
  late WineRepositoryImpl repo;

  const ownerId = 'owner-1';
  const memberId = 'member-1';
  const canonicalId = 'cw-1';

  setUp(() {
    db = makeFakeDatabase();
    api = MockWineSupabaseApi();
    imageService = MockWineImageService();
    analytics = MockAnalyticsService();

    when(() => api.fetchWines(any())).thenAnswer((_) async => []);
    when(() => api.upsertWine(any())).thenAnswer((_) async {});
    when(() => api.fetchWineById(any())).thenAnswer((_) async => null);
    when(() => api.deleteWine(any())).thenAnswer((_) async {});
    when(() => analytics.syncFailed(any(),
        error: any(named: 'error'))).thenAnswer((_) async {});

    repo = WineRepositoryImpl(
      dao: db.winesDao,
      api: api,
      userId: ownerId,
      imageService: imageService,
      analytics: analytics,
      outbox: db.pendingImageUploadsDao,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test(
      'owner adds wine → member rates → merge surfaces both with rank 1',
      () async {
    // Step 1: Owner adds a wine. Repo writes locally + syncs to mock.
    final wine = WineEntity(
      id: 'personal-1',
      name: 'Brunello',
      rating: 8,
      type: WineType.red,
      winery: 'Biondi-Santi',
      vintage: 2018,
      canonicalWineId: canonicalId,
      userId: ownerId,
      createdAt: DateTime.utc(2026, 5, 1),
    );
    await repo.addWine(wine);
    await Future<void>.delayed(Duration.zero);

    // Verify it landed in Drift.
    final localOwner = await db.winesDao.getWineById('personal-1');
    expect(localOwner, isNotNull);
    expect(localOwner!.canonicalWineId, canonicalId);
    expect(localOwner.userId, ownerId);

    // Step 2: Owner updates rating from 8 → 9.5.
    await repo.updateWine(wine.copyWith(rating: 9.5));
    await Future<void>.delayed(Duration.zero);
    final after = await db.winesDao.getWineById('personal-1');
    expect(after!.rating, 9.5);

    // Step 3: A member adds a group_wine_ratings row for the same
    // canonical bottle.
    final memberRating = GroupWineRatingModel(
      groupId: 'g-1',
      canonicalWineId: canonicalId,
      userId: memberId,
      rating: 7.0,
      notes: 'Solid.',
      updatedAt: DateTime.utc(2026, 5, 4),
    );

    // Step 4: Merge the owner (from local) with the member row.
    final ownerEntity = (await db.winesDao.getWineById('personal-1'))!
        .let((row) => WineEntity(
              id: row.id,
              name: row.name,
              rating: row.rating,
              type: WineType.red,
              userId: row.userId,
              canonicalWineId: row.canonicalWineId,
              createdAt: row.createdAt,
            ));

    final merged = mergeGroupRatings(
      groupId: 'g-1',
      canonicalWineId: canonicalId,
      ownerId: ownerId,
      ownerRating: ownerEntity.rating,
      ownerUpdatedAt: ownerEntity.updatedAt ?? DateTime.utc(2026, 5, 1),
      memberModels: [memberRating],
      profilesById: {
        ownerId: {
          'id': ownerId,
          'username': 'owner',
          'display_name': 'Owner',
          'avatar_url': null,
        },
        memberId: {
          'id': memberId,
          'username': 'member',
          'display_name': 'Member',
          'avatar_url': null,
        },
      },
    );

    expect(merged, hasLength(2));
    expect(merged.firstWhere((r) => r.userId == ownerId).rating, 9.5,
        reason: 'owner rating reflects the post-update local row');
    expect(merged.firstWhere((r) => r.userId == ownerId).isOwner, isTrue);
    expect(merged.firstWhere((r) => r.userId == memberId).rating, 7.0);

    // Step 5: Rank computation — owner local + member rating, avg
    // (9.5 + 7) / 2 = 8.25 → rank 1 (only wine).
    final ranks = computeGroupWineRanks(
      wines: [ownerEntity],
      memberRatings: [
        const MemberRatingRow(
          canonicalWineId: canonicalId,
          userId: memberId,
          rating: 7.0,
        ),
      ],
    );
    expect(ranks, {canonicalId: 1});
  });

  test(
      'idempotent: owner duplicating their rating into group_wine_ratings '
      'does not double-count', () async {
    final wine = WineEntity(
      id: 'personal-1',
      name: 'Barolo',
      rating: 8,
      type: WineType.red,
      canonicalWineId: canonicalId,
      userId: ownerId,
      createdAt: DateTime(2026),
    );
    await repo.addWine(wine);
    await Future<void>.delayed(Duration.zero);
    final ownerEntity = (await db.winesDao.getWineById('personal-1'))!
        .let((row) => WineEntity(
              id: row.id,
              name: row.name,
              rating: row.rating,
              type: WineType.red,
              userId: row.userId,
              canonicalWineId: row.canonicalWineId,
              createdAt: row.createdAt,
            ));

    // The owner-as-rater path writes BOTH wines.rating (the source of
    // truth) AND a group_wine_ratings row (so realtime members see the
    // owner's vote). The merge + rank logic must drop the group row to
    // avoid double-counting.
    final merged = mergeGroupRatings(
      groupId: 'g-1',
      canonicalWineId: canonicalId,
      ownerId: ownerId,
      ownerRating: ownerEntity.rating,
      ownerUpdatedAt: DateTime(2026),
      memberModels: [
        GroupWineRatingModel(
          groupId: 'g-1',
          canonicalWineId: canonicalId,
          userId: ownerId,
          rating: 2,
          updatedAt: DateTime(2026),
        ),
      ],
      profilesById: const {},
    );
    expect(merged.where((r) => r.userId == ownerId), hasLength(1));
    expect(merged.where((r) => r.userId == ownerId).single.rating, 8);

    final ranks = computeGroupWineRanks(
      wines: [ownerEntity],
      memberRatings: [
        const MemberRatingRow(
          canonicalWineId: canonicalId,
          userId: ownerId,
          rating: 2,
        ),
      ],
    );
    expect(ranks, {canonicalId: 1});
  });

  test('delete wine drops the local row and forwards to Supabase',
      () async {
    final wine = WineEntity(
      id: 'personal-1',
      name: 'X',
      rating: 7,
      type: WineType.red,
      canonicalWineId: canonicalId,
      userId: ownerId,
      createdAt: DateTime(2026),
    );
    await repo.addWine(wine);
    await Future<void>.delayed(Duration.zero);

    await repo.deleteWine('personal-1');

    expect(await db.winesDao.getWineById('personal-1'), isNull);
    verify(() => api.deleteWine('personal-1')).called(1);
  });
}

extension _Let<T> on T {
  R let<R>(R Function(T) f) => f(this);
}

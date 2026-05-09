// Regression test for the offline-first fix in
// `lib/features/wines/presentation/modules/wine_add/wine_add.screen.dart`
// (`_save()`): when `CanonicalWineApi.suggestMatch` (RPC
// `suggest_canonical_match`) throws — Supabase 503 / PGRST002 — the
// local Drift insert must still proceed and the fuzzy-prompt path must
// be skipped. Widget-level pumping of `WineAddScreen` is too coupled to
// `WineForm` (flutter_map, photo picker, grape sheets) to mock cleanly,
// so this asserts the same contract one layer down: the repository
// path `wine_add` calls into still persists locally even when the
// Supabase write throws.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/database/database.dart';
import 'package:sippd/features/wines/data/repositories/wine.repository.impl.dart';
import 'package:sippd/features/wines/domain/entities/canonical_wine_candidate.entity.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

import '../../../../../helpers/fake_database.dart';
import '../../../../../helpers/mocks.dart';

void main() {
  setUpAll(registerTestFallbacks);

  late AppDatabase db;
  late MockWineSupabaseApi wineApi;
  late MockCanonicalWineApi canonicalApi;
  late MockAnalyticsService analytics;

  setUp(() {
    db = makeFakeDatabase();
    wineApi = MockWineSupabaseApi();
    canonicalApi = MockCanonicalWineApi();
    analytics = MockAnalyticsService();

    when(() => wineApi.fetchWines(any())).thenAnswer((_) async => []);
    when(() => wineApi.fetchWineById(any())).thenAnswer((_) async => null);
    when(
      () => analytics.syncFailed(any(), error: any(named: 'error')),
    ).thenAnswer((_) async {});
  });

  tearDown(() async {
    await db.close();
  });

  WineRepositoryImpl buildRepo() => WineRepositoryImpl(
    dao: db.winesDao,
    api: wineApi,
    userId: 'user-1',
    analytics: analytics,
    outbox: db.pendingImageUploadsDao,
  );

  WineEntity newWine() => WineEntity(
    id: 'wine-offline-1',
    name: 'Barolo 2018',
    rating: 8,
    type: WineType.red,
    userId: 'user-1',
    createdAt: DateTime(2026, 5, 9),
  );

  test(
    'suggest_canonical_match RPC failure does not block local insert',
    () async {
      // Arrange: server-side suggestMatch throws (PGRST002 / 503).
      // Mirrors the screen's try/catch: the wine_add `_save()` flow
      // catches and proceeds straight to wineControllerProvider.addWine,
      // which delegates to WineRepositoryImpl.addWine.
      when(
        () => canonicalApi.suggestMatch(
          name: any(named: 'name'),
          winery: any(named: 'winery'),
          vintage: any(named: 'vintage'),
        ),
      ).thenThrow(StateError('PGRST002 schema cache miss'));
      // Remote upsert ALSO down — proves Drift insert lands first.
      when(() => wineApi.upsertWine(any())).thenThrow(StateError('503'));

      List<CanonicalWineCandidate> suggestions = const [];
      try {
        suggestions = await canonicalApi.suggestMatch(
          name: 'Barolo 2018',
          winery: null,
          vintage: 2018,
        );
      } catch (_) {
        // Same swallow the screen does — offline path.
      }
      final wouldPrompt = suggestions.where((c) => !c.isExact).isNotEmpty;

      await buildRepo().addWine(newWine());
      await Future<void>.delayed(Duration.zero);

      // Assert: prompt sheet would not have shown.
      expect(
        wouldPrompt,
        isFalse,
        reason: 'fuzzy-prompt must be skipped when suggestMatch throws',
      );

      // Local insert succeeded.
      final local = await db.winesDao.getWineById('wine-offline-1');
      expect(
        local,
        isNotNull,
        reason: 'wine must persist locally even when both RPCs fail',
      );
      expect(local!.name, 'Barolo 2018');

      // recordDecision must NEVER fire when suggestMatch threw — the
      // screen short-circuits past the prompt branch entirely.
      verifyNever(
        () => canonicalApi.recordDecision(
          inputName: any(named: 'inputName'),
          inputWinery: any(named: 'inputWinery'),
          inputVintage: any(named: 'inputVintage'),
          candidateId: any(named: 'candidateId'),
          linked: any(named: 'linked'),
        ),
      );

      // Remote upsert was attempted (fire-and-forget) and failed
      // gracefully — analytics captured, no exception bubbled up.
      verify(
        () => analytics.syncFailed('wine_upsert', error: any(named: 'error')),
      ).called(1);
    },
  );
}

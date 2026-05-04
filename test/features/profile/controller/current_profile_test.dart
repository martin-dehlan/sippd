import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/database/database.dart';
import 'package:sippd/common/services/analytics/analytics.provider.dart';
import 'package:sippd/features/auth/controller/auth.provider.dart';
import 'package:sippd/features/profile/controller/profile.provider.dart';
import 'package:sippd/features/profile/data/models/profile.model.dart';
import 'package:sippd/features/wines/controller/wine.provider.dart';

import '../../../helpers/fake_database.dart';
import '../../../helpers/mocks.dart';

void main() {
  setUpAll(registerTestFallbacks);

  late AppDatabase db;
  late MockSupabaseClient supabaseClient;
  late MockGoTrueClient gotrue;
  late MockUser user;
  late MockProfileApi profileApi;
  late MockAnalyticsService analytics;

  setUp(() {
    db = makeFakeDatabase();
    supabaseClient = MockSupabaseClient();
    gotrue = MockGoTrueClient();
    user = MockUser();
    profileApi = MockProfileApi();
    analytics = MockAnalyticsService();

    // Wire the supabase client surface needed by currentProfile.
    when(() => supabaseClient.auth).thenReturn(gotrue);
    when(() => gotrue.currentUser).thenReturn(user);
    when(() => user.id).thenReturn('user-1');
    when(() => analytics.syncFailed(any(),
        error: any(named: 'error'))).thenAnswer((_) async {});
  });

  tearDown(() async {
    await db.close();
  });

  ProviderContainer container({bool authed = true}) {
    return ProviderContainer(overrides: [
      authControllerProvider.overrideWith(
        () => FakeAuthController(user: authed ? user : null),
      ),
      supabaseClientProvider.overrideWithValue(supabaseClient),
      appDatabaseProvider.overrideWithValue(db),
      profileApiProvider.overrideWithValue(profileApi),
      analyticsProvider.overrideWithValue(analytics),
    ]);
  }

  group('currentProfile', () {
    test('emits null when unauthenticated', () async {
      when(() => profileApi.fetchMyProfile())
          .thenAnswer((_) async => null);
      final c = container(authed: false);

      final emitted = await c.read(currentProfileProvider.future);
      expect(emitted, isNull);
      await Future<void>.delayed(Duration.zero);
      c.dispose();
    });

    test('emits the cached Drift row when present', () async {
      // Pre-seed Drift with a row that has no fresh fetch needed.
      const cached = ProfileModel(
        id: 'user-1',
        username: 'cached',
        displayName: 'Cached User',
        onboardingCompleted: true,
      );
      await db.profilesDao.upsert(cached.toTableData());

      when(() => profileApi.fetchMyProfile())
          .thenAnswer((_) async => null);

      final c = container();

      final emitted = await c.read(currentProfileProvider.future);
      expect(emitted?.id, 'user-1');
      expect(emitted?.username, 'cached');

      // Drain the fire-and-forget Future so it resolves before the
      // container is disposed by tearDown — otherwise the background
      // ref.read hits a disposed container.
      await Future<void>.delayed(Duration.zero);
      c.dispose();
    });

    test('background fetch persists fresh row to Drift', () async {
      const fresh = ProfileModel(
        id: 'user-1',
        username: 'fresh',
        displayName: 'Fresh User',
        onboardingCompleted: true,
      );
      when(() => profileApi.fetchMyProfile())
          .thenAnswer((_) async => fresh);

      final c = container();

      // First read kicks off the stream + the fire-and-forget fetch.
      await c.read(currentProfileProvider.future);
      // Let the fire-and-forget complete.
      await Future<void>.delayed(Duration.zero);

      // Drift now holds the freshly-fetched row.
      final row = await db.profilesDao.getById('user-1');
      expect(row?.username, 'fresh');
      c.dispose();
    });

    test('swallowed fetch error fires syncFailed telemetry', () async {
      when(() => profileApi.fetchMyProfile())
          .thenThrow(StateError('500'));

      final c = container();

      await c.read(currentProfileProvider.future);
      await Future<void>.delayed(Duration.zero);

      verify(() => analytics.syncFailed('profile_fetch',
          error: any(named: 'error'))).called(1);
      c.dispose();
    });

    test('emits null when authed but supabase has no current user', () async {
      when(() => gotrue.currentUser).thenReturn(null);

      final c = container();

      final emitted = await c.read(currentProfileProvider.future);
      expect(emitted, isNull);
      await Future<void>.delayed(Duration.zero);
      c.dispose();
    });

    test(
        'background fetch survives container disposal mid-flight '
        '(no disposed-ref crash)', () async {
      // Slow API so the fire-and-forget is still pending when we
      // dispose. With the old ref.read inside the closure, this
      // would throw "Tried to read a provider from a disposed
      // ProviderContainer" and become an unhandled async error.
      when(() => profileApi.fetchMyProfile()).thenAnswer(
        (_) async {
          await Future<void>.delayed(const Duration(milliseconds: 20));
          return null;
        },
      );

      final c = container();
      // Trigger the provider build (which schedules the fire-and-forget).
      c.read(currentProfileProvider);
      // Dispose immediately — the background fetch is still in flight.
      c.dispose();
      // Give the fire-and-forget time to complete on the disposed
      // container. If it throws, this test fails via the zoned
      // unhandled-error path.
      await Future<void>.delayed(const Duration(milliseconds: 50));
    });
  });
}

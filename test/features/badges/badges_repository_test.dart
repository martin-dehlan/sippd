import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/database/database.dart';
import 'package:sippd/features/badges/data/data_sources/badges.api.dart';
import 'package:sippd/features/badges/data/models/badge.model.dart';
import 'package:sippd/features/badges/data/repositories/badges.repository.impl.dart';

class _MockApi extends Mock implements BadgesApi {}

BadgeModel _model(String id, {bool earned = false, int current = 0}) =>
    BadgeModel(
      badgeId: id,
      category: 'volume',
      tier: 1,
      title: id,
      description: 'desc',
      icon: id,
      earned: earned,
      current: current,
      target: 10,
    );

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late _MockApi api;
  late BadgesRepositoryImpl repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    api = _MockApi();
    repo = BadgesRepositoryImpl(api: api, cacheDao: db.badgeProgressCacheDao);
  });

  tearDown(() => db.close());

  test('getProgress caches the payload on success', () async {
    when(
      () => api.getProgress('u1'),
    ).thenAnswer((_) async => [_model('first_sip', earned: true)]);

    final result = await repo.getProgress('u1');

    expect(result.single.id, 'first_sip');
    expect(result.single.earned, isTrue);
    // Payload was written to the local cache.
    expect(await db.badgeProgressCacheDao.getByUser('u1'), isNotNull);
  });

  test('getProgress falls back to cached payload on RPC failure', () async {
    // Prime the cache with a successful call.
    when(
      () => api.getProgress('u1'),
    ).thenAnswer((_) async => [_model('wine_explorer', current: 30)]);
    await repo.getProgress('u1');

    // Next call fails — repo must serve the cached payload, not throw.
    when(() => api.getProgress('u1')).thenThrow(Exception('offline'));
    final result = await repo.getProgress('u1');

    expect(result.single.id, 'wine_explorer');
    expect(result.single.current, 30);
  });

  test(
    'getProgress rethrows when failure has no cache to fall back to',
    () async {
      when(() => api.getProgress('u2')).thenThrow(Exception('offline'));
      expect(() => repo.getProgress('u2'), throwsException);
    },
  );

  test('getEarned returns only earned badges as earned entities', () async {
    when(() => api.getProgress('u1')).thenAnswer(
      (_) async => [
        _model('first_sip', earned: true),
        _model('connoisseur', current: 3),
      ],
    );

    final earned = await repo.getEarned('u1');

    expect(earned, hasLength(1));
    expect(earned.single.id, 'first_sip');
    expect(earned.single.earned, isTrue);
  });
}

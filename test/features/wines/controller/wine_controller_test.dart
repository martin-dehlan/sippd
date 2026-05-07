import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/services/analytics/analytics.provider.dart';
import 'package:sippd/features/auth/controller/auth.provider.dart';
import 'package:sippd/features/wines/controller/wine.provider.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/pump_provider_app.dart';

void main() {
  setUpAll(registerTestFallbacks);

  late MockWineRepository repo;
  late MockWineMemoryRepository memoryRepo;
  late MockAnalyticsService analytics;

  setUp(() {
    repo = MockWineRepository();
    memoryRepo = MockWineMemoryRepository();
    analytics = MockAnalyticsService();

    when(
      () => analytics.capture(any(), properties: any(named: 'properties')),
    ).thenAnswer((_) async {});
  });

  ProviderContainer container({Stream<List<WineEntity>>? stream}) {
    when(
      () => repo.watchWines(),
    ).thenAnswer((_) => stream ?? Stream.value(const <WineEntity>[]));
    return makeContainer(
      overrides: [
        authControllerProvider.overrideWith(FakeAuthController.new),
        wineRepositoryProvider.overrideWithValue(repo),
        wineMemoryRepositoryProvider.overrideWithValue(memoryRepo),
        analyticsProvider.overrideWithValue(analytics),
      ],
    );
  }

  WineEntity sample({String id = 'w-1', double rating = 7}) => WineEntity(
    id: id,
    name: 'Pinot',
    rating: rating,
    type: WineType.red,
    userId: 'user-1',
    createdAt: DateTime(2026),
  );

  group('build', () {
    test('emits whatever the repository stream emits', () async {
      final c = container(stream: Stream.value([sample()]));
      final state = await c.read(wineControllerProvider.future);
      expect(state.map((w) => w.id), ['w-1']);
    });

    test('starts in loading then transitions to data', () async {
      final c = container();
      // First read = AsyncLoading (no value yet).
      expect(c.read(wineControllerProvider).isLoading, isTrue);
      await c.read(wineControllerProvider.future);
      expect(c.read(wineControllerProvider).hasValue, isTrue);
    });

    test('surface stream errors as AsyncError', () async {
      final c = container(stream: Stream.error(StateError('boom')));
      // Awaiting .future surfaces the stream's first error.
      await expectLater(
        c.read(wineControllerProvider.future),
        throwsA(isA<StateError>()),
      );
      expect(c.read(wineControllerProvider).hasError, isTrue);
    });
  });

  group('addWine', () {
    test('forwards to repository and emits analytics event', () async {
      when(() => repo.addWine(any())).thenAnswer((_) async {});
      final c = container();
      await c.read(wineControllerProvider.future);

      await c.read(wineControllerProvider.notifier).addWine(sample(rating: 9));

      verify(() => repo.addWine(any())).called(1);
      verify(
        () => analytics.capture(
          'wine_added',
          properties: any(named: 'properties'),
        ),
      ).called(1);
    });

    test('rethrows repository failure so UI can surface it', () async {
      when(() => repo.addWine(any())).thenThrow(StateError('db full'));
      final c = container();
      await c.read(wineControllerProvider.future);

      await expectLater(
        c.read(wineControllerProvider.notifier).addWine(sample()),
        throwsA(isA<StateError>()),
      );
      verifyNever(
        () => analytics.capture(
          'wine_added',
          properties: any(named: 'properties'),
        ),
      );
    });
  });

  group('updateWine', () {
    test('forwards to repository and captures wine_updated event', () async {
      when(() => repo.updateWine(any())).thenAnswer((_) async {});
      final c = container();
      await c.read(wineControllerProvider.future);

      await c
          .read(wineControllerProvider.notifier)
          .updateWine(sample().copyWith(rating: 8.4));

      verify(() => repo.updateWine(any())).called(1);
      verify(
        () => analytics.capture(
          'wine_updated',
          properties: any(named: 'properties'),
        ),
      ).called(1);
    });
  });
}

# Testing Rules

**TL;DR:** Three-tier test pyramid: unit (fast, most), widget (medium), integration (slow, few). Use Mocktail for mocks. Override Riverpod providers with `ProviderScope`. Keep tests in `test/` mirroring `lib/` structure.

---

## Test Pyramid

```
         /\
        /  \   Integration tests   (test/integration_test/)
       /----\  Widget tests        (test/widget/)
      /      \ Unit tests          (test/unit/)
     /________\
```

- **Unit**: repositories, use cases, controllers, mappers — no Flutter framework
- **Widget**: screens and widgets with mock providers — no real network/DB
- **Integration**: full app flows with a real or in-memory database

---

## Dependencies

```yaml
# pubspec.yaml dev_dependencies
dev_dependencies:
  flutter_test:
    sdk: flutter
  mocktail: ^1.x.x
  integration_test:
    sdk: flutter
```

---

## Folder Structure

```
test/
  unit/
    features/
      wine/
        wine_controller_test.dart
        wine_repository_test.dart
        add_wine_usecase_test.dart
    common/
      error_mapper_test.dart
  widget/
    features/
      wine/
        wine_list_screen_test.dart
        wine_card_test.dart
  helpers/
    pump_routed_app.dart        ← shared test helper
    mock_repositories.dart      ← centralized mock declarations
integration_test/
  wine_flow_test.dart
  auth_flow_test.dart
```

---

## Mocktail Setup

File: `test/helpers/mock_repositories.dart`

```dart
import 'package:mocktail/mocktail.dart';
import 'package:sippd/features/wine/domain/wine.repository.dart';
import 'package:sippd/features/wine/data/wine.api.dart';
import 'package:sippd/common/database/daos/wine.dao.dart';

class MockWineRepository extends Mock implements WineRepository {}
class MockWineApi extends Mock implements WineApi {}
class MockWineDao extends Mock implements WineDao {}

// Call this in setUpAll() to register fallback values
void registerFallbacks() {
  registerFallbackValue(
    WineEntity(
      id: 'test-id',
      name: 'Test Wine',
      winery: 'Test Winery',
      region: 'Napa Valley',
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
  );
}
```

---

## Unit Tests: Controllers

Test state transitions, not implementation details.

```dart
// test/unit/features/wine/wine_controller_test.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../helpers/mock_repositories.dart';

void main() {
  late MockWineRepository mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockWineRepository();
    container = ProviderContainer(
      overrides: [
        wineRepositoryProvider.overrideWithValue(mockRepo),
        currentUserIdProvider.overrideWithValue('user-123'),
      ],
    );
    addTearDown(container.dispose);
  });

  group('WineController', () {
    test('initial state loads wines from repository', () async {
      // Arrange
      final wines = [_makeWine('id-1'), _makeWine('id-2')];
      when(() => mockRepo.getWines('user-123')).thenAnswer((_) async => wines);

      // Act
      final result = await container.read(wineControllerProvider.future);

      // Assert
      expect(result, wines);
    });

    test('addWine updates state and invalidates', () async {
      final newWine = _makeWine('id-new', name: 'Merlot');
      when(() => mockRepo.getWines(any())).thenAnswer((_) async => []);
      when(() => mockRepo.addWine(any(), any())).thenAnswer((_) async {});

      // Verify no error state after adding
      final controller = container.read(wineControllerProvider.notifier);
      await controller.addWine(newWine);

      verify(() => mockRepo.addWine(newWine, 'user-123')).called(1);
      expect(container.read(wineControllerProvider).hasError, isFalse);
    });

    test('is idempotent — adding same wine twice does not duplicate', () async {
      final wine = _makeWine('id-1');
      when(() => mockRepo.getWines(any())).thenAnswer((_) async => [wine]);
      when(() => mockRepo.addWine(any(), any())).thenAnswer((_) async {});

      final controller = container.read(wineControllerProvider.notifier);
      await controller.addWine(wine);
      await controller.addWine(wine);

      verify(() => mockRepo.addWine(wine, 'user-123')).called(2);
    });
  });
}

WineEntity _makeWine(String id, {String name = 'Cabernet'}) => WineEntity(
  id: id,
  name: name,
  winery: 'Test Winery',
  region: 'Napa Valley',
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);
```

### State Termination Test Pattern

Ensure every state sequence eventually reaches a terminal state (data or error):

```dart
test('state terminates — never stays in loading indefinitely', () async {
  when(() => mockRepo.getWines(any())).thenAnswer((_) async => []);

  final future = container.read(wineControllerProvider.future);
  await expectLater(future, completes);
});
```

---

## Unit Tests: Repositories

```dart
// test/unit/features/wine/wine_repository_test.dart
void main() {
  late MockWineApi mockApi;
  late MockWineDao mockDao;
  late WineRepositoryImpl repository;

  setUp(() {
    mockApi = MockWineApi();
    mockDao = MockWineDao();
    repository = WineRepositoryImpl(api: mockApi, dao: mockDao);
  });

  test('getWines falls back to local data on network error', () async {
    final localWines = [_makeTableData('id-1')];
    when(() => mockApi.fetchWines(any())).thenThrow(
      const AppError.network(),
    );
    when(() => mockDao.getWinesByUser(any())).thenAnswer((_) async => localWines);

    final result = await repository.getWines('user-123');

    expect(result.length, 1);
    expect(result.first.id, 'id-1');
  });
}
```

---

## Widget Tests

File: `test/widget/features/wine/wine_list_screen_test.dart`

```dart
void main() {
  late MockWineRepository mockRepo;

  setUp(() => mockRepo = MockWineRepository());

  testWidgets('shows wine cards when data loaded', (tester) async {
    final wines = [_makeWine('id-1', name: 'Pinot Noir')];
    when(() => mockRepo.getWines(any())).thenAnswer((_) async => wines);

    await tester.pumpProviderApp(
      overrides: [
        wineRepositoryProvider.overrideWithValue(mockRepo),
        currentUserIdProvider.overrideWithValue('user-123'),
      ],
      initialRoute: AppRoutes.wines,
    );
    await tester.pumpAndSettle();

    expect(find.text('Pinot Noir'), findsOneWidget);
  });

  testWidgets('shows error state on failure', (tester) async {
    when(() => mockRepo.getWines(any())).thenThrow(
      const AppError.network(),
    );

    await tester.pumpProviderApp(
      overrides: [wineRepositoryProvider.overrideWithValue(mockRepo)],
      initialRoute: AppRoutes.wines,
    );
    await tester.pumpAndSettle();

    expect(find.byType(ErrorState), findsOneWidget);
  });
}
```

---

## pump_routed_app Helper

File: `test/helpers/pump_routed_app.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

extension PumpRouted on WidgetTester {
  Future<void> pumpProviderApp({
    required List<Override> overrides,
    String initialRoute = '/',
  }) async {
    final router = GoRouter(
      initialLocation: initialRoute,
      routes: appRouterConfig, // import your route list
    );

    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
  }
}
```

---

## Integration Tests

File: `integration_test/wine_flow_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('user can add and see a wine', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: SippdApp()));
    await tester.pumpAndSettle();

    // Login (or skip to authenticated state via override)
    // ...

    // Navigate to add wine
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Fill form
    await tester.enterText(find.byKey(const Key('wine_name_field')), 'Barolo');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify result
    expect(find.text('Barolo'), findsOneWidget);
  });
}
```

Run integration tests:
```bash
flutter test integration_test/
```

---

## Rules Checklist

- [ ] Unit tests use `ProviderContainer` directly (no Flutter framework)
- [ ] Widget tests use `pumpProviderApp` helper
- [ ] Every async controller test checks for state termination
- [ ] Mocks declared centrally in `test/helpers/mock_repositories.dart`
- [ ] No real network or Supabase calls in unit or widget tests
- [ ] Test state transitions, not internal implementation
- [ ] `addTearDown(container.dispose)` in every unit test with `ProviderContainer`

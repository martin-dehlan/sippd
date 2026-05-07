import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpProviderApp on WidgetTester {
  /// Pumps [child] inside a `MaterialApp` wrapped in a `ProviderScope`
  /// with the given [overrides]. Use for widget tests that need a
  /// minimal app shell (theme, MediaQuery, navigation `Navigator`)
  /// without booting the real router.
  Future<void> pumpProviderApp({
    required Widget child,
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(home: child, debugShowCheckedModeBanner: false),
      ),
    );
  }
}

/// Wraps [test] body in a fresh [ProviderContainer] with [overrides]
/// applied, disposing it on tearDown. Saves boilerplate in unit tests.
ProviderContainer makeContainer({List<Override> overrides = const []}) {
  final container = ProviderContainer(overrides: overrides);
  addTearDown(container.dispose);
  return container;
}

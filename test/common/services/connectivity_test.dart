import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/errors/app_error.dart';
import 'package:sippd/common/services/connectivity/connectivity.provider.dart';
import 'package:sippd/common/widgets/inline_error.widget.dart';

void main() {
  group('isOnlineProvider', () {
    test('reports offline when ConnectivityState resolves to false', () async {
      final container = ProviderContainer(
        overrides: [
          connectivityStateProvider.overrideWith(() => _FakeConn(false)),
        ],
      );
      addTearDown(container.dispose);
      await container.read(connectivityStateProvider.future);
      expect(container.read(isOnlineProvider), isFalse);
    });

    test('reports online when ConnectivityState resolves to true', () async {
      final container = ProviderContainer(
        overrides: [
          connectivityStateProvider.overrideWith(() => _FakeConn(true)),
        ],
      );
      addTearDown(container.dispose);
      await container.read(connectivityStateProvider.future);
      expect(container.read(isOnlineProvider), isTrue);
    });
  });

  group('Ref.requireOnline()', () {
    test('throws AppError.offline when offline', () async {
      final container = ProviderContainer(
        overrides: [
          connectivityStateProvider.overrideWith(() => _FakeConn(false)),
        ],
      );
      addTearDown(container.dispose);
      await container.read(connectivityStateProvider.future);
      final probe = Provider<void>((ref) {
        ref.requireOnline();
      });
      expect(() => container.read(probe), throwsA(isA<OfflineError>()));
    });

    test('does not throw when online', () async {
      final container = ProviderContainer(
        overrides: [
          connectivityStateProvider.overrideWith(() => _FakeConn(true)),
        ],
      );
      addTearDown(container.dispose);
      await container.read(connectivityStateProvider.future);
      final probe = Provider<bool>((ref) {
        ref.requireOnline();
        return true;
      });
      expect(container.read(probe), isTrue);
    });
  });

  group('Future.withNetTimeout()', () {
    test('completes normally when below the deadline', () async {
      final value = await Future.value(42).withNetTimeout();
      expect(value, 42);
    });

    test('throws TimeoutException past the deadline', () async {
      expect(
        () => Future.delayed(
          const Duration(seconds: 30),
          () => 42,
        ).withNetTimeout(const Duration(milliseconds: 50)),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('describeAppError', () {
    test('translates OfflineError to friendly copy', () {
      expect(describeAppError(const AppError.offline()), contains('offline'));
    });

    test('translates NetworkError to friendly copy', () {
      expect(describeAppError(const AppError.network()), contains('Network'));
    });

    test('falls back for unknown errors', () {
      expect(
        describeAppError(StateError('boom'), fallback: 'Custom fallback.'),
        'Custom fallback.',
      );
    });
  });
}

class _FakeConn extends ConnectivityState {
  _FakeConn(this._online);
  final bool _online;

  @override
  Future<bool> build() async => _online;
}

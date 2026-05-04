import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/errors/app_error.dart';
import 'package:sippd/common/services/connectivity/connectivity.provider.dart';
import 'package:sippd/features/auth/controller/auth.provider.dart';
import 'package:sippd/features/groups/controller/group.provider.dart';

void main() {
  group('GroupController', () {
    test('throws AppError.offline when device is offline', () async {
      final container = ProviderContainer(
        overrides: [
          connectivityStateProvider.overrideWith(() => _FakeConn(false)),
          // Authed user — otherwise the provider short-circuits to []
          // before it even checks connectivity.
          currentUserIdProvider.overrideWith((_) => 'user-123'),
        ],
      );
      addTearDown(container.dispose);
      await container.read(connectivityStateProvider.future);

      expect(
        () => container.read(groupControllerProvider.future),
        throwsA(isA<OfflineError>()),
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

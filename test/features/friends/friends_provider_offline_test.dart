import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/errors/app_error.dart';
import 'package:sippd/common/services/connectivity/connectivity.provider.dart';
import 'package:sippd/features/friends/controller/friends.provider.dart';
import 'package:sippd/features/friends/domain/entities/friend_profile.entity.dart';
import 'package:sippd/features/friends/domain/entities/friend_request.entity.dart';
import 'package:sippd/features/friends/domain/repositories/friends.repository.dart';

class _MockRepo extends Mock implements FriendsRepository {}

void main() {
  group('friendsListProvider stream', () {
    test('emits AppError.offline as a stream error when offline', () async {
      final repo = _MockRepo();
      // Repo should NEVER be called when offline.
      when(
        () => repo.watchFriends(),
      ).thenAnswer((_) => Stream<List<FriendProfileEntity>>.value(const []));

      final container = ProviderContainer(
        overrides: [
          connectivityStateProvider.overrideWith(() => _FakeConn(false)),
          friendsRepositoryProvider.overrideWith((_) => repo),
        ],
      );
      addTearDown(container.dispose);
      await container.read(connectivityStateProvider.future);

      expect(
        container.read(friendsListProvider.stream),
        emitsError(isA<OfflineError>()),
      );
      verifyNever(() => repo.watchFriends());
    });

    test('returns repo stream when online', () async {
      final repo = _MockRepo();
      when(
        () => repo.watchFriends(),
      ).thenAnswer((_) => Stream.value(const [FriendProfileEntity(id: 'a')]));
      // Stub the request streams used by sibling providers if they fire
      // — they don't here, but mocktail throws on any unexpected call.
      when(
        () => repo.watchIncomingRequests(),
      ).thenAnswer((_) => Stream<List<FriendRequestEntity>>.value(const []));
      when(
        () => repo.watchOutgoingRequests(),
      ).thenAnswer((_) => Stream<List<FriendRequestEntity>>.value(const []));

      final container = ProviderContainer(
        overrides: [
          connectivityStateProvider.overrideWith(() => _FakeConn(true)),
          friendsRepositoryProvider.overrideWith((_) => repo),
        ],
      );
      addTearDown(container.dispose);
      await container.read(connectivityStateProvider.future);

      final list = await container.read(friendsListProvider.future);
      expect(list, hasLength(1));
      expect(list.first.id, 'a');
    });
  });
}

class _FakeConn extends ConnectivityState {
  _FakeConn(this._online);
  final bool _online;

  @override
  Future<bool> build() async => _online;
}

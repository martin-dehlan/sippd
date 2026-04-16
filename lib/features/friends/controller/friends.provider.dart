import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../data/data_sources/friends.api.dart';
import '../data/repositories/friends.repository.impl.dart';
import '../domain/entities/friend_profile.entity.dart';
import '../domain/entities/friend_request.entity.dart';
import '../domain/repositories/friends.repository.dart';

part 'friends.provider.g.dart';

@riverpod
FriendsRepository? friendsRepository(FriendsRepositoryRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return FriendsRepositoryImpl(FriendsApi(client));
}

@riverpod
Stream<List<FriendProfileEntity>> friendsList(FriendsListRef ref) {
  final repo = ref.watch(friendsRepositoryProvider);
  if (repo == null) return Stream.value(const []);
  return repo.watchFriends();
}

@riverpod
Stream<List<FriendRequestEntity>> incomingFriendRequests(
    IncomingFriendRequestsRef ref) {
  final repo = ref.watch(friendsRepositoryProvider);
  if (repo == null) return Stream.value(const []);
  return repo.watchIncomingRequests();
}

@riverpod
class FriendSearchController extends _$FriendSearchController {
  @override
  Future<List<FriendProfileEntity>> build() async => const [];

  Future<void> search(String query) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) {
      state = const AsyncValue.data([]);
      return;
    }
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.searchUsers(query));
  }

  void clear() => state = const AsyncValue.data([]);
}

@riverpod
class FriendsController extends _$FriendsController {
  @override
  FutureOr<void> build() {}

  Future<void> sendRequest(String receiverId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.sendRequest(receiverId));
  }

  Future<void> acceptRequest(String requestId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.acceptRequest(requestId));
  }

  Future<void> declineRequest(String requestId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.declineRequest(requestId));
  }

  Future<void> removeFriend(String friendId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) return;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => repo.removeFriend(friendId));
  }
}

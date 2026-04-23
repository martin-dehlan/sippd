import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../../wines/domain/entities/wine.entity.dart';
import '../data/data_sources/activity.api.dart';
import '../data/data_sources/friend_wines.api.dart';
import '../data/data_sources/friends.api.dart';
import '../data/models/friend_profile.model.dart';
import '../data/repositories/friends.repository.impl.dart';
import '../domain/entities/activity_item.entity.dart';
import '../domain/entities/friend_profile.entity.dart';
import '../domain/entities/friend_request.entity.dart';
import '../domain/repositories/friends.repository.dart';
import '../../wines/data/models/wine.model.dart';

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
Stream<List<FriendRequestEntity>> outgoingFriendRequests(
    OutgoingFriendRequestsRef ref) {
  final repo = ref.watch(friendsRepositoryProvider);
  if (repo == null) return Stream.value(const []);
  return repo.watchOutgoingRequests();
}

@riverpod
FriendWinesApi? friendWinesApi(FriendWinesApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return FriendWinesApi(client);
}

@riverpod
Future<List<WineEntity>> friendWines(
    FriendWinesRef ref, String friendId) async {
  final api = ref.watch(friendWinesApiProvider);
  if (api == null) return const [];
  final models = await api.fetchFriendWines(friendId);
  return models.map((m) => m.toEntity()).toList();
}

@riverpod
ActivityApi? activityApi(ActivityApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  final client = ref.read(supabaseClientProvider);
  return ActivityApi(client);
}

@riverpod
Future<List<ActivityItemEntity>> activityFeed(ActivityFeedRef ref) async {
  final api = ref.watch(activityApiProvider);
  if (api == null) return const [];
  final raw = await api.fetchRecent();
  return raw
      .map((r) => ActivityItemEntity(
            wine: r.wine.toEntity(),
            friend: r.friend.toEntity(),
          ))
      .toList();
}

@riverpod
Future<FriendProfileEntity?> friendProfile(
    FriendProfileRef ref, String friendId) async {
  final repo = ref.watch(friendsRepositoryProvider);
  if (repo == null) return null;
  final friends = await repo.watchFriends().first;
  return friends.firstWhere(
    (f) => f.id == friendId,
    orElse: () => FriendProfileEntity(id: friendId),
  );
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
    if (repo == null) throw StateError('Sign in required');
    await repo.sendRequest(receiverId);
  }

  Future<void> acceptRequest(String requestId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) throw StateError('Sign in required');
    await repo.acceptRequest(requestId);
  }

  Future<void> declineRequest(String requestId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) throw StateError('Sign in required');
    await repo.declineRequest(requestId);
  }

  Future<void> removeFriend(String friendId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) throw StateError('Sign in required');
    await repo.removeFriend(friendId);
  }

  Future<void> cancelRequest(String requestId) async {
    final repo = ref.read(friendsRepositoryProvider);
    if (repo == null) throw StateError('Sign in required');
    await repo.cancelRequest(requestId);
  }
}

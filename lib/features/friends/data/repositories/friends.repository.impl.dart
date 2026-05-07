import '../../domain/entities/friend_profile.entity.dart';
import '../../domain/entities/friend_request.entity.dart';
import '../../domain/repositories/friends.repository.dart';
import '../data_sources/friends.api.dart';
import '../models/friend_profile.model.dart';
import '../models/friend_request.model.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  final FriendsApi _api;
  FriendsRepositoryImpl(this._api);

  @override
  Stream<List<FriendProfileEntity>> watchFriends() =>
      _api.watchFriends().map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Stream<List<FriendRequestEntity>> watchIncomingRequests() => _api
      .watchIncomingRequests()
      .map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Stream<List<FriendRequestEntity>> watchOutgoingRequests() => _api
      .watchOutgoingRequests()
      .map((list) => list.map((m) => m.toEntity()).toList());

  @override
  Future<List<FriendProfileEntity>> searchUsers(String query) async {
    if (query.trim().isEmpty) return [];
    final results = await _api.searchUsers(query.trim());
    return results.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> sendRequest(String receiverId) => _api.sendRequest(receiverId);

  @override
  Future<void> acceptRequest(String requestId) => _api.acceptRequest(requestId);

  @override
  Future<void> declineRequest(String requestId) =>
      _api.declineRequest(requestId);

  @override
  Future<void> removeFriend(String friendId) => _api.removeFriend(friendId);

  @override
  Future<void> cancelRequest(String requestId) => _api.cancelRequest(requestId);
}

import '../entities/friend_profile.entity.dart';
import '../entities/friend_request.entity.dart';

abstract class FriendsRepository {
  Stream<List<FriendProfileEntity>> watchFriends();
  Stream<List<FriendRequestEntity>> watchIncomingRequests();
  Stream<List<FriendRequestEntity>> watchOutgoingRequests();

  Future<List<FriendProfileEntity>> searchUsers(String query);

  Future<void> sendRequest(String receiverId);
  Future<void> acceptRequest(String requestId);
  Future<void> declineRequest(String requestId);
  Future<void> cancelRequest(String requestId);
  Future<void> removeFriend(String friendId);
}

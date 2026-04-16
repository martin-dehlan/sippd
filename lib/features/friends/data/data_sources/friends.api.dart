import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/friend_profile.model.dart';
import '../models/friend_request.model.dart';

class FriendsApi {
  final SupabaseClient _client;
  FriendsApi(this._client);

  String get _uid => _client.auth.currentUser!.id;

  Stream<List<FriendProfileModel>> watchFriends() {
    return _client
        .from('friendships')
        .stream(primaryKey: ['user_id', 'friend_id'])
        .eq('user_id', _uid)
        .asyncMap((rows) async {
      if (rows.isEmpty) return <FriendProfileModel>[];
      final friendIds = rows.map((r) => r['friend_id'] as String).toList();
      final profiles = await _client
          .from('profiles')
          .select()
          .inFilter('id', friendIds);
      return (profiles as List)
          .map((p) => FriendProfileModel.fromJson(p as Map<String, dynamic>))
          .toList();
    });
  }

  Stream<List<FriendRequestModel>> watchIncomingRequests() {
    return _client
        .from('friend_requests')
        .stream(primaryKey: ['id'])
        .eq('receiver_id', _uid)
        .asyncMap((rows) async {
      final pending = rows.where((r) => r['status'] == 'pending').toList();
      if (pending.isEmpty) return <FriendRequestModel>[];
      final senderIds =
          pending.map((r) => r['sender_id'] as String).toSet().toList();
      final senders = await _client
          .from('profiles')
          .select()
          .inFilter('id', senderIds);
      final senderMap = {
        for (final p in senders as List)
          (p as Map<String, dynamic>)['id'] as String: p,
      };
      return pending.map((r) {
        final senderId = r['sender_id'] as String;
        return FriendRequestModel.fromJson({
          ...r,
          'sender': senderMap[senderId],
        });
      }).toList();
    });
  }

  Future<List<FriendProfileModel>> searchUsers(String query) async {
    final rows = await _client
        .from('profiles')
        .select()
        .neq('id', _uid)
        .or('username.ilike.%$query%,display_name.ilike.%$query%')
        .limit(20);
    return (rows as List)
        .map((p) => FriendProfileModel.fromJson(p as Map<String, dynamic>))
        .toList();
  }

  Future<void> sendRequest(String receiverId) async {
    await _client.from('friend_requests').insert({
      'sender_id': _uid,
      'receiver_id': receiverId,
      'status': 'pending',
    });
  }

  Future<void> acceptRequest(String requestId) async {
    await _client
        .from('friend_requests')
        .update({'status': 'accepted'}).eq('id', requestId);
  }

  Future<void> declineRequest(String requestId) async {
    await _client
        .from('friend_requests')
        .update({'status': 'declined'}).eq('id', requestId);
  }

  Future<void> removeFriend(String friendId) async {
    await _client
        .from('friendships')
        .delete()
        .eq('user_id', _uid)
        .eq('friend_id', friendId);
    await _client
        .from('friendships')
        .delete()
        .eq('user_id', friendId)
        .eq('friend_id', _uid);
  }
}

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
              .map(
                (p) => FriendProfileModel.fromJson(p as Map<String, dynamic>),
              )
              .toList();
        });
  }

  /// Receiver IDs of all friend requests I've sent that are still pending.
  /// UI uses this to mark search results as "already requested".
  Stream<Set<String>> watchOutgoingPendingReceiverIds() {
    return _client
        .from('friend_requests')
        .stream(primaryKey: ['id'])
        .eq('sender_id', _uid)
        .map(
          (rows) => rows
              .where((r) => r['status'] == 'pending')
              .map((r) => r['receiver_id'] as String)
              .toSet(),
        );
  }

  /// Full outgoing pending requests with receiver profile joined — used to
  /// show a "Pending" section on the friends screen so users can see who
  /// they're waiting on and cancel if needed.
  Stream<List<FriendRequestModel>> watchOutgoingRequests() {
    return _client
        .from('friend_requests')
        .stream(primaryKey: ['id'])
        .eq('sender_id', _uid)
        .asyncMap((rows) async {
          final pending = rows.where((r) => r['status'] == 'pending').toList();
          if (pending.isEmpty) return <FriendRequestModel>[];
          final receiverIds = pending
              .map((r) => r['receiver_id'] as String)
              .toSet()
              .toList();
          final receivers = await _client
              .from('profiles')
              .select()
              .inFilter('id', receiverIds);
          final receiverMap = {
            for (final p in receivers as List)
              (p as Map<String, dynamic>)['id'] as String: p,
          };
          return pending.map((r) {
            final receiverId = r['receiver_id'] as String;
            return FriendRequestModel.fromJson({
              ...r,
              'receiver': receiverMap[receiverId],
            });
          }).toList();
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
          final senderIds = pending
              .map((r) => r['sender_id'] as String)
              .toSet()
              .toList();
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
    // Strip PostgREST filter metachars + SQL LIKE wildcards to prevent
    // filter-expression injection via the `or()` string builder.
    final safe = query.replaceAll(RegExp(r'[,()%_*\\]'), '').trim();
    if (safe.isEmpty) return <FriendProfileModel>[];
    final rows = await _client
        .from('profiles')
        .select()
        .neq('id', _uid)
        .or('username.ilike.%$safe%,display_name.ilike.%$safe%')
        .limit(20);
    return (rows as List)
        .map((p) => FriendProfileModel.fromJson(p as Map<String, dynamic>))
        .toList();
  }

  Future<void> sendRequest(String receiverId) async {
    // Look up any prior request row from me to this user. Unique is on
    // (sender_id, receiver_id), so only my-own direction can block insert.
    final existing = await _client
        .from('friend_requests')
        .select('status')
        .eq('sender_id', _uid)
        .eq('receiver_id', receiverId)
        .maybeSingle();

    if (existing != null) {
      final status = existing['status'] as String?;
      if (status == 'pending') {
        // Request already in flight — do nothing, no duplicate push.
        return;
      }
      if (status == 'accepted') {
        // Confirm friendship actually exists. A stranded 'accepted' row
        // (friendship deleted but request not cleaned) would block re-add
        // forever otherwise.
        final friendship = await _client
            .from('friendships')
            .select('user_id')
            .eq('user_id', _uid)
            .eq('friend_id', receiverId)
            .maybeSingle();
        if (friendship != null) {
          throw const FriendRequestExistsException();
        }
      }
      // accepted-without-friendship OR declined → wipe and reinsert so the
      // INSERT trigger fires and the receiver actually gets the push.
      await _client
          .from('friend_requests')
          .delete()
          .eq('sender_id', _uid)
          .eq('receiver_id', receiverId);
    }

    await _client.from('friend_requests').insert({
      'sender_id': _uid,
      'receiver_id': receiverId,
      'status': 'pending',
    });
  }

  Future<void> acceptRequest(String requestId) async {
    await _client
        .from('friend_requests')
        .update({'status': 'accepted'})
        .eq('id', requestId);
  }

  Future<void> declineRequest(String requestId) async {
    await _client
        .from('friend_requests')
        .update({'status': 'declined'})
        .eq('id', requestId);
  }

  Future<void> removeFriend(String friendId) async {
    await _client
        .from('friendships')
        .delete()
        .eq('user_id', _uid)
        .eq('friend_id', friendId);
  }

  /// Withdraw my own outgoing pending request.
  Future<void> cancelRequest(String requestId) async {
    await _client
        .from('friend_requests')
        .delete()
        .eq('id', requestId)
        .eq('sender_id', _uid);
  }
}

class FriendRequestExistsException implements Exception {
  const FriendRequestExistsException();
  @override
  String toString() => 'FriendRequestExistsException';
}

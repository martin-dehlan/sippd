import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/friends/data/models/friend_profile.model.dart';
import 'package:sippd/features/friends/data/models/friend_request.model.dart';
import 'package:sippd/features/friends/domain/entities/friend_request.entity.dart';

void main() {
  group('FriendProfileModel ↔ JSON', () {
    test('round-trips with snake_case keys', () {
      const original = FriendProfileModel(
        id: 'u-1',
        username: 'martin',
        displayName: 'Martin',
        avatarUrl: 'https://cdn/m.png',
      );
      final json = original.toJson();
      expect(json.keys, containsAll(['display_name', 'avatar_url']));
      expect(FriendProfileModel.fromJson(json), original);
    });

    test('only id is required — others nullable', () {
      final m = FriendProfileModel.fromJson({'id': 'u-1'});
      expect(m.username, isNull);
      expect(m.displayName, isNull);
      expect(m.avatarUrl, isNull);
    });

    test('toEntity mirrors fields 1:1', () {
      const m = FriendProfileModel(id: 'u-1', username: 'm');
      final e = m.toEntity();
      expect(e.id, 'u-1');
      expect(e.username, 'm');
    });
  });

  group('FriendRequestModel ↔ JSON', () {
    test('round-trips through wire encoding (jsonEncode/decode)', () {
      // Without `explicitToJson`, freezed/json_serializable only
      // serialises nested objects when a real wire encoding round-
      // trip happens (jsonEncode → jsonDecode). Calling toJson()
      // alone leaves nested objects as raw class instances, so we
      // simulate a real Supabase round-trip.
      final original = FriendRequestModel(
        id: 'fr-1',
        senderId: 'a',
        receiverId: 'b',
        status: 'pending',
        createdAt: DateTime.utc(2026, 5, 4),
        sender: const FriendProfileModel(id: 'a', username: 'anna'),
        receiver: const FriendProfileModel(id: 'b', username: 'ben'),
      );
      final wire = jsonDecode(jsonEncode(original.toJson()))
          as Map<String, dynamic>;
      expect(wire.keys,
          containsAll(['sender_id', 'receiver_id', 'created_at']));
      final round = FriendRequestModel.fromJson(wire);
      expect(round.id, original.id);
      expect(round.senderId, original.senderId);
      expect(round.receiverId, original.receiverId);
      expect(round.status, original.status);
      expect(round.sender?.username, 'anna');
      expect(round.receiver?.username, 'ben');
    });

    test('embedded profiles are optional', () {
      final json = {
        'id': 'fr-1',
        'sender_id': 'a',
        'receiver_id': 'b',
        'status': 'accepted',
        'created_at': DateTime.utc(2026).toIso8601String(),
      };
      final m = FriendRequestModel.fromJson(json);
      expect(m.sender, isNull);
      expect(m.receiver, isNull);
    });

    test('status string parses into typed enum', () {
      for (final s in FriendRequestStatus.values) {
        final m = FriendRequestModel.fromJson({
          'id': 'x',
          'sender_id': 'a',
          'receiver_id': 'b',
          'status': s.name,
          'created_at': DateTime.utc(2026).toIso8601String(),
        });
        expect(m.toEntity().status, s);
      }
    });

    test('unknown status string falls back to pending', () {
      final m = FriendRequestModel.fromJson({
        'id': 'x',
        'sender_id': 'a',
        'receiver_id': 'b',
        'status': 'mystery',
        'created_at': DateTime.utc(2026).toIso8601String(),
      });
      expect(m.toEntity().status, FriendRequestStatus.pending);
    });

    test('toEntity hydrates sender/receiver entities from embedded models',
        () {
      final m = FriendRequestModel(
        id: 'fr-1',
        senderId: 'a',
        receiverId: 'b',
        status: 'pending',
        createdAt: DateTime.utc(2026),
        sender: const FriendProfileModel(id: 'a', displayName: 'Anna'),
        receiver: const FriendProfileModel(id: 'b', displayName: 'Ben'),
      );
      final e = m.toEntity();
      expect(e.senderProfile?.displayName, 'Anna');
      expect(e.receiverProfile?.displayName, 'Ben');
    });
  });
}

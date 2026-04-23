import 'package:freezed_annotation/freezed_annotation.dart';
import 'friend_profile.entity.dart';

part 'friend_request.entity.freezed.dart';

enum FriendRequestStatus { pending, accepted, declined }

@freezed
class FriendRequestEntity with _$FriendRequestEntity {
  const factory FriendRequestEntity({
    required String id,
    required String senderId,
    required String receiverId,
    required FriendRequestStatus status,
    required DateTime createdAt,
    FriendProfileEntity? senderProfile,
    FriendProfileEntity? receiverProfile,
  }) = _FriendRequestEntity;
}

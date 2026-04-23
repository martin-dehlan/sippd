import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/friend_request.entity.dart';
import 'friend_profile.model.dart';

part 'friend_request.model.freezed.dart';
part 'friend_request.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class FriendRequestModel with _$FriendRequestModel {
  const factory FriendRequestModel({
    required String id,
    @JsonKey(name: 'sender_id') required String senderId,
    @JsonKey(name: 'receiver_id') required String receiverId,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'sender') FriendProfileModel? sender,
    @JsonKey(name: 'receiver') FriendProfileModel? receiver,
  }) = _FriendRequestModel;

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestModelFromJson(json);
}

extension FriendRequestModelX on FriendRequestModel {
  FriendRequestEntity toEntity() => FriendRequestEntity(
        id: id,
        senderId: senderId,
        receiverId: receiverId,
        status: FriendRequestStatus.values.firstWhere(
          (s) => s.name == status,
          orElse: () => FriendRequestStatus.pending,
        ),
        createdAt: createdAt,
        senderProfile: sender?.toEntity(),
        receiverProfile: receiver?.toEntity(),
      );
}

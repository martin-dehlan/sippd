// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendRequestModelImpl _$$FriendRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$FriendRequestModelImpl(
  id: json['id'] as String,
  senderId: json['sender_id'] as String,
  receiverId: json['receiver_id'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  sender: json['sender'] == null
      ? null
      : FriendProfileModel.fromJson(json['sender'] as Map<String, dynamic>),
  receiver: json['receiver'] == null
      ? null
      : FriendProfileModel.fromJson(json['receiver'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$FriendRequestModelImplToJson(
  _$FriendRequestModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'sender_id': instance.senderId,
  'receiver_id': instance.receiverId,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
  'sender': instance.sender,
  'receiver': instance.receiver,
};

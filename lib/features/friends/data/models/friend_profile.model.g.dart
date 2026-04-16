// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_profile.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendProfileModelImpl _$$FriendProfileModelImplFromJson(
  Map<String, dynamic> json,
) => _$FriendProfileModelImpl(
  id: json['id'] as String,
  username: json['username'] as String?,
  displayName: json['display_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$$FriendProfileModelImplToJson(
  _$FriendProfileModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'display_name': instance.displayName,
  'avatar_url': instance.avatarUrl,
};

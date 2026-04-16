import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_profile.entity.freezed.dart';

@freezed
class FriendProfileEntity with _$FriendProfileEntity {
  const factory FriendProfileEntity({
    required String id,
    String? username,
    String? displayName,
    String? avatarUrl,
  }) = _FriendProfileEntity;
}

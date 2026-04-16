import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/friend_profile.entity.dart';

part 'friend_profile.model.freezed.dart';
part 'friend_profile.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class FriendProfileModel with _$FriendProfileModel {
  const factory FriendProfileModel({
    required String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _FriendProfileModel;

  factory FriendProfileModel.fromJson(Map<String, dynamic> json) =>
      _$FriendProfileModelFromJson(json);
}

extension FriendProfileModelX on FriendProfileModel {
  FriendProfileEntity toEntity() => FriendProfileEntity(
        id: id,
        username: username,
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
}

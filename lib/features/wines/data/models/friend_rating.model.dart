import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/friend_rating.entity.dart';

part 'friend_rating.model.freezed.dart';
part 'friend_rating.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class FriendRatingModel with _$FriendRatingModel {
  const factory FriendRatingModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'display_name') String? displayName,
    String? username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    required double rating,
    @JsonKey(name: 'rated_at') required DateTime ratedAt,
  }) = _FriendRatingModel;

  factory FriendRatingModel.fromJson(Map<String, dynamic> json) =>
      _$FriendRatingModelFromJson(json);
}

extension FriendRatingModelToEntity on FriendRatingModel {
  FriendRatingEntity toEntity() => FriendRatingEntity(
    userId: userId,
    displayName: displayName,
    username: username,
    avatarUrl: avatarUrl,
    rating: rating,
    ratedAt: ratedAt,
  );
}

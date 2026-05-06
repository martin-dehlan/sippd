import 'package:freezed_annotation/freezed_annotation.dart';

part 'friend_rating.entity.freezed.dart';

@freezed
class FriendRatingEntity with _$FriendRatingEntity {
  const factory FriendRatingEntity({
    required String userId,
    String? displayName,
    String? username,
    String? avatarUrl,
    required double rating,
    required DateTime ratedAt,
  }) = _FriendRatingEntity;
}

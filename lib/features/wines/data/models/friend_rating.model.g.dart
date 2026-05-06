// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_rating.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendRatingModelImpl _$$FriendRatingModelImplFromJson(
  Map<String, dynamic> json,
) => _$FriendRatingModelImpl(
  userId: json['user_id'] as String,
  displayName: json['display_name'] as String?,
  username: json['username'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  rating: (json['rating'] as num).toDouble(),
  ratedAt: DateTime.parse(json['rated_at'] as String),
);

Map<String, dynamic> _$$FriendRatingModelImplToJson(
  _$FriendRatingModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'display_name': instance.displayName,
  'username': instance.username,
  'avatar_url': instance.avatarUrl,
  'rating': instance.rating,
  'rated_at': instance.ratedAt.toIso8601String(),
};

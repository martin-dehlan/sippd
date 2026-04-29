// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drinking_partner.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DrinkingPartnerModelImpl _$$DrinkingPartnerModelImplFromJson(
  Map<String, dynamic> json,
) => _$DrinkingPartnerModelImpl(
  userId: json['user_id'] as String,
  username: json['username'] as String?,
  displayName: json['display_name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  sharedWines: (json['shared_wines'] as num).toInt(),
);

Map<String, dynamic> _$$DrinkingPartnerModelImplToJson(
  _$DrinkingPartnerModelImpl instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'username': instance.username,
  'display_name': instance.displayName,
  'avatar_url': instance.avatarUrl,
  'shared_wines': instance.sharedWines,
};

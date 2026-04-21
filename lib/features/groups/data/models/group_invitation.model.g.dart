// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_invitation.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupInvitationModelImpl _$$GroupInvitationModelImplFromJson(
  Map<String, dynamic> json,
) => _$GroupInvitationModelImpl(
  id: json['id'] as String,
  groupId: json['group_id'] as String,
  inviterId: json['inviter_id'] as String,
  inviteeId: json['invitee_id'] as String,
  status: json['status'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  respondedAt: json['responded_at'] == null
      ? null
      : DateTime.parse(json['responded_at'] as String),
);

Map<String, dynamic> _$$GroupInvitationModelImplToJson(
  _$GroupInvitationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'group_id': instance.groupId,
  'inviter_id': instance.inviterId,
  'invitee_id': instance.inviteeId,
  'status': instance.status,
  'created_at': instance.createdAt.toIso8601String(),
  'responded_at': instance.respondedAt?.toIso8601String(),
};

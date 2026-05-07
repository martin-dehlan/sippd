import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group_invitation.entity.dart';

part 'group_invitation.model.freezed.dart';
part 'group_invitation.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class GroupInvitationModel with _$GroupInvitationModel {
  const factory GroupInvitationModel({
    required String id,
    @JsonKey(name: 'group_id') required String groupId,
    @JsonKey(name: 'inviter_id') required String inviterId,
    @JsonKey(name: 'invitee_id') required String inviteeId,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
  }) = _GroupInvitationModel;

  factory GroupInvitationModel.fromJson(Map<String, dynamic> json) =>
      _$GroupInvitationModelFromJson(json);
}

extension GroupInvitationModelToEntity on GroupInvitationModel {
  GroupInvitationEntity toEntity() => GroupInvitationEntity(
    id: id,
    groupId: groupId,
    inviterId: inviterId,
    inviteeId: inviteeId,
    status: GroupInvitationStatus.values.firstWhere(
      (s) => s.name == status,
      orElse: () => GroupInvitationStatus.pending,
    ),
    createdAt: createdAt,
    respondedAt: respondedAt,
  );
}

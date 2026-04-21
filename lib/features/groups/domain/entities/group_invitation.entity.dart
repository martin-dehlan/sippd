import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_invitation.entity.freezed.dart';

enum GroupInvitationStatus { pending, accepted, declined }

@freezed
class GroupInvitationEntity with _$GroupInvitationEntity {
  const factory GroupInvitationEntity({
    required String id,
    required String groupId,
    required String inviterId,
    required String inviteeId,
    required GroupInvitationStatus status,
    required DateTime createdAt,
    DateTime? respondedAt,
  }) = _GroupInvitationEntity;
}

/// View model for the inbox: enriched with group + inviter info.
@freezed
class GroupInvitationInboxItem with _$GroupInvitationInboxItem {
  const factory GroupInvitationInboxItem({
    required GroupInvitationEntity invitation,
    required String groupName,
    String? groupImageUrl,
    String? inviterDisplayName,
    String? inviterUsername,
    String? inviterAvatarUrl,
  }) = _GroupInvitationInboxItem;
}

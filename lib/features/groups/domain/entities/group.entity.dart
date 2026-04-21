import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.entity.freezed.dart';

@freezed
class GroupEntity with _$GroupEntity {
  const factory GroupEntity({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
    required String inviteCode,
    required String createdBy,
    required DateTime createdAt,
    @Default(0) int memberCount,
    @Default(0) int wineCount,
  }) = _GroupEntity;
}

@freezed
class GroupMemberEntity with _$GroupMemberEntity {
  const factory GroupMemberEntity({
    required String groupId,
    required String userId,
    required String role,
    String? displayName,
    required DateTime joinedAt,
  }) = _GroupMemberEntity;
}

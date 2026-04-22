import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/group.entity.dart';

part 'group.model.freezed.dart';
part 'group.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class GroupModel with _$GroupModel {
  const factory GroupModel({
    required String id,
    required String name,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'invite_code') required String inviteCode,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _GroupModel;

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);
}

extension GroupModelX on GroupModel {
  GroupEntity toEntity({int memberCount = 0, int wineCount = 0}) =>
      GroupEntity(
        id: id,
        name: name,
        imageUrl: imageUrl,
        inviteCode: inviteCode,
        createdBy: createdBy,
        createdAt: createdAt,
        memberCount: memberCount,
        wineCount: wineCount,
      );
}

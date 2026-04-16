import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile.entity.dart';

part 'profile.model.freezed.dart';
part 'profile.model.g.dart';

@freezed
class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
    required String id,
    String? username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
}

extension ProfileModelX on ProfileModel {
  ProfileEntity toEntity() => ProfileEntity(
        id: id,
        username: username,
        displayName: displayName,
        avatarUrl: avatarUrl,
      );
}

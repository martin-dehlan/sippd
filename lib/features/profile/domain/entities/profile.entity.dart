import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.entity.freezed.dart';

@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String id,
    String? username,
    String? displayName,
    String? avatarUrl,
    @Default(false) bool onboardingCompleted,
  }) = _ProfileEntity;
}

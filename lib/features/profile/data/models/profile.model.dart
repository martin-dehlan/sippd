import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../onboarding/domain/onboarding_answers.dart';
import '../../../wines/domain/entities/wine.entity.dart';
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
    @JsonKey(name: 'onboarding_completed')
    @Default(false)
    bool onboardingCompleted,
    @JsonKey(name: 'taste_level') String? tasteLevel,
    @Default(<String>[]) List<String> goals,
    @Default(<String>[]) List<String> styles,
    @JsonKey(name: 'drink_frequency') String? drinkFrequency,
    @JsonKey(name: 'taste_emoji') String? tasteEmoji,
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
        onboardingCompleted: onboardingCompleted,
        tasteLevel: _enumByName(TasteLevel.values, tasteLevel),
        goals: goals
            .map((g) => _enumByName(OnboardingGoal.values, g))
            .whereType<OnboardingGoal>()
            .toSet(),
        styles: styles
            .map((s) => _enumByName(WineType.values, s))
            .whereType<WineType>()
            .toSet(),
        drinkFrequency: _enumByName(DrinkFrequency.values, drinkFrequency),
        tasteEmoji: tasteEmoji,
      );
}

T? _enumByName<T extends Enum>(List<T> values, String? name) {
  if (name == null) return null;
  for (final v in values) {
    if (v.name == name) return v;
  }
  return null;
}

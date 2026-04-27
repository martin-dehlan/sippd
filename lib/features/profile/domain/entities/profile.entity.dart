import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../onboarding/domain/onboarding_answers.dart';
import '../../../wines/domain/entities/wine.entity.dart';

part 'profile.entity.freezed.dart';

@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String id,
    String? username,
    String? displayName,
    String? avatarUrl,
    @Default(false) bool onboardingCompleted,
    TasteLevel? tasteLevel,
    @Default(<OnboardingGoal>{}) Set<OnboardingGoal> goals,
    @Default(<WineType>{}) Set<WineType> styles,
    DrinkFrequency? drinkFrequency,
    String? tasteEmoji,
  }) = _ProfileEntity;
}

extension ProfileEntityX on ProfileEntity {
  /// True if the profile already carries answers from the onboarding quiz —
  /// used by [OnboardingAnswersController] to decide whether to hydrate from
  /// server (cross-device) or fall back to the local SharedPreferences buffer.
  bool get hasTasteData =>
      tasteLevel != null ||
      drinkFrequency != null ||
      goals.isNotEmpty ||
      styles.isNotEmpty;

  OnboardingAnswers toOnboardingAnswers() => OnboardingAnswers(
    tasteLevel: tasteLevel,
    goals: goals,
    styles: styles,
    frequency: drinkFrequency,
    displayName: displayName,
    emoji: tasteEmoji,
    notificationsAsked: true,
  );
}

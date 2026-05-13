import 'package:flutter/widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/l10n/generated/app_localizations.dart';
import '../../wines/domain/entities/wine.entity.dart';

enum TasteLevel { beginner, curious, enthusiast, pro }

enum DrinkFrequency { weekly, monthly, rare }

enum OnboardingGoal { remember, discover, social, value }

class OnboardingAnswers {
  final TasteLevel? tasteLevel;
  final Set<OnboardingGoal> goals;
  final Set<WineType> styles;
  final DrinkFrequency? frequency;
  final String? displayName;
  final String? emoji;
  final bool notificationsAsked;

  const OnboardingAnswers({
    this.tasteLevel,
    this.goals = const {},
    this.styles = const {},
    this.frequency,
    this.displayName,
    this.emoji,
    this.notificationsAsked = false,
  });

  OnboardingAnswers copyWith({
    TasteLevel? tasteLevel,
    Set<OnboardingGoal>? goals,
    Set<WineType>? styles,
    DrinkFrequency? frequency,
    String? displayName,
    String? emoji,
    bool? notificationsAsked,
  }) => OnboardingAnswers(
    tasteLevel: tasteLevel ?? this.tasteLevel,
    goals: goals ?? this.goals,
    styles: styles ?? this.styles,
    frequency: frequency ?? this.frequency,
    displayName: displayName ?? this.displayName,
    emoji: emoji ?? this.emoji,
    notificationsAsked: notificationsAsked ?? this.notificationsAsked,
  );

  Map<String, dynamic> toJson() => {
    if (tasteLevel != null) 'tasteLevel': tasteLevel!.name,
    'goals': goals.map((g) => g.name).toList(),
    'styles': styles.map((s) => s.name).toList(),
    if (frequency != null) 'frequency': frequency!.name,
    if (displayName != null) 'displayName': displayName,
    if (emoji != null) 'emoji': emoji,
    'notificationsAsked': notificationsAsked,
  };

  factory OnboardingAnswers.fromJson(Map<String, dynamic> j) =>
      OnboardingAnswers(
        tasteLevel: _enumByName(TasteLevel.values, j['tasteLevel'] as String?),
        goals: ((j['goals'] as List?) ?? [])
            .map((e) => _enumByName(OnboardingGoal.values, e as String?))
            .whereType<OnboardingGoal>()
            .toSet(),
        styles: ((j['styles'] as List?) ?? [])
            .map((e) => _enumByName(WineType.values, e as String?))
            .whereType<WineType>()
            .toSet(),
        frequency: _enumByName(
          DrinkFrequency.values,
          j['frequency'] as String?,
        ),
        displayName: j['displayName'] as String?,
        emoji: j['emoji'] as String?,
        notificationsAsked: j['notificationsAsked'] as bool? ?? false,
      );
}

T? _enumByName<T extends Enum>(List<T> values, String? name) {
  if (name == null) return null;
  for (final v in values) {
    if (v.name == name) return v;
  }
  return null;
}

extension TasteLevelX on TasteLevel {
  String label(AppLocalizations l) => switch (this) {
    TasteLevel.beginner => l.onbLevelBeginnerLabel,
    TasteLevel.curious => l.onbLevelCuriousLabel,
    TasteLevel.enthusiast => l.onbLevelEnthusiastLabel,
    TasteLevel.pro => l.onbLevelProLabel,
  };

  String subtitle(AppLocalizations l) => switch (this) {
    TasteLevel.beginner => l.onbLevelBeginnerSubtitle,
    TasteLevel.curious => l.onbLevelCuriousSubtitle,
    TasteLevel.enthusiast => l.onbLevelEnthusiastSubtitle,
    TasteLevel.pro => l.onbLevelProSubtitle,
  };

  IconData get icon => switch (this) {
    TasteLevel.beginner => PhosphorIconsRegular.plant,
    TasteLevel.curious => PhosphorIconsRegular.compass,
    TasteLevel.enthusiast => PhosphorIconsRegular.wine,
    TasteLevel.pro => PhosphorIconsRegular.medal,
  };
}

extension DrinkFrequencyX on DrinkFrequency {
  String label(AppLocalizations l) => switch (this) {
    DrinkFrequency.weekly => l.onbFreqWeekly,
    DrinkFrequency.monthly => l.onbFreqMonthly,
    DrinkFrequency.rare => l.onbFreqRare,
  };

  IconData get icon => switch (this) {
    DrinkFrequency.weekly => PhosphorIconsRegular.calendarCheck,
    DrinkFrequency.monthly => PhosphorIconsRegular.calendar,
    DrinkFrequency.rare => PhosphorIconsRegular.hourglass,
  };
}

extension OnboardingGoalX on OnboardingGoal {
  String label(AppLocalizations l) => switch (this) {
    OnboardingGoal.remember => l.onbGoalRemember,
    OnboardingGoal.discover => l.onbGoalDiscover,
    OnboardingGoal.social => l.onbGoalSocial,
    OnboardingGoal.value => l.onbGoalValue,
  };

  String get emoji => switch (this) {
    OnboardingGoal.remember => '📖',
    OnboardingGoal.discover => '🧭',
    OnboardingGoal.social => '🥂',
    OnboardingGoal.value => '💶',
  };

  IconData get icon => switch (this) {
    OnboardingGoal.remember => PhosphorIconsRegular.bookmark,
    OnboardingGoal.discover => PhosphorIconsRegular.compass,
    OnboardingGoal.social => PhosphorIconsRegular.usersThree,
    OnboardingGoal.value => PhosphorIconsRegular.coins,
  };
}

extension WineTypeOnboardingX on WineType {
  String onboardingLabel(AppLocalizations l) => switch (this) {
    WineType.red => l.wineTypeRed,
    WineType.white => l.wineTypeWhite,
    WineType.rose => l.wineTypeRose,
    WineType.sparkling => l.wineTypeSparkling,
  };

  String get onboardingEmoji => switch (this) {
    WineType.red => '🍷',
    WineType.white => '🥂',
    WineType.rose => '🌸',
    WineType.sparkling => '🍾',
  };

  IconData get onboardingIcon => switch (this) {
    WineType.red => PhosphorIconsRegular.wine,
    WineType.white => PhosphorIconsRegular.wine,
    WineType.rose => PhosphorIconsRegular.wine,
    WineType.sparkling => PhosphorIconsRegular.champagne,
  };

  Color get onboardingIconTint => switch (this) {
    WineType.red => const Color(0xFFB06573),
    WineType.white => const Color(0xFFD9C17E),
    WineType.rose => const Color(0xFFD89AA8),
    WineType.sparkling => const Color(0xFFC7A955),
  };
}

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
  }) =>
      OnboardingAnswers(
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
        frequency:
            _enumByName(DrinkFrequency.values, j['frequency'] as String?),
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
  String get label => switch (this) {
        TasteLevel.beginner => 'Beginner',
        TasteLevel.curious => 'Curious',
        TasteLevel.enthusiast => 'Enthusiast',
        TasteLevel.pro => 'Pro',
      };

  String get subtitle => switch (this) {
        TasteLevel.beginner => 'Just starting out',
        TasteLevel.curious => 'A few favorites',
        TasteLevel.enthusiast => 'I know what I like',
        TasteLevel.pro => 'Somm-level',
      };
}

extension DrinkFrequencyX on DrinkFrequency {
  String get label => switch (this) {
        DrinkFrequency.weekly => 'Weekly',
        DrinkFrequency.monthly => 'A few times a month',
        DrinkFrequency.rare => 'Now and then',
      };
}

extension OnboardingGoalX on OnboardingGoal {
  String get label => switch (this) {
        OnboardingGoal.remember => 'Remember bottles I love',
        OnboardingGoal.discover => 'Discover new styles',
        OnboardingGoal.social => 'Taste with friends',
        OnboardingGoal.value => 'Track what I pay',
      };

  String get emoji => switch (this) {
        OnboardingGoal.remember => '📖',
        OnboardingGoal.discover => '🧭',
        OnboardingGoal.social => '🥂',
        OnboardingGoal.value => '💶',
      };
}

extension WineTypeOnboardingX on WineType {
  String get onboardingLabel => switch (this) {
        WineType.red => 'Red',
        WineType.white => 'White',
        WineType.rose => 'Rosé',
        WineType.sparkling => 'Sparkling',
      };

  String get onboardingEmoji => switch (this) {
        WineType.red => '🍷',
        WineType.white => '🥂',
        WineType.rose => '🌸',
        WineType.sparkling => '🍾',
      };
}

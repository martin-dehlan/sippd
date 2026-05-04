import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/onboarding/domain/onboarding_answers.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

void main() {
  group('OnboardingAnswers JSON', () {
    test('round-trips populated answers', () {
      const original = OnboardingAnswers(
        tasteLevel: TasteLevel.enthusiast,
        goals: {OnboardingGoal.remember, OnboardingGoal.discover},
        styles: {WineType.red, WineType.sparkling},
        frequency: DrinkFrequency.weekly,
        displayName: 'Martin',
        emoji: '🍷',
        notificationsAsked: true,
      );
      final round = OnboardingAnswers.fromJson(original.toJson());
      expect(round.tasteLevel, original.tasteLevel);
      expect(round.goals, original.goals);
      expect(round.styles, original.styles);
      expect(round.frequency, original.frequency);
      expect(round.displayName, original.displayName);
      expect(round.emoji, original.emoji);
      expect(round.notificationsAsked, isTrue);
    });

    test('omits null fields from toJson (server default takes over)', () {
      const blank = OnboardingAnswers();
      final j = blank.toJson();
      expect(j.containsKey('tasteLevel'), isFalse);
      expect(j.containsKey('frequency'), isFalse);
      expect(j.containsKey('displayName'), isFalse);
      expect(j['goals'], isEmpty);
      expect(j['styles'], isEmpty);
      expect(j['notificationsAsked'], isFalse);
    });

    test('drops unknown enum values silently on parse', () {
      final j = {
        'tasteLevel': 'mystery',
        'goals': ['remember', 'unknownGoal'],
        'styles': ['red', 'orange'],
        'frequency': 'rare',
      };
      final a = OnboardingAnswers.fromJson(j);
      expect(a.tasteLevel, isNull,
          reason: 'unknown taste level → null, not crash');
      expect(a.goals, {OnboardingGoal.remember});
      expect(a.styles, {WineType.red});
      expect(a.frequency, DrinkFrequency.rare);
    });

    test('notificationsAsked defaults to false when absent', () {
      final a = OnboardingAnswers.fromJson({});
      expect(a.notificationsAsked, isFalse);
    });
  });

  group('OnboardingAnswers.copyWith', () {
    test('replaces only the supplied fields', () {
      const start = OnboardingAnswers(
        tasteLevel: TasteLevel.beginner,
        goals: {OnboardingGoal.remember},
        notificationsAsked: false,
      );
      final next = start.copyWith(
        tasteLevel: TasteLevel.pro,
        notificationsAsked: true,
      );
      expect(next.tasteLevel, TasteLevel.pro);
      expect(next.notificationsAsked, isTrue);
      expect(next.goals, {OnboardingGoal.remember},
          reason: 'unspecified field carries over');
    });
  });
}

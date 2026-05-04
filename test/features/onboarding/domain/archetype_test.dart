import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/onboarding/domain/archetype.dart';
import 'package:sippd/features/onboarding/domain/onboarding_answers.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

void main() {
  group('archetypeFor', () {
    test('pro + weekly → Seasoned Somm', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.pro,
        frequency: DrinkFrequency.weekly,
      ));
      expect(a.title, 'Seasoned Somm');
    });

    test('pro + non-weekly → Sharp Palate', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.pro,
        frequency: DrinkFrequency.monthly,
      ));
      expect(a.title, 'Sharp Palate');
    });

    test('enthusiast + weekly → Cellar Regular', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.enthusiast,
        frequency: DrinkFrequency.weekly,
      ));
      expect(a.title, 'Cellar Regular');
    });

    test('enthusiast + non-weekly → Devoted Taster', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.enthusiast,
        frequency: DrinkFrequency.rare,
      ));
      expect(a.title, 'Devoted Taster');
    });

    test('curious + only red → Red Loyalist', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.curious,
        styles: {WineType.red},
      ));
      expect(a.title, 'Red Loyalist');
    });

    test('curious + only sparkling → Bubble Chaser', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.curious,
        styles: {WineType.sparkling},
      ));
      expect(a.title, 'Bubble Chaser');
    });

    test('curious + 3+ styles → Open Palate', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.curious,
        styles: {WineType.red, WineType.white, WineType.rose},
      ));
      expect(a.title, 'Open Palate');
    });

    test('curious + weekly + ambiguous styles → Steady Sipper', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.curious,
        styles: {WineType.red, WineType.white},
        frequency: DrinkFrequency.weekly,
      ));
      expect(a.title, 'Steady Sipper');
    });

    test('curious + monthly + ambiguous → Now-and-Then Taster', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.curious,
        styles: {WineType.red, WineType.white},
        frequency: DrinkFrequency.monthly,
      ));
      expect(a.title, 'Now-and-Then Taster');
    });

    test('curious + rare + ambiguous → Occasional Glass', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.curious,
        styles: {WineType.red, WineType.white},
        frequency: DrinkFrequency.rare,
      ));
      expect(a.title, 'Occasional Glass');
    });

    test('beginner → Fresh Palate regardless of other fields', () {
      final a = archetypeFor(const OnboardingAnswers(
        tasteLevel: TasteLevel.beginner,
        frequency: DrinkFrequency.weekly,
        styles: {WineType.red, WineType.white, WineType.sparkling},
      ));
      expect(a.title, 'Fresh Palate');
    });

    test('no level set → Wine Curious fallback', () {
      final a = archetypeFor(const OnboardingAnswers());
      expect(a.title, 'Wine Curious');
    });

    test('every result has a non-empty title and subtitle', () {
      // Smoke-test the full matrix so a future archetype rule
      // typo (empty string) is caught.
      for (final level in [...TasteLevel.values, null]) {
        for (final freq in [...DrinkFrequency.values, null]) {
          final a = archetypeFor(OnboardingAnswers(
            tasteLevel: level,
            frequency: freq,
          ));
          expect(a.title, isNotEmpty, reason: '$level + $freq');
          expect(a.subtitle, isNotEmpty, reason: '$level + $freq');
        }
      }
    });
  });
}

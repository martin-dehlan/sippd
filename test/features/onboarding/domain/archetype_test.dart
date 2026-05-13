import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/l10n/generated/app_localizations.dart';
import 'package:sippd/features/onboarding/domain/archetype.dart';
import 'package:sippd/features/onboarding/domain/onboarding_answers.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

void main() {
  late AppLocalizations l;

  setUpAll(() async {
    l = await AppLocalizations.delegate.load(const Locale('en'));
  });

  group('archetypeFor', () {
    test('pro + weekly → Seasoned Somm', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.pro,
          frequency: DrinkFrequency.weekly,
        ),
        l,
      );
      expect(a.title, l.onbArchSommTitle);
    });

    test('pro + non-weekly → Sharp Palate', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.pro,
          frequency: DrinkFrequency.monthly,
        ),
        l,
      );
      expect(a.title, l.onbArchPalateTitle);
    });

    test('enthusiast + weekly → Cellar Regular', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.enthusiast,
          frequency: DrinkFrequency.weekly,
        ),
        l,
      );
      expect(a.title, l.onbArchRegularTitle);
    });

    test('enthusiast + non-weekly → Devoted Taster', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.enthusiast,
          frequency: DrinkFrequency.rare,
        ),
        l,
      );
      expect(a.title, l.onbArchDevotedTitle);
    });

    test('curious + only red → Red Loyalist', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.curious,
          styles: {WineType.red},
        ),
        l,
      );
      expect(a.title, l.onbArchRedTitle);
    });

    test('curious + only sparkling → Bubble Chaser', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.curious,
          styles: {WineType.sparkling},
        ),
        l,
      );
      expect(a.title, l.onbArchBubbleTitle);
    });

    test('curious + 3+ styles → Open Palate', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.curious,
          styles: {WineType.red, WineType.white, WineType.rose},
        ),
        l,
      );
      expect(a.title, l.onbArchOpenTitle);
    });

    test('curious + weekly + ambiguous styles → Steady Sipper', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.curious,
          styles: {WineType.red, WineType.white},
          frequency: DrinkFrequency.weekly,
        ),
        l,
      );
      expect(a.title, l.onbArchSteadyTitle);
    });

    test('curious + monthly + ambiguous → Now-and-Then Taster', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.curious,
          styles: {WineType.red, WineType.white},
          frequency: DrinkFrequency.monthly,
        ),
        l,
      );
      expect(a.title, l.onbArchNowAndThenTitle);
    });

    test('curious + rare + ambiguous → Occasional Glass', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.curious,
          styles: {WineType.red, WineType.white},
          frequency: DrinkFrequency.rare,
        ),
        l,
      );
      expect(a.title, l.onbArchOccasionalTitle);
    });

    test('beginner → Fresh Palate regardless of other fields', () {
      final a = archetypeFor(
        const OnboardingAnswers(
          tasteLevel: TasteLevel.beginner,
          frequency: DrinkFrequency.weekly,
          styles: {WineType.red, WineType.white, WineType.sparkling},
        ),
        l,
      );
      expect(a.title, l.onbArchFreshTitle);
    });

    test('no level set → Wine Curious fallback', () {
      final a = archetypeFor(const OnboardingAnswers(), l);
      expect(a.title, l.onbArchCuriousTitle);
    });

    test('every result has a non-empty title and subtitle', () {
      for (final level in [...TasteLevel.values, null]) {
        for (final freq in [...DrinkFrequency.values, null]) {
          final a = archetypeFor(
            OnboardingAnswers(tasteLevel: level, frequency: freq),
            l,
          );
          expect(a.title, isNotEmpty, reason: '$level + $freq');
          expect(a.subtitle, isNotEmpty, reason: '$level + $freq');
        }
      }
    });
  });
}

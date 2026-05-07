import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/onboarding/domain/onboarding_answers.dart';
import 'package:sippd/features/profile/data/models/profile.model.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

void main() {
  ProfileModel sampleModel() => const ProfileModel(
    id: 'user-1',
    username: 'martin',
    displayName: 'Martin',
    avatarUrl: 'https://cdn/m.png',
    onboardingCompleted: true,
    tasteLevel: 'enthusiast',
    goals: ['remember', 'discover'],
    styles: ['red', 'white'],
    drinkFrequency: 'weekly',
    tasteEmoji: '🍷',
  );

  group('ProfileModel ↔ JSON', () {
    test('round-trips with snake_case keys', () {
      final json = sampleModel().toJson();
      expect(
        json.keys,
        containsAll([
          'display_name',
          'avatar_url',
          'onboarding_completed',
          'taste_level',
          'drink_frequency',
          'taste_emoji',
        ]),
      );
      expect(ProfileModel.fromJson(json), sampleModel());
    });

    test('defaults onboardingCompleted=false and empty lists when absent', () {
      final m = ProfileModel.fromJson({'id': 'u'});
      expect(m.onboardingCompleted, isFalse);
      expect(m.goals, isEmpty);
      expect(m.styles, isEmpty);
    });
  });

  group('ProfileModel → ProfileEntity', () {
    test('parses enum strings into typed values', () {
      final e = sampleModel().toEntity();
      expect(e.tasteLevel, TasteLevel.enthusiast);
      expect(e.drinkFrequency, DrinkFrequency.weekly);
      expect(e.goals, {OnboardingGoal.remember, OnboardingGoal.discover});
      expect(e.styles, {WineType.red, WineType.white});
    });

    test('drops unknown enum values silently', () {
      final m = sampleModel().copyWith(
        goals: ['remember', 'mystery_goal'],
        styles: ['red', 'orange'],
      );
      final e = m.toEntity();
      expect(e.goals, {OnboardingGoal.remember});
      expect(e.styles, {WineType.red});
    });

    test('null enum strings stay null', () {
      final e = const ProfileModel(id: 'u').toEntity();
      expect(e.tasteLevel, isNull);
      expect(e.drinkFrequency, isNull);
    });
  });

  group('ProfileModel ↔ ProfileTableData', () {
    test('CSV-encodes lists then round-trips through Drift row', () {
      final original = sampleModel();
      final round = original.toTableData().toModel();
      expect(round.goals, original.goals);
      expect(round.styles, original.styles);
    });

    test('empty CSV survives round-trip as empty list', () {
      final m = const ProfileModel(id: 'u');
      final round = m.toTableData().toModel();
      expect(round.goals, isEmpty);
      expect(round.styles, isEmpty);
    });
  });
}

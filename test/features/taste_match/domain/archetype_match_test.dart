import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/taste_match/domain/archetype_match.dart';
import 'package:sippd/features/taste_match/domain/entities/taste_compass.entity.dart';
import 'package:sippd/features/taste_match/domain/entities/user_style_dna.entity.dart';

void main() {
  TasteCompassEntity compass({int total = 30}) =>
      TasteCompassEntity(totalCount: total);

  UserStyleDna dna(Map<String, double> values,
          {int attributedCount = 20, double confidence = 0.9}) =>
      UserStyleDna(
        values: values,
        attributedCount: attributedCount,
        confidence: confidence,
      );

  group('matchArchetype thresholds', () {
    test('newcomer when totalCount < 5', () {
      final m = matchArchetype(
        const TasteCompassEntity(totalCount: 4),
        dna(const {'body': 0.5}, attributedCount: 5),
      );
      expect(m.archetype.id, 'curious_newcomer');
      expect(m.score, 0);
      expect(m.confidence, 0);
      expect(m.isNewcomer, isTrue);
    });

    test('newcomer when DNA is null', () {
      final m = matchArchetype(compass(), null);
      expect(m.archetype.id, 'curious_newcomer');
    });

    test('newcomer when attributedCount < 3', () {
      final m =
          matchArchetype(compass(), dna({'body': 0.5}, attributedCount: 2));
      expect(m.archetype.id, 'curious_newcomer');
    });
  });

  group('matchArchetype scoring', () {
    test('big-bold-red DNA matches Bold Red Hunter', () {
      // Vector close to Bold Red Hunter target.
      final m = matchArchetype(
        compass(),
        dna({
          'body': 0.85,
          'tannin': 0.85,
          'acidity': 0.55,
          'sweetness': 0.0,
          'oak': 0.65,
          'intensity': 0.75,
        }),
      );
      expect(m.archetype.id, 'bold_red_hunter');
      expect(m.score, greaterThan(80),
          reason: 'near-perfect vector should score high');
      expect(m.isTentative, isFalse,
          reason: 'confidence 0.9 → not tentative');
    });

    test('light-acid-low-tannin matches Elegant Burgundian, not Bold Red',
        () {
      final m = matchArchetype(
        compass(),
        dna({
          'body': 0.35,
          'tannin': 0.3,
          'acidity': 0.75,
          'sweetness': 0.0,
          'oak': 0.4,
          'intensity': 0.6,
        }),
      );
      expect(m.archetype.id, 'elegant_burgundian');
    });

    test('low confidence DNA flips to tentative', () {
      final m = matchArchetype(
        compass(),
        dna({'body': 0.85, 'tannin': 0.85, 'acidity': 0.55,
              'sweetness': 0.0, 'oak': 0.65, 'intensity': 0.75},
            confidence: 0.3),
      );
      expect(m.isTentative, isTrue);
    });

    test('score is bounded to 0..100 even with strong contextual bonus',
        () {
      final m = matchArchetype(
        compass(),
        dna({
          'body': 0.85,
          'tannin': 0.85,
          'acidity': 0.55,
          'sweetness': 0.0,
          'oak': 0.65,
          'intensity': 0.75,
        }),
      );
      expect(m.score, lessThanOrEqualTo(100));
      expect(m.score, greaterThanOrEqualTo(0));
    });
  });
}

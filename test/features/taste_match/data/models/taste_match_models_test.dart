import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/taste_match/data/models/shared_bottle.model.dart';
import 'package:sippd/features/taste_match/data/models/taste_compass.model.dart';
import 'package:sippd/features/taste_match/data/models/taste_match.model.dart';
import 'package:sippd/features/taste_match/domain/entities/taste_match.entity.dart';

void main() {
  group('TasteMatchModel', () {
    test('round-trips with snake_case keys + nullable score', () {
      const original = TasteMatchModel(
        score: 78,
        confidence: 'high',
        overlapCount: 12,
        myTotal: 30,
        theirTotal: 42,
        reason: null,
        bucketScore: 80,
        dnaScore: 76,
        sameCanonicalPairs: 5,
        agreePairs: 4,
        disagreePairs: 1,
      );
      final round = TasteMatchModel.fromJson(original.toJson());
      expect(round, original);
      // Lock the snake_case wire layout — RPC depends on these keys.
      expect(
        original.toJson().keys,
        containsAll([
          'overlap_count',
          'my_total',
          'their_total',
          'bucket_score',
          'dna_score',
          'same_canonical_pairs',
          'agree_pairs',
          'disagree_pairs',
        ]),
      );
    });

    test('confidence string parses into typed enum', () {
      for (final s in ['low', 'medium', 'high']) {
        final m = TasteMatchModel.fromJson({'confidence': s}).toEntity();
        expect(m.confidence?.name, s);
      }
    });

    test('unknown confidence string parses to null (no crash)', () {
      final m = TasteMatchModel.fromJson({'confidence': 'mystery'}).toEntity();
      expect(m.confidence, isNull);
    });

    test('reason string parses into typed unavailable reason', () {
      const cases = {
        'unavailable': MatchUnavailableReason.unavailable,
        'not_enough_ratings': MatchUnavailableReason.notEnoughRatings,
        'not_enough_overlap': MatchUnavailableReason.notEnoughOverlap,
      };
      cases.forEach((raw, expected) {
        final m = TasteMatchModel.fromJson({'reason': raw}).toEntity();
        expect(m.reason, expected);
      });
    });

    test('defaults: empty payload still produces a usable entity', () {
      final m = TasteMatchModel.fromJson({}).toEntity();
      expect(m.score, isNull);
      expect(m.overlapCount, 0);
      expect(m.myTotal, 0);
      expect(m.sameCanonicalPairs, 0);
    });
  });

  group('TasteCompassModel', () {
    test('round-trips through wire encoding (jsonEncode/decode)', () {
      const original = TasteCompassModel(
        totalCount: 10,
        overallAvg: 7.4,
        topRegions: [
          CompassBucketModel(region: 'Toscana', count: 3, avgRating: 8.0),
        ],
        topCountries: [
          CompassBucketModel(country: 'IT', count: 5, avgRating: 7.8),
        ],
        typeBreakdown: [
          CompassBucketModel(type: 'red', count: 7, avgRating: 7.5),
        ],
      );
      final wire =
          jsonDecode(jsonEncode(original.toJson())) as Map<String, dynamic>;
      final round = TasteCompassModel.fromJson(wire);
      expect(round, original);
    });

    test('CompassBucket.toEntity picks region > country > type', () {
      const r = CompassBucketModel(region: 'X', count: 1, avgRating: 5);
      const c = CompassBucketModel(country: 'Y', count: 1, avgRating: 5);
      const t = CompassBucketModel(type: 'red', count: 1, avgRating: 5);
      expect(r.toEntity().label, 'X');
      expect(c.toEntity().label, 'Y');
      expect(t.toEntity().label, 'red');
    });

    test('CompassBucket falls back to empty label when all axes null', () {
      const b = CompassBucketModel(count: 1, avgRating: 5);
      expect(b.toEntity().label, '');
    });
  });

  group('SharedBottleModel', () {
    test('round-trips with snake_case keys', () {
      final original = SharedBottleModel(
        groupId: 'g-1',
        wineId: 'w-1',
        wineName: 'Brunello',
        winery: 'Biondi-Santi',
        region: 'Toscana',
        country: 'IT',
        type: 'red',
        vintage: 2018,
        myRating: 9,
        theirRating: 7,
        delta: 2,
        ratedAt: DateTime.utc(2026, 5, 1),
      );
      expect(
        original.toJson().keys,
        containsAll([
          'group_id',
          'wine_id',
          'wine_name',
          'my_rating',
          'their_rating',
          'rated_at',
        ]),
      );
      expect(SharedBottleModel.fromJson(original.toJson()), original);
    });

    test('ratedAt is optional', () {
      final m = SharedBottleModel.fromJson({
        'group_id': 'g',
        'wine_id': 'w',
        'wine_name': 'X',
        'type': 'red',
        'my_rating': 7.0,
        'their_rating': 8.0,
        'delta': 1.0,
      });
      expect(m.ratedAt, isNull);
    });
  });
}

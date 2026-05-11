import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/wines/data/models/rating_summary.model.dart';

void main() {
  group('RatingSummaryModel.fromJson', () {
    test('parses a full RPC payload', () {
      final payload = {
        'distinct_wine_count': 12,
        'avg_rating': 8.4,
        'personal_count': 7,
        'group_count': 4,
        'tasting_count': 3,
        'by_type': [
          {'type': 'red', 'count': 8, 'avg': 8.5},
          {'type': 'white', 'count': 4, 'avg': 7.9},
        ],
        'by_month': [
          {'month': '2026-05', 'count': 3, 'avg': 8.0},
        ],
        'by_country': [
          {'country': 'Italy', 'count': 6, 'avg': 8.6},
        ],
        'by_region': [
          {'region': 'Tuscany', 'count': 4, 'avg': 8.8},
        ],
      };

      final m = RatingSummaryModel.fromJson(payload);

      expect(m.distinctWineCount, 12);
      expect(m.avgRating, 8.4);
      expect(m.personalCount, 7);
      expect(m.groupCount, 4);
      expect(m.tastingCount, 3);
      expect(m.byType, hasLength(2));
      expect(m.byType.first.type, 'red');
      expect(m.byType.first.avg, 8.5);
      expect(m.byMonth.single.month, '2026-05');
      expect(m.byCountry.single.country, 'Italy');
      expect(m.byRegion.single.region, 'Tuscany');
    });

    test('handles null avg_rating (empty user)', () {
      final payload = {
        'distinct_wine_count': 0,
        'avg_rating': null,
        'personal_count': 0,
        'group_count': 0,
        'tasting_count': 0,
        'by_type': [],
        'by_month': [],
        'by_country': [],
        'by_region': [],
      };
      final m = RatingSummaryModel.fromJson(payload);
      expect(m.avgRating, isNull);
      expect(m.distinctWineCount, 0);
    });

    test('coerces whole-number avg to double (PG numeric → JSON int)', () {
      // round(8.0, 2) may serialize as `8` (int) over the wire; the
      // _toDouble converter must accept either.
      final payload = {
        'distinct_wine_count': 1,
        'avg_rating': 8,
        'personal_count': 1,
        'group_count': 0,
        'tasting_count': 0,
        'by_type': [
          {'type': 'red', 'count': 1, 'avg': 8},
        ],
        'by_month': [
          {'month': '2026-05', 'count': 1, 'avg': 8},
        ],
        'by_country': [],
        'by_region': [],
      };
      final m = RatingSummaryModel.fromJson(payload);
      expect(m.avgRating, 8.0);
      expect(m.byType.single.avg, 8.0);
      expect(m.byMonth.single.avg, 8.0);
    });

    test('empty() constructor produces zero-state', () {
      final m = RatingSummaryModel.empty();
      expect(m.distinctWineCount, 0);
      expect(m.avgRating, isNull);
      expect(m.personalCount, 0);
      expect(m.byType, isEmpty);
    });
  });
}

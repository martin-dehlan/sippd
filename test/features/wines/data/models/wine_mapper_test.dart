import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/wines/data/models/wine.mapper.dart';
import 'package:sippd/features/wines/data/models/wine.model.dart';
import 'package:sippd/features/wines/domain/entities/wine.entity.dart';

void main() {
  // Round-trips guard against schema drift between the three wine
  // shapes (Drift TableData, Supabase Model, domain Entity). If a new
  // field gets added to one but not propagated, these break first.

  WineEntity sampleEntity({String type = 'red'}) => WineEntity(
    id: 'wine-1',
    name: 'Brunello',
    rating: 9.2,
    type: WineType.values.firstWhere((t) => t.name == type),
    price: 45.50,
    currency: 'EUR',
    country: 'IT',
    region: 'Toscana',
    location: 'Montalcino',
    latitude: 43.05,
    longitude: 11.49,
    notes: 'Long finish.',
    imageUrl: 'https://cdn/a.jpg',
    localImagePath: '/tmp/a.jpg',
    vintage: 2018,
    grape: 'Sangiovese',
    canonicalGrapeId: 'grape-1',
    grapeFreetext: 'Sangiovese Grosso',
    canonicalWineId: 'canon-1',
    winery: 'Biondi-Santi',
    nameNorm: 'brunello',
    userId: 'user-1',
    visibility: 'friends',
    createdAt: DateTime.utc(2026, 1, 1),
    updatedAt: DateTime.utc(2026, 5, 4),
  );

  group('Entity ↔ Model round-trip', () {
    test('preserves every field through toModel.toEntity', () {
      final original = sampleEntity();
      final round = original.toModel().toEntity();
      expect(round, original);
    });

    test('serializes and deserializes via JSON without loss', () {
      final original = sampleEntity();
      final json = original.toModel().toJson();
      // localImagePath is intentionally excluded from toJson.
      expect(json.containsKey('local_image_path'), isFalse);
      final round = WineModel.fromJson(json).toEntity();
      // The local-only field disappears across the network boundary.
      expect(round.localImagePath, isNull);
      // Everything else round-trips.
      expect(round.copyWith(localImagePath: original.localImagePath), original);
    });

    test('all four wine types round-trip through name string', () {
      for (final t in WineType.values) {
        final e = sampleEntity(type: t.name);
        expect(e.toModel().toEntity().type, t);
      }
    });

    test('unknown type string falls back to red', () {
      final raw = sampleEntity().toModel().toJson()..['type'] = 'mead';
      expect(WineModel.fromJson(raw).toEntity().type, WineType.red);
    });
  });

  group('Entity ↔ TableData round-trip', () {
    test('preserves every field', () {
      final original = sampleEntity();
      final round = original.toTableData().toEntity();
      expect(round, original);
    });

    test('localImagePath round-trips locally (unlike Supabase)', () {
      final original = sampleEntity();
      final round = original.toTableData().toEntity();
      expect(round.localImagePath, '/tmp/a.jpg');
    });
  });

  group('Snake-case field mapping', () {
    test('JSON keys match the Supabase column names', () {
      final json = sampleEntity().toModel().toJson();
      expect(
        json.keys,
        containsAll([
          'image_url',
          'canonical_grape_id',
          'grape_freetext',
          'canonical_wine_id',
          'name_norm',
          'user_id',
          'created_at',
          'updated_at',
        ]),
      );
    });
  });
}

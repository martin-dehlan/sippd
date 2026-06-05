import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/features/scanner/data/models/scan_result.model.dart';

/// What these catch: the Edge Function → Dart JSON contract (key names,
/// null-tolerance, list defaults) and the model→entity mapping the whole
/// feature reads through. What they miss: that the Edge Function actually
/// emits these keys (contract is asserted here, not verified end-to-end).
void main() {
  Map<String, dynamic> fullJson() => {
    'result': {
      'producer': 'Château Test',
      'wineName': 'Grand Cuvée',
      'vintage': 2019,
      'appellation': 'Saint-Émilion',
      'country': 'France',
      'region': 'Bordeaux',
      'grapes': ['Merlot', 'Cabernet Franc'],
      'tastingNotes': 'Plum, leather, fine tannins.',
      'servingTempC': 17,
      'decantMinutes': 60,
      'foodPairings': ['Lamb', 'Aged cheese'],
    },
    'quota': {'used': 2, 'limit': 5, 'remaining': 3},
    'mock': false,
  };

  group('ScanResponseModel.fromJson', () {
    test('parses a fully-populated envelope', () {
      final m = ScanResponseModel.fromJson(fullJson());

      expect(m.result.producer, 'Château Test');
      expect(m.result.wineName, 'Grand Cuvée');
      expect(m.result.vintage, 2019);
      expect(m.result.grapes, ['Merlot', 'Cabernet Franc']);
      expect(m.result.servingTempC, 17);
      expect(m.quota.remaining, 3);
      expect(m.mock, isFalse);
    });

    test(
      'tolerates a sparse result — nullable fields stay null, lists empty',
      () {
        final m = ScanResponseModel.fromJson(<String, dynamic>{
          'result': <String, dynamic>{'producer': 'Solo'},
          'quota': <String, dynamic>{'used': 0, 'limit': 5, 'remaining': 5},
        });

        expect(m.result.producer, 'Solo');
        expect(m.result.wineName, isNull);
        expect(m.result.vintage, isNull);
        expect(m.result.grapes, isEmpty);
        expect(m.result.foodPairings, isEmpty);
        expect(m.mock, isFalse); // defaults when absent
      },
    );

    test('mock flag round-trips', () {
      final m = ScanResponseModel.fromJson(<String, dynamic>{
        'result': <String, dynamic>{},
        'quota': <String, dynamic>{},
        'mock': true,
      });
      expect(m.mock, isTrue);
    });
  });

  group('toEntity', () {
    test('maps every field plus quota and mock flag', () {
      final e = ScanResponseModel.fromJson(fullJson()).toEntity();

      expect(e.producer, 'Château Test');
      expect(e.wineName, 'Grand Cuvée');
      expect(e.region, 'Bordeaux');
      expect(e.grapes, ['Merlot', 'Cabernet Franc']);
      expect(e.decantMinutes, 60);
      expect(e.quota.used, 2);
      expect(e.quota.remaining, 3);
      expect(e.isMock, isFalse);
    });

    test('displayName prefers wineName, falls back to producer', () {
      final named = ScanResponseModel.fromJson(fullJson()).toEntity();
      expect(named.displayName, 'Grand Cuvée');

      final producerOnly = ScanResponseModel.fromJson(<String, dynamic>{
        'result': <String, dynamic>{'producer': 'Solo'},
        'quota': <String, dynamic>{},
      }).toEntity();
      expect(producerOnly.displayName, 'Solo');
    });

    test('quota entity exposes exhaustion', () {
      final exhausted = ScanResponseModel.fromJson(<String, dynamic>{
        'result': <String, dynamic>{},
        'quota': <String, dynamic>{'used': 5, 'limit': 5, 'remaining': 0},
      }).toEntity().quota;
      expect(exhausted.isExhausted, isTrue);
    });
  });
}

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/errors/app_error.dart';
import 'package:sippd/features/scanner/data/data_sources/scanner.api.dart';
import 'package:sippd/features/scanner/data/models/scan_result.model.dart';
import 'package:sippd/features/scanner/data/repositories/scanner.repository.impl.dart';

class MockScannerApi extends Mock implements ScannerApi {}

class _FakeFile extends Fake implements File {}

/// What these catch: the repository delegating to the api and translating
/// the typed [ScanQuotaExceeded] into the [AppError.validation] the UI
/// keys on to show the daily-limit block + manual-entry fallback.
/// What they miss: the real Edge Function call and the JWT it carries.
void main() {
  setUpAll(() => registerFallbackValue(_FakeFile()));

  late MockScannerApi api;
  final image = _FakeFile();

  ScanResponseModel okResponse() => ScanResponseModel.fromJson({
    'result': {'producer': 'Château Test'},
    'quota': {'used': 1, 'limit': 5, 'remaining': 4},
  });

  setUp(() => api = MockScannerApi());

  group('recognize', () {
    test('delegates to api, returns mapped entity', () async {
      when(
        () => api.recognize(any(), lang: any(named: 'lang')),
      ).thenAnswer((_) async => okResponse());

      final repo = ScannerRepositoryImpl(api);
      final result = await repo.recognize(image, lang: 'en');

      expect(result.producer, 'Château Test');
      expect(result.quota.remaining, 4);
      verify(() => api.recognize(image, lang: 'en')).called(1);
    });

    test(
      'maps ScanQuotaExceeded to AppError.validation(field: scan_quota)',
      () async {
        when(() => api.recognize(any(), lang: any(named: 'lang'))).thenThrow(
          const ScanQuotaExceeded(
            ScanQuotaModel(used: 5, limit: 5, remaining: 0),
          ),
        );

        final repo = ScannerRepositoryImpl(api);

        await expectLater(
          repo.recognize(image),
          throwsA(
            isA<ValidationError>().having(
              (e) => e.field,
              'field',
              'scan_quota',
            ),
          ),
        );
      },
    );
  });

  group('quotaStatus', () {
    test('returns mapped entity', () async {
      when(() => api.quotaStatus()).thenAnswer(
        (_) async => const ScanQuotaModel(used: 2, limit: 5, remaining: 3),
      );

      final repo = ScannerRepositoryImpl(api);
      final q = await repo.quotaStatus();

      expect(q?.remaining, 3);
      expect(q?.isExhausted, isFalse);
    });

    test('swallows api failure — best-effort badge hides on error', () async {
      when(() => api.quotaStatus()).thenThrow(Exception('offline'));

      final repo = ScannerRepositoryImpl(api);
      expect(await repo.quotaStatus(), isNull);
    });
  });
}

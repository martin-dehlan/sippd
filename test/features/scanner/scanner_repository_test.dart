import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sippd/common/errors/app_error.dart';
import 'package:sippd/features/scanner/data/data_sources/scanner.api.dart';
import 'package:sippd/features/scanner/data/models/scan_result.model.dart';
import 'package:sippd/features/scanner/data/repositories/scanner.repository.impl.dart';

class MockScannerApi extends Mock implements ScannerApi {}

class _FakeFile extends Fake implements File {}

/// What these catch: the repository's two jobs — threading the client-side
/// Pro flag into the api, and translating the typed [ScanQuotaExceeded]
/// into the [AppError.validation] the UI keys on to open the paywall.
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
        () => api.recognize(
          any(),
          lang: any(named: 'lang'),
          isPro: any(named: 'isPro'),
        ),
      ).thenAnswer((_) async => okResponse());

      final repo = ScannerRepositoryImpl(api, () => false);
      final result = await repo.recognize(image, lang: 'en');

      expect(result.producer, 'Château Test');
      expect(result.quota.remaining, 4);
    });

    test('forwards the resolved Pro flag to the api', () async {
      when(
        () => api.recognize(
          any(),
          lang: any(named: 'lang'),
          isPro: any(named: 'isPro'),
        ),
      ).thenAnswer((_) async => okResponse());

      final repo = ScannerRepositoryImpl(api, () => true);
      await repo.recognize(image);

      verify(() => api.recognize(image, lang: 'en', isPro: true)).called(1);
    });

    test(
      'maps ScanQuotaExceeded to AppError.validation(field: scan_quota)',
      () async {
        when(
          () => api.recognize(
            any(),
            lang: any(named: 'lang'),
            isPro: any(named: 'isPro'),
          ),
        ).thenThrow(
          const ScanQuotaExceeded(
            ScanQuotaModel(used: 5, limit: 5, remaining: 0),
          ),
        );

        final repo = ScannerRepositoryImpl(api, () => false);

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
      when(() => api.quotaStatus(isPro: any(named: 'isPro'))).thenAnswer(
        (_) async => const ScanQuotaModel(used: 2, limit: 5, remaining: 3),
      );

      final repo = ScannerRepositoryImpl(api, () => false);
      final q = await repo.quotaStatus();

      expect(q?.remaining, 3);
      expect(q?.isExhausted, isFalse);
    });

    test('swallows api failure — best-effort badge hides on error', () async {
      when(
        () => api.quotaStatus(isPro: any(named: 'isPro')),
      ).thenThrow(Exception('offline'));

      final repo = ScannerRepositoryImpl(api, () => false);
      expect(await repo.quotaStatus(), isNull);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sippd/features/paywall/controller/paywall.provider.dart';

import '../../../helpers/mocks.dart';
import '../../../helpers/pump_provider_app.dart';

void main() {
  setUpAll(registerTestFallbacks);

  late MockPaywallService service;

  setUp(() {
    service = MockPaywallService();
    // Default: empty stream so isProProvider falls back to the
    // service's cached isPro getter.
    when(() => service.customerInfoStream)
        .thenAnswer((_) => const Stream<CustomerInfo>.empty());
  });

  group('isProProvider — fallback path (stream not yet emitted)', () {
    test('returns service.isPro=false when stream has no value', () async {
      when(() => service.isPro).thenReturn(false);

      final c = makeContainer(
        overrides: [paywallProvider.overrideWithValue(service)],
      );
      // Touch the stream provider so it surfaces null on first read.
      await Future<void>.delayed(Duration.zero);
      expect(c.read(isProProvider), isFalse);
    });

    test('returns service.isPro=true when stream has no value', () async {
      when(() => service.isPro).thenReturn(true);

      final c = makeContainer(
        overrides: [paywallProvider.overrideWithValue(service)],
      );
      await Future<void>.delayed(Duration.zero);
      expect(c.read(isProProvider), isTrue);
    });
  });

  group('currentCustomerInfoProvider — fallback to service.currentInfo',
      () {
    test('returns null when neither stream nor service has a value',
        () async {
      when(() => service.currentInfo).thenReturn(null);

      final c = makeContainer(
        overrides: [paywallProvider.overrideWithValue(service)],
      );
      await Future<void>.delayed(Duration.zero);
      expect(c.read(currentCustomerInfoProvider), isNull);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:sippd/common/errors/app_error.dart';
import 'package:sippd/common/widgets/inline_error.widget.dart';

void main() {
  group('AppError union', () {
    test('network defaults message and exposes optional fields', () {
      const e = AppError.network();
      expect(e, isA<NetworkError>());
      expect((e as NetworkError).message, 'Network unavailable.');
      expect(e.statusCode, isNull);
      expect(e.endpoint, isNull);
    });

    test('network propagates explicit fields', () {
      const e = AppError.network(
        message: 'Boom',
        statusCode: 503,
        endpoint: '/wines',
      );
      expect((e as NetworkError).message, 'Boom');
      expect(e.statusCode, 503);
      expect(e.endpoint, '/wines');
    });

    test('offline is its own subtype distinct from network', () {
      const e = AppError.offline();
      expect(e, isA<OfflineError>());
      expect(e, isNot(isA<NetworkError>()));
    });

    test('validation requires message and accepts field', () {
      const e = AppError.validation(message: 'Required', field: 'name');
      expect((e as ValidationError).message, 'Required');
      expect(e.field, 'name');
    });

    test('notFound captures resource identity', () {
      const e = AppError.notFound(
        message: 'Missing',
        resourceType: 'wine',
        resourceId: 'abc',
      );
      expect((e as NotFoundError).resourceType, 'wine');
      expect(e.resourceId, 'abc');
    });

    test('serverError carries status code', () {
      const e = AppError.serverError(message: 'oops', statusCode: 500);
      expect((e as ServerError).statusCode, 500);
    });

    test('unknown wraps the originating error', () {
      final cause = StateError('boom');
      final e = AppError.unknown(message: 'wrap', originalError: cause);
      expect((e as UnknownError).originalError, cause);
    });
  });

  group('describeAppError', () {
    test('OfflineError → friendly offline copy', () {
      expect(describeAppError(const AppError.offline()),
          contains('offline'));
    });

    test('NetworkError → friendly network copy', () {
      expect(describeAppError(const AppError.network()),
          contains('Network'));
    });

    test('non-AppError falls back to default message', () {
      expect(describeAppError(StateError('boom')),
          'Something went wrong.');
    });

    test('non-AppError uses caller-supplied fallback', () {
      expect(
        describeAppError(StateError('boom'), fallback: 'Try later.'),
        'Try later.',
      );
    });

    test('non-network AppError falls through to fallback', () {
      // The describe* function is intentionally narrow — only
      // network-class errors get their own copy. Everything else
      // uses the caller's fallback. Lock this in so a future
      // refactor doesn't accidentally widen it.
      expect(
        describeAppError(
          const AppError.validation(message: 'bad'),
          fallback: 'Custom.',
        ),
        'Custom.',
      );
    });
  });
}

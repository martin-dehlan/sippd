# Error Handling Rules

**TL;DR:** All errors funnel through `AppError` (Freezed union). Repositories catch exceptions and map to `AppError`. Controllers use `AsyncValue.guard`. UI uses `.when()` with `ErrorState` widget. User-facing errors show as SnackBars.

---

## AppError Union

File: `lib/common/errors/app_error.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError implements Exception {
  const factory AppError.network({
    String? message,
    int?    statusCode,
  }) = NetworkError;

  const factory AppError.database({
    required String message,
    Object? cause,
  }) = DatabaseError;

  const factory AppError.validation({
    required String field,
    required String message,
  }) = ValidationError;

  const factory AppError.notFound({
    required String resource,
  }) = NotFoundError;

  const factory AppError.unauthorized() = UnauthorizedError;

  const factory AppError.serverError({
    String? message,
    int?    statusCode,
  }) = ServerError;

  const factory AppError.unknown({
    required Object cause,
    StackTrace? stackTrace,
  }) = UnknownError;
}

extension AppErrorX on AppError {
  String get userMessage => when(
    network:    (msg, _)        => msg ?? 'No internet connection. Using cached data.',
    database:   (msg, _)        => 'Local data error: $msg',
    validation: (field, msg)    => '$field: $msg',
    notFound:   (resource)      => '$resource not found.',
    unauthorized: ()            => 'Please sign in to continue.',
    serverError: (msg, code)    => msg ?? 'Server error (${code ?? '?'}). Try again.',
    unknown:    (cause, _)      => 'Something went wrong. Please try again.',
  );
}
```

---

## ErrorMapper

File: `lib/common/errors/error_mapper.dart`

```dart
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app_error.dart';

class ErrorMapper {
  static AppError fromException(Object error, [StackTrace? st]) {
    if (error is AppError) return error;

    // Dio (HTTP client)
    if (error is DioException) {
      return switch (error.type) {
        DioExceptionType.connectionError ||
        DioExceptionType.connectionTimeout ||
        DioExceptionType.receiveTimeout  => const AppError.network(),
        _ => switch (error.response?.statusCode) {
          401 => const AppError.unauthorized(),
          404 => AppError.notFound(resource: error.requestOptions.path),
          >= 500 => AppError.serverError(statusCode: error.response?.statusCode),
          _ => AppError.unknown(cause: error, stackTrace: st),
        },
      };
    }

    // Supabase
    if (error is PostgrestException) {
      return switch (error.code) {
        'PGRST116' => AppError.notFound(resource: 'record'),
        '42501'    => const AppError.unauthorized(),
        _          => AppError.serverError(message: error.message),
      };
    }

    if (error is AuthException) {
      return const AppError.unauthorized();
    }

    // Drift / SQLite
    if (error.toString().contains('SqliteException') ||
        error.toString().contains('DriftWrappedException')) {
      return AppError.database(message: error.toString(), cause: error);
    }

    return AppError.unknown(cause: error, stackTrace: st);
  }
}
```

---

## Repository Error Handling

Repositories catch all exceptions, map to `AppError`, and fall back to local data on network errors:

```dart
// wine.repository.impl.dart
@override
Future<List<WineEntity>> getWines(String userId) async {
  try {
    final models = await api.fetchWines(userId);
    final companions = models.map((m) => m.toCompanion()).toList();
    await dao.upsertWines(companions);
  } on Object catch (e, st) {
    final appError = ErrorMapper.fromException(e, st);
    // Network errors: silently fall through to local
    if (appError is! NetworkError) rethrow;
  }
  // Always return from local
  final rows = await dao.getWinesByUser(userId);
  return rows.map((r) => r.toEntity()).toList();
}

@override
Future<void> addWine(WineEntity wine, String userId) async {
  try {
    await dao.upsertWine(wine.toCompanion(isSynced: false));
    await api.createWine(wine.toModel().copyWith(userId: userId));
    await dao.markSynced(wine.id);
  } on Object catch (e, st) {
    throw ErrorMapper.fromException(e, st);
  }
}
```

---

## Controller: AsyncValue.guard

```dart
@riverpod
class WineController extends _$WineController {
  @override
  Future<List<WineEntity>> build() async {
    final userId = ref.watch(currentUserIdProvider);
    return ref.watch(wineRepositoryProvider).getWines(userId);
  }

  Future<void> addWine(WineEntity wine) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(wineRepositoryProvider).addWine(
        wine,
        ref.read(currentUserIdProvider),
      ),
    );
    if (!state.hasError) ref.invalidateSelf();
  }
}
```

`AsyncValue.guard` catches exceptions automatically and wraps them in `AsyncError`.

---

## UI: .when() with ErrorState

```dart
// wine_list.screen.dart
ref.watch(wineListControllerProvider).when(
  data:    (wines)  => WineListView(wines: wines),
  loading: ()       => const LoadingState(),
  error:   (e, _)   => ErrorState(error: e),
)
```

File: `lib/common/widgets/error_state.widget.dart`

```dart
class ErrorState extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;

  const ErrorState({super.key, required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final appError = error is AppError
        ? error as AppError
        : ErrorMapper.fromException(error);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          SizedBox(height: context.spaceM),
          Text(
            appError.userMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: context.fontM),
          ),
          if (onRetry != null) ...[
            SizedBox(height: context.spaceM),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    );
  }
}
```

---

## SnackBar Notifications

For non-blocking errors (e.g., background sync failure), use `ref.listen`:

```dart
ref.listen<AsyncValue<List<WineEntity>>>(
  wineListControllerProvider,
  (_, next) {
    next.whenOrNull(
      error: (e, _) {
        final appError = e is AppError ? e : ErrorMapper.fromException(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(appError.userMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => ref.invalidate(wineListControllerProvider),
            ),
          ),
        );
      },
    );
  },
);
```

---

## Rules Checklist

- [ ] All exceptions caught in repositories and mapped via `ErrorMapper`
- [ ] Repositories throw `AppError`, never raw exceptions
- [ ] Network errors trigger local fallback, not error state
- [ ] Controllers use `AsyncValue.guard` — no manual try/catch
- [ ] UI always handles all three `AsyncValue` states (data/loading/error)
- [ ] User-visible messages come from `AppError.userMessage`, never raw exceptions

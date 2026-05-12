import 'package:freezed_annotation/freezed_annotation.dart';

import '../l10n/generated/app_localizations.dart';

part 'app_error.freezed.dart';

@freezed
class AppError with _$AppError {
  const factory AppError.network({
    @Default('Network unavailable.') String message,
    int? statusCode,
    String? endpoint,
  }) = NetworkError;

  /// Convenience for "device has no connection." Same shape as
  /// [AppError.network] so error views can treat them identically.
  const factory AppError.offline() = OfflineError;

  const factory AppError.database({required String message, String? table}) =
      DatabaseError;

  const factory AppError.validation({required String message, String? field}) =
      ValidationError;

  const factory AppError.notFound({
    required String message,
    String? resourceType,
    String? resourceId,
  }) = NotFoundError;

  const factory AppError.unauthorized({required String message}) =
      UnauthorizedError;

  const factory AppError.serverError({
    required String message,
    int? statusCode,
  }) = ServerError;

  const factory AppError.unknown({
    required String message,
    Object? originalError,
  }) = UnknownError;
}

/// Localized user-facing messages for [AppError].
///
/// Always call from a widget that has access to a [BuildContext] so the
/// caller can resolve [AppLocalizations] for the active locale. Stored
/// messages on the union (e.g. `AppError.network(message: ...)`) are
/// passed through verbatim when present, because those originate from
/// upstream APIs and are not translation targets. The defaults fall back
/// to the localized strings.
extension AppErrorX on AppError {
  String userMessage(AppLocalizations l) => when(
    network: (message, _, _) =>
        message.isEmpty || message == 'Network unavailable.'
            ? l.errNetworkDefault
            : message,
    offline: () => l.errOffline,
    database: (message, _) => l.errDatabase(message),
    validation: (message, field) => field == null || field.isEmpty
        ? l.errValidationNoField(message)
        : l.errValidation(field, message),
    notFound: (message, resourceType, _) =>
        resourceType == null || resourceType.isEmpty
            ? (message.isEmpty ? l.errNotFoundDefault : message)
            : l.errNotFound(resourceType),
    unauthorized: (_) => l.errUnauthorized,
    serverError: (message, statusCode) => statusCode == null
        ? (message.isEmpty ? l.errServerNoCode : message)
        : l.errServer(statusCode),
    unknown: (_, _) => l.errUnknown,
  );
}

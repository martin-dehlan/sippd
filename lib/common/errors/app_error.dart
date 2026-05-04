import 'package:freezed_annotation/freezed_annotation.dart';

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

  const factory AppError.database({
    required String message,
    String? table,
  }) = DatabaseError;

  const factory AppError.validation({
    required String message,
    String? field,
  }) = ValidationError;

  const factory AppError.notFound({
    required String message,
    String? resourceType,
    String? resourceId,
  }) = NotFoundError;

  const factory AppError.unauthorized({
    required String message,
  }) = UnauthorizedError;

  const factory AppError.serverError({
    required String message,
    int? statusCode,
  }) = ServerError;

  const factory AppError.unknown({
    required String message,
    Object? originalError,
  }) = UnknownError;
}

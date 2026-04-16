// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AppError {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppErrorCopyWith<AppError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppErrorCopyWith<$Res> {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) then) =
      _$AppErrorCopyWithImpl<$Res, AppError>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$AppErrorCopyWithImpl<$Res, $Val extends AppError>
    implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
    _$NetworkErrorImpl value,
    $Res Function(_$NetworkErrorImpl) then,
  ) = __$$NetworkErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int? statusCode, String? endpoint});
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
    _$NetworkErrorImpl _value,
    $Res Function(_$NetworkErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = freezed,
    Object? endpoint = freezed,
  }) {
    return _then(
      _$NetworkErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        endpoint: freezed == endpoint
            ? _value.endpoint
            : endpoint // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkErrorImpl implements NetworkError {
  const _$NetworkErrorImpl({
    required this.message,
    this.statusCode,
    this.endpoint,
  });

  @override
  final String message;
  @override
  final int? statusCode;
  @override
  final String? endpoint;

  @override
  String toString() {
    return 'AppError.network(message: $message, statusCode: $statusCode, endpoint: $endpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode, endpoint);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      __$$NetworkErrorImplCopyWithImpl<_$NetworkErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return network(message, statusCode, endpoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return network?.call(message, statusCode, endpoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, statusCode, endpoint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkError implements AppError {
  const factory NetworkError({
    required final String message,
    final int? statusCode,
    final String? endpoint,
  }) = _$NetworkErrorImpl;

  @override
  String get message;
  int? get statusCode;
  String? get endpoint;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkErrorImplCopyWith<_$NetworkErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DatabaseErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$DatabaseErrorImplCopyWith(
    _$DatabaseErrorImpl value,
    $Res Function(_$DatabaseErrorImpl) then,
  ) = __$$DatabaseErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? table});
}

/// @nodoc
class __$$DatabaseErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$DatabaseErrorImpl>
    implements _$$DatabaseErrorImplCopyWith<$Res> {
  __$$DatabaseErrorImplCopyWithImpl(
    _$DatabaseErrorImpl _value,
    $Res Function(_$DatabaseErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? table = freezed}) {
    return _then(
      _$DatabaseErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        table: freezed == table
            ? _value.table
            : table // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DatabaseErrorImpl implements DatabaseError {
  const _$DatabaseErrorImpl({required this.message, this.table});

  @override
  final String message;
  @override
  final String? table;

  @override
  String toString() {
    return 'AppError.database(message: $message, table: $table)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DatabaseErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.table, table) || other.table == table));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, table);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DatabaseErrorImplCopyWith<_$DatabaseErrorImpl> get copyWith =>
      __$$DatabaseErrorImplCopyWithImpl<_$DatabaseErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return database(message, table);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return database?.call(message, table);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (database != null) {
      return database(message, table);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) {
    return database(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return database?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (database != null) {
      return database(this);
    }
    return orElse();
  }
}

abstract class DatabaseError implements AppError {
  const factory DatabaseError({
    required final String message,
    final String? table,
  }) = _$DatabaseErrorImpl;

  @override
  String get message;
  String? get table;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DatabaseErrorImplCopyWith<_$DatabaseErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$ValidationErrorImplCopyWith(
    _$ValidationErrorImpl value,
    $Res Function(_$ValidationErrorImpl) then,
  ) = __$$ValidationErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? field});
}

/// @nodoc
class __$$ValidationErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$ValidationErrorImpl>
    implements _$$ValidationErrorImplCopyWith<$Res> {
  __$$ValidationErrorImplCopyWithImpl(
    _$ValidationErrorImpl _value,
    $Res Function(_$ValidationErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? field = freezed}) {
    return _then(
      _$ValidationErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        field: freezed == field
            ? _value.field
            : field // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ValidationErrorImpl implements ValidationError {
  const _$ValidationErrorImpl({required this.message, this.field});

  @override
  final String message;
  @override
  final String? field;

  @override
  String toString() {
    return 'AppError.validation(message: $message, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, field);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      __$$ValidationErrorImplCopyWithImpl<_$ValidationErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return validation(message, field);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return validation?.call(message, field);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, field);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationError implements AppError {
  const factory ValidationError({
    required final String message,
    final String? field,
  }) = _$ValidationErrorImpl;

  @override
  String get message;
  String? get field;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$NotFoundErrorImplCopyWith(
    _$NotFoundErrorImpl value,
    $Res Function(_$NotFoundErrorImpl) then,
  ) = __$$NotFoundErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? resourceType, String? resourceId});
}

/// @nodoc
class __$$NotFoundErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$NotFoundErrorImpl>
    implements _$$NotFoundErrorImplCopyWith<$Res> {
  __$$NotFoundErrorImplCopyWithImpl(
    _$NotFoundErrorImpl _value,
    $Res Function(_$NotFoundErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? resourceType = freezed,
    Object? resourceId = freezed,
  }) {
    return _then(
      _$NotFoundErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        resourceType: freezed == resourceType
            ? _value.resourceType
            : resourceType // ignore: cast_nullable_to_non_nullable
                  as String?,
        resourceId: freezed == resourceId
            ? _value.resourceId
            : resourceId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundErrorImpl implements NotFoundError {
  const _$NotFoundErrorImpl({
    required this.message,
    this.resourceType,
    this.resourceId,
  });

  @override
  final String message;
  @override
  final String? resourceType;
  @override
  final String? resourceId;

  @override
  String toString() {
    return 'AppError.notFound(message: $message, resourceType: $resourceType, resourceId: $resourceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.resourceType, resourceType) ||
                other.resourceType == resourceType) &&
            (identical(other.resourceId, resourceId) ||
                other.resourceId == resourceId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, resourceType, resourceId);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundErrorImplCopyWith<_$NotFoundErrorImpl> get copyWith =>
      __$$NotFoundErrorImplCopyWithImpl<_$NotFoundErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return notFound(message, resourceType, resourceId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return notFound?.call(message, resourceType, resourceId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message, resourceType, resourceId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundError implements AppError {
  const factory NotFoundError({
    required final String message,
    final String? resourceType,
    final String? resourceId,
  }) = _$NotFoundErrorImpl;

  @override
  String get message;
  String? get resourceType;
  String? get resourceId;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundErrorImplCopyWith<_$NotFoundErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$UnauthorizedErrorImplCopyWith(
    _$UnauthorizedErrorImpl value,
    $Res Function(_$UnauthorizedErrorImpl) then,
  ) = __$$UnauthorizedErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnauthorizedErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$UnauthorizedErrorImpl>
    implements _$$UnauthorizedErrorImplCopyWith<$Res> {
  __$$UnauthorizedErrorImplCopyWithImpl(
    _$UnauthorizedErrorImpl _value,
    $Res Function(_$UnauthorizedErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnauthorizedErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnauthorizedErrorImpl implements UnauthorizedError {
  const _$UnauthorizedErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AppError.unauthorized(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedErrorImplCopyWith<_$UnauthorizedErrorImpl> get copyWith =>
      __$$UnauthorizedErrorImplCopyWithImpl<_$UnauthorizedErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return unauthorized(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return unauthorized?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class UnauthorizedError implements AppError {
  const factory UnauthorizedError({required final String message}) =
      _$UnauthorizedErrorImpl;

  @override
  String get message;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnauthorizedErrorImplCopyWith<_$UnauthorizedErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$ServerErrorImplCopyWith(
    _$ServerErrorImpl value,
    $Res Function(_$ServerErrorImpl) then,
  ) = __$$ServerErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int? statusCode});
}

/// @nodoc
class __$$ServerErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$ServerErrorImpl>
    implements _$$ServerErrorImplCopyWith<$Res> {
  __$$ServerErrorImplCopyWithImpl(
    _$ServerErrorImpl _value,
    $Res Function(_$ServerErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? statusCode = freezed}) {
    return _then(
      _$ServerErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$ServerErrorImpl implements ServerError {
  const _$ServerErrorImpl({required this.message, this.statusCode});

  @override
  final String message;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'AppError.serverError(message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      __$$ServerErrorImplCopyWithImpl<_$ServerErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return serverError(message, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return serverError?.call(message, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(message, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) {
    return serverError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return serverError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (serverError != null) {
      return serverError(this);
    }
    return orElse();
  }
}

abstract class ServerError implements AppError {
  const factory ServerError({
    required final String message,
    final int? statusCode,
  }) = _$ServerErrorImpl;

  @override
  String get message;
  int? get statusCode;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerErrorImplCopyWith<_$ServerErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownErrorImplCopyWith<$Res>
    implements $AppErrorCopyWith<$Res> {
  factory _$$UnknownErrorImplCopyWith(
    _$UnknownErrorImpl value,
    $Res Function(_$UnknownErrorImpl) then,
  ) = __$$UnknownErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? originalError});
}

/// @nodoc
class __$$UnknownErrorImplCopyWithImpl<$Res>
    extends _$AppErrorCopyWithImpl<$Res, _$UnknownErrorImpl>
    implements _$$UnknownErrorImplCopyWith<$Res> {
  __$$UnknownErrorImplCopyWithImpl(
    _$UnknownErrorImpl _value,
    $Res Function(_$UnknownErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? originalError = freezed}) {
    return _then(
      _$UnknownErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        originalError: freezed == originalError
            ? _value.originalError
            : originalError,
      ),
    );
  }
}

/// @nodoc

class _$UnknownErrorImpl implements UnknownError {
  const _$UnknownErrorImpl({required this.message, this.originalError});

  @override
  final String message;
  @override
  final Object? originalError;

  @override
  String toString() {
    return 'AppError.unknown(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other.originalError,
              originalError,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(originalError),
  );

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      __$$UnknownErrorImplCopyWithImpl<_$UnknownErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(String message, String? table) database,
    required TResult Function(String message, String? field) validation,
    required TResult Function(
      String message,
      String? resourceType,
      String? resourceId,
    )
    notFound,
    required TResult Function(String message) unauthorized,
    required TResult Function(String message, int? statusCode) serverError,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return unknown(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(String message, String? table)? database,
    TResult? Function(String message, String? field)? validation,
    TResult? Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult? Function(String message)? unauthorized,
    TResult? Function(String message, int? statusCode)? serverError,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return unknown?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(String message, String? table)? database,
    TResult Function(String message, String? field)? validation,
    TResult Function(String message, String? resourceType, String? resourceId)?
    notFound,
    TResult Function(String message)? unauthorized,
    TResult Function(String message, int? statusCode)? serverError,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkError value) network,
    required TResult Function(DatabaseError value) database,
    required TResult Function(ValidationError value) validation,
    required TResult Function(NotFoundError value) notFound,
    required TResult Function(UnauthorizedError value) unauthorized,
    required TResult Function(ServerError value) serverError,
    required TResult Function(UnknownError value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkError value)? network,
    TResult? Function(DatabaseError value)? database,
    TResult? Function(ValidationError value)? validation,
    TResult? Function(NotFoundError value)? notFound,
    TResult? Function(UnauthorizedError value)? unauthorized,
    TResult? Function(ServerError value)? serverError,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkError value)? network,
    TResult Function(DatabaseError value)? database,
    TResult Function(ValidationError value)? validation,
    TResult Function(NotFoundError value)? notFound,
    TResult Function(UnauthorizedError value)? unauthorized,
    TResult Function(ServerError value)? serverError,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownError implements AppError {
  const factory UnknownError({
    required final String message,
    final Object? originalError,
  }) = _$UnknownErrorImpl;

  @override
  String get message;
  Object? get originalError;

  /// Create a copy of AppError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

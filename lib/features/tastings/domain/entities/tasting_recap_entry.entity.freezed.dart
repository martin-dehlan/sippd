// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasting_recap_entry.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TastingRecapEntry {
  String get userId => throw _privateConstructorUsedError;
  String get canonicalWineId => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;

  /// Create a copy of TastingRecapEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TastingRecapEntryCopyWith<TastingRecapEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TastingRecapEntryCopyWith<$Res> {
  factory $TastingRecapEntryCopyWith(
    TastingRecapEntry value,
    $Res Function(TastingRecapEntry) then,
  ) = _$TastingRecapEntryCopyWithImpl<$Res, TastingRecapEntry>;
  @useResult
  $Res call({
    String userId,
    String canonicalWineId,
    double rating,
    String? displayName,
    String? username,
    String? avatarUrl,
  });
}

/// @nodoc
class _$TastingRecapEntryCopyWithImpl<$Res, $Val extends TastingRecapEntry>
    implements $TastingRecapEntryCopyWith<$Res> {
  _$TastingRecapEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TastingRecapEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? canonicalWineId = null,
    Object? rating = null,
    Object? displayName = freezed,
    Object? username = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            canonicalWineId: null == canonicalWineId
                ? _value.canonicalWineId
                : canonicalWineId // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TastingRecapEntryImplCopyWith<$Res>
    implements $TastingRecapEntryCopyWith<$Res> {
  factory _$$TastingRecapEntryImplCopyWith(
    _$TastingRecapEntryImpl value,
    $Res Function(_$TastingRecapEntryImpl) then,
  ) = __$$TastingRecapEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String canonicalWineId,
    double rating,
    String? displayName,
    String? username,
    String? avatarUrl,
  });
}

/// @nodoc
class __$$TastingRecapEntryImplCopyWithImpl<$Res>
    extends _$TastingRecapEntryCopyWithImpl<$Res, _$TastingRecapEntryImpl>
    implements _$$TastingRecapEntryImplCopyWith<$Res> {
  __$$TastingRecapEntryImplCopyWithImpl(
    _$TastingRecapEntryImpl _value,
    $Res Function(_$TastingRecapEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TastingRecapEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? canonicalWineId = null,
    Object? rating = null,
    Object? displayName = freezed,
    Object? username = freezed,
    Object? avatarUrl = freezed,
  }) {
    return _then(
      _$TastingRecapEntryImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        canonicalWineId: null == canonicalWineId
            ? _value.canonicalWineId
            : canonicalWineId // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$TastingRecapEntryImpl implements _TastingRecapEntry {
  const _$TastingRecapEntryImpl({
    required this.userId,
    required this.canonicalWineId,
    required this.rating,
    this.displayName,
    this.username,
    this.avatarUrl,
  });

  @override
  final String userId;
  @override
  final String canonicalWineId;
  @override
  final double rating;
  @override
  final String? displayName;
  @override
  final String? username;
  @override
  final String? avatarUrl;

  @override
  String toString() {
    return 'TastingRecapEntry(userId: $userId, canonicalWineId: $canonicalWineId, rating: $rating, displayName: $displayName, username: $username, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TastingRecapEntryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.canonicalWineId, canonicalWineId) ||
                other.canonicalWineId == canonicalWineId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    canonicalWineId,
    rating,
    displayName,
    username,
    avatarUrl,
  );

  /// Create a copy of TastingRecapEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TastingRecapEntryImplCopyWith<_$TastingRecapEntryImpl> get copyWith =>
      __$$TastingRecapEntryImplCopyWithImpl<_$TastingRecapEntryImpl>(
        this,
        _$identity,
      );
}

abstract class _TastingRecapEntry implements TastingRecapEntry {
  const factory _TastingRecapEntry({
    required final String userId,
    required final String canonicalWineId,
    required final double rating,
    final String? displayName,
    final String? username,
    final String? avatarUrl,
  }) = _$TastingRecapEntryImpl;

  @override
  String get userId;
  @override
  String get canonicalWineId;
  @override
  double get rating;
  @override
  String? get displayName;
  @override
  String? get username;
  @override
  String? get avatarUrl;

  /// Create a copy of TastingRecapEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TastingRecapEntryImplCopyWith<_$TastingRecapEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

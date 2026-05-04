// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_grape_share.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserGrapeShare {
  String get canonicalGrapeId => throw _privateConstructorUsedError;
  String get grapeName => throw _privateConstructorUsedError;
  String get grapeColor => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  double get avgRating => throw _privateConstructorUsedError;

  /// Create a copy of UserGrapeShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserGrapeShareCopyWith<UserGrapeShare> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserGrapeShareCopyWith<$Res> {
  factory $UserGrapeShareCopyWith(
    UserGrapeShare value,
    $Res Function(UserGrapeShare) then,
  ) = _$UserGrapeShareCopyWithImpl<$Res, UserGrapeShare>;
  @useResult
  $Res call({
    String canonicalGrapeId,
    String grapeName,
    String grapeColor,
    int count,
    double avgRating,
  });
}

/// @nodoc
class _$UserGrapeShareCopyWithImpl<$Res, $Val extends UserGrapeShare>
    implements $UserGrapeShareCopyWith<$Res> {
  _$UserGrapeShareCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserGrapeShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canonicalGrapeId = null,
    Object? grapeName = null,
    Object? grapeColor = null,
    Object? count = null,
    Object? avgRating = null,
  }) {
    return _then(
      _value.copyWith(
            canonicalGrapeId: null == canonicalGrapeId
                ? _value.canonicalGrapeId
                : canonicalGrapeId // ignore: cast_nullable_to_non_nullable
                      as String,
            grapeName: null == grapeName
                ? _value.grapeName
                : grapeName // ignore: cast_nullable_to_non_nullable
                      as String,
            grapeColor: null == grapeColor
                ? _value.grapeColor
                : grapeColor // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            avgRating: null == avgRating
                ? _value.avgRating
                : avgRating // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserGrapeShareImplCopyWith<$Res>
    implements $UserGrapeShareCopyWith<$Res> {
  factory _$$UserGrapeShareImplCopyWith(
    _$UserGrapeShareImpl value,
    $Res Function(_$UserGrapeShareImpl) then,
  ) = __$$UserGrapeShareImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String canonicalGrapeId,
    String grapeName,
    String grapeColor,
    int count,
    double avgRating,
  });
}

/// @nodoc
class __$$UserGrapeShareImplCopyWithImpl<$Res>
    extends _$UserGrapeShareCopyWithImpl<$Res, _$UserGrapeShareImpl>
    implements _$$UserGrapeShareImplCopyWith<$Res> {
  __$$UserGrapeShareImplCopyWithImpl(
    _$UserGrapeShareImpl _value,
    $Res Function(_$UserGrapeShareImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserGrapeShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canonicalGrapeId = null,
    Object? grapeName = null,
    Object? grapeColor = null,
    Object? count = null,
    Object? avgRating = null,
  }) {
    return _then(
      _$UserGrapeShareImpl(
        canonicalGrapeId: null == canonicalGrapeId
            ? _value.canonicalGrapeId
            : canonicalGrapeId // ignore: cast_nullable_to_non_nullable
                  as String,
        grapeName: null == grapeName
            ? _value.grapeName
            : grapeName // ignore: cast_nullable_to_non_nullable
                  as String,
        grapeColor: null == grapeColor
            ? _value.grapeColor
            : grapeColor // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        avgRating: null == avgRating
            ? _value.avgRating
            : avgRating // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$UserGrapeShareImpl implements _UserGrapeShare {
  const _$UserGrapeShareImpl({
    required this.canonicalGrapeId,
    required this.grapeName,
    required this.grapeColor,
    required this.count,
    required this.avgRating,
  });

  @override
  final String canonicalGrapeId;
  @override
  final String grapeName;
  @override
  final String grapeColor;
  @override
  final int count;
  @override
  final double avgRating;

  @override
  String toString() {
    return 'UserGrapeShare(canonicalGrapeId: $canonicalGrapeId, grapeName: $grapeName, grapeColor: $grapeColor, count: $count, avgRating: $avgRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserGrapeShareImpl &&
            (identical(other.canonicalGrapeId, canonicalGrapeId) ||
                other.canonicalGrapeId == canonicalGrapeId) &&
            (identical(other.grapeName, grapeName) ||
                other.grapeName == grapeName) &&
            (identical(other.grapeColor, grapeColor) ||
                other.grapeColor == grapeColor) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.avgRating, avgRating) ||
                other.avgRating == avgRating));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    canonicalGrapeId,
    grapeName,
    grapeColor,
    count,
    avgRating,
  );

  /// Create a copy of UserGrapeShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserGrapeShareImplCopyWith<_$UserGrapeShareImpl> get copyWith =>
      __$$UserGrapeShareImplCopyWithImpl<_$UserGrapeShareImpl>(
        this,
        _$identity,
      );
}

abstract class _UserGrapeShare implements UserGrapeShare {
  const factory _UserGrapeShare({
    required final String canonicalGrapeId,
    required final String grapeName,
    required final String grapeColor,
    required final int count,
    required final double avgRating,
  }) = _$UserGrapeShareImpl;

  @override
  String get canonicalGrapeId;
  @override
  String get grapeName;
  @override
  String get grapeColor;
  @override
  int get count;
  @override
  double get avgRating;

  /// Create a copy of UserGrapeShare
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserGrapeShareImplCopyWith<_$UserGrapeShareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

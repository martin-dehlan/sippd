// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_style_dna.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserStyleDna {
  Map<String, double> get values => throw _privateConstructorUsedError;
  int get attributedCount => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;

  /// Create a copy of UserStyleDna
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStyleDnaCopyWith<UserStyleDna> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStyleDnaCopyWith<$Res> {
  factory $UserStyleDnaCopyWith(
    UserStyleDna value,
    $Res Function(UserStyleDna) then,
  ) = _$UserStyleDnaCopyWithImpl<$Res, UserStyleDna>;
  @useResult
  $Res call({
    Map<String, double> values,
    int attributedCount,
    double confidence,
  });
}

/// @nodoc
class _$UserStyleDnaCopyWithImpl<$Res, $Val extends UserStyleDna>
    implements $UserStyleDnaCopyWith<$Res> {
  _$UserStyleDnaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStyleDna
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
    Object? attributedCount = null,
    Object? confidence = null,
  }) {
    return _then(
      _value.copyWith(
            values: null == values
                ? _value.values
                : values // ignore: cast_nullable_to_non_nullable
                      as Map<String, double>,
            attributedCount: null == attributedCount
                ? _value.attributedCount
                : attributedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserStyleDnaImplCopyWith<$Res>
    implements $UserStyleDnaCopyWith<$Res> {
  factory _$$UserStyleDnaImplCopyWith(
    _$UserStyleDnaImpl value,
    $Res Function(_$UserStyleDnaImpl) then,
  ) = __$$UserStyleDnaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Map<String, double> values,
    int attributedCount,
    double confidence,
  });
}

/// @nodoc
class __$$UserStyleDnaImplCopyWithImpl<$Res>
    extends _$UserStyleDnaCopyWithImpl<$Res, _$UserStyleDnaImpl>
    implements _$$UserStyleDnaImplCopyWith<$Res> {
  __$$UserStyleDnaImplCopyWithImpl(
    _$UserStyleDnaImpl _value,
    $Res Function(_$UserStyleDnaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserStyleDna
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? values = null,
    Object? attributedCount = null,
    Object? confidence = null,
  }) {
    return _then(
      _$UserStyleDnaImpl(
        values: null == values
            ? _value._values
            : values // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        attributedCount: null == attributedCount
            ? _value.attributedCount
            : attributedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$UserStyleDnaImpl implements _UserStyleDna {
  const _$UserStyleDnaImpl({
    required final Map<String, double> values,
    required this.attributedCount,
    required this.confidence,
  }) : _values = values;

  final Map<String, double> _values;
  @override
  Map<String, double> get values {
    if (_values is EqualUnmodifiableMapView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_values);
  }

  @override
  final int attributedCount;
  @override
  final double confidence;

  @override
  String toString() {
    return 'UserStyleDna(values: $values, attributedCount: $attributedCount, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStyleDnaImpl &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.attributedCount, attributedCount) ||
                other.attributedCount == attributedCount) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_values),
    attributedCount,
    confidence,
  );

  /// Create a copy of UserStyleDna
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStyleDnaImplCopyWith<_$UserStyleDnaImpl> get copyWith =>
      __$$UserStyleDnaImplCopyWithImpl<_$UserStyleDnaImpl>(this, _$identity);
}

abstract class _UserStyleDna implements UserStyleDna {
  const factory _UserStyleDna({
    required final Map<String, double> values,
    required final int attributedCount,
    required final double confidence,
  }) = _$UserStyleDnaImpl;

  @override
  Map<String, double> get values;
  @override
  int get attributedCount;
  @override
  double get confidence;

  /// Create a copy of UserStyleDna
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStyleDnaImplCopyWith<_$UserStyleDnaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

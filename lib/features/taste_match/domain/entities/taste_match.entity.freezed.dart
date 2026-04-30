// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taste_match.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TasteMatchEntity {
  int? get score => throw _privateConstructorUsedError;
  MatchConfidence? get confidence => throw _privateConstructorUsedError;
  int get overlapCount => throw _privateConstructorUsedError;
  int get myTotal => throw _privateConstructorUsedError;
  int get theirTotal => throw _privateConstructorUsedError;
  MatchUnavailableReason? get reason => throw _privateConstructorUsedError;

  /// Create a copy of TasteMatchEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TasteMatchEntityCopyWith<TasteMatchEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasteMatchEntityCopyWith<$Res> {
  factory $TasteMatchEntityCopyWith(
    TasteMatchEntity value,
    $Res Function(TasteMatchEntity) then,
  ) = _$TasteMatchEntityCopyWithImpl<$Res, TasteMatchEntity>;
  @useResult
  $Res call({
    int? score,
    MatchConfidence? confidence,
    int overlapCount,
    int myTotal,
    int theirTotal,
    MatchUnavailableReason? reason,
  });
}

/// @nodoc
class _$TasteMatchEntityCopyWithImpl<$Res, $Val extends TasteMatchEntity>
    implements $TasteMatchEntityCopyWith<$Res> {
  _$TasteMatchEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasteMatchEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = freezed,
    Object? confidence = freezed,
    Object? overlapCount = null,
    Object? myTotal = null,
    Object? theirTotal = null,
    Object? reason = freezed,
  }) {
    return _then(
      _value.copyWith(
            score: freezed == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int?,
            confidence: freezed == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as MatchConfidence?,
            overlapCount: null == overlapCount
                ? _value.overlapCount
                : overlapCount // ignore: cast_nullable_to_non_nullable
                      as int,
            myTotal: null == myTotal
                ? _value.myTotal
                : myTotal // ignore: cast_nullable_to_non_nullable
                      as int,
            theirTotal: null == theirTotal
                ? _value.theirTotal
                : theirTotal // ignore: cast_nullable_to_non_nullable
                      as int,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as MatchUnavailableReason?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TasteMatchEntityImplCopyWith<$Res>
    implements $TasteMatchEntityCopyWith<$Res> {
  factory _$$TasteMatchEntityImplCopyWith(
    _$TasteMatchEntityImpl value,
    $Res Function(_$TasteMatchEntityImpl) then,
  ) = __$$TasteMatchEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? score,
    MatchConfidence? confidence,
    int overlapCount,
    int myTotal,
    int theirTotal,
    MatchUnavailableReason? reason,
  });
}

/// @nodoc
class __$$TasteMatchEntityImplCopyWithImpl<$Res>
    extends _$TasteMatchEntityCopyWithImpl<$Res, _$TasteMatchEntityImpl>
    implements _$$TasteMatchEntityImplCopyWith<$Res> {
  __$$TasteMatchEntityImplCopyWithImpl(
    _$TasteMatchEntityImpl _value,
    $Res Function(_$TasteMatchEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TasteMatchEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = freezed,
    Object? confidence = freezed,
    Object? overlapCount = null,
    Object? myTotal = null,
    Object? theirTotal = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$TasteMatchEntityImpl(
        score: freezed == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int?,
        confidence: freezed == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as MatchConfidence?,
        overlapCount: null == overlapCount
            ? _value.overlapCount
            : overlapCount // ignore: cast_nullable_to_non_nullable
                  as int,
        myTotal: null == myTotal
            ? _value.myTotal
            : myTotal // ignore: cast_nullable_to_non_nullable
                  as int,
        theirTotal: null == theirTotal
            ? _value.theirTotal
            : theirTotal // ignore: cast_nullable_to_non_nullable
                  as int,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as MatchUnavailableReason?,
      ),
    );
  }
}

/// @nodoc

class _$TasteMatchEntityImpl extends _TasteMatchEntity {
  const _$TasteMatchEntityImpl({
    this.score,
    this.confidence,
    this.overlapCount = 0,
    this.myTotal = 0,
    this.theirTotal = 0,
    this.reason,
  }) : super._();

  @override
  final int? score;
  @override
  final MatchConfidence? confidence;
  @override
  @JsonKey()
  final int overlapCount;
  @override
  @JsonKey()
  final int myTotal;
  @override
  @JsonKey()
  final int theirTotal;
  @override
  final MatchUnavailableReason? reason;

  @override
  String toString() {
    return 'TasteMatchEntity(score: $score, confidence: $confidence, overlapCount: $overlapCount, myTotal: $myTotal, theirTotal: $theirTotal, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasteMatchEntityImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.overlapCount, overlapCount) ||
                other.overlapCount == overlapCount) &&
            (identical(other.myTotal, myTotal) || other.myTotal == myTotal) &&
            (identical(other.theirTotal, theirTotal) ||
                other.theirTotal == theirTotal) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    score,
    confidence,
    overlapCount,
    myTotal,
    theirTotal,
    reason,
  );

  /// Create a copy of TasteMatchEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasteMatchEntityImplCopyWith<_$TasteMatchEntityImpl> get copyWith =>
      __$$TasteMatchEntityImplCopyWithImpl<_$TasteMatchEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _TasteMatchEntity extends TasteMatchEntity {
  const factory _TasteMatchEntity({
    final int? score,
    final MatchConfidence? confidence,
    final int overlapCount,
    final int myTotal,
    final int theirTotal,
    final MatchUnavailableReason? reason,
  }) = _$TasteMatchEntityImpl;
  const _TasteMatchEntity._() : super._();

  @override
  int? get score;
  @override
  MatchConfidence? get confidence;
  @override
  int get overlapCount;
  @override
  int get myTotal;
  @override
  int get theirTotal;
  @override
  MatchUnavailableReason? get reason;

  /// Create a copy of TasteMatchEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasteMatchEntityImplCopyWith<_$TasteMatchEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

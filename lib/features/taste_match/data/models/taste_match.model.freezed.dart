// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taste_match.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TasteMatchModel _$TasteMatchModelFromJson(Map<String, dynamic> json) {
  return _TasteMatchModel.fromJson(json);
}

/// @nodoc
mixin _$TasteMatchModel {
  int? get score => throw _privateConstructorUsedError;
  String? get confidence => throw _privateConstructorUsedError;
  @JsonKey(name: 'overlap_count')
  int get overlapCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'my_total')
  int get myTotal => throw _privateConstructorUsedError;
  @JsonKey(name: 'their_total')
  int get theirTotal => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this TasteMatchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TasteMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TasteMatchModelCopyWith<TasteMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TasteMatchModelCopyWith<$Res> {
  factory $TasteMatchModelCopyWith(
    TasteMatchModel value,
    $Res Function(TasteMatchModel) then,
  ) = _$TasteMatchModelCopyWithImpl<$Res, TasteMatchModel>;
  @useResult
  $Res call({
    int? score,
    String? confidence,
    @JsonKey(name: 'overlap_count') int overlapCount,
    @JsonKey(name: 'my_total') int myTotal,
    @JsonKey(name: 'their_total') int theirTotal,
    String? reason,
  });
}

/// @nodoc
class _$TasteMatchModelCopyWithImpl<$Res, $Val extends TasteMatchModel>
    implements $TasteMatchModelCopyWith<$Res> {
  _$TasteMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TasteMatchModel
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
                      as String?,
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
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TasteMatchModelImplCopyWith<$Res>
    implements $TasteMatchModelCopyWith<$Res> {
  factory _$$TasteMatchModelImplCopyWith(
    _$TasteMatchModelImpl value,
    $Res Function(_$TasteMatchModelImpl) then,
  ) = __$$TasteMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? score,
    String? confidence,
    @JsonKey(name: 'overlap_count') int overlapCount,
    @JsonKey(name: 'my_total') int myTotal,
    @JsonKey(name: 'their_total') int theirTotal,
    String? reason,
  });
}

/// @nodoc
class __$$TasteMatchModelImplCopyWithImpl<$Res>
    extends _$TasteMatchModelCopyWithImpl<$Res, _$TasteMatchModelImpl>
    implements _$$TasteMatchModelImplCopyWith<$Res> {
  __$$TasteMatchModelImplCopyWithImpl(
    _$TasteMatchModelImpl _value,
    $Res Function(_$TasteMatchModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TasteMatchModel
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
      _$TasteMatchModelImpl(
        score: freezed == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int?,
        confidence: freezed == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as String?,
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
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TasteMatchModelImpl implements _TasteMatchModel {
  const _$TasteMatchModelImpl({
    this.score,
    this.confidence,
    @JsonKey(name: 'overlap_count') this.overlapCount = 0,
    @JsonKey(name: 'my_total') this.myTotal = 0,
    @JsonKey(name: 'their_total') this.theirTotal = 0,
    this.reason,
  });

  factory _$TasteMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TasteMatchModelImplFromJson(json);

  @override
  final int? score;
  @override
  final String? confidence;
  @override
  @JsonKey(name: 'overlap_count')
  final int overlapCount;
  @override
  @JsonKey(name: 'my_total')
  final int myTotal;
  @override
  @JsonKey(name: 'their_total')
  final int theirTotal;
  @override
  final String? reason;

  @override
  String toString() {
    return 'TasteMatchModel(score: $score, confidence: $confidence, overlapCount: $overlapCount, myTotal: $myTotal, theirTotal: $theirTotal, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasteMatchModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  /// Create a copy of TasteMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasteMatchModelImplCopyWith<_$TasteMatchModelImpl> get copyWith =>
      __$$TasteMatchModelImplCopyWithImpl<_$TasteMatchModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TasteMatchModelImplToJson(this);
  }
}

abstract class _TasteMatchModel implements TasteMatchModel {
  const factory _TasteMatchModel({
    final int? score,
    final String? confidence,
    @JsonKey(name: 'overlap_count') final int overlapCount,
    @JsonKey(name: 'my_total') final int myTotal,
    @JsonKey(name: 'their_total') final int theirTotal,
    final String? reason,
  }) = _$TasteMatchModelImpl;

  factory _TasteMatchModel.fromJson(Map<String, dynamic> json) =
      _$TasteMatchModelImpl.fromJson;

  @override
  int? get score;
  @override
  String? get confidence;
  @override
  @JsonKey(name: 'overlap_count')
  int get overlapCount;
  @override
  @JsonKey(name: 'my_total')
  int get myTotal;
  @override
  @JsonKey(name: 'their_total')
  int get theirTotal;
  @override
  String? get reason;

  /// Create a copy of TasteMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasteMatchModelImplCopyWith<_$TasteMatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

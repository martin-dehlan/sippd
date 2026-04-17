// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_wine_rating.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GroupWineRatingModel _$GroupWineRatingModelFromJson(Map<String, dynamic> json) {
  return _GroupWineRatingModel.fromJson(json);
}

/// @nodoc
mixin _$GroupWineRatingModel {
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'wine_id')
  String get wineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this GroupWineRatingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroupWineRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupWineRatingModelCopyWith<GroupWineRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupWineRatingModelCopyWith<$Res> {
  factory $GroupWineRatingModelCopyWith(
    GroupWineRatingModel value,
    $Res Function(GroupWineRatingModel) then,
  ) = _$GroupWineRatingModelCopyWithImpl<$Res, GroupWineRatingModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'group_id') String groupId,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'user_id') String userId,
    double rating,
    String? notes,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$GroupWineRatingModelCopyWithImpl<
  $Res,
  $Val extends GroupWineRatingModel
>
    implements $GroupWineRatingModelCopyWith<$Res> {
  _$GroupWineRatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroupWineRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? wineId = null,
    Object? userId = null,
    Object? rating = null,
    Object? notes = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String,
            wineId: null == wineId
                ? _value.wineId
                : wineId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GroupWineRatingModelImplCopyWith<$Res>
    implements $GroupWineRatingModelCopyWith<$Res> {
  factory _$$GroupWineRatingModelImplCopyWith(
    _$GroupWineRatingModelImpl value,
    $Res Function(_$GroupWineRatingModelImpl) then,
  ) = __$$GroupWineRatingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'group_id') String groupId,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'user_id') String userId,
    double rating,
    String? notes,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$GroupWineRatingModelImplCopyWithImpl<$Res>
    extends _$GroupWineRatingModelCopyWithImpl<$Res, _$GroupWineRatingModelImpl>
    implements _$$GroupWineRatingModelImplCopyWith<$Res> {
  __$$GroupWineRatingModelImplCopyWithImpl(
    _$GroupWineRatingModelImpl _value,
    $Res Function(_$GroupWineRatingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GroupWineRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? wineId = null,
    Object? userId = null,
    Object? rating = null,
    Object? notes = freezed,
    Object? updatedAt = null,
  }) {
    return _then(
      _$GroupWineRatingModelImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        wineId: null == wineId
            ? _value.wineId
            : wineId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupWineRatingModelImpl implements _GroupWineRatingModel {
  const _$GroupWineRatingModelImpl({
    @JsonKey(name: 'group_id') required this.groupId,
    @JsonKey(name: 'wine_id') required this.wineId,
    @JsonKey(name: 'user_id') required this.userId,
    required this.rating,
    this.notes,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$GroupWineRatingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupWineRatingModelImplFromJson(json);

  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'wine_id')
  final String wineId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final double rating;
  @override
  final String? notes;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'GroupWineRatingModel(groupId: $groupId, wineId: $wineId, userId: $userId, rating: $rating, notes: $notes, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupWineRatingModelImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.wineId, wineId) || other.wineId == wineId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    groupId,
    wineId,
    userId,
    rating,
    notes,
    updatedAt,
  );

  /// Create a copy of GroupWineRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupWineRatingModelImplCopyWith<_$GroupWineRatingModelImpl>
  get copyWith =>
      __$$GroupWineRatingModelImplCopyWithImpl<_$GroupWineRatingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupWineRatingModelImplToJson(this);
  }
}

abstract class _GroupWineRatingModel implements GroupWineRatingModel {
  const factory _GroupWineRatingModel({
    @JsonKey(name: 'group_id') required final String groupId,
    @JsonKey(name: 'wine_id') required final String wineId,
    @JsonKey(name: 'user_id') required final String userId,
    required final double rating,
    final String? notes,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$GroupWineRatingModelImpl;

  factory _GroupWineRatingModel.fromJson(Map<String, dynamic> json) =
      _$GroupWineRatingModelImpl.fromJson;

  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'wine_id')
  String get wineId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  double get rating;
  @override
  String? get notes;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of GroupWineRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupWineRatingModelImplCopyWith<_$GroupWineRatingModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

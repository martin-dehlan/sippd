// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared_bottle.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SharedBottleModel _$SharedBottleModelFromJson(Map<String, dynamic> json) {
  return _SharedBottleModel.fromJson(json);
}

/// @nodoc
mixin _$SharedBottleModel {
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'wine_id')
  String get wineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'wine_name')
  String get wineName => throw _privateConstructorUsedError;
  String? get winery => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int? get vintage => throw _privateConstructorUsedError;
  @JsonKey(name: 'my_rating')
  double get myRating => throw _privateConstructorUsedError;
  @JsonKey(name: 'their_rating')
  double get theirRating => throw _privateConstructorUsedError;
  double get delta => throw _privateConstructorUsedError;
  @JsonKey(name: 'rated_at')
  DateTime? get ratedAt => throw _privateConstructorUsedError;

  /// Serializes this SharedBottleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SharedBottleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SharedBottleModelCopyWith<SharedBottleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SharedBottleModelCopyWith<$Res> {
  factory $SharedBottleModelCopyWith(
    SharedBottleModel value,
    $Res Function(SharedBottleModel) then,
  ) = _$SharedBottleModelCopyWithImpl<$Res, SharedBottleModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'group_id') String groupId,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'wine_name') String wineName,
    String? winery,
    String? region,
    String? country,
    String type,
    int? vintage,
    @JsonKey(name: 'my_rating') double myRating,
    @JsonKey(name: 'their_rating') double theirRating,
    double delta,
    @JsonKey(name: 'rated_at') DateTime? ratedAt,
  });
}

/// @nodoc
class _$SharedBottleModelCopyWithImpl<$Res, $Val extends SharedBottleModel>
    implements $SharedBottleModelCopyWith<$Res> {
  _$SharedBottleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SharedBottleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? wineId = null,
    Object? wineName = null,
    Object? winery = freezed,
    Object? region = freezed,
    Object? country = freezed,
    Object? type = null,
    Object? vintage = freezed,
    Object? myRating = null,
    Object? theirRating = null,
    Object? delta = null,
    Object? ratedAt = freezed,
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
            wineName: null == wineName
                ? _value.wineName
                : wineName // ignore: cast_nullable_to_non_nullable
                      as String,
            winery: freezed == winery
                ? _value.winery
                : winery // ignore: cast_nullable_to_non_nullable
                      as String?,
            region: freezed == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            vintage: freezed == vintage
                ? _value.vintage
                : vintage // ignore: cast_nullable_to_non_nullable
                      as int?,
            myRating: null == myRating
                ? _value.myRating
                : myRating // ignore: cast_nullable_to_non_nullable
                      as double,
            theirRating: null == theirRating
                ? _value.theirRating
                : theirRating // ignore: cast_nullable_to_non_nullable
                      as double,
            delta: null == delta
                ? _value.delta
                : delta // ignore: cast_nullable_to_non_nullable
                      as double,
            ratedAt: freezed == ratedAt
                ? _value.ratedAt
                : ratedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SharedBottleModelImplCopyWith<$Res>
    implements $SharedBottleModelCopyWith<$Res> {
  factory _$$SharedBottleModelImplCopyWith(
    _$SharedBottleModelImpl value,
    $Res Function(_$SharedBottleModelImpl) then,
  ) = __$$SharedBottleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'group_id') String groupId,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'wine_name') String wineName,
    String? winery,
    String? region,
    String? country,
    String type,
    int? vintage,
    @JsonKey(name: 'my_rating') double myRating,
    @JsonKey(name: 'their_rating') double theirRating,
    double delta,
    @JsonKey(name: 'rated_at') DateTime? ratedAt,
  });
}

/// @nodoc
class __$$SharedBottleModelImplCopyWithImpl<$Res>
    extends _$SharedBottleModelCopyWithImpl<$Res, _$SharedBottleModelImpl>
    implements _$$SharedBottleModelImplCopyWith<$Res> {
  __$$SharedBottleModelImplCopyWithImpl(
    _$SharedBottleModelImpl _value,
    $Res Function(_$SharedBottleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SharedBottleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupId = null,
    Object? wineId = null,
    Object? wineName = null,
    Object? winery = freezed,
    Object? region = freezed,
    Object? country = freezed,
    Object? type = null,
    Object? vintage = freezed,
    Object? myRating = null,
    Object? theirRating = null,
    Object? delta = null,
    Object? ratedAt = freezed,
  }) {
    return _then(
      _$SharedBottleModelImpl(
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        wineId: null == wineId
            ? _value.wineId
            : wineId // ignore: cast_nullable_to_non_nullable
                  as String,
        wineName: null == wineName
            ? _value.wineName
            : wineName // ignore: cast_nullable_to_non_nullable
                  as String,
        winery: freezed == winery
            ? _value.winery
            : winery // ignore: cast_nullable_to_non_nullable
                  as String?,
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        vintage: freezed == vintage
            ? _value.vintage
            : vintage // ignore: cast_nullable_to_non_nullable
                  as int?,
        myRating: null == myRating
            ? _value.myRating
            : myRating // ignore: cast_nullable_to_non_nullable
                  as double,
        theirRating: null == theirRating
            ? _value.theirRating
            : theirRating // ignore: cast_nullable_to_non_nullable
                  as double,
        delta: null == delta
            ? _value.delta
            : delta // ignore: cast_nullable_to_non_nullable
                  as double,
        ratedAt: freezed == ratedAt
            ? _value.ratedAt
            : ratedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SharedBottleModelImpl implements _SharedBottleModel {
  const _$SharedBottleModelImpl({
    @JsonKey(name: 'group_id') required this.groupId,
    @JsonKey(name: 'wine_id') required this.wineId,
    @JsonKey(name: 'wine_name') required this.wineName,
    this.winery,
    this.region,
    this.country,
    required this.type,
    this.vintage,
    @JsonKey(name: 'my_rating') required this.myRating,
    @JsonKey(name: 'their_rating') required this.theirRating,
    required this.delta,
    @JsonKey(name: 'rated_at') this.ratedAt,
  });

  factory _$SharedBottleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SharedBottleModelImplFromJson(json);

  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  @JsonKey(name: 'wine_id')
  final String wineId;
  @override
  @JsonKey(name: 'wine_name')
  final String wineName;
  @override
  final String? winery;
  @override
  final String? region;
  @override
  final String? country;
  @override
  final String type;
  @override
  final int? vintage;
  @override
  @JsonKey(name: 'my_rating')
  final double myRating;
  @override
  @JsonKey(name: 'their_rating')
  final double theirRating;
  @override
  final double delta;
  @override
  @JsonKey(name: 'rated_at')
  final DateTime? ratedAt;

  @override
  String toString() {
    return 'SharedBottleModel(groupId: $groupId, wineId: $wineId, wineName: $wineName, winery: $winery, region: $region, country: $country, type: $type, vintage: $vintage, myRating: $myRating, theirRating: $theirRating, delta: $delta, ratedAt: $ratedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SharedBottleModelImpl &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.wineId, wineId) || other.wineId == wineId) &&
            (identical(other.wineName, wineName) ||
                other.wineName == wineName) &&
            (identical(other.winery, winery) || other.winery == winery) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.vintage, vintage) || other.vintage == vintage) &&
            (identical(other.myRating, myRating) ||
                other.myRating == myRating) &&
            (identical(other.theirRating, theirRating) ||
                other.theirRating == theirRating) &&
            (identical(other.delta, delta) || other.delta == delta) &&
            (identical(other.ratedAt, ratedAt) || other.ratedAt == ratedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    groupId,
    wineId,
    wineName,
    winery,
    region,
    country,
    type,
    vintage,
    myRating,
    theirRating,
    delta,
    ratedAt,
  );

  /// Create a copy of SharedBottleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SharedBottleModelImplCopyWith<_$SharedBottleModelImpl> get copyWith =>
      __$$SharedBottleModelImplCopyWithImpl<_$SharedBottleModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SharedBottleModelImplToJson(this);
  }
}

abstract class _SharedBottleModel implements SharedBottleModel {
  const factory _SharedBottleModel({
    @JsonKey(name: 'group_id') required final String groupId,
    @JsonKey(name: 'wine_id') required final String wineId,
    @JsonKey(name: 'wine_name') required final String wineName,
    final String? winery,
    final String? region,
    final String? country,
    required final String type,
    final int? vintage,
    @JsonKey(name: 'my_rating') required final double myRating,
    @JsonKey(name: 'their_rating') required final double theirRating,
    required final double delta,
    @JsonKey(name: 'rated_at') final DateTime? ratedAt,
  }) = _$SharedBottleModelImpl;

  factory _SharedBottleModel.fromJson(Map<String, dynamic> json) =
      _$SharedBottleModelImpl.fromJson;

  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  @JsonKey(name: 'wine_id')
  String get wineId;
  @override
  @JsonKey(name: 'wine_name')
  String get wineName;
  @override
  String? get winery;
  @override
  String? get region;
  @override
  String? get country;
  @override
  String get type;
  @override
  int? get vintage;
  @override
  @JsonKey(name: 'my_rating')
  double get myRating;
  @override
  @JsonKey(name: 'their_rating')
  double get theirRating;
  @override
  double get delta;
  @override
  @JsonKey(name: 'rated_at')
  DateTime? get ratedAt;

  /// Create a copy of SharedBottleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SharedBottleModelImplCopyWith<_$SharedBottleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

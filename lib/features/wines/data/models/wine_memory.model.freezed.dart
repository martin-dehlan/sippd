// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_memory.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WineMemoryModel _$WineMemoryModelFromJson(Map<String, dynamic> json) {
  return _WineMemoryModel.fromJson(json);
}

/// @nodoc
mixin _$WineMemoryModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'wine_id')
  String get wineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'local_image_path')
  String? get localImagePath => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'occurred_at')
  DateTime? get occurredAt => throw _privateConstructorUsedError;
  String? get occasion => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_name')
  String? get placeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_lat')
  double? get placeLat => throw _privateConstructorUsedError;
  @JsonKey(name: 'place_lng')
  double? get placeLng => throw _privateConstructorUsedError;
  @JsonKey(name: 'food_paired')
  String? get foodPaired => throw _privateConstructorUsedError;
  @JsonKey(name: 'companion_user_ids')
  List<String> get companionUserIds => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WineMemoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineMemoryModelCopyWith<WineMemoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineMemoryModelCopyWith<$Res> {
  factory $WineMemoryModelCopyWith(
    WineMemoryModel value,
    $Res Function(WineMemoryModel) then,
  ) = _$WineMemoryModelCopyWithImpl<$Res, WineMemoryModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path') String? localImagePath,
    String? caption,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'occurred_at') DateTime? occurredAt,
    String? occasion,
    @JsonKey(name: 'place_name') String? placeName,
    @JsonKey(name: 'place_lat') double? placeLat,
    @JsonKey(name: 'place_lng') double? placeLng,
    @JsonKey(name: 'food_paired') String? foodPaired,
    @JsonKey(name: 'companion_user_ids') List<String> companionUserIds,
    String? note,
    String visibility,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class _$WineMemoryModelCopyWithImpl<$Res, $Val extends WineMemoryModel>
    implements $WineMemoryModelCopyWith<$Res> {
  _$WineMemoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wineId = null,
    Object? userId = null,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? caption = freezed,
    Object? createdAt = null,
    Object? occurredAt = freezed,
    Object? occasion = freezed,
    Object? placeName = freezed,
    Object? placeLat = freezed,
    Object? placeLng = freezed,
    Object? foodPaired = freezed,
    Object? companionUserIds = null,
    Object? note = freezed,
    Object? visibility = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            wineId: null == wineId
                ? _value.wineId
                : wineId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            localImagePath: freezed == localImagePath
                ? _value.localImagePath
                : localImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            caption: freezed == caption
                ? _value.caption
                : caption // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            occurredAt: freezed == occurredAt
                ? _value.occurredAt
                : occurredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            occasion: freezed == occasion
                ? _value.occasion
                : occasion // ignore: cast_nullable_to_non_nullable
                      as String?,
            placeName: freezed == placeName
                ? _value.placeName
                : placeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            placeLat: freezed == placeLat
                ? _value.placeLat
                : placeLat // ignore: cast_nullable_to_non_nullable
                      as double?,
            placeLng: freezed == placeLng
                ? _value.placeLng
                : placeLng // ignore: cast_nullable_to_non_nullable
                      as double?,
            foodPaired: freezed == foodPaired
                ? _value.foodPaired
                : foodPaired // ignore: cast_nullable_to_non_nullable
                      as String?,
            companionUserIds: null == companionUserIds
                ? _value.companionUserIds
                : companionUserIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            note: freezed == note
                ? _value.note
                : note // ignore: cast_nullable_to_non_nullable
                      as String?,
            visibility: null == visibility
                ? _value.visibility
                : visibility // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WineMemoryModelImplCopyWith<$Res>
    implements $WineMemoryModelCopyWith<$Res> {
  factory _$$WineMemoryModelImplCopyWith(
    _$WineMemoryModelImpl value,
    $Res Function(_$WineMemoryModelImpl) then,
  ) = __$$WineMemoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'wine_id') String wineId,
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'local_image_path') String? localImagePath,
    String? caption,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'occurred_at') DateTime? occurredAt,
    String? occasion,
    @JsonKey(name: 'place_name') String? placeName,
    @JsonKey(name: 'place_lat') double? placeLat,
    @JsonKey(name: 'place_lng') double? placeLng,
    @JsonKey(name: 'food_paired') String? foodPaired,
    @JsonKey(name: 'companion_user_ids') List<String> companionUserIds,
    String? note,
    String visibility,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WineMemoryModelImplCopyWithImpl<$Res>
    extends _$WineMemoryModelCopyWithImpl<$Res, _$WineMemoryModelImpl>
    implements _$$WineMemoryModelImplCopyWith<$Res> {
  __$$WineMemoryModelImplCopyWithImpl(
    _$WineMemoryModelImpl _value,
    $Res Function(_$WineMemoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wineId = null,
    Object? userId = null,
    Object? imageUrl = freezed,
    Object? localImagePath = freezed,
    Object? caption = freezed,
    Object? createdAt = null,
    Object? occurredAt = freezed,
    Object? occasion = freezed,
    Object? placeName = freezed,
    Object? placeLat = freezed,
    Object? placeLng = freezed,
    Object? foodPaired = freezed,
    Object? companionUserIds = null,
    Object? note = freezed,
    Object? visibility = null,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$WineMemoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        wineId: null == wineId
            ? _value.wineId
            : wineId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        localImagePath: freezed == localImagePath
            ? _value.localImagePath
            : localImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        caption: freezed == caption
            ? _value.caption
            : caption // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        occurredAt: freezed == occurredAt
            ? _value.occurredAt
            : occurredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        occasion: freezed == occasion
            ? _value.occasion
            : occasion // ignore: cast_nullable_to_non_nullable
                  as String?,
        placeName: freezed == placeName
            ? _value.placeName
            : placeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        placeLat: freezed == placeLat
            ? _value.placeLat
            : placeLat // ignore: cast_nullable_to_non_nullable
                  as double?,
        placeLng: freezed == placeLng
            ? _value.placeLng
            : placeLng // ignore: cast_nullable_to_non_nullable
                  as double?,
        foodPaired: freezed == foodPaired
            ? _value.foodPaired
            : foodPaired // ignore: cast_nullable_to_non_nullable
                  as String?,
        companionUserIds: null == companionUserIds
            ? _value._companionUserIds
            : companionUserIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        note: freezed == note
            ? _value.note
            : note // ignore: cast_nullable_to_non_nullable
                  as String?,
        visibility: null == visibility
            ? _value.visibility
            : visibility // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WineMemoryModelImpl implements _WineMemoryModel {
  const _$WineMemoryModelImpl({
    required this.id,
    @JsonKey(name: 'wine_id') required this.wineId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'local_image_path') this.localImagePath,
    this.caption,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'occurred_at') this.occurredAt,
    this.occasion,
    @JsonKey(name: 'place_name') this.placeName,
    @JsonKey(name: 'place_lat') this.placeLat,
    @JsonKey(name: 'place_lng') this.placeLng,
    @JsonKey(name: 'food_paired') this.foodPaired,
    @JsonKey(name: 'companion_user_ids')
    final List<String> companionUserIds = const <String>[],
    this.note,
    this.visibility = 'friends',
    @JsonKey(name: 'updated_at') this.updatedAt,
  }) : _companionUserIds = companionUserIds;

  factory _$WineMemoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WineMemoryModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'wine_id')
  final String wineId;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'local_image_path')
  final String? localImagePath;
  @override
  final String? caption;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'occurred_at')
  final DateTime? occurredAt;
  @override
  final String? occasion;
  @override
  @JsonKey(name: 'place_name')
  final String? placeName;
  @override
  @JsonKey(name: 'place_lat')
  final double? placeLat;
  @override
  @JsonKey(name: 'place_lng')
  final double? placeLng;
  @override
  @JsonKey(name: 'food_paired')
  final String? foodPaired;
  final List<String> _companionUserIds;
  @override
  @JsonKey(name: 'companion_user_ids')
  List<String> get companionUserIds {
    if (_companionUserIds is EqualUnmodifiableListView)
      return _companionUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_companionUserIds);
  }

  @override
  final String? note;
  @override
  @JsonKey()
  final String visibility;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WineMemoryModel(id: $id, wineId: $wineId, userId: $userId, imageUrl: $imageUrl, localImagePath: $localImagePath, caption: $caption, createdAt: $createdAt, occurredAt: $occurredAt, occasion: $occasion, placeName: $placeName, placeLat: $placeLat, placeLng: $placeLng, foodPaired: $foodPaired, companionUserIds: $companionUserIds, note: $note, visibility: $visibility, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineMemoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wineId, wineId) || other.wineId == wineId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.localImagePath, localImagePath) ||
                other.localImagePath == localImagePath) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt) &&
            (identical(other.occasion, occasion) ||
                other.occasion == occasion) &&
            (identical(other.placeName, placeName) ||
                other.placeName == placeName) &&
            (identical(other.placeLat, placeLat) ||
                other.placeLat == placeLat) &&
            (identical(other.placeLng, placeLng) ||
                other.placeLng == placeLng) &&
            (identical(other.foodPaired, foodPaired) ||
                other.foodPaired == foodPaired) &&
            const DeepCollectionEquality().equals(
              other._companionUserIds,
              _companionUserIds,
            ) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    wineId,
    userId,
    imageUrl,
    localImagePath,
    caption,
    createdAt,
    occurredAt,
    occasion,
    placeName,
    placeLat,
    placeLng,
    foodPaired,
    const DeepCollectionEquality().hash(_companionUserIds),
    note,
    visibility,
    updatedAt,
  );

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineMemoryModelImplCopyWith<_$WineMemoryModelImpl> get copyWith =>
      __$$WineMemoryModelImplCopyWithImpl<_$WineMemoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WineMemoryModelImplToJson(this);
  }
}

abstract class _WineMemoryModel implements WineMemoryModel {
  const factory _WineMemoryModel({
    required final String id,
    @JsonKey(name: 'wine_id') required final String wineId,
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'local_image_path') final String? localImagePath,
    final String? caption,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'occurred_at') final DateTime? occurredAt,
    final String? occasion,
    @JsonKey(name: 'place_name') final String? placeName,
    @JsonKey(name: 'place_lat') final double? placeLat,
    @JsonKey(name: 'place_lng') final double? placeLng,
    @JsonKey(name: 'food_paired') final String? foodPaired,
    @JsonKey(name: 'companion_user_ids') final List<String> companionUserIds,
    final String? note,
    final String visibility,
    @JsonKey(name: 'updated_at') final DateTime? updatedAt,
  }) = _$WineMemoryModelImpl;

  factory _WineMemoryModel.fromJson(Map<String, dynamic> json) =
      _$WineMemoryModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'wine_id')
  String get wineId;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'local_image_path')
  String? get localImagePath;
  @override
  String? get caption;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'occurred_at')
  DateTime? get occurredAt;
  @override
  String? get occasion;
  @override
  @JsonKey(name: 'place_name')
  String? get placeName;
  @override
  @JsonKey(name: 'place_lat')
  double? get placeLat;
  @override
  @JsonKey(name: 'place_lng')
  double? get placeLng;
  @override
  @JsonKey(name: 'food_paired')
  String? get foodPaired;
  @override
  @JsonKey(name: 'companion_user_ids')
  List<String> get companionUserIds;
  @override
  String? get note;
  @override
  String get visibility;
  @override
  @JsonKey(name: 'updated_at')
  DateTime? get updatedAt;

  /// Create a copy of WineMemoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineMemoryModelImplCopyWith<_$WineMemoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

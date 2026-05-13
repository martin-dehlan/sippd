// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wine_memory.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WineMemoryEntity {
  String get id => throw _privateConstructorUsedError;
  String get wineId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get localImagePath => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get occurredAt => throw _privateConstructorUsedError;
  String? get occasion => throw _privateConstructorUsedError;
  String? get placeName => throw _privateConstructorUsedError;
  double? get placeLat => throw _privateConstructorUsedError;
  double? get placeLng => throw _privateConstructorUsedError;
  String? get foodPaired => throw _privateConstructorUsedError;
  List<String> get companionUserIds => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  String get visibility => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of WineMemoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WineMemoryEntityCopyWith<WineMemoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WineMemoryEntityCopyWith<$Res> {
  factory $WineMemoryEntityCopyWith(
    WineMemoryEntity value,
    $Res Function(WineMemoryEntity) then,
  ) = _$WineMemoryEntityCopyWithImpl<$Res, WineMemoryEntity>;
  @useResult
  $Res call({
    String id,
    String wineId,
    String userId,
    String? imageUrl,
    String? localImagePath,
    String? caption,
    DateTime createdAt,
    DateTime? occurredAt,
    String? occasion,
    String? placeName,
    double? placeLat,
    double? placeLng,
    String? foodPaired,
    List<String> companionUserIds,
    String? note,
    String visibility,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$WineMemoryEntityCopyWithImpl<$Res, $Val extends WineMemoryEntity>
    implements $WineMemoryEntityCopyWith<$Res> {
  _$WineMemoryEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WineMemoryEntity
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
abstract class _$$WineMemoryEntityImplCopyWith<$Res>
    implements $WineMemoryEntityCopyWith<$Res> {
  factory _$$WineMemoryEntityImplCopyWith(
    _$WineMemoryEntityImpl value,
    $Res Function(_$WineMemoryEntityImpl) then,
  ) = __$$WineMemoryEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String wineId,
    String userId,
    String? imageUrl,
    String? localImagePath,
    String? caption,
    DateTime createdAt,
    DateTime? occurredAt,
    String? occasion,
    String? placeName,
    double? placeLat,
    double? placeLng,
    String? foodPaired,
    List<String> companionUserIds,
    String? note,
    String visibility,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$WineMemoryEntityImplCopyWithImpl<$Res>
    extends _$WineMemoryEntityCopyWithImpl<$Res, _$WineMemoryEntityImpl>
    implements _$$WineMemoryEntityImplCopyWith<$Res> {
  __$$WineMemoryEntityImplCopyWithImpl(
    _$WineMemoryEntityImpl _value,
    $Res Function(_$WineMemoryEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WineMemoryEntity
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
      _$WineMemoryEntityImpl(
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

class _$WineMemoryEntityImpl implements _WineMemoryEntity {
  const _$WineMemoryEntityImpl({
    required this.id,
    required this.wineId,
    required this.userId,
    this.imageUrl,
    this.localImagePath,
    this.caption,
    required this.createdAt,
    this.occurredAt,
    this.occasion,
    this.placeName,
    this.placeLat,
    this.placeLng,
    this.foodPaired,
    final List<String> companionUserIds = const <String>[],
    this.note,
    this.visibility = 'friends',
    this.updatedAt,
  }) : _companionUserIds = companionUserIds;

  @override
  final String id;
  @override
  final String wineId;
  @override
  final String userId;
  @override
  final String? imageUrl;
  @override
  final String? localImagePath;
  @override
  final String? caption;
  @override
  final DateTime createdAt;
  @override
  final DateTime? occurredAt;
  @override
  final String? occasion;
  @override
  final String? placeName;
  @override
  final double? placeLat;
  @override
  final double? placeLng;
  @override
  final String? foodPaired;
  final List<String> _companionUserIds;
  @override
  @JsonKey()
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
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WineMemoryEntity(id: $id, wineId: $wineId, userId: $userId, imageUrl: $imageUrl, localImagePath: $localImagePath, caption: $caption, createdAt: $createdAt, occurredAt: $occurredAt, occasion: $occasion, placeName: $placeName, placeLat: $placeLat, placeLng: $placeLng, foodPaired: $foodPaired, companionUserIds: $companionUserIds, note: $note, visibility: $visibility, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WineMemoryEntityImpl &&
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

  /// Create a copy of WineMemoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WineMemoryEntityImplCopyWith<_$WineMemoryEntityImpl> get copyWith =>
      __$$WineMemoryEntityImplCopyWithImpl<_$WineMemoryEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _WineMemoryEntity implements WineMemoryEntity {
  const factory _WineMemoryEntity({
    required final String id,
    required final String wineId,
    required final String userId,
    final String? imageUrl,
    final String? localImagePath,
    final String? caption,
    required final DateTime createdAt,
    final DateTime? occurredAt,
    final String? occasion,
    final String? placeName,
    final double? placeLat,
    final double? placeLng,
    final String? foodPaired,
    final List<String> companionUserIds,
    final String? note,
    final String visibility,
    final DateTime? updatedAt,
  }) = _$WineMemoryEntityImpl;

  @override
  String get id;
  @override
  String get wineId;
  @override
  String get userId;
  @override
  String? get imageUrl;
  @override
  String? get localImagePath;
  @override
  String? get caption;
  @override
  DateTime get createdAt;
  @override
  DateTime? get occurredAt;
  @override
  String? get occasion;
  @override
  String? get placeName;
  @override
  double? get placeLat;
  @override
  double? get placeLng;
  @override
  String? get foodPaired;
  @override
  List<String> get companionUserIds;
  @override
  String? get note;
  @override
  String get visibility;
  @override
  DateTime? get updatedAt;

  /// Create a copy of WineMemoryEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WineMemoryEntityImplCopyWith<_$WineMemoryEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

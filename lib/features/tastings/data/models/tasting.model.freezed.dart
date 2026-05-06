// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tasting.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TastingModel _$TastingModelFromJson(Map<String, dynamic> json) {
  return _TastingModel.fromJson(json);
}

/// @nodoc
mixin _$TastingModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_id')
  String get groupId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'scheduled_at')
  DateTime get scheduledAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  String get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_blind')
  bool get isBlind => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_revealed')
  bool get isRevealed => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  @JsonKey(name: 'lineup_mode')
  String get lineupMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'started_at')
  DateTime? get startedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ended_at')
  DateTime? get endedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TastingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TastingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TastingModelCopyWith<TastingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TastingModelCopyWith<$Res> {
  factory $TastingModelCopyWith(
    TastingModel value,
    $Res Function(TastingModel) then,
  ) = _$TastingModelCopyWithImpl<$Res, TastingModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'group_id') String groupId,
    String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'scheduled_at') DateTime scheduledAt,
    @JsonKey(name: 'created_by') String createdBy,
    @JsonKey(name: 'is_blind') bool isBlind,
    @JsonKey(name: 'is_revealed') bool isRevealed,
    String state,
    @JsonKey(name: 'lineup_mode') String lineupMode,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$TastingModelCopyWithImpl<$Res, $Val extends TastingModel>
    implements $TastingModelCopyWith<$Res> {
  _$TastingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TastingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? title = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? scheduledAt = null,
    Object? createdBy = null,
    Object? isBlind = null,
    Object? isRevealed = null,
    Object? state = null,
    Object? lineupMode = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            groupId: null == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            scheduledAt: null == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            isBlind: null == isBlind
                ? _value.isBlind
                : isBlind // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRevealed: null == isRevealed
                ? _value.isRevealed
                : isRevealed // ignore: cast_nullable_to_non_nullable
                      as bool,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            lineupMode: null == lineupMode
                ? _value.lineupMode
                : lineupMode // ignore: cast_nullable_to_non_nullable
                      as String,
            startedAt: freezed == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TastingModelImplCopyWith<$Res>
    implements $TastingModelCopyWith<$Res> {
  factory _$$TastingModelImplCopyWith(
    _$TastingModelImpl value,
    $Res Function(_$TastingModelImpl) then,
  ) = __$$TastingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'group_id') String groupId,
    String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'scheduled_at') DateTime scheduledAt,
    @JsonKey(name: 'created_by') String createdBy,
    @JsonKey(name: 'is_blind') bool isBlind,
    @JsonKey(name: 'is_revealed') bool isRevealed,
    String state,
    @JsonKey(name: 'lineup_mode') String lineupMode,
    @JsonKey(name: 'started_at') DateTime? startedAt,
    @JsonKey(name: 'ended_at') DateTime? endedAt,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$TastingModelImplCopyWithImpl<$Res>
    extends _$TastingModelCopyWithImpl<$Res, _$TastingModelImpl>
    implements _$$TastingModelImplCopyWith<$Res> {
  __$$TastingModelImplCopyWithImpl(
    _$TastingModelImpl _value,
    $Res Function(_$TastingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TastingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupId = null,
    Object? title = null,
    Object? description = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? scheduledAt = null,
    Object? createdBy = null,
    Object? isBlind = null,
    Object? isRevealed = null,
    Object? state = null,
    Object? lineupMode = null,
    Object? startedAt = freezed,
    Object? endedAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$TastingModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        groupId: null == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        scheduledAt: null == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        isBlind: null == isBlind
            ? _value.isBlind
            : isBlind // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRevealed: null == isRevealed
            ? _value.isRevealed
            : isRevealed // ignore: cast_nullable_to_non_nullable
                  as bool,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        lineupMode: null == lineupMode
            ? _value.lineupMode
            : lineupMode // ignore: cast_nullable_to_non_nullable
                  as String,
        startedAt: freezed == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TastingModelImpl implements _TastingModel {
  const _$TastingModelImpl({
    required this.id,
    @JsonKey(name: 'group_id') required this.groupId,
    required this.title,
    this.description,
    this.location,
    this.latitude,
    this.longitude,
    @JsonKey(name: 'scheduled_at') required this.scheduledAt,
    @JsonKey(name: 'created_by') required this.createdBy,
    @JsonKey(name: 'is_blind') this.isBlind = false,
    @JsonKey(name: 'is_revealed') this.isRevealed = false,
    this.state = 'upcoming',
    @JsonKey(name: 'lineup_mode') this.lineupMode = 'planned',
    @JsonKey(name: 'started_at') this.startedAt,
    @JsonKey(name: 'ended_at') this.endedAt,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$TastingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TastingModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'group_id')
  final String groupId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? location;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  @JsonKey(name: 'scheduled_at')
  final DateTime scheduledAt;
  @override
  @JsonKey(name: 'created_by')
  final String createdBy;
  @override
  @JsonKey(name: 'is_blind')
  final bool isBlind;
  @override
  @JsonKey(name: 'is_revealed')
  final bool isRevealed;
  @override
  @JsonKey()
  final String state;
  @override
  @JsonKey(name: 'lineup_mode')
  final String lineupMode;
  @override
  @JsonKey(name: 'started_at')
  final DateTime? startedAt;
  @override
  @JsonKey(name: 'ended_at')
  final DateTime? endedAt;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'TastingModel(id: $id, groupId: $groupId, title: $title, description: $description, location: $location, latitude: $latitude, longitude: $longitude, scheduledAt: $scheduledAt, createdBy: $createdBy, isBlind: $isBlind, isRevealed: $isRevealed, state: $state, lineupMode: $lineupMode, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TastingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.isBlind, isBlind) || other.isBlind == isBlind) &&
            (identical(other.isRevealed, isRevealed) ||
                other.isRevealed == isRevealed) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.lineupMode, lineupMode) ||
                other.lineupMode == lineupMode) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    groupId,
    title,
    description,
    location,
    latitude,
    longitude,
    scheduledAt,
    createdBy,
    isBlind,
    isRevealed,
    state,
    lineupMode,
    startedAt,
    endedAt,
    createdAt,
  );

  /// Create a copy of TastingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TastingModelImplCopyWith<_$TastingModelImpl> get copyWith =>
      __$$TastingModelImplCopyWithImpl<_$TastingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TastingModelImplToJson(this);
  }
}

abstract class _TastingModel implements TastingModel {
  const factory _TastingModel({
    required final String id,
    @JsonKey(name: 'group_id') required final String groupId,
    required final String title,
    final String? description,
    final String? location,
    final double? latitude,
    final double? longitude,
    @JsonKey(name: 'scheduled_at') required final DateTime scheduledAt,
    @JsonKey(name: 'created_by') required final String createdBy,
    @JsonKey(name: 'is_blind') final bool isBlind,
    @JsonKey(name: 'is_revealed') final bool isRevealed,
    final String state,
    @JsonKey(name: 'lineup_mode') final String lineupMode,
    @JsonKey(name: 'started_at') final DateTime? startedAt,
    @JsonKey(name: 'ended_at') final DateTime? endedAt,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$TastingModelImpl;

  factory _TastingModel.fromJson(Map<String, dynamic> json) =
      _$TastingModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'group_id')
  String get groupId;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get location;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(name: 'scheduled_at')
  DateTime get scheduledAt;
  @override
  @JsonKey(name: 'created_by')
  String get createdBy;
  @override
  @JsonKey(name: 'is_blind')
  bool get isBlind;
  @override
  @JsonKey(name: 'is_revealed')
  bool get isRevealed;
  @override
  String get state;
  @override
  @JsonKey(name: 'lineup_mode')
  String get lineupMode;
  @override
  @JsonKey(name: 'started_at')
  DateTime? get startedAt;
  @override
  @JsonKey(name: 'ended_at')
  DateTime? get endedAt;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of TastingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TastingModelImplCopyWith<_$TastingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

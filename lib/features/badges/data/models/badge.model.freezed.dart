// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'badge.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BadgeModel _$BadgeModelFromJson(Map<String, dynamic> json) {
  return _BadgeModel.fromJson(json);
}

/// @nodoc
mixin _$BadgeModel {
  @JsonKey(name: 'badge_id')
  String get badgeId => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  int get tier => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  bool get earned => throw _privateConstructorUsedError;
  @JsonKey(name: 'earned_at')
  DateTime? get earnedAt => throw _privateConstructorUsedError;
  int get current => throw _privateConstructorUsedError;
  int get target => throw _privateConstructorUsedError;

  /// Serializes this BadgeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgeModelCopyWith<BadgeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeModelCopyWith<$Res> {
  factory $BadgeModelCopyWith(
    BadgeModel value,
    $Res Function(BadgeModel) then,
  ) = _$BadgeModelCopyWithImpl<$Res, BadgeModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'badge_id') String badgeId,
    String category,
    int tier,
    String title,
    String description,
    String icon,
    bool earned,
    @JsonKey(name: 'earned_at') DateTime? earnedAt,
    int current,
    int target,
  });
}

/// @nodoc
class _$BadgeModelCopyWithImpl<$Res, $Val extends BadgeModel>
    implements $BadgeModelCopyWith<$Res> {
  _$BadgeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badgeId = null,
    Object? category = null,
    Object? tier = null,
    Object? title = null,
    Object? description = null,
    Object? icon = null,
    Object? earned = null,
    Object? earnedAt = freezed,
    Object? current = null,
    Object? target = null,
  }) {
    return _then(
      _value.copyWith(
            badgeId: null == badgeId
                ? _value.badgeId
                : badgeId // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            tier: null == tier
                ? _value.tier
                : tier // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: null == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String,
            earned: null == earned
                ? _value.earned
                : earned // ignore: cast_nullable_to_non_nullable
                      as bool,
            earnedAt: freezed == earnedAt
                ? _value.earnedAt
                : earnedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            current: null == current
                ? _value.current
                : current // ignore: cast_nullable_to_non_nullable
                      as int,
            target: null == target
                ? _value.target
                : target // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BadgeModelImplCopyWith<$Res>
    implements $BadgeModelCopyWith<$Res> {
  factory _$$BadgeModelImplCopyWith(
    _$BadgeModelImpl value,
    $Res Function(_$BadgeModelImpl) then,
  ) = __$$BadgeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'badge_id') String badgeId,
    String category,
    int tier,
    String title,
    String description,
    String icon,
    bool earned,
    @JsonKey(name: 'earned_at') DateTime? earnedAt,
    int current,
    int target,
  });
}

/// @nodoc
class __$$BadgeModelImplCopyWithImpl<$Res>
    extends _$BadgeModelCopyWithImpl<$Res, _$BadgeModelImpl>
    implements _$$BadgeModelImplCopyWith<$Res> {
  __$$BadgeModelImplCopyWithImpl(
    _$BadgeModelImpl _value,
    $Res Function(_$BadgeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? badgeId = null,
    Object? category = null,
    Object? tier = null,
    Object? title = null,
    Object? description = null,
    Object? icon = null,
    Object? earned = null,
    Object? earnedAt = freezed,
    Object? current = null,
    Object? target = null,
  }) {
    return _then(
      _$BadgeModelImpl(
        badgeId: null == badgeId
            ? _value.badgeId
            : badgeId // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        tier: null == tier
            ? _value.tier
            : tier // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: null == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String,
        earned: null == earned
            ? _value.earned
            : earned // ignore: cast_nullable_to_non_nullable
                  as bool,
        earnedAt: freezed == earnedAt
            ? _value.earnedAt
            : earnedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        current: null == current
            ? _value.current
            : current // ignore: cast_nullable_to_non_nullable
                  as int,
        target: null == target
            ? _value.target
            : target // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeModelImpl implements _BadgeModel {
  const _$BadgeModelImpl({
    @JsonKey(name: 'badge_id') required this.badgeId,
    required this.category,
    required this.tier,
    required this.title,
    required this.description,
    required this.icon,
    this.earned = false,
    @JsonKey(name: 'earned_at') this.earnedAt,
    this.current = 0,
    this.target = 1,
  });

  factory _$BadgeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeModelImplFromJson(json);

  @override
  @JsonKey(name: 'badge_id')
  final String badgeId;
  @override
  final String category;
  @override
  final int tier;
  @override
  final String title;
  @override
  final String description;
  @override
  final String icon;
  @override
  @JsonKey()
  final bool earned;
  @override
  @JsonKey(name: 'earned_at')
  final DateTime? earnedAt;
  @override
  @JsonKey()
  final int current;
  @override
  @JsonKey()
  final int target;

  @override
  String toString() {
    return 'BadgeModel(badgeId: $badgeId, category: $category, tier: $tier, title: $title, description: $description, icon: $icon, earned: $earned, earnedAt: $earnedAt, current: $current, target: $target)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeModelImpl &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.earned, earned) || other.earned == earned) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.target, target) || other.target == target));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    badgeId,
    category,
    tier,
    title,
    description,
    icon,
    earned,
    earnedAt,
    current,
    target,
  );

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeModelImplCopyWith<_$BadgeModelImpl> get copyWith =>
      __$$BadgeModelImplCopyWithImpl<_$BadgeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgeModelImplToJson(this);
  }
}

abstract class _BadgeModel implements BadgeModel {
  const factory _BadgeModel({
    @JsonKey(name: 'badge_id') required final String badgeId,
    required final String category,
    required final int tier,
    required final String title,
    required final String description,
    required final String icon,
    final bool earned,
    @JsonKey(name: 'earned_at') final DateTime? earnedAt,
    final int current,
    final int target,
  }) = _$BadgeModelImpl;

  factory _BadgeModel.fromJson(Map<String, dynamic> json) =
      _$BadgeModelImpl.fromJson;

  @override
  @JsonKey(name: 'badge_id')
  String get badgeId;
  @override
  String get category;
  @override
  int get tier;
  @override
  String get title;
  @override
  String get description;
  @override
  String get icon;
  @override
  bool get earned;
  @override
  @JsonKey(name: 'earned_at')
  DateTime? get earnedAt;
  @override
  int get current;
  @override
  int get target;

  /// Create a copy of BadgeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgeModelImplCopyWith<_$BadgeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

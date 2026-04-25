// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProfileEntity {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  bool get onboardingCompleted => throw _privateConstructorUsedError;
  TasteLevel? get tasteLevel => throw _privateConstructorUsedError;
  Set<OnboardingGoal> get goals => throw _privateConstructorUsedError;
  Set<WineType> get styles => throw _privateConstructorUsedError;
  DrinkFrequency? get drinkFrequency => throw _privateConstructorUsedError;
  String? get tasteEmoji => throw _privateConstructorUsedError;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileEntityCopyWith<ProfileEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEntityCopyWith<$Res> {
  factory $ProfileEntityCopyWith(
    ProfileEntity value,
    $Res Function(ProfileEntity) then,
  ) = _$ProfileEntityCopyWithImpl<$Res, ProfileEntity>;
  @useResult
  $Res call({
    String id,
    String? username,
    String? displayName,
    String? avatarUrl,
    bool onboardingCompleted,
    TasteLevel? tasteLevel,
    Set<OnboardingGoal> goals,
    Set<WineType> styles,
    DrinkFrequency? drinkFrequency,
    String? tasteEmoji,
  });
}

/// @nodoc
class _$ProfileEntityCopyWithImpl<$Res, $Val extends ProfileEntity>
    implements $ProfileEntityCopyWith<$Res> {
  _$ProfileEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? onboardingCompleted = null,
    Object? tasteLevel = freezed,
    Object? goals = null,
    Object? styles = null,
    Object? drinkFrequency = freezed,
    Object? tasteEmoji = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            onboardingCompleted: null == onboardingCompleted
                ? _value.onboardingCompleted
                : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            tasteLevel: freezed == tasteLevel
                ? _value.tasteLevel
                : tasteLevel // ignore: cast_nullable_to_non_nullable
                      as TasteLevel?,
            goals: null == goals
                ? _value.goals
                : goals // ignore: cast_nullable_to_non_nullable
                      as Set<OnboardingGoal>,
            styles: null == styles
                ? _value.styles
                : styles // ignore: cast_nullable_to_non_nullable
                      as Set<WineType>,
            drinkFrequency: freezed == drinkFrequency
                ? _value.drinkFrequency
                : drinkFrequency // ignore: cast_nullable_to_non_nullable
                      as DrinkFrequency?,
            tasteEmoji: freezed == tasteEmoji
                ? _value.tasteEmoji
                : tasteEmoji // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileEntityImplCopyWith<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  factory _$$ProfileEntityImplCopyWith(
    _$ProfileEntityImpl value,
    $Res Function(_$ProfileEntityImpl) then,
  ) = __$$ProfileEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? username,
    String? displayName,
    String? avatarUrl,
    bool onboardingCompleted,
    TasteLevel? tasteLevel,
    Set<OnboardingGoal> goals,
    Set<WineType> styles,
    DrinkFrequency? drinkFrequency,
    String? tasteEmoji,
  });
}

/// @nodoc
class __$$ProfileEntityImplCopyWithImpl<$Res>
    extends _$ProfileEntityCopyWithImpl<$Res, _$ProfileEntityImpl>
    implements _$$ProfileEntityImplCopyWith<$Res> {
  __$$ProfileEntityImplCopyWithImpl(
    _$ProfileEntityImpl _value,
    $Res Function(_$ProfileEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? onboardingCompleted = null,
    Object? tasteLevel = freezed,
    Object? goals = null,
    Object? styles = null,
    Object? drinkFrequency = freezed,
    Object? tasteEmoji = freezed,
  }) {
    return _then(
      _$ProfileEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        onboardingCompleted: null == onboardingCompleted
            ? _value.onboardingCompleted
            : onboardingCompleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        tasteLevel: freezed == tasteLevel
            ? _value.tasteLevel
            : tasteLevel // ignore: cast_nullable_to_non_nullable
                  as TasteLevel?,
        goals: null == goals
            ? _value._goals
            : goals // ignore: cast_nullable_to_non_nullable
                  as Set<OnboardingGoal>,
        styles: null == styles
            ? _value._styles
            : styles // ignore: cast_nullable_to_non_nullable
                  as Set<WineType>,
        drinkFrequency: freezed == drinkFrequency
            ? _value.drinkFrequency
            : drinkFrequency // ignore: cast_nullable_to_non_nullable
                  as DrinkFrequency?,
        tasteEmoji: freezed == tasteEmoji
            ? _value.tasteEmoji
            : tasteEmoji // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ProfileEntityImpl implements _ProfileEntity {
  const _$ProfileEntityImpl({
    required this.id,
    this.username,
    this.displayName,
    this.avatarUrl,
    this.onboardingCompleted = false,
    this.tasteLevel,
    final Set<OnboardingGoal> goals = const <OnboardingGoal>{},
    final Set<WineType> styles = const <WineType>{},
    this.drinkFrequency,
    this.tasteEmoji,
  }) : _goals = goals,
       _styles = styles;

  @override
  final String id;
  @override
  final String? username;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final bool onboardingCompleted;
  @override
  final TasteLevel? tasteLevel;
  final Set<OnboardingGoal> _goals;
  @override
  @JsonKey()
  Set<OnboardingGoal> get goals {
    if (_goals is EqualUnmodifiableSetView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_goals);
  }

  final Set<WineType> _styles;
  @override
  @JsonKey()
  Set<WineType> get styles {
    if (_styles is EqualUnmodifiableSetView) return _styles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_styles);
  }

  @override
  final DrinkFrequency? drinkFrequency;
  @override
  final String? tasteEmoji;

  @override
  String toString() {
    return 'ProfileEntity(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, onboardingCompleted: $onboardingCompleted, tasteLevel: $tasteLevel, goals: $goals, styles: $styles, drinkFrequency: $drinkFrequency, tasteEmoji: $tasteEmoji)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted) &&
            (identical(other.tasteLevel, tasteLevel) ||
                other.tasteLevel == tasteLevel) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            const DeepCollectionEquality().equals(other._styles, _styles) &&
            (identical(other.drinkFrequency, drinkFrequency) ||
                other.drinkFrequency == drinkFrequency) &&
            (identical(other.tasteEmoji, tasteEmoji) ||
                other.tasteEmoji == tasteEmoji));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    displayName,
    avatarUrl,
    onboardingCompleted,
    tasteLevel,
    const DeepCollectionEquality().hash(_goals),
    const DeepCollectionEquality().hash(_styles),
    drinkFrequency,
    tasteEmoji,
  );

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileEntityImplCopyWith<_$ProfileEntityImpl> get copyWith =>
      __$$ProfileEntityImplCopyWithImpl<_$ProfileEntityImpl>(this, _$identity);
}

abstract class _ProfileEntity implements ProfileEntity {
  const factory _ProfileEntity({
    required final String id,
    final String? username,
    final String? displayName,
    final String? avatarUrl,
    final bool onboardingCompleted,
    final TasteLevel? tasteLevel,
    final Set<OnboardingGoal> goals,
    final Set<WineType> styles,
    final DrinkFrequency? drinkFrequency,
    final String? tasteEmoji,
  }) = _$ProfileEntityImpl;

  @override
  String get id;
  @override
  String? get username;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  bool get onboardingCompleted;
  @override
  TasteLevel? get tasteLevel;
  @override
  Set<OnboardingGoal> get goals;
  @override
  Set<WineType> get styles;
  @override
  DrinkFrequency? get drinkFrequency;
  @override
  String? get tasteEmoji;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileEntityImplCopyWith<_$ProfileEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

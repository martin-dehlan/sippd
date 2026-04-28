// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_prefs.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationPrefsModel _$NotificationPrefsModelFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationPrefsModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationPrefsModel {
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasting_reminders')
  bool get tastingReminders => throw _privateConstructorUsedError;
  @JsonKey(name: 'tasting_reminder_hours')
  int get tastingReminderHours => throw _privateConstructorUsedError;
  @JsonKey(name: 'friend_activity')
  bool get friendActivity => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_activity')
  bool get groupActivity => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_wine_shared')
  bool get groupWineShared => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationPrefsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPrefsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPrefsModelCopyWith<NotificationPrefsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPrefsModelCopyWith<$Res> {
  factory $NotificationPrefsModelCopyWith(
    NotificationPrefsModel value,
    $Res Function(NotificationPrefsModel) then,
  ) = _$NotificationPrefsModelCopyWithImpl<$Res, NotificationPrefsModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'tasting_reminders') bool tastingReminders,
    @JsonKey(name: 'tasting_reminder_hours') int tastingReminderHours,
    @JsonKey(name: 'friend_activity') bool friendActivity,
    @JsonKey(name: 'group_activity') bool groupActivity,
    @JsonKey(name: 'group_wine_shared') bool groupWineShared,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$NotificationPrefsModelCopyWithImpl<
  $Res,
  $Val extends NotificationPrefsModel
>
    implements $NotificationPrefsModelCopyWith<$Res> {
  _$NotificationPrefsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPrefsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? tastingReminders = null,
    Object? tastingReminderHours = null,
    Object? friendActivity = null,
    Object? groupActivity = null,
    Object? groupWineShared = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            tastingReminders: null == tastingReminders
                ? _value.tastingReminders
                : tastingReminders // ignore: cast_nullable_to_non_nullable
                      as bool,
            tastingReminderHours: null == tastingReminderHours
                ? _value.tastingReminderHours
                : tastingReminderHours // ignore: cast_nullable_to_non_nullable
                      as int,
            friendActivity: null == friendActivity
                ? _value.friendActivity
                : friendActivity // ignore: cast_nullable_to_non_nullable
                      as bool,
            groupActivity: null == groupActivity
                ? _value.groupActivity
                : groupActivity // ignore: cast_nullable_to_non_nullable
                      as bool,
            groupWineShared: null == groupWineShared
                ? _value.groupWineShared
                : groupWineShared // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$NotificationPrefsModelImplCopyWith<$Res>
    implements $NotificationPrefsModelCopyWith<$Res> {
  factory _$$NotificationPrefsModelImplCopyWith(
    _$NotificationPrefsModelImpl value,
    $Res Function(_$NotificationPrefsModelImpl) then,
  ) = __$$NotificationPrefsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'tasting_reminders') bool tastingReminders,
    @JsonKey(name: 'tasting_reminder_hours') int tastingReminderHours,
    @JsonKey(name: 'friend_activity') bool friendActivity,
    @JsonKey(name: 'group_activity') bool groupActivity,
    @JsonKey(name: 'group_wine_shared') bool groupWineShared,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$NotificationPrefsModelImplCopyWithImpl<$Res>
    extends
        _$NotificationPrefsModelCopyWithImpl<$Res, _$NotificationPrefsModelImpl>
    implements _$$NotificationPrefsModelImplCopyWith<$Res> {
  __$$NotificationPrefsModelImplCopyWithImpl(
    _$NotificationPrefsModelImpl _value,
    $Res Function(_$NotificationPrefsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationPrefsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? tastingReminders = null,
    Object? tastingReminderHours = null,
    Object? friendActivity = null,
    Object? groupActivity = null,
    Object? groupWineShared = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$NotificationPrefsModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        tastingReminders: null == tastingReminders
            ? _value.tastingReminders
            : tastingReminders // ignore: cast_nullable_to_non_nullable
                  as bool,
        tastingReminderHours: null == tastingReminderHours
            ? _value.tastingReminderHours
            : tastingReminderHours // ignore: cast_nullable_to_non_nullable
                  as int,
        friendActivity: null == friendActivity
            ? _value.friendActivity
            : friendActivity // ignore: cast_nullable_to_non_nullable
                  as bool,
        groupActivity: null == groupActivity
            ? _value.groupActivity
            : groupActivity // ignore: cast_nullable_to_non_nullable
                  as bool,
        groupWineShared: null == groupWineShared
            ? _value.groupWineShared
            : groupWineShared // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$NotificationPrefsModelImpl implements _NotificationPrefsModel {
  const _$NotificationPrefsModelImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'tasting_reminders') required this.tastingReminders,
    @JsonKey(name: 'tasting_reminder_hours') required this.tastingReminderHours,
    @JsonKey(name: 'friend_activity') required this.friendActivity,
    @JsonKey(name: 'group_activity') required this.groupActivity,
    @JsonKey(name: 'group_wine_shared') required this.groupWineShared,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$NotificationPrefsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationPrefsModelImplFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'tasting_reminders')
  final bool tastingReminders;
  @override
  @JsonKey(name: 'tasting_reminder_hours')
  final int tastingReminderHours;
  @override
  @JsonKey(name: 'friend_activity')
  final bool friendActivity;
  @override
  @JsonKey(name: 'group_activity')
  final bool groupActivity;
  @override
  @JsonKey(name: 'group_wine_shared')
  final bool groupWineShared;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'NotificationPrefsModel(userId: $userId, tastingReminders: $tastingReminders, tastingReminderHours: $tastingReminderHours, friendActivity: $friendActivity, groupActivity: $groupActivity, groupWineShared: $groupWineShared, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPrefsModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.tastingReminders, tastingReminders) ||
                other.tastingReminders == tastingReminders) &&
            (identical(other.tastingReminderHours, tastingReminderHours) ||
                other.tastingReminderHours == tastingReminderHours) &&
            (identical(other.friendActivity, friendActivity) ||
                other.friendActivity == friendActivity) &&
            (identical(other.groupActivity, groupActivity) ||
                other.groupActivity == groupActivity) &&
            (identical(other.groupWineShared, groupWineShared) ||
                other.groupWineShared == groupWineShared) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    tastingReminders,
    tastingReminderHours,
    friendActivity,
    groupActivity,
    groupWineShared,
    updatedAt,
  );

  /// Create a copy of NotificationPrefsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPrefsModelImplCopyWith<_$NotificationPrefsModelImpl>
  get copyWith =>
      __$$NotificationPrefsModelImplCopyWithImpl<_$NotificationPrefsModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPrefsModelImplToJson(this);
  }
}

abstract class _NotificationPrefsModel implements NotificationPrefsModel {
  const factory _NotificationPrefsModel({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'tasting_reminders') required final bool tastingReminders,
    @JsonKey(name: 'tasting_reminder_hours')
    required final int tastingReminderHours,
    @JsonKey(name: 'friend_activity') required final bool friendActivity,
    @JsonKey(name: 'group_activity') required final bool groupActivity,
    @JsonKey(name: 'group_wine_shared') required final bool groupWineShared,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$NotificationPrefsModelImpl;

  factory _NotificationPrefsModel.fromJson(Map<String, dynamic> json) =
      _$NotificationPrefsModelImpl.fromJson;

  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  @JsonKey(name: 'tasting_reminders')
  bool get tastingReminders;
  @override
  @JsonKey(name: 'tasting_reminder_hours')
  int get tastingReminderHours;
  @override
  @JsonKey(name: 'friend_activity')
  bool get friendActivity;
  @override
  @JsonKey(name: 'group_activity')
  bool get groupActivity;
  @override
  @JsonKey(name: 'group_wine_shared')
  bool get groupWineShared;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of NotificationPrefsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPrefsModelImplCopyWith<_$NotificationPrefsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

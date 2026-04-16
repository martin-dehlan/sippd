// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_item.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ActivityItemEntity {
  WineEntity get wine => throw _privateConstructorUsedError;
  FriendProfileEntity get friend => throw _privateConstructorUsedError;

  /// Create a copy of ActivityItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityItemEntityCopyWith<ActivityItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityItemEntityCopyWith<$Res> {
  factory $ActivityItemEntityCopyWith(
    ActivityItemEntity value,
    $Res Function(ActivityItemEntity) then,
  ) = _$ActivityItemEntityCopyWithImpl<$Res, ActivityItemEntity>;
  @useResult
  $Res call({WineEntity wine, FriendProfileEntity friend});

  $WineEntityCopyWith<$Res> get wine;
  $FriendProfileEntityCopyWith<$Res> get friend;
}

/// @nodoc
class _$ActivityItemEntityCopyWithImpl<$Res, $Val extends ActivityItemEntity>
    implements $ActivityItemEntityCopyWith<$Res> {
  _$ActivityItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? wine = null, Object? friend = null}) {
    return _then(
      _value.copyWith(
            wine: null == wine
                ? _value.wine
                : wine // ignore: cast_nullable_to_non_nullable
                      as WineEntity,
            friend: null == friend
                ? _value.friend
                : friend // ignore: cast_nullable_to_non_nullable
                      as FriendProfileEntity,
          )
          as $Val,
    );
  }

  /// Create a copy of ActivityItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WineEntityCopyWith<$Res> get wine {
    return $WineEntityCopyWith<$Res>(_value.wine, (value) {
      return _then(_value.copyWith(wine: value) as $Val);
    });
  }

  /// Create a copy of ActivityItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileEntityCopyWith<$Res> get friend {
    return $FriendProfileEntityCopyWith<$Res>(_value.friend, (value) {
      return _then(_value.copyWith(friend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActivityItemEntityImplCopyWith<$Res>
    implements $ActivityItemEntityCopyWith<$Res> {
  factory _$$ActivityItemEntityImplCopyWith(
    _$ActivityItemEntityImpl value,
    $Res Function(_$ActivityItemEntityImpl) then,
  ) = __$$ActivityItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WineEntity wine, FriendProfileEntity friend});

  @override
  $WineEntityCopyWith<$Res> get wine;
  @override
  $FriendProfileEntityCopyWith<$Res> get friend;
}

/// @nodoc
class __$$ActivityItemEntityImplCopyWithImpl<$Res>
    extends _$ActivityItemEntityCopyWithImpl<$Res, _$ActivityItemEntityImpl>
    implements _$$ActivityItemEntityImplCopyWith<$Res> {
  __$$ActivityItemEntityImplCopyWithImpl(
    _$ActivityItemEntityImpl _value,
    $Res Function(_$ActivityItemEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ActivityItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? wine = null, Object? friend = null}) {
    return _then(
      _$ActivityItemEntityImpl(
        wine: null == wine
            ? _value.wine
            : wine // ignore: cast_nullable_to_non_nullable
                  as WineEntity,
        friend: null == friend
            ? _value.friend
            : friend // ignore: cast_nullable_to_non_nullable
                  as FriendProfileEntity,
      ),
    );
  }
}

/// @nodoc

class _$ActivityItemEntityImpl implements _ActivityItemEntity {
  const _$ActivityItemEntityImpl({required this.wine, required this.friend});

  @override
  final WineEntity wine;
  @override
  final FriendProfileEntity friend;

  @override
  String toString() {
    return 'ActivityItemEntity(wine: $wine, friend: $friend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityItemEntityImpl &&
            (identical(other.wine, wine) || other.wine == wine) &&
            (identical(other.friend, friend) || other.friend == friend));
  }

  @override
  int get hashCode => Object.hash(runtimeType, wine, friend);

  /// Create a copy of ActivityItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityItemEntityImplCopyWith<_$ActivityItemEntityImpl> get copyWith =>
      __$$ActivityItemEntityImplCopyWithImpl<_$ActivityItemEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _ActivityItemEntity implements ActivityItemEntity {
  const factory _ActivityItemEntity({
    required final WineEntity wine,
    required final FriendProfileEntity friend,
  }) = _$ActivityItemEntityImpl;

  @override
  WineEntity get wine;
  @override
  FriendProfileEntity get friend;

  /// Create a copy of ActivityItemEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityItemEntityImplCopyWith<_$ActivityItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

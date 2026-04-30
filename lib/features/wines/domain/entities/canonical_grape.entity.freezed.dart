// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canonical_grape.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CanonicalGrapeEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  GrapeColor get color => throw _privateConstructorUsedError;
  List<String> get aliases => throw _privateConstructorUsedError;

  /// Create a copy of CanonicalGrapeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CanonicalGrapeEntityCopyWith<CanonicalGrapeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanonicalGrapeEntityCopyWith<$Res> {
  factory $CanonicalGrapeEntityCopyWith(
    CanonicalGrapeEntity value,
    $Res Function(CanonicalGrapeEntity) then,
  ) = _$CanonicalGrapeEntityCopyWithImpl<$Res, CanonicalGrapeEntity>;
  @useResult
  $Res call({String id, String name, GrapeColor color, List<String> aliases});
}

/// @nodoc
class _$CanonicalGrapeEntityCopyWithImpl<
  $Res,
  $Val extends CanonicalGrapeEntity
>
    implements $CanonicalGrapeEntityCopyWith<$Res> {
  _$CanonicalGrapeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CanonicalGrapeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? aliases = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as GrapeColor,
            aliases: null == aliases
                ? _value.aliases
                : aliases // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CanonicalGrapeEntityImplCopyWith<$Res>
    implements $CanonicalGrapeEntityCopyWith<$Res> {
  factory _$$CanonicalGrapeEntityImplCopyWith(
    _$CanonicalGrapeEntityImpl value,
    $Res Function(_$CanonicalGrapeEntityImpl) then,
  ) = __$$CanonicalGrapeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, GrapeColor color, List<String> aliases});
}

/// @nodoc
class __$$CanonicalGrapeEntityImplCopyWithImpl<$Res>
    extends _$CanonicalGrapeEntityCopyWithImpl<$Res, _$CanonicalGrapeEntityImpl>
    implements _$$CanonicalGrapeEntityImplCopyWith<$Res> {
  __$$CanonicalGrapeEntityImplCopyWithImpl(
    _$CanonicalGrapeEntityImpl _value,
    $Res Function(_$CanonicalGrapeEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CanonicalGrapeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? aliases = null,
  }) {
    return _then(
      _$CanonicalGrapeEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as GrapeColor,
        aliases: null == aliases
            ? _value._aliases
            : aliases // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$CanonicalGrapeEntityImpl implements _CanonicalGrapeEntity {
  const _$CanonicalGrapeEntityImpl({
    required this.id,
    required this.name,
    required this.color,
    final List<String> aliases = const <String>[],
  }) : _aliases = aliases;

  @override
  final String id;
  @override
  final String name;
  @override
  final GrapeColor color;
  final List<String> _aliases;
  @override
  @JsonKey()
  List<String> get aliases {
    if (_aliases is EqualUnmodifiableListView) return _aliases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_aliases);
  }

  @override
  String toString() {
    return 'CanonicalGrapeEntity(id: $id, name: $name, color: $color, aliases: $aliases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanonicalGrapeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._aliases, _aliases));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    color,
    const DeepCollectionEquality().hash(_aliases),
  );

  /// Create a copy of CanonicalGrapeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CanonicalGrapeEntityImplCopyWith<_$CanonicalGrapeEntityImpl>
  get copyWith =>
      __$$CanonicalGrapeEntityImplCopyWithImpl<_$CanonicalGrapeEntityImpl>(
        this,
        _$identity,
      );
}

abstract class _CanonicalGrapeEntity implements CanonicalGrapeEntity {
  const factory _CanonicalGrapeEntity({
    required final String id,
    required final String name,
    required final GrapeColor color,
    final List<String> aliases,
  }) = _$CanonicalGrapeEntityImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  GrapeColor get color;
  @override
  List<String> get aliases;

  /// Create a copy of CanonicalGrapeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CanonicalGrapeEntityImplCopyWith<_$CanonicalGrapeEntityImpl>
  get copyWith => throw _privateConstructorUsedError;
}

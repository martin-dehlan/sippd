// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canonical_grape.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CanonicalGrapeModel _$CanonicalGrapeModelFromJson(Map<String, dynamic> json) {
  return _CanonicalGrapeModel.fromJson(json);
}

/// @nodoc
mixin _$CanonicalGrapeModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  List<String> get aliases => throw _privateConstructorUsedError;

  /// Serializes this CanonicalGrapeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CanonicalGrapeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CanonicalGrapeModelCopyWith<CanonicalGrapeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanonicalGrapeModelCopyWith<$Res> {
  factory $CanonicalGrapeModelCopyWith(
    CanonicalGrapeModel value,
    $Res Function(CanonicalGrapeModel) then,
  ) = _$CanonicalGrapeModelCopyWithImpl<$Res, CanonicalGrapeModel>;
  @useResult
  $Res call({String id, String name, String color, List<String> aliases});
}

/// @nodoc
class _$CanonicalGrapeModelCopyWithImpl<$Res, $Val extends CanonicalGrapeModel>
    implements $CanonicalGrapeModelCopyWith<$Res> {
  _$CanonicalGrapeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CanonicalGrapeModel
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
                      as String,
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
abstract class _$$CanonicalGrapeModelImplCopyWith<$Res>
    implements $CanonicalGrapeModelCopyWith<$Res> {
  factory _$$CanonicalGrapeModelImplCopyWith(
    _$CanonicalGrapeModelImpl value,
    $Res Function(_$CanonicalGrapeModelImpl) then,
  ) = __$$CanonicalGrapeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String color, List<String> aliases});
}

/// @nodoc
class __$$CanonicalGrapeModelImplCopyWithImpl<$Res>
    extends _$CanonicalGrapeModelCopyWithImpl<$Res, _$CanonicalGrapeModelImpl>
    implements _$$CanonicalGrapeModelImplCopyWith<$Res> {
  __$$CanonicalGrapeModelImplCopyWithImpl(
    _$CanonicalGrapeModelImpl _value,
    $Res Function(_$CanonicalGrapeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CanonicalGrapeModel
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
      _$CanonicalGrapeModelImpl(
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
                  as String,
        aliases: null == aliases
            ? _value._aliases
            : aliases // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CanonicalGrapeModelImpl implements _CanonicalGrapeModel {
  const _$CanonicalGrapeModelImpl({
    required this.id,
    required this.name,
    required this.color,
    final List<String> aliases = const <String>[],
  }) : _aliases = aliases;

  factory _$CanonicalGrapeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CanonicalGrapeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String color;
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
    return 'CanonicalGrapeModel(id: $id, name: $name, color: $color, aliases: $aliases)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanonicalGrapeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._aliases, _aliases));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    color,
    const DeepCollectionEquality().hash(_aliases),
  );

  /// Create a copy of CanonicalGrapeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CanonicalGrapeModelImplCopyWith<_$CanonicalGrapeModelImpl> get copyWith =>
      __$$CanonicalGrapeModelImplCopyWithImpl<_$CanonicalGrapeModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CanonicalGrapeModelImplToJson(this);
  }
}

abstract class _CanonicalGrapeModel implements CanonicalGrapeModel {
  const factory _CanonicalGrapeModel({
    required final String id,
    required final String name,
    required final String color,
    final List<String> aliases,
  }) = _$CanonicalGrapeModelImpl;

  factory _CanonicalGrapeModel.fromJson(Map<String, dynamic> json) =
      _$CanonicalGrapeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get color;
  @override
  List<String> get aliases;

  /// Create a copy of CanonicalGrapeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CanonicalGrapeModelImplCopyWith<_$CanonicalGrapeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

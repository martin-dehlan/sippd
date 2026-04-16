// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scanned_wine.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScannedWineData {
  String? get barcode => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get grape => throw _privateConstructorUsedError;
  int? get vintage => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get labelImagePath => throw _privateConstructorUsedError;
  ScanSource get source => throw _privateConstructorUsedError;
  bool get found => throw _privateConstructorUsedError;

  /// Create a copy of ScannedWineData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScannedWineDataCopyWith<ScannedWineData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannedWineDataCopyWith<$Res> {
  factory $ScannedWineDataCopyWith(
    ScannedWineData value,
    $Res Function(ScannedWineData) then,
  ) = _$ScannedWineDataCopyWithImpl<$Res, ScannedWineData>;
  @useResult
  $Res call({
    String? barcode,
    String? name,
    String? brand,
    String? country,
    String? grape,
    int? vintage,
    String? imageUrl,
    String? labelImagePath,
    ScanSource source,
    bool found,
  });
}

/// @nodoc
class _$ScannedWineDataCopyWithImpl<$Res, $Val extends ScannedWineData>
    implements $ScannedWineDataCopyWith<$Res> {
  _$ScannedWineDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScannedWineData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = freezed,
    Object? name = freezed,
    Object? brand = freezed,
    Object? country = freezed,
    Object? grape = freezed,
    Object? vintage = freezed,
    Object? imageUrl = freezed,
    Object? labelImagePath = freezed,
    Object? source = null,
    Object? found = null,
  }) {
    return _then(
      _value.copyWith(
            barcode: freezed == barcode
                ? _value.barcode
                : barcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            grape: freezed == grape
                ? _value.grape
                : grape // ignore: cast_nullable_to_non_nullable
                      as String?,
            vintage: freezed == vintage
                ? _value.vintage
                : vintage // ignore: cast_nullable_to_non_nullable
                      as int?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            labelImagePath: freezed == labelImagePath
                ? _value.labelImagePath
                : labelImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as ScanSource,
            found: null == found
                ? _value.found
                : found // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScannedWineDataImplCopyWith<$Res>
    implements $ScannedWineDataCopyWith<$Res> {
  factory _$$ScannedWineDataImplCopyWith(
    _$ScannedWineDataImpl value,
    $Res Function(_$ScannedWineDataImpl) then,
  ) = __$$ScannedWineDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? barcode,
    String? name,
    String? brand,
    String? country,
    String? grape,
    int? vintage,
    String? imageUrl,
    String? labelImagePath,
    ScanSource source,
    bool found,
  });
}

/// @nodoc
class __$$ScannedWineDataImplCopyWithImpl<$Res>
    extends _$ScannedWineDataCopyWithImpl<$Res, _$ScannedWineDataImpl>
    implements _$$ScannedWineDataImplCopyWith<$Res> {
  __$$ScannedWineDataImplCopyWithImpl(
    _$ScannedWineDataImpl _value,
    $Res Function(_$ScannedWineDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScannedWineData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? barcode = freezed,
    Object? name = freezed,
    Object? brand = freezed,
    Object? country = freezed,
    Object? grape = freezed,
    Object? vintage = freezed,
    Object? imageUrl = freezed,
    Object? labelImagePath = freezed,
    Object? source = null,
    Object? found = null,
  }) {
    return _then(
      _$ScannedWineDataImpl(
        barcode: freezed == barcode
            ? _value.barcode
            : barcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        grape: freezed == grape
            ? _value.grape
            : grape // ignore: cast_nullable_to_non_nullable
                  as String?,
        vintage: freezed == vintage
            ? _value.vintage
            : vintage // ignore: cast_nullable_to_non_nullable
                  as int?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        labelImagePath: freezed == labelImagePath
            ? _value.labelImagePath
            : labelImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as ScanSource,
        found: null == found
            ? _value.found
            : found // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ScannedWineDataImpl implements _ScannedWineData {
  const _$ScannedWineDataImpl({
    this.barcode,
    this.name,
    this.brand,
    this.country,
    this.grape,
    this.vintage,
    this.imageUrl,
    this.labelImagePath,
    this.source = ScanSource.manual,
    this.found = false,
  });

  @override
  final String? barcode;
  @override
  final String? name;
  @override
  final String? brand;
  @override
  final String? country;
  @override
  final String? grape;
  @override
  final int? vintage;
  @override
  final String? imageUrl;
  @override
  final String? labelImagePath;
  @override
  @JsonKey()
  final ScanSource source;
  @override
  @JsonKey()
  final bool found;

  @override
  String toString() {
    return 'ScannedWineData(barcode: $barcode, name: $name, brand: $brand, country: $country, grape: $grape, vintage: $vintage, imageUrl: $imageUrl, labelImagePath: $labelImagePath, source: $source, found: $found)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannedWineDataImpl &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.grape, grape) || other.grape == grape) &&
            (identical(other.vintage, vintage) || other.vintage == vintage) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.labelImagePath, labelImagePath) ||
                other.labelImagePath == labelImagePath) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.found, found) || other.found == found));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    barcode,
    name,
    brand,
    country,
    grape,
    vintage,
    imageUrl,
    labelImagePath,
    source,
    found,
  );

  /// Create a copy of ScannedWineData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannedWineDataImplCopyWith<_$ScannedWineDataImpl> get copyWith =>
      __$$ScannedWineDataImplCopyWithImpl<_$ScannedWineDataImpl>(
        this,
        _$identity,
      );
}

abstract class _ScannedWineData implements ScannedWineData {
  const factory _ScannedWineData({
    final String? barcode,
    final String? name,
    final String? brand,
    final String? country,
    final String? grape,
    final int? vintage,
    final String? imageUrl,
    final String? labelImagePath,
    final ScanSource source,
    final bool found,
  }) = _$ScannedWineDataImpl;

  @override
  String? get barcode;
  @override
  String? get name;
  @override
  String? get brand;
  @override
  String? get country;
  @override
  String? get grape;
  @override
  int? get vintage;
  @override
  String? get imageUrl;
  @override
  String? get labelImagePath;
  @override
  ScanSource get source;
  @override
  bool get found;

  /// Create a copy of ScannedWineData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannedWineDataImplCopyWith<_$ScannedWineDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

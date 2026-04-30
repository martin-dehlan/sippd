import 'package:freezed_annotation/freezed_annotation.dart';

part 'canonical_grape.entity.freezed.dart';

enum GrapeColor { red, white }

@freezed
class CanonicalGrapeEntity with _$CanonicalGrapeEntity {
  const factory CanonicalGrapeEntity({
    required String id,
    required String name,
    required GrapeColor color,
    @Default(<String>[]) List<String> aliases,
  }) = _CanonicalGrapeEntity;
}

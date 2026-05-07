import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/database/database.dart';
import '../../domain/entities/canonical_grape.entity.dart';

part 'canonical_grape.model.freezed.dart';
part 'canonical_grape.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class CanonicalGrapeModel with _$CanonicalGrapeModel {
  const factory CanonicalGrapeModel({
    required String id,
    required String name,
    required String color,
    @Default(<String>[]) List<String> aliases,
  }) = _CanonicalGrapeModel;

  factory CanonicalGrapeModel.fromJson(Map<String, dynamic> json) =>
      _$CanonicalGrapeModelFromJson(json);
}

extension CanonicalGrapeModelToEntity on CanonicalGrapeModel {
  CanonicalGrapeEntity toEntity() => CanonicalGrapeEntity(
    id: id,
    name: name,
    color: GrapeColor.values.firstWhere(
      (c) => c.name == color,
      orElse: () => GrapeColor.red,
    ),
    aliases: aliases,
  );

  CanonicalGrapeTableData toTableData() => CanonicalGrapeTableData(
    id: id,
    name: name,
    color: color,
    aliases: aliases,
  );
}

extension CanonicalGrapeTableDataToEntity on CanonicalGrapeTableData {
  CanonicalGrapeEntity toEntity() => CanonicalGrapeEntity(
    id: id,
    name: name,
    color: GrapeColor.values.firstWhere(
      (c) => c.name == color,
      orElse: () => GrapeColor.red,
    ),
    aliases: aliases,
  );
}

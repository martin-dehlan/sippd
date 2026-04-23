import 'package:drift/drift.dart' show Value;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/database/database.dart';
import '../../domain/entities/wine_alias.entity.dart';

part 'wine_alias.model.freezed.dart';
part 'wine_alias.model.g.dart';

@Freezed(fromJson: true, toJson: true)
class WineAliasModel with _$WineAliasModel {
  const factory WineAliasModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'local_wine_id') required String localWineId,
    @JsonKey(name: 'canonical_wine_id') required String canonicalWineId,
    @JsonKey(name: 'source') @Default('share_match') String source,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _WineAliasModel;

  factory WineAliasModel.fromJson(Map<String, dynamic> json) =>
      _$WineAliasModelFromJson(json);
}

extension WineAliasModelX on WineAliasModel {
  WineAliasEntity toEntity() => WineAliasEntity(
        userId: userId,
        localWineId: localWineId,
        canonicalWineId: canonicalWineId,
        source: WineAliasSourceX.fromWire(source),
        createdAt: createdAt,
      );
}

extension WineAliasEntityX on WineAliasEntity {
  WineAliasModel toModel() => WineAliasModel(
        userId: userId,
        localWineId: localWineId,
        canonicalWineId: canonicalWineId,
        source: source.wireValue,
        createdAt: createdAt,
      );

  WineAliasesTableCompanion toCompanion() => WineAliasesTableCompanion(
        userId: Value(userId),
        localWineId: Value(localWineId),
        canonicalWineId: Value(canonicalWineId),
        source: Value(source.wireValue),
        createdAt: Value(createdAt),
      );
}

extension WineAliasTableDataX on WineAliasTableData {
  WineAliasEntity toEntity() => WineAliasEntity(
        userId: userId,
        localWineId: localWineId,
        canonicalWineId: canonicalWineId,
        source: WineAliasSourceX.fromWire(source),
        createdAt: createdAt,
      );
}

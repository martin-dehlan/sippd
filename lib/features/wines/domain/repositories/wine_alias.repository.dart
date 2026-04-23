import '../entities/wine_alias.entity.dart';

abstract class WineAliasRepository {
  Future<String> resolveCanonical({
    required String userId,
    required String localWineId,
  });
  Future<void> link({
    required String userId,
    required String localWineId,
    required String canonicalWineId,
  });
  Future<WineAliasEntity?> getAlias({
    required String userId,
    required String localWineId,
  });
}

import '../../../../common/database/daos/wine_aliases.dao.dart';
import '../../domain/entities/wine_alias.entity.dart';
import '../../domain/repositories/wine_alias.repository.dart';
import '../data_sources/wine_alias_supabase.api.dart';
import '../models/wine_alias.model.dart';

class WineAliasRepositoryImpl implements WineAliasRepository {
  final WineAliasesDao _dao;
  final WineAliasSupabaseApi? _api;

  WineAliasRepositoryImpl(this._dao, [this._api]);

  @override
  Future<String> resolveCanonical({
    required String userId,
    required String localWineId,
  }) async {
    final row = await _dao.getAlias(userId: userId, localWineId: localWineId);
    return row?.canonicalWineId ?? localWineId;
  }

  @override
  Future<WineAliasEntity?> getAlias({
    required String userId,
    required String localWineId,
  }) async {
    final row = await _dao.getAlias(userId: userId, localWineId: localWineId);
    return row?.toEntity();
  }

  @override
  Future<void> link({
    required String userId,
    required String localWineId,
    required String canonicalWineId,
  }) async {
    if (localWineId == canonicalWineId) return;
    final entity = WineAliasEntity(
      userId: userId,
      localWineId: localWineId,
      canonicalWineId: canonicalWineId,
      createdAt: DateTime.now(),
    );
    await _dao.upsert(entity.toCompanion());
    try {
      await _api?.upsert(entity.toModel());
    } catch (_) {
      // Local link stands; remote retried next sync.
    }
  }
}

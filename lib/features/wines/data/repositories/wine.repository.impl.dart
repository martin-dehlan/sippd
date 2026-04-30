import '../../domain/entities/wine.entity.dart';
import '../../domain/repositories/wine.repository.dart';
import '../../../../common/database/daos/wines.dao.dart';
import '../../../../common/utils/name_normalizer.dart';
import '../data_sources/wine_supabase.api.dart';
import '../models/wine.mapper.dart';
import '../models/wine.model.dart';

class WineRepositoryImpl implements WineRepository {
  final WinesDao _dao;
  final WineSupabaseApi? _api;
  final String? _userId;

  WineRepositoryImpl(this._dao, [this._api, this._userId]);

  @override
  Future<List<WineEntity>> getWines() async {
    // Background sync from Supabase (fire and forget)
    _syncFromRemote();
    final localData = await _dao.getAllWines();
    return localData.map((td) => td.toEntity()).toList();
  }

  @override
  Future<WineEntity?> getWineById(String id) async {
    final data = await _dao.getWineById(id);
    return data?.toEntity();
  }

  @override
  Future<void> addWine(WineEntity wine) async {
    final normalized = _withNameNorm(wine);
    await _dao.insertWineUnsynced(normalized.toTableData());
    await _trySync(normalized);
  }

  @override
  Future<void> updateWine(WineEntity wine) async {
    final normalized = _withNameNorm(wine);
    await _dao.insertWineUnsynced(normalized.toTableData());
    await _trySync(normalized);
  }

  WineEntity _withNameNorm(WineEntity wine) =>
      wine.copyWith(nameNorm: normalizeName(wine.name));

  @override
  Future<void> deleteWine(String id) async {
    await _dao.deleteWine(id);
    try {
      await _api?.deleteWine(id);
    } catch (_) {
      // Silently fail — local delete stands
    }
  }

  @override
  Stream<List<WineEntity>> watchWines() {
    // Trigger sync, return local stream
    _syncFromRemote();
    return _dao.watchAllWines().map(
          (list) => list.map((td) => td.toEntity()).toList(),
        );
  }

  @override
  Future<List<WineEntity>> getWinesByType(WineType type) async {
    final data = await _dao.getWinesByType(type.name);
    return data.map((td) => td.toEntity()).toList();
  }

  @override
  Future<int> flushPendingSyncs() async {
    if (_api == null) return await _dao.countUnsynced();
    final pending = await _dao.getUnsynced();
    for (final row in pending) {
      try {
        await _api.upsertWine(row.toEntity().toModel());
        await _dao.markSynced(row.id);
      } catch (_) {
        // Stop on first failure — likely no network. Try again later.
        break;
      }
    }
    return await _dao.countUnsynced();
  }

  // ── Sync helpers ──────────────────────────────────────────

  Future<void> _trySync(WineEntity wine) async {
    if (_api == null) return;
    try {
      await _api.upsertWine(wine.toModel());
      await _dao.markSynced(wine.id);
    } catch (_) {
      // Local write stays unsynced; flushPendingSyncs() will retry.
    }
  }

  Future<void> _syncFromRemote() async {
    if (_api == null) return;
    final userId = _userId;
    if (userId == null || userId.isEmpty) return;
    try {
      final models = await _api.fetchWines(userId);
      final tableData = models.map((m) => m.toEntity().toTableData()).toList();
      for (final td in tableData) {
        await _dao.insertWine(td);
      }
    } catch (_) {
      // Network error — local data serves as fallback
    }
  }
}

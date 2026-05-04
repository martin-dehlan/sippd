import '../../../../common/database/daos/wine_memories.dao.dart';
import '../../../../common/services/analytics/analytics.service.dart';
import '../../domain/entities/wine_memory.entity.dart';
import '../../domain/repositories/wine_memory.repository.dart';
import '../data_sources/wine_memory_supabase.api.dart';
import '../models/wine_memory.model.dart';

class WineMemoryRepositoryImpl implements WineMemoryRepository {
  final WineMemoriesDao _dao;
  final WineMemorySupabaseApi? _api;
  final AnalyticsService? _analytics;

  WineMemoryRepositoryImpl(this._dao, [this._api, this._analytics]);

  @override
  Future<List<WineMemoryEntity>> getByWine(String wineId) async {
    _syncFromRemote(wineId);
    final rows = await _dao.getByWine(wineId);
    return rows.map((r) => r.toEntity()).toList();
  }

  @override
  Stream<List<WineMemoryEntity>> watchByWine(String wineId) {
    _syncFromRemote(wineId);
    return _dao
        .watchByWine(wineId)
        .map((rows) => rows.map((r) => r.toEntity()).toList());
  }

  @override
  Future<void> addMemory(WineMemoryEntity memory) async {
    await _dao.insertMemory(memory.toTableData());
    _syncToRemote(memory);
  }

  @override
  Future<void> deleteMemory(String id) async {
    await _dao.deleteMemory(id);
    try {
      await _api?.deleteMemory(id);
    } catch (e) {
      _analytics?.syncFailed('memory_delete', error: e);
    }
  }

  @override
  Future<void> deleteByWine(String wineId) async {
    await _dao.deleteByWine(wineId);
    try {
      await _api?.deleteByWine(wineId);
    } catch (e) {
      _analytics?.syncFailed('memory_delete_by_wine', error: e);
    }
  }

  Future<void> _syncToRemote(WineMemoryEntity memory) async {
    try {
      await _api?.upsertMemory(memory.toModel());
    } catch (e) {
      _analytics?.syncFailed('memory_upsert', error: e);
    }
  }

  Future<void> _syncFromRemote(String wineId) async {
    if (_api == null) return;
    try {
      final models = await _api.fetchByWine(wineId);
      for (final m in models) {
        await _dao.insertMemory(m.toEntity().toTableData());
      }
    } catch (e) {
      _analytics?.syncFailed('memory_fetch', error: e);
    }
  }
}

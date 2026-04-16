import '../../domain/entities/wine.entity.dart';
import '../../domain/repositories/wine.repository.dart';
import '../../../../common/database/daos/wines.dao.dart';
import '../data_sources/wine_supabase.api.dart';
import '../models/wine.mapper.dart';
import '../models/wine.model.dart';

class WineRepositoryImpl implements WineRepository {
  final WinesDao _dao;
  final WineSupabaseApi? _api;

  WineRepositoryImpl(this._dao, [this._api]);

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
    // Local first
    await _dao.insertWine(wine.toTableData());
    // Sync to remote
    _syncToRemote(wine);
  }

  @override
  Future<void> updateWine(WineEntity wine) async {
    await _dao.updateWine(wine.toTableData());
    _syncToRemote(wine);
  }

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

  // ── Sync helpers ──────────────────────────────────────────

  Future<void> _syncToRemote(WineEntity wine) async {
    try {
      await _api?.upsertWine(wine.toModel());
    } catch (_) {
      // Local write stands; will sync on next fetch
    }
  }

  Future<void> _syncFromRemote() async {
    if (_api == null) return;
    try {
      final models = await _api.fetchWines(
        // Get current user wines — userId comes from the API's RLS
        '', // RLS handles filtering by auth.uid()
      );
      final tableData = models.map((m) => m.toModel().toTableData()).toList();
      // Upsert doesn't exist on our DAO yet, so insert each
      for (final td in tableData) {
        await _dao.insertWine(td);
      }
    } catch (_) {
      // Network error — local data serves as fallback
    }
  }
}

extension _WineModelToTableData on WineModel {
  WineEntity toModel() => WineEntity(
        id: id,
        name: name,
        rating: rating,
        type: WineType.values.firstWhere(
          (t) => t.name == type,
          orElse: () => WineType.red,
        ),
        price: price,
        currency: currency,
        country: country,
        location: location,
        notes: notes,
        imageUrl: imageUrl,
        localImagePath: localImagePath,
        vintage: vintage,
        grape: grape,
        userId: userId,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

import '../../../../common/database/daos/wine_memory_photos.dao.dart';
import '../../../../common/services/analytics/analytics.service.dart';
import '../../domain/entities/wine_memory_photo.entity.dart';
import '../../domain/repositories/wine_memory_photo.repository.dart';
import '../data_sources/wine_memory_photo_supabase.api.dart';
import '../models/wine_memory_photo.model.dart';

class WineMemoryPhotoRepositoryImpl implements WineMemoryPhotoRepository {
  final WineMemoryPhotosDao _dao;
  final WineMemoryPhotoSupabaseApi? _api;
  final AnalyticsService? _analytics;

  WineMemoryPhotoRepositoryImpl(this._dao, [this._api, this._analytics]);

  @override
  Future<List<WineMemoryPhotoEntity>> getByMemory(String memoryId) async {
    _syncFromRemote(memoryId);
    final rows = await _dao.getByMemory(memoryId);
    return rows.map((r) => r.toEntity()).toList();
  }

  @override
  Stream<List<WineMemoryPhotoEntity>> watchByMemory(String memoryId) {
    _syncFromRemote(memoryId);
    return _dao
        .watchByMemory(memoryId)
        .map((rows) => rows.map((r) => r.toEntity()).toList());
  }

  @override
  Future<void> addPhoto(WineMemoryPhotoEntity photo) async {
    await _dao.insertPhoto(photo.toTableData());
    try {
      await _api?.upsertPhoto(photo.toModel());
    } catch (e) {
      _analytics?.syncFailed('memory_photo_upsert', error: e);
    }
  }

  @override
  Future<void> addPhotos(List<WineMemoryPhotoEntity> photos) async {
    if (photos.isEmpty) return;
    await _dao.insertPhotos(photos.map((p) => p.toTableData()).toList());
    try {
      await _api?.upsertPhotos(photos.map((p) => p.toModel()).toList());
    } catch (e) {
      _analytics?.syncFailed('memory_photos_upsert', error: e);
    }
  }

  @override
  Future<void> deletePhoto(String id) async {
    await _dao.deletePhoto(id);
    try {
      await _api?.deletePhoto(id);
    } catch (e) {
      _analytics?.syncFailed('memory_photo_delete', error: e);
    }
  }

  @override
  Future<void> deleteByMemory(String memoryId) async {
    await _dao.deleteByMemory(memoryId);
    try {
      await _api?.deleteByMemory(memoryId);
    } catch (e) {
      _analytics?.syncFailed('memory_photos_delete_by_memory', error: e);
    }
  }

  @override
  Future<void> reorder(String memoryId, List<String> photoIdsInOrder) async {
    await _dao.reorder(memoryId, photoIdsInOrder);
    if (_api == null) return;
    final positions = <String, int>{
      for (var i = 0; i < photoIdsInOrder.length; i++) photoIdsInOrder[i]: i,
    };
    try {
      await _api.updatePositions(positions);
    } catch (e) {
      _analytics?.syncFailed('memory_photos_reorder', error: e);
    }
  }

  Future<void> _syncFromRemote(String memoryId) async {
    if (_api == null) return;
    try {
      final models = await _api.fetchByMemory(memoryId);
      if (models.isEmpty) return;
      await _dao.insertPhotos(
        models.map((m) => m.toEntity().toTableData()).toList(),
      );
    } catch (e) {
      _analytics?.syncFailed('memory_photo_fetch', error: e);
    }
  }
}

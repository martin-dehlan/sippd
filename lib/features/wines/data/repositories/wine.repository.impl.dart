import '../../domain/entities/wine.entity.dart';
import '../../domain/repositories/wine.repository.dart';
import '../../../../common/database/daos/pending_image_uploads.dao.dart';
import '../../../../common/database/daos/wines.dao.dart';
import '../../../../common/services/analytics/analytics.service.dart';
import '../../../../common/utils/name_normalizer.dart';
import '../data_sources/wine_image.service.dart';
import '../data_sources/wine_supabase.api.dart';
import '../models/wine.mapper.dart';
import '../models/wine.model.dart';

class WineRepositoryImpl implements WineRepository {
  final WinesDao _dao;
  final WineSupabaseApi? _api;
  final WineImageService? _imageService;
  final String? _userId;
  final AnalyticsService? _analytics;
  final PendingImageUploadsDao? _outbox;

  WineRepositoryImpl({
    required WinesDao dao,
    WineSupabaseApi? api,
    String? userId,
    WineImageService? imageService,
    AnalyticsService? analytics,
    PendingImageUploadsDao? outbox,
  })  : _dao = dao,
        _api = api,
        _userId = userId,
        _imageService = imageService,
        _analytics = analytics,
        _outbox = outbox;

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
    await _dao.insertWine(normalized.toTableData());
    _syncToRemote(normalized);
  }

  @override
  Future<void> updateWine(WineEntity wine) async {
    final normalized = _withNameNorm(wine);
    await _dao.updateWine(normalized.toTableData());
    _syncToRemote(normalized);
  }

  WineEntity _withNameNorm(WineEntity wine) =>
      wine.copyWith(nameNorm: normalizeName(wine.name));

  @override
  Future<void> deleteWine(String id) async {
    await _dao.deleteWine(id);
    try {
      await _api?.deleteWine(id);
    } catch (e) {
      _analytics?.syncFailed('wine_delete', error: e);
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
    if (_api == null) return;
    try {
      // Upload-retry: a previous save left only a local file (e.g. the
      // photo picker fired the upload offline, or the upload threw). Try
      // again now so other group members eventually see the photo.
      // Idempotent — runs on every save until imageUrl is populated.
      WineEntity toSync = wine;
      if (_imageService != null &&
          _userId != null &&
          (wine.imageUrl == null || wine.imageUrl!.isEmpty) &&
          (wine.localImagePath != null && wine.localImagePath!.isNotEmpty)) {
        try {
          final url = await _imageService.uploadImage(
            userId: _userId,
            filePath: wine.localImagePath!,
          );
          toSync = wine.copyWith(imageUrl: url);
          // Persist the new URL locally too so the watch stream emits it
          // immediately and a later sync-from-remote doesn't blow it away.
          await _dao.updateWine(_withNameNorm(toSync).toTableData());
          // Upload succeeded — drop any outbox entry from a previous fail.
          await _outbox?.remove(wine.id);
        } catch (e) {
          // Upload still failing — enqueue for the OutboxFlusher to
          // retry later. Local rendering keeps using the file.
          _analytics?.syncFailed('wine_image_upload', error: e);
          await _outbox?.enqueue(wine.id, wine.localImagePath!);
        }
      }
      await _api.upsertWine(toSync.toModel());

      // Refetch so server-resolved fields (canonical_wine_id, name_norm)
      // land in Drift immediately. Without this, freshly-added wines
      // miss canonical_wine_id until the next full sync — which breaks
      // the group-wines lookup (`localByCanonical`) and causes the
      // group carousel to render the placeholder instead of the photo.
      // Preserve `localImagePath`: the remote model never carries it
      // (includeToJson: false) but local rendering still wants the file.
      final fresh = await _api.fetchWineById(toSync.id);
      if (fresh != null) {
        final merged = fresh
            .toEntity()
            .copyWith(localImagePath: toSync.localImagePath);
        await _dao.updateWine(_withNameNorm(merged).toTableData());
      }
    } catch (e) {
      // Local write stands; will sync on next fetch
      _analytics?.syncFailed('wine_upsert', error: e);
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
    } catch (e) {
      // Network error — local data serves as fallback
      _analytics?.syncFailed('wine_fetch', error: e);
    }
  }
}


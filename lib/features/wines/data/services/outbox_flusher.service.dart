import '../../../../common/database/daos/pending_image_uploads.dao.dart';
import '../../../../common/database/daos/wines.dao.dart';
import '../../../../common/database/database.dart';
import '../../../../common/services/analytics/analytics.service.dart';
import '../data_sources/wine_image.service.dart';
import '../data_sources/wine_supabase.api.dart';
import '../models/wine.mapper.dart';
import '../models/wine.model.dart';

/// Drains [PendingImageUploadsDao] by retrying each due image upload
/// and propagating the resolved URL into both the wines Drift row and
/// the Supabase row. Idempotent — safe to call repeatedly. Triggered
/// at app launch and on every connectivity flip to online.
///
/// Each item is bounded by [PendingImageUploadsDao.maxAttempts] with
/// exponential backoff so a permanently broken file (deleted by the
/// user, OS cleanup, missing permissions) doesn't loop forever.
class OutboxFlusher {
  final PendingImageUploadsDao _outbox;
  final WinesDao _winesDao;
  final WineImageService? _imageService;
  final WineSupabaseApi? _api;
  final String? _userId;
  final AnalyticsService? _analytics;

  bool _running = false;

  OutboxFlusher({
    required PendingImageUploadsDao outbox,
    required WinesDao winesDao,
    required WineImageService? imageService,
    required WineSupabaseApi? api,
    required String? userId,
    required AnalyticsService? analytics,
  })  : _outbox = outbox,
        _winesDao = winesDao,
        _imageService = imageService,
        _api = api,
        _userId = userId,
        _analytics = analytics;

  Future<void> flush() async {
    if (_running) return; // Single-flight to avoid double-uploads.
    if (_imageService == null || _api == null || _userId == null) return;
    _running = true;
    try {
      final due = await _outbox.due(DateTime.now());
      for (final item in due) {
        await _uploadOne(item);
      }
    } finally {
      _running = false;
    }
  }

  Future<void> _uploadOne(PendingImageUploadData item) async {
    try {
      final url = await _imageService!.uploadImage(
        userId: _userId!,
        filePath: item.localPath,
      );
      // Update local Drift row with the new URL.
      final row = await _winesDao.getWineById(item.wineId);
      if (row != null) {
        final updated = row.toEntity().copyWith(imageUrl: url).toTableData();
        await _winesDao.updateWine(updated);
        // Mirror to Supabase so other devices see the photo.
        await _api!.upsertWine(row.toEntity().copyWith(imageUrl: url).toModel());
      }
      await _outbox.remove(item.wineId);
    } catch (e) {
      _analytics?.syncFailed('outbox_image_upload', error: e);
      await _outbox.recordFailure(item.wineId);
    }
  }
}

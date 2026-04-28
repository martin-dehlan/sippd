import '../../../../common/database/daos/notification_prefs.dao.dart';
import '../../domain/entities/notification_prefs.entity.dart';
import '../../domain/repositories/notification_prefs.repository.dart';
import '../data_sources/notification_prefs.api.dart';
import '../models/notification_prefs.model.dart';

class NotificationPrefsRepositoryImpl implements NotificationPrefsRepository {
  final NotificationPrefsDao _dao;
  final NotificationPrefsApi? _api;

  NotificationPrefsRepositoryImpl(this._dao, [this._api]);

  @override
  Stream<NotificationPrefsEntity> watchPrefs(String userId) {
    _syncFromRemote(userId);
    return _dao.watchByUser(userId).map(
      (row) => row?.toEntity() ?? NotificationPrefsEntity.defaults(userId),
    );
  }

  @override
  Future<NotificationPrefsEntity> getPrefs(String userId) async {
    await _syncFromRemote(userId);
    final row = await _dao.getByUser(userId);
    return row?.toEntity() ?? NotificationPrefsEntity.defaults(userId);
  }

  @override
  Future<void> updatePrefs(NotificationPrefsEntity prefs) async {
    final stamped = prefs.copyWith(updatedAt: DateTime.now());
    await _dao.upsert(stamped.toTableData());
    if (_api == null) return;
    try {
      final saved = await _api.upsert(stamped.toModel());
      // Round-trip: replace local row with server-confirmed updated_at so
      // future syncs don't appear newer than they really are.
      await _dao.upsert(saved.toEntity().toTableData());
    } catch (_) {
      // Network failure — local change stands; next watchPrefs() refresh
      // will reconcile when remote is reachable again.
    }
  }

  Future<void> _syncFromRemote(String userId) async {
    if (_api == null) return;
    try {
      final model = await _api.fetch(userId);
      if (model != null) {
        await _dao.upsert(model.toEntity().toTableData());
      }
    } catch (_) {
      // Offline-first: defaults() is returned by the stream until the row
      // syncs in.
    }
  }
}

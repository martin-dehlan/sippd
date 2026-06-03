import 'dart:convert';

import '../../../../common/database/daos/badge_progress_cache.dao.dart';
import '../../domain/entities/badge.entity.dart';
import '../../domain/repositories/badges.repository.dart';
import '../data_sources/badges.api.dart';
import '../models/badge.model.dart';

class BadgesRepositoryImpl implements BadgesRepository {
  BadgesRepositoryImpl({required this.api, required this.cacheDao});

  final BadgesApi api;
  final BadgeProgressCacheDao cacheDao;

  @override
  Future<List<BadgeEntity>> getProgress(String userId) async {
    try {
      final models = await api.getProgress(userId);
      // Cache the raw rows so the grid renders offline next time.
      await cacheDao.upsert(
        userId,
        jsonEncode(models.map((m) => m.toJson()).toList()),
        DateTime.now(),
      );
      return models.map((m) => m.toEntity()).toList(growable: false);
    } catch (_) {
      final cached = await cacheDao.getByUser(userId);
      if (cached != null) {
        final list = jsonDecode(cached.payload) as List<dynamic>;
        return list
            .map((e) => BadgeModel.fromJson(Map<String, dynamic>.from(e as Map))
                .toEntity())
            .toList(growable: false);
      }
      rethrow;
    }
  }

  @override
  Future<List<BadgeEntity>> getEarned(String userId) async {
    final models = await api.getProgress(userId);
    return models
        .where((m) => m.earned || m.earnedAt != null)
        .map((m) => m.toEntity(forceEarned: true))
        .toList(growable: false);
  }

  @override
  Future<List<BadgeEntity>> getUnseen() async {
    final models = await api.getUnseen();
    return models
        .map((m) => m.toEntity(forceEarned: true))
        .toList(growable: false);
  }

  @override
  Future<void> markSeen(List<String> badgeIds) => api.markSeen(badgeIds);

  @override
  Future<List<String>> evaluate() => api.evaluateMine();
}

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../friends/data/models/friend_profile.model.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../models/tasting.model.dart';

class TastingAttendeeRow {
  final String tastingId;
  final String userId;
  final String status;
  final FriendProfileModel? profile;

  TastingAttendeeRow({
    required this.tastingId,
    required this.userId,
    required this.status,
    this.profile,
  });
}

class TastingsApi {
  final SupabaseClient _client;
  TastingsApi(this._client);

  String get _uid => _client.auth.currentUser!.id;

  Future<List<TastingModel>> fetchForGroup(String groupId) async {
    final rows = (await _client
        .from('group_tastings')
        .select()
        .eq('group_id', groupId)
        .order('scheduled_at', ascending: true)) as List;
    return rows
        .map((r) => TastingModel.fromJson(r as Map<String, dynamic>))
        .toList();
  }

  Future<TastingModel?> fetchById(String id) async {
    final row = await _client
        .from('group_tastings')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (row == null) return null;
    return TastingModel.fromJson(row);
  }

  Future<TastingModel> create({
    required String groupId,
    required String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    required DateTime scheduledAt,
    String lineupMode = 'planned',
  }) async {
    final inserted = await _client
        .from('group_tastings')
        .insert({
          'group_id': groupId,
          'title': title,
          'description': description,
          'location': location,
          'latitude': latitude,
          'longitude': longitude,
          'scheduled_at': scheduledAt.toUtc().toIso8601String(),
          'created_by': _uid,
          'lineup_mode': lineupMode,
        })
        .select()
        .single();
    return TastingModel.fromJson(inserted);
  }

  /// Adds personal [wineIds] (wines.id) to a tasting flight. Resolves
  /// each one's canonical_wine_id and stores the catalog identity, so
  /// the flight survives the original sharer deleting their personal
  /// log row.
  Future<void> addWines(String tastingId, List<String> wineIds) async {
    if (wineIds.isEmpty) return;
    final winesRows = (await _client
        .from('wines')
        .select('id, canonical_wine_id')
        .inFilter('id', wineIds)) as List;
    final canonicalById = <String, String>{
      for (final r in winesRows)
        if ((r as Map<String, dynamic>)['canonical_wine_id'] != null)
          r['id'] as String: r['canonical_wine_id'] as String,
    };
    final rows = <Map<String, dynamic>>[];
    for (var i = 0; i < wineIds.length; i++) {
      final cid = canonicalById[wineIds[i]];
      if (cid == null) continue;
      rows.add({
        'tasting_id': tastingId,
        'canonical_wine_id': cid,
        'position': i,
      });
    }
    if (rows.isEmpty) return;
    await _client.from('tasting_wines').insert(rows);
  }

  /// Returns the bottles in [tastingId] in flight order. Entities are
  /// catalog-keyed: `id` is the canonical_wine.id. Image URLs are
  /// hydrated from the original sharer's `wines` row (RLS policy
  /// `wines_select_shared` lets group members read these by
  /// canonical_wine_id) so other attendees see the photo too.
  Future<List<WineEntity>> fetchWines(String tastingId) async {
    final joinRows = (await _client
        .from('tasting_wines')
        .select('canonical_wine_id, position')
        .eq('tasting_id', tastingId)
        .order('position', ascending: true)) as List;
    if (joinRows.isEmpty) return const [];
    final canonicalIds = joinRows
        .map((j) => (j as Map<String, dynamic>)['canonical_wine_id'] as String)
        .toList();
    final canonicalRows = (await _client
        .from('canonical_wine')
        .select('id, name, winery, region, country, type, vintage')
        .inFilter('id', canonicalIds)) as List;
    final wineRows = (await _client
        .from('wines')
        .select('canonical_wine_id, image_url, updated_at')
        .inFilter('canonical_wine_id', canonicalIds)
        .not('image_url', 'is', null)) as List;
    final imageUrlByCanonical = <String, String>{};
    for (final r in wineRows) {
      final m = r as Map<String, dynamic>;
      final cid = m['canonical_wine_id'] as String;
      final url = m['image_url'] as String?;
      if (url == null || url.isEmpty) continue;
      imageUrlByCanonical.putIfAbsent(cid, () => url);
    }
    final now = DateTime.now();
    final byId = <String, WineEntity>{};
    for (final raw in canonicalRows) {
      final r = raw as Map<String, dynamic>;
      final id = r['id'] as String;
      byId[id] = _canonicalToEntity(r, now, imageUrlByCanonical[id]);
    }
    return canonicalIds
        .map((id) => byId[id])
        .whereType<WineEntity>()
        .toList();
  }

  static WineEntity _canonicalToEntity(
      Map<String, dynamic> r, DateTime now, String? imageUrl) {
    final id = r['id'] as String;
    final rawType = r['type'] as String?;
    final type = WineType.values
            .where((t) => t.name == rawType)
            .firstOrNull ??
        WineType.red;
    return WineEntity(
      id: id,
      name: (r['name'] as String?) ?? 'Unknown',
      rating: 0,
      type: type,
      country: r['country'] as String?,
      region: r['region'] as String?,
      winery: r['winery'] as String?,
      vintage: r['vintage'] as int?,
      imageUrl: imageUrl,
      canonicalWineId: id,
      userId: '',
      createdAt: now,
    );
  }

  Future<List<TastingAttendeeRow>> fetchAttendees(String tastingId) async {
    final rows = (await _client
        .from('tasting_attendees')
        .select('tasting_id, user_id, status')
        .eq('tasting_id', tastingId)) as List;
    if (rows.isEmpty) return const [];
    final userIds = rows
        .map((r) => (r as Map<String, dynamic>)['user_id'] as String)
        .toList();
    final profiles = (await _client
        .from('profiles')
        .select()
        .inFilter('id', userIds)) as List;
    final byId = {
      for (final p in profiles)
        (p as Map<String, dynamic>)['id'] as String:
            FriendProfileModel.fromJson(p),
    };
    return rows.map((r) {
      final row = r as Map<String, dynamic>;
      return TastingAttendeeRow(
        tastingId: row['tasting_id'] as String,
        userId: row['user_id'] as String,
        status: row['status'] as String,
        profile: byId[row['user_id']],
      );
    }).toList();
  }

  Future<void> setMyRsvp({
    required String tastingId,
    required String status,
  }) async {
    await _client.from('tasting_attendees').upsert({
      'tasting_id': tastingId,
      'user_id': _uid,
      'status': status,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  Future<void> removeWine(String tastingId, String canonicalWineId) async {
    await _client
        .from('tasting_wines')
        .delete()
        .eq('tasting_id', tastingId)
        .eq('canonical_wine_id', canonicalWineId);
  }

  Future<void> deleteTasting(String id) async {
    await _client.from('group_tastings').delete().eq('id', id);
  }

  /// Host-driven transition `upcoming → active`. Stamps `started_at` so
  /// the recap card and listings can sort by real start time, not by
  /// scheduledAt (which is just the planned moment).
  Future<TastingModel> startTasting(String id) async {
    final updated = await _client
        .from('group_tastings')
        .update({
          'state': 'active',
          'started_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', id)
        .select()
        .single();
    return TastingModel.fromJson(updated);
  }

  /// Host-driven transition `active → concluded`. Stamps `ended_at` so
  /// rating-edit windows and recap surfaces have a reference point.
  Future<TastingModel> endTasting(String id) async {
    final updated = await _client
        .from('group_tastings')
        .update({
          'state': 'concluded',
          'ended_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', id)
        .select()
        .single();
    return TastingModel.fromJson(updated);
  }

  Future<TastingModel> setLineupMode(String id, String lineupMode) async {
    final updated = await _client
        .from('group_tastings')
        .update({'lineup_mode': lineupMode})
        .eq('id', id)
        .select()
        .single();
    return TastingModel.fromJson(updated);
  }

  Future<TastingModel> update({
    required String id,
    required String title,
    String? description,
    String? location,
    double? latitude,
    double? longitude,
    required DateTime scheduledAt,
  }) async {
    final updated = await _client
        .from('group_tastings')
        .update({
          'title': title,
          'description': description,
          'location': location,
          'latitude': latitude,
          'longitude': longitude,
          'scheduled_at': scheduledAt.toUtc().toIso8601String(),
        })
        .eq('id', id)
        .select()
        .single();
    return TastingModel.fromJson(updated);
  }

  /// Upsert the caller's rating for a wine in this tasting. Writes to
  /// `tasting_ratings` keyed (tasting_id, canonical_wine_id, user_id).
  /// RLS enforces caller identity + group membership for SELECT.
  Future<void> upsertMyTastingRating({
    required String tastingId,
    required String canonicalWineId,
    required double rating,
    String? notes,
  }) async {
    await _client.from('tasting_ratings').upsert(
      {
        'tasting_id': tastingId,
        'canonical_wine_id': canonicalWineId,
        'user_id': _uid,
        'rating': rating,
        'notes': notes,
      },
      onConflict: 'tasting_id,canonical_wine_id,user_id',
    );
  }

  Future<double?> fetchMyTastingRating({
    required String tastingId,
    required String canonicalWineId,
  }) async {
    final row = await _client
        .from('tasting_ratings')
        .select('rating')
        .eq('tasting_id', tastingId)
        .eq('canonical_wine_id', canonicalWineId)
        .eq('user_id', _uid)
        .maybeSingle();
    if (row == null) return null;
    return (row['rating'] as num?)?.toDouble();
  }

  /// Returns avg rating per canonical wine for this tasting, computed
  /// across all attendees who submitted a rating.
  Future<Map<String, double>> fetchTastingAverages(String tastingId) async {
    final rows = (await _client
        .from('tasting_ratings')
        .select('canonical_wine_id, rating')
        .eq('tasting_id', tastingId)) as List;
    final perCanonical = <String, List<double>>{};
    for (final r in rows) {
      final m = r as Map<String, dynamic>;
      final cid = m['canonical_wine_id'] as String;
      final rating = (m['rating'] as num).toDouble();
      perCanonical.putIfAbsent(cid, () => []).add(rating);
    }
    return {
      for (final e in perCanonical.entries)
        if (e.value.isNotEmpty)
          e.key: e.value.reduce((a, b) => a + b) / e.value.length,
    };
  }
}

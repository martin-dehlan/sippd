import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../friends/data/models/friend_profile.model.dart';
import '../../../wines/data/models/wine.model.dart';
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
        })
        .select()
        .single();
    return TastingModel.fromJson(inserted);
  }

  Future<void> addWines(String tastingId, List<String> wineIds) async {
    if (wineIds.isEmpty) return;
    final rows = [
      for (var i = 0; i < wineIds.length; i++)
        {
          'tasting_id': tastingId,
          'wine_id': wineIds[i],
          'position': i,
        },
    ];
    await _client.from('tasting_wines').insert(rows);
  }

  Future<List<WineModel>> fetchWines(String tastingId) async {
    final joinRows = (await _client
        .from('tasting_wines')
        .select('wine_id, position')
        .eq('tasting_id', tastingId)
        .order('position', ascending: true)) as List;
    if (joinRows.isEmpty) return const [];
    final wineIds = joinRows
        .map((j) => (j as Map<String, dynamic>)['wine_id'] as String)
        .toList();
    final wineRows = (await _client
        .from('wines')
        .select()
        .inFilter('id', wineIds)) as List;
    final byId = {
      for (final r in wineRows)
        (r as Map<String, dynamic>)['id'] as String:
            WineModel.fromJson(r),
    };
    return wineIds
        .map((id) => byId[id])
        .whereType<WineModel>()
        .toList();
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

  Future<void> deleteTasting(String id) async {
    await _client.from('group_tastings').delete().eq('id', id);
  }
}

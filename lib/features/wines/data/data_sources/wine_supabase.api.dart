import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wine.model.dart';

class WineSupabaseApi {
  final SupabaseClient _client;

  WineSupabaseApi(this._client);

  Future<List<WineModel>> fetchWines(String userId) async {
    final data = await _client
        .from('wines')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (data as List).map((row) => WineModel.fromJson(row)).toList();
  }

  Future<void> upsertWine(WineModel wine) async {
    await _client.from('wines').upsert(wine.toJson());
  }

  /// Reads back a single wine after upsert. Used by the repo to capture
  /// fields populated by server-side triggers (canonical_wine_id,
  /// name_norm) that wouldn't otherwise reach the local Drift row until
  /// the next full refetch.
  Future<WineModel?> fetchWineById(String id) async {
    final row = await _client
        .from('wines')
        .select()
        .eq('id', id)
        .maybeSingle();
    if (row == null) return null;
    return WineModel.fromJson(row);
  }

  Future<void> deleteWine(String id) async {
    await _client.from('wines').delete().eq('id', id);
  }
}

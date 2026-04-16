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

  Future<void> deleteWine(String id) async {
    await _client.from('wines').delete().eq('id', id);
  }
}

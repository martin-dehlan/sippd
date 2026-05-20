import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wine_memory.model.dart';

class WineMemorySupabaseApi {
  final SupabaseClient _client;

  WineMemorySupabaseApi(this._client);

  Future<List<WineMemoryModel>> fetchByWine(String wineId) async {
    final data = await _client
        .from('wine_memories')
        .select()
        .eq('wine_id', wineId)
        .order('created_at', ascending: true);

    return (data as List).map((row) => WineMemoryModel.fromJson(row)).toList();
  }

  Future<void> upsertMemory(WineMemoryModel memory) async {
    await _client.from('wine_memories').upsert(memory.toJson());
  }

  Future<void> deleteMemory(String id) async {
    await _client.from('wine_memories').delete().eq('id', id);
  }

  Future<void> deleteByWine(String wineId) async {
    await _client.from('wine_memories').delete().eq('wine_id', wineId);
  }

  /// Moments where the caller and the other user are both involved
  /// (one owns, the other is tagged). Returns most-recent first.
  /// Backed by the `get_shared_moments` RPC so the friendship-aware
  /// filter stays on the server.
  Future<List<WineMemoryModel>> fetchShared(String otherUserId) async {
    final data = await _client.rpc<List<dynamic>>(
      'get_shared_moments',
      params: {'p_other_user_id': otherUserId},
    );
    return data.map((row) => WineMemoryModel.fromJson(row)).toList();
  }
}

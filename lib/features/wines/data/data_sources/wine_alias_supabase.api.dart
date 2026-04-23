import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/wine_alias.model.dart';

class WineAliasSupabaseApi {
  final SupabaseClient _client;

  WineAliasSupabaseApi(this._client);

  Future<List<WineAliasModel>> fetchForUser(String userId) async {
    final data = await _client
        .from('wine_aliases')
        .select()
        .eq('user_id', userId);
    return (data as List)
        .map((row) => WineAliasModel.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  Future<void> upsert(WineAliasModel alias) async {
    await _client.from('wine_aliases').upsert(alias.toJson());
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../wines/data/models/wine.model.dart';

class FriendWinesApi {
  final SupabaseClient _client;
  FriendWinesApi(this._client);

  Future<List<WineModel>> fetchFriendWines(String friendId,
      {int limit = 50}) async {
    final rows = await _client
        .from('wines')
        .select()
        .eq('user_id', friendId)
        .order('created_at', ascending: false)
        .limit(limit);
    return (rows as List)
        .map((r) => WineModel.fromJson(r as Map<String, dynamic>))
        .toList();
  }
}

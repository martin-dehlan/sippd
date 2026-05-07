import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/friend_profile.model.dart';
import '../../../wines/data/models/wine.model.dart';

class ActivityItemRaw {
  final WineModel wine;
  final FriendProfileModel friend;
  ActivityItemRaw({required this.wine, required this.friend});
}

class ActivityApi {
  final SupabaseClient _client;
  ActivityApi(this._client);

  String get _uid => _client.auth.currentUser!.id;

  Future<List<ActivityItemRaw>> fetchRecent({int limit = 50}) async {
    final friendships =
        (await _client
                .from('friendships')
                .select('friend_id')
                .eq('user_id', _uid))
            as List;
    if (friendships.isEmpty) return const [];

    final friendIds = friendships
        .map((f) => (f as Map<String, dynamic>)['friend_id'] as String)
        .toList();

    final wineRows =
        (await _client
                .from('wines')
                .select()
                .inFilter('user_id', friendIds)
                .order('created_at', ascending: false)
                .limit(limit))
            as List;

    if (wineRows.isEmpty) return const [];

    final profileRows =
        (await _client.from('profiles').select().inFilter('id', friendIds))
            as List;
    final profilesMap = {
      for (final p in profileRows)
        (p as Map<String, dynamic>)['id'] as String:
            FriendProfileModel.fromJson(p),
    };

    return wineRows.map((r) {
      final wine = WineModel.fromJson(r as Map<String, dynamic>);
      final friend =
          profilesMap[wine.userId] ?? FriendProfileModel(id: wine.userId);
      return ActivityItemRaw(wine: wine, friend: friend);
    }).toList();
  }
}

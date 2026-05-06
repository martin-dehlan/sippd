import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/friend_rating.model.dart';

class FriendRatingsApi {
  FriendRatingsApi(this._client);

  final SupabaseClient _client;

  /// Returns the caller's friends who have rated the given canonical wine.
  /// Source = solo `wines.rating` only (group/tasting ratings stay private
  /// to their respective members). RLS-enforced via SECURITY INVOKER.
  Future<List<FriendRatingModel>> getForCanonicalWine(
    String canonicalWineId, {
    int limit = 10,
  }) async {
    final raw = await _client.rpc(
      'get_friend_ratings_for_canonical_wine',
      params: {
        'p_canonical_wine_id': canonicalWineId,
        'p_limit': limit,
      },
    );
    if (raw is! List) return const [];
    return raw
        .map((row) =>
            FriendRatingModel.fromJson(Map<String, dynamic>.from(row as Map)))
        .toList(growable: false);
  }
}

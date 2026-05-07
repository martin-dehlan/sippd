import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/canonical_merge_pair.entity.dart';
import '../../domain/entities/canonical_wine_candidate.entity.dart';

class CanonicalWineApi {
  final SupabaseClient _client;

  CanonicalWineApi(this._client);

  /// Returns the Tier 1 exact match (one row, isExact=true) when one
  /// exists; otherwise up to 3 Tier 2 fuzzy candidates the user has
  /// not already declined.
  Future<List<CanonicalWineCandidate>> suggestMatch({
    required String name,
    String? winery,
    int? vintage,
  }) async {
    final data = await _client.rpc(
      'suggest_canonical_match',
      params: {'p_name': name, 'p_winery': winery, 'p_vintage': vintage},
    );
    if (data == null) return const [];
    return (data as List)
        .map(
          (row) => CanonicalWineCandidate(
            id: row['candidate_id'] as String,
            name: row['name'] as String,
            winery: row['winery'] as String?,
            vintage: row['vintage'] as int?,
            similarity: (row['similarity'] as num).toDouble(),
            isExact: row['is_exact'] as bool,
          ),
        )
        .toList();
  }

  /// Records the user's "linked" or "different" decision so we never
  /// re-prompt for the same input pair.
  Future<void> recordDecision({
    required String inputName,
    String? inputWinery,
    int? inputVintage,
    required String candidateId,
    required bool linked,
  }) async {
    await _client.rpc(
      'record_canonical_match_decision',
      params: {
        'p_input_name': inputName,
        'p_input_winery': inputWinery,
        'p_input_vintage': inputVintage,
        'p_candidate_id': candidateId,
        'p_decision': linked ? 'linked' : 'different',
      },
    );
  }

  /// Server-side resolve: returns the existing canonical id for the
  /// (name, winery, vintage) triple if one exists, otherwise inserts a
  /// new canonical_wine row and returns its id. Used by the new-wine flow
  /// when expert tasting dimensions need to be persisted before the
  /// fire-and-forget background sync has populated `wines.canonical_wine_id`.
  /// Returns null if the name is shorter than 3 chars (server-side guard).
  Future<String?> resolve({
    required String name,
    String? winery,
    int? vintage,
    String? type,
    String? country,
    String? region,
    String? canonicalGrapeId,
    required String userId,
  }) async {
    final id = await _client.rpc(
      'resolve_canonical_wine',
      params: {
        'p_name': name,
        'p_winery': winery,
        'p_vintage': vintage,
        'p_type': type,
        'p_country': country,
        'p_region': region,
        'p_canonical_grape_id': canonicalGrapeId,
        'p_user_id': userId,
      },
    );
    return id as String?;
  }

  /// Pairs of canonicals the caller participates in that look similar
  /// enough to potentially merge. Used by the manual cleanup screen.
  Future<List<CanonicalMergePair>> findMergeCandidates({
    double minSimilarity = 0.6,
    int limit = 50,
  }) async {
    final data = await _client.rpc(
      'find_canonical_merge_candidates',
      params: {'p_min_similarity': minSimilarity, 'p_limit': limit},
    );
    if (data == null) return const [];
    return (data as List)
        .map(
          (row) => CanonicalMergePair(
            loserId: row['loser_id'] as String,
            winnerId: row['winner_id'] as String,
            loserName: row['loser_name'] as String,
            winnerName: row['winner_name'] as String,
            loserWinery: row['loser_winery'] as String?,
            winnerWinery: row['winner_winery'] as String?,
            loserVintage: row['loser_vintage'] as int?,
            winnerVintage: row['winner_vintage'] as int?,
            similarity: (row['similarity'] as num).toDouble(),
          ),
        )
        .toList();
  }

  /// Collapses two canonicals into one. The winner stays; every wines
  /// row pointing at the loser gets repointed at the winner; the
  /// loser canonical is deleted.
  Future<void> mergeCanonicals({
    required String loserId,
    required String winnerId,
  }) async {
    await _client.rpc(
      'merge_canonical_wines',
      params: {'p_loser_id': loserId, 'p_winner_id': winnerId},
    );
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

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
      params: {
        'p_name': name,
        'p_winery': winery,
        'p_vintage': vintage,
      },
    );
    if (data == null) return const [];
    return (data as List)
        .map((row) => CanonicalWineCandidate(
              id: row['candidate_id'] as String,
              name: row['name'] as String,
              winery: row['winery'] as String?,
              vintage: row['vintage'] as int?,
              similarity: (row['similarity'] as num).toDouble(),
              isExact: row['is_exact'] as bool,
            ))
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
}

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/badge.model.dart';

/// Thin Supabase data source over the badge RPCs. No business logic.
class BadgesApi {
  BadgesApi(this._client);

  final SupabaseClient _client;

  List<BadgeModel> _parseList(dynamic raw) {
    if (raw is! List) return const [];
    return raw
        .map((row) => BadgeModel.fromJson(Map<String, dynamic>.from(row as Map)))
        .toList(growable: false);
  }

  /// Every active badge with this user's progress. For a friend's id the RPC
  /// returns earned-only rows (RLS), which is exactly what the showcase wants.
  Future<List<BadgeModel>> getProgress(String userId) async {
    final raw = await _client.rpc<dynamic>(
      'get_user_badge_progress',
      params: {'p_user_id': userId},
    );
    return _parseList(raw);
  }

  /// Badges earned but not yet shown to the caller (drives the celebration).
  Future<List<BadgeModel>> getUnseen() async {
    final raw = await _client.rpc<dynamic>('get_unseen_badges');
    return _parseList(raw);
  }

  /// Marks the given badges seen so they stop surfacing in the celebration.
  Future<void> markSeen(List<String> badgeIds) async {
    if (badgeIds.isEmpty) return;
    await _client.rpc<dynamic>(
      'mark_badges_seen',
      params: {'p_ids': badgeIds},
    );
  }

  /// Manual re-evaluation (server recomputes from authoritative data). Returns
  /// the ids awarded this call. The rating-write trigger usually beats this,
  /// but it's a safety net for refresh / pull-to-refresh.
  Future<List<String>> evaluateMine() async {
    final raw = await _client.rpc<dynamic>('evaluate_my_badges');
    if (raw is! List) return const [];
    return raw.map((e) => e.toString()).toList(growable: false);
  }
}

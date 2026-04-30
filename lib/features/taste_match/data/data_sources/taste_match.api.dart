import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_grape_share.entity.dart';
import '../../domain/entities/user_style_dna.entity.dart';
import '../models/shared_bottle.model.dart';
import '../models/taste_compass.model.dart';
import '../models/taste_match.model.dart';

class TasteMatchApi {
  TasteMatchApi(this._client);

  final SupabaseClient _client;

  Future<TasteCompassModel> getCompass(String userId) async {
    final raw = await _client.rpc(
      'get_taste_compass',
      params: {'p_user_id': userId},
    );
    if (raw is! Map) {
      return const TasteCompassModel(totalCount: 0);
    }
    return TasteCompassModel.fromJson(Map<String, dynamic>.from(raw));
  }

  Future<List<UserGrapeShare>> getTopGrapes(String userId, {int limit = 7}) async {
    final raw = await _client.rpc(
      'get_user_top_grapes',
      params: {'p_user_id': userId, 'p_limit': limit},
    );
    if (raw is! List) return const [];
    return raw.map((row) {
      final m = Map<String, dynamic>.from(row as Map);
      return UserGrapeShare(
        canonicalGrapeId: m['canonical_grape_id'] as String,
        grapeName: m['grape_name'] as String,
        grapeColor: m['grape_color'] as String,
        count: m['count'] as int,
        avgRating: (m['avg_rating'] as num).toDouble(),
      );
    }).toList(growable: false);
  }

  Future<UserStyleDna> getStyleDna(String userId) async {
    final raw = await _client.rpc(
      'get_user_style_dna',
      params: {'p_user_id': userId},
    );
    if (raw is! Map) {
      return const UserStyleDna(
        values: {},
        attributedCount: 0,
        confidence: 0,
      );
    }
    final m = Map<String, dynamic>.from(raw);
    final values = <String, double>{};
    for (final k in const ['body', 'tannin', 'acidity', 'sweetness', 'oak', 'intensity']) {
      final v = m[k];
      if (v is num) values[k] = v.toDouble();
    }
    return UserStyleDna(
      values: values,
      attributedCount: (m['attributed_count'] as num?)?.toInt() ?? 0,
      confidence: (m['confidence'] as num?)?.toDouble() ?? 0,
    );
  }

  Future<List<SharedBottleModel>> getSharedBottles(String otherUserId) async {
    final raw = await _client.rpc(
      'get_shared_bottles',
      params: {'p_other_user_id': otherUserId},
    );
    if (raw is! List) return const [];
    return raw
        .map((row) =>
            SharedBottleModel.fromJson(Map<String, dynamic>.from(row as Map)))
        .toList(growable: false);
  }

  Future<TasteMatchModel> getMatch(String otherUserId) async {
    final raw = await _client.rpc(
      'get_taste_match',
      params: {'p_other_user_id': otherUserId},
    );
    if (raw is! Map) {
      return const TasteMatchModel();
    }
    return TasteMatchModel.fromJson(Map<String, dynamic>.from(raw));
  }
}

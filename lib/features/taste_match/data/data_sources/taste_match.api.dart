import 'package:supabase_flutter/supabase_flutter.dart';

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

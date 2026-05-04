import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/expert_tasting.entity.dart';

class ExpertTastingApi {
  ExpertTastingApi(this._client);

  final SupabaseClient _client;

  Future<ExpertTastingEntity?> getMine({
    required String canonicalWineId,
    String context = 'personal',
    String? groupId,
    String? tastingId,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final query = _client
        .from('wine_ratings_extended')
        .select()
        .eq('user_id', user.id)
        .eq('canonical_wine_id', canonicalWineId)
        .eq('context', context);
    final rows = await query.limit(1);
    if (rows.isEmpty) return null;
    final m = rows.first;
    if (groupId != null && m['group_id'] != groupId) return null;
    if (tastingId != null && m['tasting_id'] != tastingId) return null;
    return ExpertTastingEntity(
      id: m['id'] as String?,
      body: m['body'] as int?,
      tannin: m['tannin'] as int?,
      acidity: m['acidity'] as int?,
      sweetness: m['sweetness'] as int?,
      oak: m['oak'] as int?,
      finish: m['finish'] as int?,
      aromaTags:
          ((m['aroma_tags'] as List?)?.cast<String>() ?? const <String>[]),
    );
  }

  Future<void> upsert({
    required String canonicalWineId,
    required ExpertTastingEntity tasting,
    String context = 'personal',
    String? groupId,
    String? tastingId,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw StateError('not authenticated');
    }
    if (tasting.isEmpty) {
      // Empty submit removes any prior entry.
      await _client
          .from('wine_ratings_extended')
          .delete()
          .eq('user_id', user.id)
          .eq('canonical_wine_id', canonicalWineId)
          .eq('context', context);
      return;
    }
    final payload = <String, dynamic>{
      'user_id': user.id,
      'canonical_wine_id': canonicalWineId,
      'context': context,
      'group_id': groupId,
      'tasting_id': tastingId,
      'body': tasting.body,
      'tannin': tasting.tannin,
      'acidity': tasting.acidity,
      'sweetness': tasting.sweetness,
      'oak': tasting.oak,
      'finish': tasting.finish,
      'aroma_tags': tasting.aromaTags,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
    await _client
        .from('wine_ratings_extended')
        .upsert(
          payload,
          onConflict: 'user_id,canonical_wine_id,context',
        );
  }
}

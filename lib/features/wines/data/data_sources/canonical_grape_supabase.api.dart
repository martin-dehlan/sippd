import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/canonical_grape.model.dart';

class CanonicalGrapeSupabaseApi {
  final SupabaseClient _client;

  CanonicalGrapeSupabaseApi(this._client);

  Future<List<CanonicalGrapeModel>> fetchAll() async {
    final data = await _client
        .from('canonical_grape')
        .select('id, name, color, aliases')
        .order('name');

    return (data as List)
        .map((row) => CanonicalGrapeModel.fromJson(row as Map<String, dynamic>))
        .toList();
  }
}

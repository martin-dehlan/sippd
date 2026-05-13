import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/wine_memory_photo.model.dart';

class WineMemoryPhotoSupabaseApi {
  final SupabaseClient _client;

  WineMemoryPhotoSupabaseApi(this._client);

  Future<List<WineMemoryPhotoModel>> fetchByMemory(String memoryId) async {
    final data = await _client
        .from('wine_memory_photos')
        .select()
        .eq('memory_id', memoryId)
        .order('position', ascending: true);

    return (data as List)
        .map((row) => WineMemoryPhotoModel.fromJson(row))
        .toList();
  }

  Future<void> upsertPhoto(WineMemoryPhotoModel photo) async {
    await _client.from('wine_memory_photos').upsert(photo.toJson());
  }

  Future<void> upsertPhotos(List<WineMemoryPhotoModel> photos) async {
    if (photos.isEmpty) return;
    await _client
        .from('wine_memory_photos')
        .upsert(photos.map((p) => p.toJson()).toList());
  }

  Future<void> deletePhoto(String id) async {
    await _client.from('wine_memory_photos').delete().eq('id', id);
  }

  Future<void> deleteByMemory(String memoryId) async {
    await _client.from('wine_memory_photos').delete().eq('memory_id', memoryId);
  }

  /// Updates `position` for the listed ids in one round-trip per row.
  /// The trigger on insert is bypassed for plain updates so reorders
  /// are safe.
  Future<void> updatePositions(Map<String, int> idToPosition) async {
    for (final entry in idToPosition.entries) {
      await _client
          .from('wine_memory_photos')
          .update({'position': entry.value})
          .eq('id', entry.key);
    }
  }
}

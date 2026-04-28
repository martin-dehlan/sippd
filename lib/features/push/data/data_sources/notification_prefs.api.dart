import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/notification_prefs.model.dart';

class NotificationPrefsApi {
  final SupabaseClient _client;
  NotificationPrefsApi(this._client);

  Future<NotificationPrefsModel?> fetch(String userId) async {
    final row = await _client
        .from('user_notification_prefs')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (row == null) return null;
    return NotificationPrefsModel.fromJson(row);
  }

  Future<NotificationPrefsModel> upsert(NotificationPrefsModel model) async {
    final payload = model.toJson()..remove('updated_at');
    final row = await _client
        .from('user_notification_prefs')
        .upsert(payload, onConflict: 'user_id')
        .select()
        .single();
    return NotificationPrefsModel.fromJson(row);
  }
}

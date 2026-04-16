import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile.model.dart';

class ProfileApi {
  final SupabaseClient _client;
  ProfileApi(this._client);

  String get _uid => _client.auth.currentUser!.id;

  Future<ProfileModel?> fetchMyProfile() async {
    final row = await _client
        .from('profiles')
        .select()
        .eq('id', _uid)
        .maybeSingle();
    if (row == null) return null;
    return ProfileModel.fromJson(row);
  }

  Stream<ProfileModel?> watchMyProfile() {
    return _client
        .from('profiles')
        .stream(primaryKey: ['id'])
        .eq('id', _uid)
        .map((rows) {
      if (rows.isEmpty) return null;
      return ProfileModel.fromJson(rows.first);
    });
  }

  Future<bool> isUsernameAvailable(String username) async {
    final row = await _client
        .from('profiles')
        .select('id')
        .eq('username', username.toLowerCase())
        .maybeSingle();
    return row == null;
  }

  Future<void> updateUsername(String username) async {
    await _client
        .from('profiles')
        .update({'username': username.toLowerCase()})
        .eq('id', _uid);
  }
}

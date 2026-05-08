import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../onboarding/domain/onboarding_answers.dart';
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

  Future<void> updateDisplayName(String? displayName) async {
    await _client
        .from('profiles')
        .update({'display_name': displayName})
        .eq('id', _uid);
  }

  Future<void> updateAvatarUrl(String? avatarUrl) async {
    await _client
        .from('profiles')
        .update({'avatar_url': avatarUrl})
        .eq('id', _uid);
  }

  Future<void> markOnboardingCompleted() async {
    await _client
        .from('profiles')
        .update({'onboarding_completed': true})
        .eq('id', _uid);
  }

  /// Single atomic UPDATE writing every field that comes out of the
  /// pre-auth onboarding funnel. Avoids the multi-write flicker where the
  /// router would briefly redirect to /onboarding between calls.
  Future<void> seedProfileFromOnboarding({
    required String username,
    String? displayName,
    required OnboardingAnswers answers,
  }) async {
    await _client
        .from('profiles')
        .update({
          'username': username.toLowerCase(),
          'display_name': displayName,
          'onboarding_completed': true,
          'taste_level': answers.tasteLevel?.name,
          'goals': answers.goals.map((g) => g.name).toList(),
          'styles': answers.styles.map((s) => s.name).toList(),
          'drink_frequency': answers.frequency?.name,
          'taste_emoji': answers.emoji,
        })
        .eq('id', _uid);
  }

  /// Used by edit-profile when the user adjusts taste fields after signup.
  Future<void> updateTasteProfile(OnboardingAnswers answers) async {
    await _client
        .from('profiles')
        .update({
          'taste_level': answers.tasteLevel?.name,
          'goals': answers.goals.map((g) => g.name).toList(),
          'styles': answers.styles.map((s) => s.name).toList(),
          'drink_frequency': answers.frequency?.name,
          'taste_emoji': answers.emoji,
        })
        .eq('id', _uid);
  }

  Future<void> deleteMyAccount() async {
    // Storage wipe must complete before the auth row goes — once auth.users
    // is gone the user no longer has an RLS path to delete their own files.
    try {
      await _wipeUserStorage();
    } catch (e) {
      // One retry, then surface so the user can try again. Better to leave
      // a non-deleted account than orphan files on the public bucket.
      await _wipeUserStorage();
    }
    await _client.rpc('delete_my_account');
  }

  Future<void> _wipeUserStorage() async {
    await _removeFolder('wine-images', _uid);
    await _removeFolder('avatars', _uid);

    final ownedGroups = await _client
        .from('groups')
        .select('id, group_members(user_id)')
        .eq('created_by', _uid);

    final soloGroupIds = (ownedGroups as List)
        .where((g) {
          final members = (g['group_members'] as List);
          return members.every((m) => m['user_id'] == _uid);
        })
        .map((g) => g['id'] as String)
        .toList();

    for (final groupId in soloGroupIds) {
      await _removeFolder('group-images', groupId);
    }
  }

  Future<void> _removeFolder(String bucket, String folder) async {
    const pageSize = 100;
    var offset = 0;
    final paths = <String>[];

    while (true) {
      final files = await _client.storage
          .from(bucket)
          .list(
            path: folder,
            searchOptions: SearchOptions(limit: pageSize, offset: offset),
          );
      if (files.isEmpty) break;
      paths.addAll(files.map((f) => '$folder/${f.name}'));
      if (files.length < pageSize) break;
      offset += pageSize;
    }

    if (paths.isNotEmpty) {
      await _client.storage.from(bucket).remove(paths);
    }
  }
}

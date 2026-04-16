import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FcmService {
  final SupabaseClient _client;
  FcmService(this._client);

  FirebaseMessaging get _messaging => FirebaseMessaging.instance;

  Future<NotificationSettings> requestPermission() async {
    return _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  Future<String?> _currentToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      debugPrint('FCM getToken failed: $e');
      return null;
    }
  }

  String get _platform {
    if (kIsWeb) return 'web';
    if (Platform.isIOS) return 'ios';
    if (Platform.isAndroid) return 'android';
    return 'web';
  }

  /// Register the current device's FCM token for the logged-in user.
  /// Safe to call repeatedly; upserts on (user_id, token).
  Future<void> register() async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final settings = await requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.denied) return;

    final token = await _currentToken();
    if (token == null) return;

    await _client.from('user_devices').upsert({
      'user_id': user.id,
      'token': token,
      'platform': _platform,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }

  /// Listen for token refreshes and update the row.
  Stream<String> onTokenRefresh() => _messaging.onTokenRefresh;

  Future<void> unregisterCurrentDevice() async {
    final user = _client.auth.currentUser;
    if (user == null) return;
    final token = await _currentToken();
    if (token == null) return;
    await _client
        .from('user_devices')
        .delete()
        .eq('user_id', user.id)
        .eq('token', token);
  }
}

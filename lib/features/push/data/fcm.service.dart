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
  /// Token is globally unique — if another account previously claimed it on
  /// this device, ownership transfers to the current user.
  ///
  /// We do NOT gate this on notification permission. On Android the token
  /// is valid regardless; if the user later grants permission, deliveries
  /// just start displaying. On iOS getToken returns null without
  /// permission, so this no-ops gracefully.
  Future<void> register() async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    final token = await _currentToken();
    if (token == null) return;

    await _client.rpc(
      'register_user_device',
      params: {'p_token': token, 'p_platform': _platform},
    );
  }

  /// Listen for token refreshes and update the row.
  Stream<String> onTokenRefresh() => _messaging.onTokenRefresh;

  Future<void> unregisterCurrentDevice() async {
    final user = _client.auth.currentUser;
    final token = await _currentToken();
    if (user != null && token != null) {
      await _client
          .from('user_devices')
          .delete()
          .eq('user_id', user.id)
          .eq('token', token);
    }
    // Nuke the client-side FCM token cache so the next sign-in gets a
    // fresh one. Without this, a stale token from an earlier Firebase
    // project (or another account) keeps being reused and FCM delivery
    // fails silently.
    try {
      await _messaging.deleteToken();
    } catch (e) {
      debugPrint('FCM deleteToken failed: $e');
    }
  }
}

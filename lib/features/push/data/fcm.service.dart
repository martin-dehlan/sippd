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
      // On iOS we need APNS to attach a device-token before FCM will
      // mint a registration token — without it `getToken()` returns
      // null silently. The plugin exposes `getAPNSToken()`; awaiting
      // it here gives the system a moment to complete the APNS
      // handshake on first launch right after permission grant.
      if (!kIsWeb && Platform.isIOS) {
        try {
          final apns = await _messaging.getAPNSToken();
          if (apns == null) {
            debugPrint(
              'FCM: APNS token still null after wait — '
              'iOS APNS pairing not yet ready (permission denied? '
              'aps-environment mismatch? bad APNs key in Firebase?)',
            );
          } else {
            debugPrint('FCM: APNS token present (len=${apns.length})');
          }
        } catch (e) {
          debugPrint('FCM getAPNSToken failed: $e');
        }
      }
      final token = await _messaging.getToken();
      if (token == null) {
        debugPrint(
          'FCM: getToken() returned null on $_platform — no push delivery '
          'possible until a token is registered.',
        );
      } else {
        debugPrint(
          'FCM: got token on $_platform (len=${token.length}, '
          'preview=${token.substring(0, token.length < 16 ? token.length : 16)})',
        );
      }
      return token;
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
  ///
  /// On iOS the call is allowed to retry once: the APNS handshake can
  /// take a beat right after permission grant on first launch, and the
  /// initial getToken() returns null. Without the retry the user has
  /// to background+foreground the app for the next onTokenRefresh
  /// callback to wake the registration.
  Future<void> register() async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    var token = await _currentToken();
    if (token == null && !kIsWeb && Platform.isIOS) {
      debugPrint('FCM: iOS first attempt returned null, retrying in 2s…');
      await Future.delayed(const Duration(seconds: 2));
      token = await _currentToken();
    }
    if (token == null) return;

    try {
      await _client.rpc(
        'register_user_device',
        params: {'p_token': token, 'p_platform': _platform},
      );
      debugPrint('FCM: registered $_platform token with server');
    } catch (e) {
      debugPrint('FCM: register_user_device RPC failed: $e');
    }
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

import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Background isolate entry point. Must be top-level.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('BG push: ${message.messageId} data=${message.data}');
}

class PushHandlerService {
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  final StreamController<RemoteMessage> _tapStream =
      StreamController<RemoteMessage>.broadcast();

  /// Emits whenever the user taps a notification (foreground banner or system).
  Stream<RemoteMessage> get onTap => _tapStream.stream;

  StreamSubscription<RemoteMessage>? _foregroundSub;
  StreamSubscription<RemoteMessage>? _openedSub;

  Future<void> init() async {
    const androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _local.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: (resp) {
        if (resp.payload == null) return;
        try {
          final data =
              (jsonDecode(resp.payload!) as Map).cast<String, dynamic>();
          _tapStream.add(_fakeRemoteMessage(data));
        } catch (_) {}
      },
    );

    // Android 13+ notification permission is part of FCM requestPermission.
    // Ensure channel exists so banner works.
    const channel = AndroidNotificationChannel(
      'sippd_default',
      'Sippd notifications',
      importance: Importance.high,
    );
    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    _foregroundSub =
        FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    _openedSub = FirebaseMessaging.onMessageOpenedApp.listen(_tapStream.add);

    // Cold-start: opened from terminated.
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) _tapStream.add(initial);
  }

  void _onForegroundMessage(RemoteMessage msg) {
    final n = msg.notification;
    final title = n?.title ?? 'Sippd';
    final body = n?.body ?? '';
    _local.show(
      msg.hashCode,
      title,
      body,
      NotificationDetails(
        android: const AndroidNotificationDetails(
          'sippd_default',
          'Sippd notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: jsonEncode(msg.data),
    );
  }

  RemoteMessage _fakeRemoteMessage(Map<String, dynamic> data) {
    return RemoteMessage(data: data.map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> dispose() async {
    await _foregroundSub?.cancel();
    await _openedSub?.cancel();
    await _tapStream.close();
  }
}

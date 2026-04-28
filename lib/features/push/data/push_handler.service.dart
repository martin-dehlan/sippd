import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

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
    // Required for zonedSchedule — registers the IANA timezone database so
    // we can convert wall-clock DateTimes into TZDateTime values that the
    // OS scheduler honours across DST transitions.
    tz_data.initializeTimeZones();

    const androidInit =
        AndroidInitializationSettings('ic_notification');
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

    // FCM requestPermission grants the *system* notification permission but
    // flutter_local_notifications tracks its own internal grant flag — so we
    // re-request via the plugin to cover the local zonedSchedule path.
    final androidPlugin = _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.requestNotificationsPermission();

    const channel = AndroidNotificationChannel(
      'sippd_default',
      'Sippd notifications',
      importance: Importance.high,
    );
    await androidPlugin?.createNotificationChannel(channel);

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
          icon: 'ic_notification',
          color: Color(0xFF6B3A51),
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: jsonEncode(msg.data),
    );
  }

  RemoteMessage _fakeRemoteMessage(Map<String, dynamic> data) {
    return RemoteMessage(data: data.map((k, v) => MapEntry(k, v.toString())));
  }

  /// Schedules a local notification at [reminderAt] for the given tasting.
  /// Caller decides offset (driven by `user_notification_prefs.tasting_reminder_hours`).
  /// No-op if [reminderAt] is in the past. Reuses the deterministic int derived
  /// from the tasting id so re-scheduling on edit/pref-change replaces cleanly.
  Future<void> scheduleTastingReminder({
    required String tastingId,
    required String tastingTitle,
    required DateTime reminderAt,
    required int offsetHours,
  }) async {
    final now = DateTime.now();
    debugPrint(
      'scheduleTastingReminder: id=$tastingId now=$now reminderAt=$reminderAt offsetHours=$offsetHours',
    );
    if (!reminderAt.isAfter(now)) {
      debugPrint('scheduleTastingReminder: skip — reminderAt is in the past');
      return;
    }

    final id = _idForTastingReminder(tastingId);
    final tzTime = tz.TZDateTime.from(reminderAt, tz.local);
    debugPrint(
      'scheduleTastingReminder: tz.local=${tz.local} tzTime=$tzTime id=$id',
    );
    // offsetHours == 0 is the debug "Send test reminder" path — surface a
    // plain "Tasting reminder" title so the notification doesn't read
    // "Tasting in 0 hours".
    final notificationTitle = offsetHours <= 0
        ? 'Tasting reminder'
        : 'Tasting in ${offsetHours == 1 ? '1 hour' : '$offsetHours hours'}';

    final androidPlugin = _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    final notifEnabled = await androidPlugin?.areNotificationsEnabled();
    final canScheduleExact =
        await androidPlugin?.canScheduleExactNotifications();
    debugPrint(
      'scheduleTastingReminder: areNotificationsEnabled=$notifEnabled canScheduleExactNotifications=$canScheduleExact',
    );

    try {
      await _local.zonedSchedule(
        id,
        notificationTitle,
        tastingTitle,
        tzTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'sippd_default',
            'Sippd notifications',
            importance: Importance.high,
            priority: Priority.high,
            icon: 'ic_notification',
            color: Color(0xFF6B3A51),
          ),
          iOS: DarwinNotificationDetails(),
        ),
        // alarmClock uses AlarmManager.setAlarmClock under the hood:
        // bypasses Doze, fires on the dot, and crucially does NOT need
        // SCHEDULE_EXACT_ALARM / USE_EXACT_ALARM grants. Side effect is the
        // device's "next alarm" indicator may show in the status bar — that
        // is acceptable for time-bound tasting reminders and avoids the
        // permission-flow tax on every Android version.
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: jsonEncode({
          'type': 'tasting_reminder',
          'tasting_id': tastingId,
        }),
      );
      final pending = await _local.pendingNotificationRequests();
      debugPrint(
        'scheduleTastingReminder: scheduled OK. pending=${pending.map((p) => '${p.id}:${p.title}').join(', ')}',
      );
    } catch (e, st) {
      debugPrint('scheduleTastingReminder: FAILED — $e\n$st');
      rethrow;
    }
  }

  Future<void> cancelTastingReminder(String tastingId) async {
    await _local.cancel(_idForTastingReminder(tastingId));
  }

  /// Maps a tasting UUID to a stable 31-bit int that fits the plugin's
  /// notification id contract on every platform.
  int _idForTastingReminder(String tastingId) =>
      tastingId.hashCode & 0x7FFFFFFF;

  Future<void> dispose() async {
    await _foregroundSub?.cancel();
    await _openedSub?.cancel();
    await _tapStream.close();
  }
}

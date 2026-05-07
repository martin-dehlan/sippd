import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../../wines/controller/wine.provider.dart' show appDatabaseProvider;
import '../data/data_sources/notification_prefs.api.dart';
import '../data/fcm.service.dart';
import '../data/push_handler.service.dart';
import '../data/repositories/notification_prefs.repository.impl.dart';
import '../domain/entities/notification_prefs.entity.dart';
import '../domain/repositories/notification_prefs.repository.dart';

part 'push.provider.g.dart';

@Riverpod(keepAlive: true)
FcmService fcmService(FcmServiceRef ref) {
  final client = ref.read(supabaseClientProvider);
  return FcmService(client);
}

/// Kicks off FCM token registration whenever we have an authenticated user.
/// Keep-alive so it runs for the lifetime of the app.
@Riverpod(keepAlive: true)
Future<void> pushRegistration(PushRegistrationRef ref) async {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return;

  final fcm = ref.watch(fcmServiceProvider);
  await fcm.register();

  final sub = fcm.onTokenRefresh().listen((_) => fcm.register());
  ref.onDispose(sub.cancel);
}

@Riverpod(keepAlive: true)
PushHandlerService pushHandler(PushHandlerRef ref) {
  final handler = PushHandlerService();
  ref.onDispose(handler.dispose);
  return handler;
}

@Riverpod(keepAlive: true)
Stream<RemoteMessage> pushTaps(PushTapsRef ref) {
  final handler = ref.watch(pushHandlerProvider);
  return handler.onTap;
}

@riverpod
NotificationPrefsApi? notificationPrefsApi(NotificationPrefsApiRef ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);
  if (!isAuth) return null;
  return NotificationPrefsApi(ref.read(supabaseClientProvider));
}

@riverpod
NotificationPrefsRepository notificationPrefsRepository(
  NotificationPrefsRepositoryRef ref,
) {
  final db = ref.read(appDatabaseProvider);
  final api = ref.watch(notificationPrefsApiProvider);
  return NotificationPrefsRepositoryImpl(db.notificationPrefsDao, api);
}

/// Streams the authenticated user's notification preferences. Emits a defaults
/// entity until the first server sync completes so the UI never has to render
/// a loading state for what is effectively config data.
@riverpod
class NotificationPrefsController extends _$NotificationPrefsController {
  @override
  Stream<NotificationPrefsEntity> build() {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return Stream.value(NotificationPrefsEntity.defaults(''));
    }
    return ref.watch(notificationPrefsRepositoryProvider).watchPrefs(userId);
  }

  Future<void> _update(
    NotificationPrefsEntity Function(NotificationPrefsEntity) mutate,
  ) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) return;
    final current =
        state.valueOrNull ?? NotificationPrefsEntity.defaults(userId);
    final next = mutate(current);
    await ref.read(notificationPrefsRepositoryProvider).updatePrefs(next);
  }

  Future<void> setTastingReminders(bool value) =>
      _update((p) => p.copyWith(tastingReminders: value));

  Future<void> setTastingReminderHours(int value) =>
      _update((p) => p.copyWith(tastingReminderHours: value));

  Future<void> setFriendActivity(bool value) =>
      _update((p) => p.copyWith(friendActivity: value));

  Future<void> setGroupActivity(bool value) =>
      _update((p) => p.copyWith(groupActivity: value));

  Future<void> setGroupWineShared(bool value) =>
      _update((p) => p.copyWith(groupWineShared: value));
}

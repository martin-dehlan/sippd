import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/controller/auth.provider.dart';
import '../data/fcm.service.dart';

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

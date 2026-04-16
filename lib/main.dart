import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/theme/app_theme.dart';
import 'core/routes/app.routes.dart';
import 'core/routes/route_config.dart';
import 'features/push/controller/push.provider.dart';
import 'features/push/data/push_handler.service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const ProviderScope(child: SippdApp()));
}

class SippdApp extends ConsumerStatefulWidget {
  const SippdApp({super.key});

  @override
  ConsumerState<SippdApp> createState() => _SippdAppState();
}

class _SippdAppState extends ConsumerState<SippdApp> {
  @override
  void initState() {
    super.initState();
    // Initialise the local-notification plugin + FCM listeners once.
    ref.read(pushHandlerProvider).init();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    // Kick off FCM registration lifecycle.
    ref.watch(pushRegistrationProvider);

    // Route the app when a push is tapped.
    ref.listen<AsyncValue<RemoteMessage>>(
      pushTapsProvider,
      (_, next) {
        final msg = next.valueOrNull;
        if (msg == null) return;
        final route = _routeForPush(msg);
        if (route != null) router.push(route);
      },
    );

    return MaterialApp.router(
      title: 'Sippd',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

String? _routeForPush(RemoteMessage msg) {
  final data = msg.data;
  switch (data['type']) {
    case 'friend_request':
      return AppRoutes.friends;
    case 'tasting_created':
      final id = data['tasting_id'];
      if (id is String && id.isNotEmpty) {
        return AppRoutes.tastingDetailPath(id);
      }
      return null;
    case 'group_joined':
      final id = data['group_id'];
      if (id is String && id.isNotEmpty) {
        return AppRoutes.groupDetailPath(id);
      }
      return null;
  }
  return null;
}

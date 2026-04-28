import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/services/analytics/analytics.provider.dart';
import 'common/services/analytics/analytics.service.dart';
import 'common/services/deep_link/deep_link.provider.dart';
import 'features/paywall/controller/paywall.provider.dart';
import 'features/paywall/data/services/paywall.service.dart';
import 'common/services/deep_link/deep_link.service.dart';
import 'common/services/secure_pkce_storage.dart';
import 'common/theme/app_theme.dart';
import 'core/routes/app.routes.dart';
import 'core/routes/route_config.dart';
import 'features/auth/controller/auth.provider.dart';
import 'features/friends/controller/friends.provider.dart';
import 'features/groups/controller/group.provider.dart';
import 'features/groups/controller/group_invitation.provider.dart';
import 'features/onboarding/controller/onboarding.provider.dart';
import 'features/profile/controller/profile.provider.dart';
import 'features/profile/domain/entities/profile.entity.dart';
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
    authOptions: FlutterAuthClientOptions(
      // Persist the PKCE code verifier in Keystore/Keychain so Google
      // sign-in survives Android killing the app process while the
      // Custom Tab is foregrounded.
      pkceAsyncStorage: SecurePkceStorage(),
    ),
  );

  final prefs = await SharedPreferences.getInstance();

  final analytics = AnalyticsService();
  await analytics.init(
    apiKey: dotenv.env['POSTHOG_API_KEY'] ?? '',
    host: dotenv.env['POSTHOG_HOST'] ?? 'https://eu.i.posthog.com',
  );

  final paywall = PaywallService();
  final rcUnified = dotenv.env['REVENUECAT_API_KEY'] ?? '';
  await paywall.init(
    iosApiKey: dotenv.env['REVENUECAT_API_KEY_IOS'] ?? rcUnified,
    androidApiKey: dotenv.env['REVENUECAT_API_KEY_ANDROID'] ?? rcUnified,
  );

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        analyticsProvider.overrideWithValue(analytics),
        paywallProvider.overrideWithValue(paywall),
      ],
      child: const SippdApp(),
    ),
  );
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
    ref.read(deepLinkProvider).init();

    // ref.listen below only fires on auth state *changes*, so a user who
    // was already signed in before the app restarted would never get
    // identified to PostHog or RevenueCat. Catch that case here.
    final bootUser = ref.read(authControllerProvider).valueOrNull;
    if (bootUser != null) {
      ref.read(analyticsProvider).identify(
        bootUser.id,
        userProperties: {
          if (bootUser.email != null) 'email': bootUser.email!,
        },
      );
      ref.read(paywallProvider).identify(bootUser.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    // Kick off FCM registration lifecycle.
    ref.watch(pushRegistrationProvider);

    // Identify PostHog + RevenueCat when auth flips, reset on sign-out.
    ref.listen<AsyncValue<User?>>(authControllerProvider, (prev, next) {
      final prevUser = prev?.valueOrNull;
      final nextUser = next.valueOrNull;
      final analytics = ref.read(analyticsProvider);
      final paywall = ref.read(paywallProvider);
      if (prevUser?.id == nextUser?.id) return;
      if (nextUser != null) {
        analytics.identify(
          nextUser.id,
          userProperties: {
            if (nextUser.email != null) 'email': nextUser.email!,
          },
        );
        paywall.identify(nextUser.id);
      } else if (prevUser != null) {
        analytics.reset();
        paywall.logout();
      }
    });

    // Route the app when a push is tapped.
    ref.listen<AsyncValue<RemoteMessage>>(
      pushTapsProvider,
      (_, next) {
        final msg = next.valueOrNull;
        if (msg == null) return;
        // Invalidate the caches that feed whichever screen we're about to
        // land on — the underlying providers are one-shot Futures, so
        // without this the destination screen shows stale data until
        // manual refresh / app restart.
        _invalidateForPush(ref, msg);
        final route = _routeForPush(msg);
        if (route == null) return;
        if (_isShellTab(route)) {
          router.go(route);
        } else {
          router.push(route);
        }
      },
    );

    // Incoming deep link (io.sippd://…).
    ref.listen<AsyncValue<DeepLinkTarget>>(
      deepLinkStreamProvider,
      (_, next) {
        final target = next.valueOrNull;
        if (target == null) return;
        _handleDeepLink(ref, router, target);
      },
    );

    // Replay any deep link that arrived while the user was unauthenticated
    // or mid-onboarding the moment the profile crosses into "ready" state.
    // This is what makes a guest tapping a group invite link actually land
    // inside the group post-signup instead of on /login with no context.
    ref.listen<AsyncValue<ProfileEntity?>>(currentProfileProvider, (prev, next) {
      final wasReady = prev?.valueOrNull?.onboardingCompleted ?? false;
      final isReady = next.valueOrNull?.onboardingCompleted ?? false;
      if (!wasReady && isReady) {
        _consumePendingDeepLink(ref, router);
      }
    });

    return MaterialApp.router(
      title: 'Sippd',
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
      restorationScopeId: 'sippd_app',
      debugShowCheckedModeBanner: false,
    );
  }
}

/// SharedPreferences key for a deep link the user tapped before they were
/// ready to consume it (unauthed, or mid-onboarding). Replayed once the
/// profile flips to onboardingCompleted = true.
const _kPendingDeepLinkKey = 'pending_deep_link';

bool _readyForDeepLink(WidgetRef ref) {
  if (!ref.read(isAuthenticatedProvider)) return false;
  final profile = ref.read(currentProfileProvider).valueOrNull;
  return profile != null && profile.onboardingCompleted;
}

Future<void> _consumePendingDeepLink(WidgetRef ref, GoRouter router) async {
  final prefs = ref.read(sharedPreferencesProvider);
  final stored = prefs.getString(_kPendingDeepLinkKey);
  if (stored == null) return;
  await prefs.remove(_kPendingDeepLinkKey);
  final target = DeepLinkService.deserializeTarget(stored);
  if (target == null) return;
  await _handleDeepLink(ref, router, target);
}

Future<void> _handleDeepLink(
    WidgetRef ref, GoRouter router, DeepLinkTarget target) async {
  // Guest taps the link → no auth, no profile, can't joinGroup or push a
  // route the guard would just bounce back. Stash and replay later.
  if (!_readyForDeepLink(ref)) {
    await ref
        .read(sharedPreferencesProvider)
        .setString(_kPendingDeepLinkKey, DeepLinkService.serializeTarget(target));
    return;
  }
  switch (target) {
    case DeepLinkGroupInvite(:final inviteCode):
      try {
        await ref
            .read(groupControllerProvider.notifier)
            .joinGroup(inviteCode);
      } catch (_) {
        // Already a member or invalid code — try to resolve existing group.
      }
      ref.invalidate(groupControllerProvider);
      final groups = await ref.read(groupControllerProvider.future);
      for (final g in groups) {
        if (g.inviteCode == inviteCode) {
          router.push(AppRoutes.groupDetailPath(g.id));
          break;
        }
      }
    case DeepLinkTasting(:final tastingId):
      router.push(AppRoutes.tastingDetailPath(tastingId));
    case DeepLinkFriend(:final friendId):
      router.push(AppRoutes.friendProfilePath(friendId));
  }
}

void _invalidateForPush(WidgetRef ref, RemoteMessage msg) {
  switch (msg.data['type']) {
    case 'friend_request':
    case 'friend_request_accepted':
      ref.invalidate(friendsListProvider);
      ref.invalidate(incomingFriendRequestsProvider);
      break;
    case 'group_invitation':
      ref.invalidate(myGroupInvitationsProvider);
      break;
    case 'group_joined':
    case 'tasting_created':
    case 'group_wine_shared':
      ref.invalidate(groupControllerProvider);
      break;
  }
}

bool _isShellTab(String route) {
  return route == AppRoutes.wines ||
      route == AppRoutes.groups ||
      route == AppRoutes.profile;
}

String? _routeForPush(RemoteMessage msg) {
  final data = msg.data;
  switch (data['type']) {
    case 'friend_request':
    case 'friend_request_accepted':
      return AppRoutes.friends;
    case 'tasting_created':
      final id = data['tasting_id'];
      if (id is String && id.isNotEmpty) {
        return AppRoutes.tastingDetailPath(id);
      }
      return null;
    case 'group_joined':
    case 'group_wine_shared':
      final id = data['group_id'];
      if (id is String && id.isNotEmpty) {
        return AppRoutes.groupDetailPath(id);
      }
      return null;
    case 'group_invitation':
      // User is not a member yet — group detail fetch would hit RLS and show
      // "not found". Land them on the groups list where the invitations
      // inbox accepts/declines the request.
      return AppRoutes.groups;
  }
  return null;
}

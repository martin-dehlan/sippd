import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/services/analytics/analytics.provider.dart';
import '../../common/widgets/offline_indicator.widget.dart';
import '../../common/widgets/splash.screen.dart';
import '../../features/auth/controller/auth.provider.dart';
import '../../features/groups/controller/group_invitation.provider.dart';
import '../../features/auth/presentation/modules/email_confirmation/email_confirmation.screen.dart';
import '../../features/auth/presentation/modules/login/login.screen.dart';
import '../../features/auth/presentation/modules/password_recovery/password_recovery.screen.dart';
import '../../features/auth/presentation/modules/profile/profile.screen.dart';
import '../../features/onboarding/controller/onboarding.provider.dart';
import '../../features/onboarding/presentation/modules/onboarding.screen.dart';
import '../../features/paywall/presentation/modules/paywall/paywall.screen.dart';
import '../../features/paywall/presentation/modules/subscription/subscription.screen.dart';
import '../../features/profile/controller/profile.provider.dart';
import '../../features/profile/presentation/modules/choose_username/choose_username.screen.dart';
import '../../features/profile/presentation/modules/edit_profile/edit_profile.screen.dart';
import '../../features/profile/presentation/modules/notification_settings/notification_settings.screen.dart';
import '../../features/wines/presentation/modules/wine_cleanup/wine_cleanup.screen.dart';
import '../../features/friends/presentation/modules/friend_profile/friend_profile.screen.dart';
import '../../features/friends/presentation/modules/friends/friends.screen.dart';
import '../../features/groups/presentation/modules/group_detail/group_detail.screen.dart';
import '../../features/groups/presentation/modules/group_wine_detail/group_wine_detail.screen.dart';
import '../../features/groups/presentation/modules/group_list/group_list.screen.dart';
import '../../features/tastings/presentation/modules/tasting_create/tasting_create.screen.dart';
import '../../features/tastings/presentation/modules/tasting_detail/tasting_detail.screen.dart';
import '../../features/tastings/presentation/modules/tasting_edit/tasting_edit.screen.dart';
import '../../features/wines/domain/entities/wine.entity.dart';
import '../../features/wines/presentation/modules/wine_list/wine_list.screen.dart';
import '../../features/wines/presentation/modules/wine_add/wine_add.screen.dart';
import '../../features/wines/presentation/modules/wine_stats/wine_stats.screen.dart';
import '../../features/wines/presentation/modules/wine_detail/wine_detail.screen.dart';
import '../../features/wines/presentation/modules/wine_edit/wine_edit.screen.dart';
import 'app.routes.dart';

part 'route_config.g.dart';

/// Flips to true ~1.5s after the user becomes authenticated. Used by the
/// router to optimistically release returning users to /wines when the
/// profile fetch is too slow (e.g. cold-start while offline). Resets on
/// auth changes so a fresh sign-in waits the full window again.
///
/// The timer lives in [_arm] (called from a `ref.listen` outside the
/// build phase) rather than inside `build()` so a future maintainer
/// adding a watched dep can't accidentally spawn duplicate timers.
@riverpod
class SplashDeadline extends _$SplashDeadline {
  Timer? _timer;

  @override
  bool build() {
    ref.onDispose(() => _timer?.cancel());
    return false;
  }

  void _arm() {
    _timer?.cancel();
    state = false;
    _timer = Timer(const Duration(milliseconds: 1500), () {
      state = true;
    });
  }

  void _disarm() {
    _timer?.cancel();
    state = false;
  }
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    restorationScopeId: 'sippd_router',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Defensive: if Flutter ever forwards an auth-callback URI into the
      // router, bounce to a sane default. Supabase SDK handles the code
      // exchange itself via its auth listener.
      if (state.uri.scheme == 'io.sippd' ||
          state.uri.host == 'login-callback' ||
          state.uri.path.contains('login-callback')) {
        return AppRoutes.splash;
      }
      final loc = state.matchedLocation;
      final authed = ref.read(isAuthenticatedProvider);
      final seen = ref.read(onboardingSeenProvider);
      final profileAsync = ref.read(currentProfileProvider);
      final profileSynced = ref.read(profileSyncedProvider);
      final inRecovery = ref.read(passwordRecoveryControllerProvider);
      final splashTimedOut = ref.read(splashDeadlineProvider);

      // Gate -1: password recovery deep link → must set new password first.
      if (inRecovery && loc != AppRoutes.passwordRecovery) {
        return AppRoutes.passwordRecovery;
      }

      // Email confirmation screen is reachable without auth.
      if (loc == AppRoutes.emailConfirmation) return null;

      // Gate 0: authed but profile stream still loading the new query →
      // hold splash, but only until the splash deadline elapses. After
      // that we fall through to Gate 2 which will optimistically release
      // the user to /wines so a slow / offline profile fetch doesn't trap
      // them on a spinner.
      if (authed && profileAsync.isLoading && !splashTimedOut) {
        return loc == AppRoutes.splash ? null : AppRoutes.splash;
      }

      // Gate 1: first-run onboarding. Allow /login + /password-recovery so
      // the welcome page's "Already have an account? Sign in" shortcut
      // doesn't bounce back into the funnel.
      if (!seen && !authed) {
        if (loc == AppRoutes.onboarding ||
            loc == AppRoutes.login ||
            loc == AppRoutes.passwordRecovery) {
          return null;
        }
        return AppRoutes.onboarding;
      }

      // Gate 2: authed → existing username flow.
      if (authed) {
        final profile = profileAsync.valueOrNull;
        if (profile == null) {
          // The Drift watch stream emits `null` immediately whenever
          // the local profile row hasn't been fetched yet for the
          // current user — `hasValue` becomes true on that null but it
          // does NOT mean the server has confirmed an empty profile.
          // Sign-in races land here: auth flips, stream emits null,
          // server fetch is still in flight. Without the synced flag
          // we'd flash chooseUsername for ~200-500ms before the real
          // profile lands.
          //
          // profileSynced flips true once the first server fetch
          // attempt for this user resolves (success OR failure). Until
          // then, hold splash. If the splash deadline times out before
          // sync (offline new install), fall back to the optimistic
          // path so the user isn't trapped.
          if (!profileSynced) {
            if (!splashTimedOut) {
              return loc == AppRoutes.splash ? null : AppRoutes.splash;
            }
            if (loc == AppRoutes.splash ||
                loc == AppRoutes.login ||
                loc == AppRoutes.onboarding) {
              return AppRoutes.wines;
            }
            return null;
          }
          // Synced && still null → server has confirmed there's no
          // profile row → genuine new signup.
          return loc == AppRoutes.chooseUsername
              ? null
              : AppRoutes.chooseUsername;
        }
        final needsUsername =
            profile.username == null || profile.username!.isEmpty;
        if (needsUsername && loc != AppRoutes.chooseUsername) {
          return AppRoutes.chooseUsername;
        }
        if (needsUsername) return null;
        // Gate 2b: post-username, account has not completed onboarding quiz.
        if (!profile.onboardingCompleted && loc != AppRoutes.onboarding) {
          return AppRoutes.onboarding;
        }
        if (profile.onboardingCompleted &&
            (loc == AppRoutes.chooseUsername ||
                loc == AppRoutes.login ||
                loc == AppRoutes.onboarding ||
                loc == AppRoutes.splash)) {
          return AppRoutes.wines;
        }
        return null;
      }

      // Gate 3: not authed → send to login unless on an allowed pre-auth screen.
      if (loc != AppRoutes.login &&
          loc != AppRoutes.onboarding &&
          loc != AppRoutes.splash) {
        return AppRoutes.login;
      }
      if (loc == AppRoutes.splash) return AppRoutes.login;
      return null;
    },
    routes: [
      // Auth
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          // The onboarding flow passes `{'mode': 'signup'}` when a
          // fresh user finishes the quiz so the screen lands in
          // "Create your account" instead of "Welcome back". Other
          // entry points (welcome page's "Already have an account?",
          // delete-account redirect, sign-out redirect) pass nothing
          // and get the default sign-in mode.
          final extra = state.extra as Map<String, dynamic>? ?? const {};
          final initialSignUp = extra['mode'] == 'signup';
          return LoginScreen(initialSignUp: initialSignUp);
        },
      ),
      GoRoute(
        path: AppRoutes.chooseUsername,
        builder: (context, state) => const ChooseUsernameScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailConfirmation,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final email = extra['email'] as String? ?? '';
          final purpose =
              extra['purpose'] as EmailConfirmationPurpose? ??
              EmailConfirmationPurpose.confirmSignup;
          return EmailConfirmationScreen(email: email, purpose: purpose);
        },
      ),
      GoRoute(
        path: AppRoutes.passwordRecovery,
        builder: (context, state) => const PasswordRecoveryScreen(),
      ),

      // Main shell — StatefulShellRoute preserves per-tab nav stack + scroll
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.wines,
                builder: (context, state) => const WineListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.groups,
                builder: (context, state) => const GroupListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Wine routes (outside shell)
      GoRoute(
        path: AppRoutes.wineStats,
        // Custom slide-from-right transition so the stats screen feels
        // like a sister page to the wines list rather than a stacked card.
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const WineStatsScreen(),
          transitionDuration: const Duration(milliseconds: 320),
          reverseTransitionDuration: const Duration(milliseconds: 260),
          transitionsBuilder: (_, animation, _, child) => SlideTransition(
            position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                .animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                    reverseCurve: Curves.easeInCubic,
                  ),
                ),
            child: child,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.wineAdd,
        builder: (context, state) => const WineAddScreen(),
      ),
      GoRoute(
        path: AppRoutes.wineDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final extra = state.extra;
          return WineDetailScreen(
            wineId: id,
            initial: extra is WineEntity ? extra : null,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.wineEdit,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return WineEditScreen(wineId: id);
        },
      ),

      // Group detail
      GoRoute(
        path: AppRoutes.groupDetail,
        builder: (context, state) =>
            GroupDetailScreen(groupId: state.pathParameters['id']!),
      ),

      // Group wine detail (canonical-keyed, for non-owner views)
      GoRoute(
        path: AppRoutes.groupWineDetail,
        builder: (context, state) {
          final extra = state.extra;
          return GroupWineDetailScreen(
            groupId: state.pathParameters['id']!,
            canonicalWineId: state.pathParameters['cid']!,
            initial: extra is WineEntity ? extra : null,
          );
        },
      ),

      // Tasting create
      GoRoute(
        path: AppRoutes.tastingCreate,
        builder: (context, state) =>
            TastingCreateScreen(groupId: state.pathParameters['groupId']!),
      ),

      // Tasting detail
      GoRoute(
        path: AppRoutes.tastingDetail,
        builder: (context, state) =>
            TastingDetailScreen(tastingId: state.pathParameters['id']!),
      ),

      // Tasting edit
      GoRoute(
        path: AppRoutes.tastingEdit,
        builder: (context, state) =>
            TastingEditScreen(tastingId: state.pathParameters['id']!),
      ),

      // Profile edit
      GoRoute(
        path: AppRoutes.profileEdit,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileNotifications,
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.wineCleanup,
        builder: (context, state) => const WineCleanupScreen(),
      ),

      // Paywall (shown as a fullscreen page; trigger source passed via extra)
      GoRoute(
        path: AppRoutes.paywall,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? const {};
          return PaywallScreen(triggerSource: extra['source'] as String?);
        },
      ),
      GoRoute(
        path: AppRoutes.subscription,
        builder: (context, state) => const SubscriptionScreen(),
      ),

      // Friends
      GoRoute(
        path: AppRoutes.friends,
        builder: (context, state) => const FriendsScreen(),
      ),
      GoRoute(
        path: AppRoutes.friendProfile,
        builder: (context, state) =>
            FriendProfileScreen(friendId: state.pathParameters['id']!),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );

  String? lastTrackedLocation;
  router.routerDelegate.addListener(() {
    final loc = router.routerDelegate.currentConfiguration.uri.path;
    if (loc.isEmpty || loc == lastTrackedLocation) return;
    lastTrackedLocation = loc;
    ref.read(analyticsProvider).screen(loc);
  });

  // Arm the splash deadline as soon as we know the user is authenticated
  // (cold start or fresh sign-in). Disarm on sign-out so a later
  // re-auth gets a full window again. Deferred via microtask: Riverpod
  // forbids mutating another provider during a build, and goRouter is
  // building right now.
  if (ref.read(isAuthenticatedProvider)) {
    Future.microtask(() => ref.read(splashDeadlineProvider.notifier)._arm());
  }
  ref.listen(authControllerProvider, (prev, next) {
    // Any successful auth (sign-in or sign-up) means the device has
    // committed — mark onboarding seen so a later sign-out doesn't bounce
    // the user back into the funnel.
    final wasSignedIn = prev?.valueOrNull != null;
    final nowSignedIn = next.valueOrNull != null;
    if (!wasSignedIn && nowSignedIn) {
      Future.microtask(
        () => ref.read(onboardingControllerProvider.notifier).markSeen(),
      );
      ref.read(splashDeadlineProvider.notifier)._arm();
    } else if (wasSignedIn && !nowSignedIn) {
      ref.read(splashDeadlineProvider.notifier)._disarm();
    }
    router.refresh();
  });
  ref.listen(onboardingControllerProvider, (_, _) => router.refresh());
  ref.listen(passwordRecoveryControllerProvider, (_, _) => router.refresh());
  ref.listen(splashDeadlineProvider, (_, _) => router.refresh());
  // Refresh on:
  //  - profile transitioning from loading → loaded (so splash can leave)
  //  - username-presence flipping (gate-relevant)
  // Avoid refresh on every displayName/avatar edit — causes Navigator
  // duplicate page key assertions during mid-pop edits.
  ref.listen(currentProfileProvider, (prev, next) {
    // Use `isLoading` (not `hasValue`) — Riverpod preserves the previous
    // value across rebuilds, so `hasValue` stays true through the
    // unauthed→authed transition. Without this we'd never refresh the
    // router when the new stream finally emits and the user would be
    // stranded on splash.
    final wasLoading = prev == null || prev.isLoading;
    final nowLoaded = !next.isLoading;
    if (wasLoading && nowLoaded) {
      router.refresh();
      return;
    }
    final prevHas = (prev?.valueOrNull?.username ?? '').isNotEmpty;
    final nextHas = (next.valueOrNull?.username ?? '').isNotEmpty;
    if (prevHas != nextHas) {
      router.refresh();
      return;
    }
    final prevDone = prev?.valueOrNull?.onboardingCompleted ?? false;
    final nextDone = next.valueOrNull?.onboardingCompleted ?? false;
    if (prevDone != nextDone) router.refresh();
  });

  return router;
}

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final pendingInvites =
        ref.watch(myGroupInvitationsProvider).valueOrNull?.length ?? 0;

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          const OfflineIndicator(),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, h * 0.012),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(w * 0.08),
              border: Border.all(color: cs.outlineVariant, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.28),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.02,
                vertical: h * 0.01,
              ),
              child: GNav(
                haptic: true,
                curve: Curves.easeOutQuart,
                duration: const Duration(milliseconds: 320),
                gap: 8,
                color: cs.outline,
                activeColor: cs.secondary,
                iconSize: w * 0.058,
                tabBorderRadius: 100,
                tabBackgroundColor: cs.primary.withValues(alpha: 0.22),
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.045,
                  vertical: h * 0.013,
                ),
                textStyle: TextStyle(
                  fontSize: w * 0.035,
                  fontWeight: FontWeight.w600,
                  color: cs.secondary,
                  letterSpacing: 0.2,
                ),
                selectedIndex: navigationShell.currentIndex,
                onTabChange: _onTap,
                tabs: [
                  const GButton(icon: PhosphorIconsRegular.wine, text: 'Wines'),
                  GButton(
                    icon: Icons.groups,
                    text: 'Groups',
                    leading: pendingInvites > 0
                        ? _GroupsTabIconWithBadge(
                            selected: navigationShell.currentIndex == 1,
                            count: pendingInvites,
                            iconSize: w * 0.058,
                            activeColor: cs.secondary,
                            inactiveColor: cs.outline,
                            badgeColor: cs.primary,
                            badgeTextColor: cs.onPrimary,
                          )
                        : null,
                  ),
                  const GButton(
                    icon: PhosphorIconsRegular.user,
                    text: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(int index) {
    // initialLocation: true → re-tap of current tab pops to branch root
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _GroupsTabIconWithBadge extends StatelessWidget {
  final bool selected;
  final int count;
  final double iconSize;
  final Color activeColor;
  final Color inactiveColor;
  final Color badgeColor;
  final Color badgeTextColor;

  const _GroupsTabIconWithBadge({
    required this.selected,
    required this.count,
    required this.iconSize,
    required this.activeColor,
    required this.inactiveColor,
    required this.badgeColor,
    required this.badgeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final badgeSize = iconSize * 0.55;
    final label = count > 9 ? '9+' : count.toString();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          Icons.groups,
          size: iconSize,
          color: selected ? activeColor : inactiveColor,
        ),
        Positioned(
          right: -badgeSize * 0.4,
          top: -badgeSize * 0.2,
          child: Container(
            height: badgeSize,
            constraints: BoxConstraints(minWidth: badgeSize),
            padding: EdgeInsets.symmetric(horizontal: badgeSize * 0.25),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(badgeSize),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: badgeTextColor,
                fontSize: badgeSize * 0.62,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

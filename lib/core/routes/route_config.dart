import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/widgets/splash.screen.dart';
import '../../features/auth/controller/auth.provider.dart';
import '../../features/auth/presentation/modules/login/login.screen.dart';
import '../../features/auth/presentation/modules/profile/profile.screen.dart';
import '../../features/onboarding/controller/onboarding.provider.dart';
import '../../features/onboarding/presentation/modules/onboarding.screen.dart';
import '../../features/profile/controller/profile.provider.dart';
import '../../features/profile/presentation/modules/choose_username/choose_username.screen.dart';
import '../../features/profile/presentation/modules/edit_profile/edit_profile.screen.dart';
import '../../features/friends/presentation/modules/friend_profile/friend_profile.screen.dart';
import '../../features/friends/presentation/modules/friends/friends.screen.dart';
import '../../features/groups/presentation/modules/group_detail/group_detail.screen.dart';
import '../../features/groups/presentation/modules/group_list/group_list.screen.dart';
import '../../features/tastings/presentation/modules/tasting_create/tasting_create.screen.dart';
import '../../features/tastings/presentation/modules/tasting_detail/tasting_detail.screen.dart';
import '../../features/tastings/presentation/modules/tasting_edit/tasting_edit.screen.dart';
import '../../features/wines/presentation/modules/wine_list/wine_list.screen.dart';
import '../../features/wines/presentation/modules/wine_add/wine_add.screen.dart';
import '../../features/wines/presentation/modules/wine_detail/wine_detail.screen.dart';
import '../../features/wines/presentation/modules/wine_edit/wine_edit.screen.dart';
import 'app.routes.dart';

part 'route_config.g.dart';

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
      final guest = ref.read(isGuestProvider);
      final profileAsync = ref.read(currentProfileProvider);

      // Gate 0: authed but profile not yet emitted → keep splash.
      if (authed && !profileAsync.hasValue) {
        return loc == AppRoutes.splash ? null : AppRoutes.splash;
      }

      // Gate 1: first-run onboarding.
      if (!seen && !authed) {
        return loc == AppRoutes.onboarding ? null : AppRoutes.onboarding;
      }

      // Gate 2: authed → existing username flow.
      if (authed) {
        final profile = profileAsync.valueOrNull;
        if (profile == null) {
          return loc == AppRoutes.chooseUsername
              ? null
              : AppRoutes.chooseUsername;
        }
        final needsUsername =
            profile.username == null || profile.username!.isEmpty;
        if (needsUsername && loc != AppRoutes.chooseUsername) {
          return AppRoutes.chooseUsername;
        }
        if (!needsUsername &&
            (loc == AppRoutes.chooseUsername ||
             loc == AppRoutes.login ||
             loc == AppRoutes.onboarding ||
             loc == AppRoutes.splash)) {
          return AppRoutes.wines;
        }
        return null;
      }

      // Gate 3: not authed, onboarding done.
      // Guest: allowed on wines. Cloud features bounce to login.
      if (guest) {
        if (loc == AppRoutes.splash) return AppRoutes.wines;
        const cloudPrefixes = [
          AppRoutes.groups,
          AppRoutes.friends,
          AppRoutes.profile,
        ];
        final needsAuth = cloudPrefixes.any(loc.startsWith);
        if (needsAuth) return AppRoutes.login;
        return null;
      }

      // Gate 4: not authed, not guest → send to login unless already there.
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
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.chooseUsername,
        builder: (context, state) => const ChooseUsernameScreen(),
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
        path: AppRoutes.wineAdd,
        builder: (context, state) => const WineAddScreen(),
      ),
      GoRoute(
        path: AppRoutes.wineDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return WineDetailScreen(wineId: id);
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

      // Tasting create
      GoRoute(
        path: AppRoutes.tastingCreate,
        builder: (context, state) => TastingCreateScreen(
            groupId: state.pathParameters['groupId']!),
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
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri}')),
    ),
  );

  ref.listen(authControllerProvider, (_, _) => router.refresh());
  ref.listen(onboardingControllerProvider, (_, _) => router.refresh());
  // Refresh on:
  //  - profile transitioning from loading → loaded (so splash can leave)
  //  - username-presence flipping (gate-relevant)
  // Avoid refresh on every displayName/avatar edit — causes Navigator
  // duplicate page key assertions during mid-pop edits.
  ref.listen(currentProfileProvider, (prev, next) {
    final wasLoading = prev == null || !prev.hasValue;
    final nowLoaded = next.hasValue;
    if (wasLoading && nowLoaded) {
      router.refresh();
      return;
    }
    final prevHas =
        (prev?.valueOrNull?.username ?? '').isNotEmpty;
    final nextHas =
        (next.valueOrNull?.username ?? '').isNotEmpty;
    if (prevHas != nextHas) router.refresh();
  });

  return router;
}

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            w * 0.05,
            0,
            w * 0.05,
            h * 0.012,
          ),
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
                tabs: const [
                  GButton(icon: Icons.wine_bar, text: 'Wines'),
                  GButton(icon: Icons.groups, text: 'Groups'),
                  GButton(icon: Icons.person, text: 'Profile'),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/modules/login/login.screen.dart';
import '../../features/auth/presentation/modules/profile/profile.screen.dart';
import '../../features/friends/presentation/modules/friend_profile/friend_profile.screen.dart';
import '../../features/friends/presentation/modules/friends/friends.screen.dart';
import '../../features/groups/presentation/modules/group_detail/group_detail.screen.dart';
import '../../features/groups/presentation/modules/group_list/group_list.screen.dart';
import '../../features/tastings/presentation/modules/tasting_create/tasting_create.screen.dart';
import '../../features/tastings/presentation/modules/tasting_detail/tasting_detail.screen.dart';
import '../../features/scanner/presentation/modules/scan/scan.screen.dart';
import '../../features/scanner/presentation/modules/scan/scan_label.screen.dart';
import '../../features/scanner/presentation/modules/scan_result/scan_result.screen.dart';
import '../../features/wines/presentation/modules/wine_list/wine_list.screen.dart';
import '../../features/wines/presentation/modules/wine_add/wine_add.screen.dart';
import '../../features/wines/presentation/modules/wine_detail/wine_detail.screen.dart';
import 'app.routes.dart';

part 'route_config.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: true,
    routes: [
      // Auth
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // Main shell
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.wines,
            builder: (context, state) => const WineListScreen(),
          ),
          GoRoute(
            path: AppRoutes.groups,
            builder: (context, state) => const GroupListScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreen(),
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

      // Scanner routes
      GoRoute(
        path: AppRoutes.scan,
        builder: (context, state) => const ScanScreen(),
      ),
      GoRoute(
        path: AppRoutes.scanResult,
        builder: (context, state) => const ScanResultScreen(),
      ),
      GoRoute(
        path: AppRoutes.scanLabel,
        builder: (context, state) => const ScanLabelScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri}')),
    ),
  );
}

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateIndex(context),
        onDestinationSelected: (index) => _onTap(index, context),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.wine_bar), label: 'Wines'),
          NavigationDestination(
              icon: Icon(Icons.qr_code_scanner), label: 'Scan'),
          NavigationDestination(icon: Icon(Icons.group), label: 'Groups'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/scan')) return 1;
    if (location.startsWith('/groups')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.wines);
      case 1:
        context.push(AppRoutes.scan);
      case 2:
        context.go(AppRoutes.groups);
      case 3:
        context.go(AppRoutes.profile);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/wines/presentation/modules/wine_list/wine_list.screen.dart';
import '../../features/wines/presentation/modules/wine_add/wine_add.screen.dart';
import '../../features/wines/presentation/modules/wine_detail/wine_detail.screen.dart';
import 'app.routes.dart';

part 'route_config.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoutes.wines,
    debugLogDiagnostics: true,
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.wines,
            builder: (context, state) => const WineListScreen(),
          ),
          GoRoute(
            path: AppRoutes.groups,
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Groups'))),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) =>
                const Scaffold(body: Center(child: Text('Profile'))),
          ),
        ],
      ),
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
          NavigationDestination(icon: Icon(Icons.group), label: 'Groups'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  int _calculateIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/groups')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.wines);
      case 1:
        context.go(AppRoutes.groups);
      case 2:
        context.go(AppRoutes.profile);
    }
  }
}

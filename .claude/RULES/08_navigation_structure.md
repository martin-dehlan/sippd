# Navigation Structure (go_router)

**TL;DR:** go_router with Riverpod integration. Feature-level route files. `ShellRoute` for bottom nav. Auth guard via `redirect`. Deep linking works out of the box.

---

## Setup

```yaml
# pubspec.yaml
dependencies:
  go_router: ^14.x.x
```

---

## AppRoutes (path constants)

File: `lib/common/routes/app_routes.dart`

```dart
abstract class AppRoutes {
  // Auth
  static const String splash    = '/';
  static const String login     = '/login';
  static const String register  = '/register';

  // Shell (bottom nav)
  static const String wines     = '/wines';
  static const String wineDetail = '/wines/:wineId';
  static const String addWine   = '/wines/add';

  static const String groups    = '/groups';
  static const String groupDetail = '/groups/:groupId';

  static const String profile   = '/profile';
  static const String settings  = '/profile/settings';
}
```

---

## Feature Route Definitions

Each feature owns its route definitions:

File: `lib/features/wine/presentation/wine.routes.dart`

```dart
import 'package:go_router/go_router.dart';
import '../screens/wine_list.screen.dart';
import '../screens/wine_detail.screen.dart';
import '../screens/add_wine.screen.dart';

final wineRoutes = [
  GoRoute(
    path: AppRoutes.wines,
    builder: (context, state) => const WineListScreen(),
    routes: [
      GoRoute(
        path: 'add',
        builder: (context, state) => const AddWineScreen(),
      ),
      GoRoute(
        path: ':wineId',
        builder: (context, state) {
          final wineId = state.pathParameters['wineId']!;
          return WineDetailScreen(wineId: wineId);
        },
      ),
    ],
  ),
];
```

---

## GoRouter Config (with Riverpod)

File: `lib/common/routes/app_router.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.register ||
          state.matchedLocation == AppRoutes.splash;

      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
      if (isLoggedIn && isAuthRoute) return AppRoutes.wines;
      return null;
    },
    routes: [
      // Auth routes
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (_, __) => const RegisterScreen(),
      ),

      // Shell with bottom nav
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          ...wineRoutes,
          ...groupRoutes,
          ...profileRoutes,
        ],
      ),
    ],
  );
}
```

---

## ShellRoute: Bottom Navigation

File: `lib/common/widgets/app_shell.widget.dart`

```dart
class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indexFromLocation(location),
        onDestinationSelected: (i) => _onTab(context, i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.wine_bar), label: 'Wines'),
          NavigationDestination(icon: Icon(Icons.group),    label: 'Groups'),
          NavigationDestination(icon: Icon(Icons.person),   label: 'Profile'),
        ],
      ),
    );
  }

  int _indexFromLocation(String location) {
    if (location.startsWith(AppRoutes.groups))  return 1;
    if (location.startsWith(AppRoutes.profile)) return 2;
    return 0;
  }

  void _onTab(BuildContext context, int index) {
    switch (index) {
      case 0: context.go(AppRoutes.wines);
      case 1: context.go(AppRoutes.groups);
      case 2: context.go(AppRoutes.profile);
    }
  }
}
```

---

## Auth Guard Pattern

Auth state from Supabase via Riverpod:

```dart
// lib/features/auth/controller/auth.provider.dart
@riverpod
Stream<AuthState> authState(Ref ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
}

@riverpod
User? currentUser(Ref ref) {
  return ref.watch(authStateProvider).valueOrNull?.session?.user;
}

@riverpod
String currentUserId(Ref ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) throw const AppError.unauthorized();
  return user.id;
}
```

The `redirect` in `GoRouter` reacts to `authStateProvider` changes automatically because the router is a Riverpod provider that watches it.

---

## Navigation in Code

```dart
// Push a new route (with back button)
context.push(AppRoutes.addWine);

// Go to route (replace current)
context.go(AppRoutes.wines);

// Go to route with path parameters
context.go('/wines/$wineId');

// Go to route with query parameters
context.go('/wines?sort=rating');

// Pop back
context.pop();

// Pop with result
context.pop(result);
```

---

## Deep Linking

go_router handles deep linking automatically. Configure in:

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<intent-filter>
  <action android:name="android.intent.action.VIEW"/>
  <category android:name="android.intent.category.DEFAULT"/>
  <category android:name="android.intent.category.BROWSABLE"/>
  <data android:scheme="sippd" android:host="app"/>
</intent-filter>
```

```xml
<!-- ios/Runner/Info.plist -->
<key>FlutterDeepLinkingEnabled</key><true/>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array><string>sippd</string></array>
  </dict>
</array>
```

Incoming link `sippd://app/wines/abc123` maps to `/wines/abc123`.

---

## App Entry Point

```dart
// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
  runApp(const ProviderScope(child: SippdApp()));
}

// lib/app.dart
class SippdApp extends ConsumerWidget {
  const SippdApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Sippd',
      theme: AppTheme.light,
    );
  }
}
```

---

## Rules Checklist

- [ ] All route paths defined as constants in `AppRoutes`
- [ ] Each feature has its own `.routes.dart` file
- [ ] Auth guard in `GoRouter.redirect`, not in individual screens
- [ ] `ShellRoute` wraps all bottom-nav destinations
- [ ] Router is a Riverpod provider so it reacts to auth state changes
- [ ] Use `context.go()` for tab navigation, `context.push()` for drill-down

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/theme/app_theme.dart';
import 'core/routes/route_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: Initialize Supabase
  // await Supabase.initialize(url: '...', anonKey: '...');

  runApp(const ProviderScope(child: SippdApp()));
}

class SippdApp extends ConsumerWidget {
  const SippdApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Sippd',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

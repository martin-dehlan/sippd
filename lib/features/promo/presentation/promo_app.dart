import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/l10n/generated/app_localizations.dart';
import '../../../common/theme/app_theme.dart';
import 'promo_showcase.screen.dart';

/// Isolated app root used only when `kIsPromo` is set. It deliberately
/// bypasses the production [GoRouter] (and its auth gates) — promo builds
/// have no session — and runs immersive + banner-free so screen recordings
/// are clean.
///
/// Wrapped in a [ProviderScope] purely so any future provider-coupled
/// showcase widget works without a separate harness; the curated set reads
/// no providers today.
class PromoApp extends StatefulWidget {
  const PromoApp({super.key});

  @override
  State<PromoApp> createState() => _PromoAppState();
}

class _PromoAppState extends State<PromoApp> {
  @override
  void initState() {
    super.initState();
    // Hide the status + nav bars for full-bleed capture.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Sippd Promo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const PromoShowcaseScreen(),
      ),
    );
  }
}

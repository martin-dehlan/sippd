import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/onboarding/controller/onboarding.provider.dart';

part 'locale.provider.g.dart';

const _localePrefKey = 'app_locale';

const supportedAppLocales = <Locale>[
  Locale('en'),
  Locale('de'),
  Locale('es'),
  Locale('it'),
  Locale('fr'),
];

@riverpod
class AppLocaleController extends _$AppLocaleController {
  @override
  Locale? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final code = prefs.getString(_localePrefKey);
    if (code == null || code.isEmpty) return null;
    return Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_localePrefKey);
    } else {
      await prefs.setString(_localePrefKey, locale.languageCode);
    }
    state = locale;
  }
}

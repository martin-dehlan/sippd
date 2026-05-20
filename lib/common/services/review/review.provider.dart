import 'package:in_app_review/in_app_review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/onboarding/controller/onboarding.provider.dart';
import '../analytics/analytics.provider.dart';

part 'review.provider.g.dart';

/// Numeric App Store ID (Apple ID) — used by the store-listing fallback on
/// iOS. Android ignores it and resolves the listing from the package id.
const appStoreId = '6764694430';

/// How many wines the user must create before the soft review ask appears.
const reviewWineThreshold = 3;

/// Lifetime count of wines created on this device (monotonic — unaffected by
/// deletes). Drives the [reviewWineThreshold] gate.
const _wineCreatedCountKey = 'review_wines_created';

/// Set once the soft ask has been surfaced. Guarantees the prompt shows at
/// most once, ever.
const _promptShownKey = 'review_prompt_shown';

@riverpod
InAppReview inAppReview(InAppReviewRef ref) => InAppReview.instance;

/// Owns the "ask for a store review" lifecycle: a SharedPreferences-gated
/// soft ask (custom overlay) that, on a positive response, hands off to the
/// native StoreKit / Play in-app review sheet.
@riverpod
class ReviewPromptController extends _$ReviewPromptController {
  @override
  void build() {}

  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  /// Bump the lifetime wine-created counter. Call after each successful add.
  Future<void> recordWineCreated() async {
    final next = (_prefs.getInt(_wineCreatedCountKey) ?? 0) + 1;
    await _prefs.setInt(_wineCreatedCountKey, next);
  }

  /// True when the user has crossed [reviewWineThreshold] and the soft ask
  /// has never been shown before.
  bool shouldPrompt() {
    if (_prefs.getBool(_promptShownKey) ?? false) return false;
    return (_prefs.getInt(_wineCreatedCountKey) ?? 0) >= reviewWineThreshold;
  }

  /// Mark the soft ask as surfaced (so it never returns) and log it.
  Future<void> markSurfaced() async {
    await _prefs.setBool(_promptShownKey, true);
    ref.read(analyticsProvider).capture('review_prompt_shown');
  }

  /// Fire the native in-app review sheet (StoreKit / Play). Falls back to the
  /// store listing when the native flow is unavailable.
  Future<void> requestNativeReview() async {
    final review = ref.read(inAppReviewProvider);
    if (await review.isAvailable()) {
      await review.requestReview();
    } else {
      await openStoreListing();
    }
  }

  /// Open the platform store page directly (used by the explicit "Rate"
  /// button and as the native-review fallback).
  Future<void> openStoreListing() =>
      ref.read(inAppReviewProvider).openStoreListing(appStoreId: appStoreId);
}

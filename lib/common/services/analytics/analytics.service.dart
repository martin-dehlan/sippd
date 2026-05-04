import 'package:flutter/foundation.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

class AnalyticsService {
  AnalyticsService();

  bool _enabled = false;

  Future<void> init({required String apiKey, required String host}) async {
    if (apiKey.isEmpty) {
      debugPrint('AnalyticsService: empty API key, analytics disabled.');
      return;
    }
    final config = PostHogConfig(apiKey)
      ..host = host
      ..captureApplicationLifecycleEvents = true
      ..debug = kDebugMode;
    await Posthog().setup(config);
    _enabled = true;
  }

  Future<void> identify(
    String userId, {
    Map<String, Object>? userProperties,
  }) async {
    if (!_enabled) return;
    await Posthog().identify(
      userId: userId,
      userProperties: userProperties,
    );
  }

  Future<void> capture(
    String event, {
    Map<String, Object>? properties,
  }) async {
    if (!_enabled) return;
    await Posthog().capture(
      eventName: event,
      properties: properties,
    );
  }

  Future<void> screen(
    String name, {
    Map<String, Object>? properties,
  }) async {
    if (!_enabled) return;
    await Posthog().screen(
      screenName: name,
      properties: properties,
    );
  }

  Future<void> reset() async {
    if (!_enabled) return;
    await Posthog().reset();
  }

  /// Telemetry for swallowed sync failures. Use at the catch site of
  /// every fire-and-forget background write so silent loss is at least
  /// observable in PostHog. [kind] is a stable event suffix
  /// (`wine_upsert`, `image_upload`, `profile_sync`, …) — avoid passing
  /// dynamic values, the dashboard groups by it.
  Future<void> syncFailed(
    String kind, {
    Object? error,
  }) =>
      capture('sync_failed', properties: {
        'kind': kind,
        if (error != null) 'error_class': error.runtimeType.toString(),
      });
}

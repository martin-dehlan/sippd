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
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'analytics.service.dart';

part 'analytics.provider.g.dart';

@Riverpod(keepAlive: true)
AnalyticsService analytics(AnalyticsRef ref) {
  // Overridden in main.dart with the initialized instance.
  return AnalyticsService();
}

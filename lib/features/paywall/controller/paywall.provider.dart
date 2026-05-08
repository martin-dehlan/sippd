import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/services/paywall.service.dart';

part 'paywall.provider.g.dart';

@Riverpod(keepAlive: true)
PaywallService paywall(PaywallRef ref) {
  // Overridden in main.dart with the initialized instance.
  return PaywallService();
}

@Riverpod(keepAlive: true)
Stream<CustomerInfo> customerInfoStream(CustomerInfoStreamRef ref) {
  return ref.watch(paywallProvider).customerInfoStream;
}

@riverpod
bool isPro(IsProRef ref) {
  // Debug-only override. --dart-define=FORCE_PRO=true|false bypasses
  // RevenueCat for pro/free UI smoke-testing. NEVER honored in release —
  // a re-signed build with --dart-define would otherwise unlock Pro for free.
  if (kDebugMode && const bool.hasEnvironment('FORCE_PRO')) {
    return const bool.fromEnvironment('FORCE_PRO');
  }
  final info = ref.watch(customerInfoStreamProvider).valueOrNull;
  if (info == null) return ref.watch(paywallProvider).isPro;
  return info.entitlements.active.containsKey(proEntitlementId);
}

@riverpod
Future<Offerings?> paywallOfferings(PaywallOfferingsRef ref) {
  return ref.watch(paywallProvider).getOfferings();
}

/// Latest CustomerInfo, preferring stream values for liveness but
/// falling back to the service's cached snapshot so screens that
/// mount after the broadcast stream's initial emit still get a value.
@riverpod
CustomerInfo? currentCustomerInfo(CurrentCustomerInfoRef ref) {
  final fromStream = ref.watch(customerInfoStreamProvider).valueOrNull;
  if (fromStream != null) return fromStream;
  return ref.watch(paywallProvider).currentInfo;
}

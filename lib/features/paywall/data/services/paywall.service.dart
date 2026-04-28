import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

const String proEntitlementId = 'pro';

class PaywallService {
  PaywallService();

  final StreamController<CustomerInfo> _customerInfoController =
      StreamController<CustomerInfo>.broadcast();

  bool _enabled = false;
  CustomerInfo? _lastInfo;

  Stream<CustomerInfo> get customerInfoStream => _customerInfoController.stream;

  /// Latest snapshot of CustomerInfo, or null if RC hasn't produced
  /// one yet. Lets surfaces that mount after init's broadcast emit
  /// (and so missed it) read the current state synchronously.
  CustomerInfo? get currentInfo => _lastInfo;

  /// True once init() has successfully configured RC. When false the
  /// service is silent — no purchases, no stream events, no restore.
  bool get isInitialised => _enabled;

  bool get isPro {
    final info = _lastInfo;
    if (info == null) return false;
    return info.entitlements.active.containsKey(proEntitlementId);
  }

  Future<void> init({
    required String iosApiKey,
    required String androidApiKey,
  }) async {
    final apiKey = Platform.isIOS ? iosApiKey : androidApiKey;
    if (apiKey.isEmpty) {
      debugPrint('PaywallService: empty API key, paywall disabled.');
      return;
    }

    // RevenueCat shows a native warning dialog when a test_-prefixed key
    // is used in a release build. Skip configure entirely in that case so
    // beta testers don't get hit with the dev-only popup. Paywall stays
    // silent until production keys land in .env.
    if (apiKey.startsWith('test_') && !kDebugMode) {
      debugPrint(
        'PaywallService: test key on release build — skipping configure.',
      );
      return;
    }

    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.warn);
    await Purchases.configure(PurchasesConfiguration(apiKey));

    Purchases.addCustomerInfoUpdateListener((info) {
      _lastInfo = info;
      _customerInfoController.add(info);
    });

    try {
      _lastInfo = await Purchases.getCustomerInfo();
      _customerInfoController.add(_lastInfo!);
    } catch (e) {
      debugPrint('PaywallService: failed to fetch initial customer info: $e');
    }

    _enabled = true;
  }

  Future<void> identify(String userId) async {
    if (!_enabled) return;
    final result = await Purchases.logIn(userId);
    _lastInfo = result.customerInfo;
    _customerInfoController.add(result.customerInfo);
  }

  Future<void> logout() async {
    if (!_enabled) return;
    final info = await Purchases.logOut();
    _lastInfo = info;
    _customerInfoController.add(info);
  }

  Future<Offerings?> getOfferings() async {
    if (!_enabled) return null;
    return Purchases.getOfferings();
  }

  Future<CustomerInfo> purchasePackage(Package package) async {
    final result = await Purchases.purchase(PurchaseParams.package(package));
    _lastInfo = result.customerInfo;
    _customerInfoController.add(result.customerInfo);
    return result.customerInfo;
  }

  Future<CustomerInfo> restore() async {
    final info = await Purchases.restorePurchases();
    _lastInfo = info;
    _customerInfoController.add(info);
    return info;
  }

  /// Force-fetches the latest CustomerInfo from RevenueCat, bypassing the
  /// SDK's internal cache. Needed when the user just changed their sub
  /// outside the app (cancel in Play Store, expiry, server-side change)
  /// because expiry events don't always reach the update listener — the
  /// SDK keeps serving cached "still active" data until next live fetch.
  Future<CustomerInfo?> refresh() async {
    if (!_enabled) return null;
    try {
      await Purchases.invalidateCustomerInfoCache();
      final info = await Purchases.getCustomerInfo();
      _lastInfo = info;
      _customerInfoController.add(info);
      return info;
    } catch (e) {
      debugPrint('PaywallService.refresh failed: $e');
      return _lastInfo;
    }
  }

  void dispose() {
    _customerInfoController.close();
  }
}

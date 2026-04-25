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

  Stream<CustomerInfo> get customerInfoStream =>
      _customerInfoController.stream;

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

    await Purchases.setLogLevel(
      kDebugMode ? LogLevel.debug : LogLevel.warn,
    );
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

  void dispose() {
    _customerInfoController.close();
  }
}

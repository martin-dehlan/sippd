import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/paywall.provider.dart';
import '../../../data/services/paywall.service.dart';
import '../../widgets/paywall_feature_row.widget.dart';
import '../../widgets/paywall_plan_card.widget.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key, this.triggerSource});

  final String? triggerSource;

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  Package? _selected;
  bool _purchasing = false;

  @override
  void initState() {
    super.initState();
    ref.read(analyticsProvider).capture(
      'paywall_impression',
      properties: {
        if (widget.triggerSource != null) 'source': widget.triggerSource!,
      },
    );
  }

  Future<void> _purchase() async {
    final pkg = _selected;
    if (pkg == null || _purchasing) return;
    setState(() => _purchasing = true);

    final analytics = ref.read(analyticsProvider);
    analytics.capture(
      'paywall_cta_tap',
      properties: {'package': pkg.identifier},
    );

    try {
      await ref.read(paywallProvider).purchasePackage(pkg);
      if (!mounted) return;
      analytics.capture(
        'paywall_purchase_success',
        properties: {'package': pkg.identifier},
      );
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      analytics.capture(
        'paywall_purchase_failed',
        properties: {'package': pkg.identifier, 'error': e.toString()},
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase failed. Please try again.')),
      );
    } finally {
      if (mounted) setState(() => _purchasing = false);
    }
  }

  Future<void> _restore() async {
    final analytics = ref.read(analyticsProvider);
    analytics.capture('paywall_restore_tap');
    try {
      final info = await ref.read(paywallProvider).restore();
      if (!mounted) return;
      final restored = info.entitlements.active.containsKey(proEntitlementId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(restored
              ? 'Welcome back to Sippd Pro!'
              : 'No active subscription found.'),
        ),
      );
      if (restored) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not restore purchases.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final offeringsAsync = ref.watch(paywallOfferingsProvider);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.x),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        actions: [
          TextButton(
            onPressed: _restore,
            child: const Text('Restore'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: context.m),
              Text(
                'Sippd Pro',
                style: TextStyle(
                  fontSize: context.titleFont,
                  fontWeight: FontWeight.w800,
                  color: cs.onSurface,
                ),
              ),
              SizedBox(height: context.s),
              Text(
                'More groups, deeper insights, premium share-cards.',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  color: cs.onSurfaceVariant,
                ),
              ),
              SizedBox(height: context.l),
              const PaywallFeatureRow(label: 'Unlimited groups'),
              const PaywallFeatureRow(label: 'Premium share-cards'),
              const PaywallFeatureRow(label: 'Taste profile + stats'),
              const PaywallFeatureRow(label: 'Themes & Pro badge'),
              SizedBox(height: context.l),
              Expanded(
                child: offeringsAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (_, _) => Center(
                    child: Text(
                      'Could not load plans. Please try again.',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                  ),
                  data: (offerings) {
                    final packages =
                        offerings?.current?.availablePackages ?? const [];
                    if (packages.isEmpty) {
                      return Center(
                        child: Text(
                          'No plans available yet.',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: packages.length,
                      separatorBuilder: (_, _) =>
                          SizedBox(height: context.s),
                      itemBuilder: (_, i) {
                        final pkg = packages[i];
                        return PaywallPlanCard(
                          package: pkg,
                          selected: _selected?.identifier == pkg.identifier,
                          onTap: () => setState(() => _selected = pkg),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: context.m),
              FilledButton(
                onPressed: _selected == null || _purchasing ? null : _purchase,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: context.m),
                ),
                child: _purchasing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        _selected == null ? 'Select a plan' : 'Continue',
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              SizedBox(height: context.m),
            ],
          ),
        ),
      ),
    );
  }
}

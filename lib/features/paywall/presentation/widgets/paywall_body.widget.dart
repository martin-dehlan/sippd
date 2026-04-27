import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../common/services/analytics/analytics.provider.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/paywall.provider.dart';
import '../../data/services/paywall.service.dart';
import 'paywall_feature_row.widget.dart';
import 'paywall_plan_card.widget.dart';
import 'paywall_trial_timeline.widget.dart';

/// Reusable paywall body — renders headline, benefits, plan picker, primary
/// CTA, dismiss link and footer disclosure. The host screen owns the chrome
/// (Scaffold, sheet, AppBar) so the same content can live in onboarding,
/// bottom sheets, and stand-alone paywall screens without duplication.
class PaywallBody extends ConsumerStatefulWidget {
  const PaywallBody({
    super.key,
    required this.triggerSource,
    this.headline,
    this.subhead,
    required this.benefits,
    this.showTrialTimeline = false,
    this.primaryLabel,
    this.dismissLabel,
    this.onSuccess,
    this.onDismiss,
  });

  final String triggerSource;
  final String? headline;
  final String? subhead;
  final List<String> benefits;
  final bool showTrialTimeline;
  final String? primaryLabel;
  final String? dismissLabel;
  final VoidCallback? onSuccess;
  final VoidCallback? onDismiss;

  @override
  ConsumerState<PaywallBody> createState() => _PaywallBodyState();
}

class _PaywallBodyState extends ConsumerState<PaywallBody> {
  Package? _selected;
  bool _purchasing = false;

  @override
  void initState() {
    super.initState();
    ref
        .read(analyticsProvider)
        .capture(
          'paywall_impression',
          properties: {'source': widget.triggerSource},
        );
  }

  void _maybePreselectAnnual(List<Package> packages) {
    if (_selected != null || packages.isEmpty) return;
    final annual = packages.firstWhere(
      (p) => p.packageType == PackageType.annual,
      orElse: () => packages.first,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _selected = annual);
    });
  }

  Future<void> _purchase() async {
    final pkg = _selected;
    if (pkg == null || _purchasing) return;
    setState(() => _purchasing = true);

    final analytics = ref.read(analyticsProvider);
    analytics.capture(
      'paywall_cta_tap',
      properties: {'package': pkg.identifier, 'source': widget.triggerSource},
    );

    try {
      await ref.read(paywallProvider).purchasePackage(pkg);
      if (!mounted) return;
      analytics.capture(
        'paywall_purchase_success',
        properties: {'package': pkg.identifier, 'source': widget.triggerSource},
      );
      widget.onSuccess?.call();
    } catch (e) {
      if (!mounted) return;
      analytics.capture(
        'paywall_purchase_failed',
        properties: {
          'package': pkg.identifier,
          'source': widget.triggerSource,
          'error': e.toString(),
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Purchase failed. Please try again.')),
      );
    } finally {
      if (mounted) setState(() => _purchasing = false);
    }
  }

  Future<void> _restore() async {
    final analytics = ref.read(analyticsProvider);
    analytics.capture(
      'paywall_restore_tap',
      properties: {'source': widget.triggerSource},
    );
    try {
      final info = await ref.read(paywallProvider).restore();
      if (!mounted) return;
      final restored = info.entitlements.active.containsKey(proEntitlementId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            restored
                ? 'Welcome back to Sippd Pro!'
                : 'No active subscription found.',
          ),
        ),
      );
      if (restored) widget.onSuccess?.call();
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.headline != null) ...[
          Text(
            widget.headline!,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.1,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: context.s),
        ],
        if (widget.subhead != null) ...[
          Text(
            widget.subhead!,
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              height: 1.4,
              color: cs.onSurfaceVariant,
            ),
          ),
          SizedBox(height: context.l),
        ],
        ...widget.benefits.map((b) => PaywallFeatureRow(label: b)),
        if (widget.showTrialTimeline) ...[
          SizedBox(height: context.m),
          const PaywallTrialTimeline(),
        ],
        SizedBox(height: context.l),
        offeringsAsync.when(
          loading: () => Padding(
            padding: EdgeInsets.symmetric(vertical: context.l),
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (_, _) => Padding(
            padding: EdgeInsets.symmetric(vertical: context.m),
            child: Text(
              'Could not load plans. Please try again.',
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
          ),
          data: (offerings) {
            final packages =
                offerings?.current?.availablePackages ?? const <Package>[];
            if (packages.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: context.m),
                child: Text(
                  'No plans available yet.',
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              );
            }
            _maybePreselectAnnual(packages);
            return Column(
              children: [
                for (var i = 0; i < packages.length; i++) ...[
                  if (i > 0) SizedBox(height: context.s),
                  PaywallPlanCard(
                    package: packages[i],
                    selected: _selected?.identifier == packages[i].identifier,
                    onTap: () => setState(() => _selected = packages[i]),
                  ),
                ],
              ],
            );
          },
        ),
        SizedBox(height: context.m),
        SizedBox(
          height: context.h * 0.065,
          child: FilledButton(
            onPressed: _selected == null || _purchasing ? null : _purchase,
            style: FilledButton.styleFrom(
              elevation: 0,
              disabledBackgroundColor: cs.surfaceContainer,
              disabledForegroundColor: cs.outline,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.w * 0.04),
              ),
            ),
            child: _purchasing
                ? SizedBox(
                    height: context.w * 0.05,
                    width: context.w * 0.05,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    widget.primaryLabel ??
                        (_selected == null ? 'Select a plan' : 'Continue'),
                    style: TextStyle(
                      fontSize: context.bodyFont * 1.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        ),
        if (widget.dismissLabel != null) ...[
          SizedBox(height: context.s),
          Center(
            child: TextButton(
              onPressed: widget.onDismiss,
              child: Text(
                widget.dismissLabel!,
                style: TextStyle(
                  fontSize: context.bodyFont * 0.95,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: context.s),
        Center(
          child: Text(
            'Cancel anytime · billed by Apple or Google',
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              color: cs.outline,
            ),
          ),
        ),
        SizedBox(height: context.xs),
        Center(
          child: TextButton(
            onPressed: _restore,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: context.s,
                vertical: context.xs,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Restore purchases',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

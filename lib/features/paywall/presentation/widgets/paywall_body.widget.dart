import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/services/analytics/analytics.provider.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/error_view.widget.dart';
import '../../controller/paywall.provider.dart';
import '../../data/services/paywall.service.dart';
import 'paywall_benefit.widget.dart';
import 'paywall_hero.widget.dart';
import 'paywall_plan_card.widget.dart';
import 'paywall_trial_timeline.widget.dart';

/// Reusable paywall body — renders an optional hero, headline, benefits,
/// plan picker, primary CTA, dismiss link and footer disclosure. Host
/// screens own the chrome (Scaffold, sheet, AppBar) so the same content
/// can live in onboarding, contextual sheets and the standalone screen
/// without duplication.
class PaywallBody extends ConsumerStatefulWidget {
  const PaywallBody({
    super.key,
    required this.triggerSource,
    required this.benefits,
    this.eyebrow,
    this.headline,
    this.subhead,
    this.showHero = false,
    this.showTrialTimeline = false,
    this.primaryLabel,
    this.dismissLabel,
    this.onSuccess,
    this.onDismiss,
  });

  final String triggerSource;
  final List<PaywallBenefit> benefits;
  final String? eyebrow;
  final String? headline;
  final String? subhead;
  final bool showHero;
  final bool showTrialTimeline;
  final String? primaryLabel;
  final String? dismissLabel;
  final VoidCallback? onSuccess;
  final VoidCallback? onDismiss;

  @override
  ConsumerState<PaywallBody> createState() => _PaywallBodyState();
}

class _PaywallBodyState extends ConsumerState<PaywallBody>
    with WidgetsBindingObserver {
  Package? _selected;
  bool _purchasing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref
        .read(analyticsProvider)
        .capture(
          'paywall_impression',
          properties: {'source': widget.triggerSource},
        );
    // Force-fresh entitlement on mount so the paywall reflects real
    // server state — avoids "subscribe" being shown to a user whose
    // sub just expired but whose cached customerInfo still says active.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(paywallProvider).refresh();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Returning from Play Store / App Store flow may have changed the
    // user's entitlement; refresh so the paywall reflects it.
    if (state == AppLifecycleState.resumed) {
      ref.read(paywallProvider).refresh();
    }
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
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.paywallErrorPurchaseFailed)),
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
      final l10n = AppLocalizations.of(context);
      final restored = info.entitlements.active.containsKey(proEntitlementId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            restored
                ? l10n.paywallRestoreWelcomeBack
                : l10n.paywallRestoreNoneFound,
          ),
        ),
      );
      if (restored) widget.onSuccess?.call();
    } catch (_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.paywallErrorRestoreFailed)),
      );
    }
  }

  /// Computes how much the annual plan saves vs paying monthly for a year.
  /// Returns null if either plan is missing or the math doesn't make sense.
  int? _annualSavingsPct(List<Package> packages) {
    final monthly = _firstOrNull(
      packages,
      (p) => p.packageType == PackageType.monthly,
    );
    final annual = _firstOrNull(
      packages,
      (p) => p.packageType == PackageType.annual,
    );
    if (monthly == null || annual == null) return null;
    final monthlyPrice = monthly.storeProduct.price;
    final annualPrice = annual.storeProduct.price;
    if (monthlyPrice <= 0 || annualPrice <= 0) return null;
    final yearlyAtMonthly = monthlyPrice * 12;
    if (yearlyAtMonthly <= annualPrice) return null;
    final pct = ((yearlyAtMonthly - annualPrice) / yearlyAtMonthly) * 100;
    return pct.round();
  }

  Package? _firstOrNull(List<Package> ps, bool Function(Package) test) {
    for (final p in ps) {
      if (test(p)) return p;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final offeringsAsync = ref.watch(paywallOfferingsProvider);

    final children = <Widget>[];

    if (widget.showHero) {
      children
        ..add(Center(child: const PaywallHero()))
        ..add(SizedBox(height: context.m));
    }

    if (widget.eyebrow != null) {
      children
        ..add(
          Text(
            widget.eyebrow!.toUpperCase(),
            textAlign: widget.showHero ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              fontWeight: FontWeight.w800,
              color: cs.primary,
              letterSpacing: 1.6,
            ),
          ).animate().fadeIn(delay: 1500.ms, duration: 360.ms),
        )
        ..add(SizedBox(height: context.s * 0.8));
    }

    if (widget.headline != null) {
      children
        ..add(
          Text(
                widget.headline!,
                textAlign: widget.showHero ? TextAlign.center : TextAlign.start,
                style: GoogleFonts.playfairDisplay(
                  fontSize: context.titleFont,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.1,
                  color: cs.onSurface,
                ),
              )
              .animate()
              .fadeIn(delay: 1600.ms, duration: 360.ms)
              .moveY(begin: 8, end: 0, delay: 1600.ms, duration: 360.ms),
        )
        ..add(SizedBox(height: context.s));
    }

    if (widget.subhead != null) {
      children
        ..add(
          Text(
                widget.subhead!,
                textAlign: widget.showHero ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: context.bodyFont * 0.95,
                  height: 1.4,
                  color: cs.onSurfaceVariant,
                ),
              )
              .animate()
              .fadeIn(delay: 1700.ms, duration: 360.ms)
              .moveY(begin: 6, end: 0, delay: 1700.ms, duration: 360.ms),
        )
        ..add(SizedBox(height: context.l));
    }

    // Benefits start animating after the hero finishes (~1.8s) so the
    // user reads the upgrade beat first, then takes in the value props.
    final benefitDelayBase = widget.showHero ? 1850 : 260;
    for (var i = 0; i < widget.benefits.length; i++) {
      final b = widget.benefits[i];
      final delay = benefitDelayBase + i * 90;
      children.add(
        PaywallBenefitRow(icon: b.icon, title: b.title, subtitle: b.subtitle)
            .animate()
            .fadeIn(delay: delay.ms, duration: 320.ms)
            .moveX(begin: 8, end: 0, delay: delay.ms, duration: 320.ms),
      );
    }

    if (widget.showTrialTimeline) {
      final timelineDelay = benefitDelayBase + widget.benefits.length * 90 + 80;
      children
        ..add(SizedBox(height: context.m))
        ..add(
          const PaywallTrialTimeline().animate().fadeIn(
            delay: timelineDelay.ms,
            duration: 320.ms,
          ),
        );
    }
    children.add(SizedBox(height: context.l));

    children.add(
      offeringsAsync.when(
        loading: () => Padding(
          padding: EdgeInsets.symmetric(vertical: context.l),
          child: const Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => ErrorView(
          title: l10n.paywallPlansLoadError,
          onRetry: () => ref.invalidate(paywallOfferingsProvider),
          compact: true,
          error: e,
        ),
        data: (offerings) {
          final packages =
              offerings?.current?.availablePackages ?? const <Package>[];
          if (packages.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: context.m),
              child: Text(
                l10n.paywallPlansEmpty,
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
            );
          }
          _maybePreselectAnnual(packages);
          final savingsPct = _annualSavingsPct(packages);
          final plansDelay =
              benefitDelayBase + widget.benefits.length * 90 + 60;
          return Column(
                children: [
                  for (var i = 0; i < packages.length; i++) ...[
                    if (i > 0) SizedBox(height: context.s * 1.2),
                    PaywallPlanCard(
                      package: packages[i],
                      selected: _selected?.identifier == packages[i].identifier,
                      onTap: () => setState(() => _selected = packages[i]),
                      badge: _badgeFor(packages[i], l10n),
                      savingsLabel: _savingsLabelFor(
                        packages[i],
                        savingsPct,
                        l10n,
                      ),
                    ),
                  ],
                ],
              )
              .animate()
              .fadeIn(delay: plansDelay.ms, duration: 360.ms)
              .moveY(begin: 8, end: 0, delay: plansDelay.ms, duration: 360.ms);
        },
      ),
    );
    children.add(SizedBox(height: context.m));

    final ctaDelay = benefitDelayBase + widget.benefits.length * 90 + 200;
    children.add(
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
                          (_selected == null
                              ? l10n.paywallCtaSelectPlan
                              : l10n.paywallCtaContinue),
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          )
          .animate()
          .fadeIn(delay: ctaDelay.ms, duration: 320.ms)
          .moveY(begin: 8, end: 0, delay: ctaDelay.ms, duration: 320.ms),
    );

    if (widget.dismissLabel != null) {
      children
        ..add(SizedBox(height: context.s))
        ..add(
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
        );
    }
    children
      ..add(SizedBox(height: context.xs))
      ..add(
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
              l10n.paywallCtaRestore,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      )
      ..add(SizedBox(height: context.xs))
      ..add(
        Center(
          child: Text(
            l10n.paywallFooterDisclosure,
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              color: cs.outline,
            ),
          ),
        ),
      );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  String? _badgeFor(Package p, AppLocalizations l10n) {
    switch (p.packageType) {
      case PackageType.annual:
        return l10n.paywallPlanBadgeAnnual;
      case PackageType.lifetime:
        return l10n.paywallPlanBadgeLifetime;
      default:
        return null;
    }
  }

  String? _savingsLabelFor(Package p, int? savingsPct, AppLocalizations l10n) {
    if (p.packageType == PackageType.annual && savingsPct != null) {
      return l10n.paywallPlanSavingsVsMonthly(savingsPct);
    }
    return null;
  }
}

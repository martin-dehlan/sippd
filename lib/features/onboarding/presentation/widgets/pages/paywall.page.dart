import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../../../common/services/analytics/analytics.provider.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../paywall/controller/paywall.provider.dart';
import '../../../../paywall/presentation/widgets/paywall_benefit.widget.dart';
import '../../../../paywall/presentation/widgets/paywall_plan_card.widget.dart';
import '../../../controller/onboarding.provider.dart';
import '../../../domain/archetype.dart';
import '../onboarding_page_shell.widget.dart';

/// Onboarding-flow paywall step. Built as a real onboarding page rather
/// than embedding the standalone PaywallBody — same shell chrome
/// (progress + back + step counter) and a bottom-anchored primary CTA
/// matching the position of the outer "Continue" footer on other
/// steps. Avoids the "wall" feeling: the user moves through one more
/// step instead of hitting an ad.
class OnboardingPaywallPage extends ConsumerStatefulWidget {
  const OnboardingPaywallPage({super.key, required this.onFinish});

  /// Called for both purchase-success and "Maybe later" — the paywall
  /// is the last value beat, so either path hands off to the auth flow
  /// / app shell the same way.
  final VoidCallback onFinish;

  @override
  ConsumerState<OnboardingPaywallPage> createState() =>
      _OnboardingPaywallPageState();
}

class _OnboardingPaywallPageState
    extends ConsumerState<OnboardingPaywallPage> {
  static const _benefits = <PaywallBenefit>[
    (
      icon: PhosphorIconsRegular.chartLineUp,
      title: 'Deep stats & taste insights',
      subtitle: 'Map · prices · top regions · podium.',
    ),
    (
      icon: PhosphorIconsRegular.usersThree,
      title: 'Unlimited groups & members',
      subtitle: 'Bring your whole tasting circle.',
    ),
    (
      icon: PhosphorIconsRegular.shareNetwork,
      title: 'Premium share-cards & themes',
      subtitle: 'Stand out everywhere you post.',
    ),
  ];

  Package? _selected;
  bool _purchasing = false;

  @override
  void initState() {
    super.initState();
    ref.read(analyticsProvider).capture(
      'paywall_impression',
      properties: const {'source': 'onboarding'},
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

  int? _annualSavingsPct(List<Package> packages) {
    Package? monthly;
    Package? annual;
    for (final p in packages) {
      if (p.packageType == PackageType.monthly) monthly = p;
      if (p.packageType == PackageType.annual) annual = p;
    }
    if (monthly == null || annual == null) return null;
    final m = monthly.storeProduct.price;
    final a = annual.storeProduct.price;
    if (m <= 0 || a <= 0) return null;
    final yearly = m * 12;
    if (yearly <= a) return null;
    return (((yearly - a) / yearly) * 100).round();
  }

  String? _badgeFor(Package p) => switch (p.packageType) {
        PackageType.annual => 'BEST VALUE',
        PackageType.lifetime => 'ONE-TIME',
        _ => null,
      };

  String? _savingsLabelFor(Package p, int? pct) {
    if (p.packageType == PackageType.annual && pct != null) {
      return 'Save $pct% vs monthly';
    }
    return null;
  }

  Future<void> _purchase() async {
    final pkg = _selected;
    if (pkg == null || _purchasing) return;
    setState(() => _purchasing = true);
    final analytics = ref.read(analyticsProvider);
    analytics.capture(
      'paywall_cta_tap',
      properties: {'package': pkg.identifier, 'source': 'onboarding'},
    );
    try {
      await ref.read(paywallProvider).purchasePackage(pkg);
      if (!mounted) return;
      analytics.capture(
        'paywall_purchase_success',
        properties: {'package': pkg.identifier, 'source': 'onboarding'},
      );
      widget.onFinish();
    } catch (e) {
      if (!mounted) return;
      analytics.capture(
        'paywall_purchase_failed',
        properties: {
          'package': pkg.identifier,
          'source': 'onboarding',
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final archetype = archetypeFor(answers);
    final offeringsAsync = ref.watch(paywallOfferingsProvider);

    return OnboardingPageShell(
      eyebrow: 'Sippd Pro',
      title: 'Your taste,\nbut elevated.',
      subtitle:
          'Built around the profile we just made for you — '
          'maps, leaderboards, deep stats.',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ArchetypeChip(archetype: archetype),
                  SizedBox(height: context.l),
                  for (final b in _benefits)
                    PaywallBenefitRow(
                      icon: b.icon,
                      title: b.title,
                      subtitle: b.subtitle,
                    ),
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
                      final packages = offerings?.current?.availablePackages ??
                          const <Package>[];
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
                      final pct = _annualSavingsPct(packages);
                      return Column(
                        children: [
                          for (var i = 0; i < packages.length; i++) ...[
                            if (i > 0) SizedBox(height: context.s * 1.2),
                            PaywallPlanCard(
                              package: packages[i],
                              selected: _selected?.identifier ==
                                  packages[i].identifier,
                              onTap: () =>
                                  setState(() => _selected = packages[i]),
                              badge: _badgeFor(packages[i]),
                              savingsLabel:
                                  _savingsLabelFor(packages[i], pct),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Pinned bottom — mirrors the outer Continue-button position
          // on every other onboarding step so the rhythm carries through.
          Padding(
            padding: EdgeInsets.only(top: context.s, bottom: context.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: context.h * 0.065,
                  child: FilledButton(
                    onPressed: _selected == null || _purchasing
                        ? null
                        : _purchase,
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      disabledBackgroundColor: cs.surfaceContainer,
                      disabledForegroundColor: cs.outline,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(context.w * 0.04),
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
                            _selected == null
                                ? 'Select a plan'
                                : 'Start 7-day free trial',
                            style: TextStyle(
                              fontSize: context.bodyFont * 1.05,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: context.xs),
                Center(
                  child: TextButton(
                    onPressed: _purchasing ? null : widget.onFinish,
                    child: Text(
                      'Maybe later',
                      style: TextStyle(
                        fontSize: context.bodyFont * 0.95,
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchetypeChip extends StatelessWidget {
  const _ArchetypeChip({required this.archetype});

  final TasteArchetype archetype;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.xs * 1.4,
        ),
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(context.w * 0.06),
          border: Border.all(
            color: cs.primary.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              archetype.icon,
              size: context.w * 0.045,
              color: cs.onPrimaryContainer,
            ),
            SizedBox(width: context.w * 0.02),
            Text(
              archetype.title,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w800,
                color: cs.onPrimaryContainer,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      )
          .animate()
          .fadeIn(duration: 360.ms)
          .scale(
            begin: const Offset(0.9, 0.9),
            end: const Offset(1, 1),
            duration: 360.ms,
            curve: Curves.easeOutBack,
          ),
    );
  }
}

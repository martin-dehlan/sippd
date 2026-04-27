import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import 'paywall_benefit.widget.dart';
import 'paywall_body.widget.dart';

/// Modal bottom sheet that hosts [PaywallBody] for contextual gates
/// (group limit, future feature limits). Resolves to `true` if a purchase
/// or successful restore happened, `false` if the user dismissed.
Future<bool> showPaywallSheet(
  BuildContext context, {
  required String triggerSource,
  required String headline,
  required String subhead,
  required List<PaywallBenefit> benefits,
  IconData? heroIcon,
  String primaryLabel = 'Try Pro free for 7 days',
  String dismissLabel = 'Not now',
}) async {
  final cs = Theme.of(context).colorScheme;
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: cs.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) => _PaywallSheetContent(
      triggerSource: triggerSource,
      headline: headline,
      subhead: subhead,
      benefits: benefits,
      heroIcon: heroIcon,
      primaryLabel: primaryLabel,
      dismissLabel: dismissLabel,
    ),
  );
  return result ?? false;
}

class _PaywallSheetContent extends StatelessWidget {
  const _PaywallSheetContent({
    required this.triggerSource,
    required this.headline,
    required this.subhead,
    required this.benefits,
    required this.heroIcon,
    required this.primaryLabel,
    required this.dismissLabel,
  });

  final String triggerSource;
  final String headline;
  final String subhead;
  final List<PaywallBenefit> benefits;
  final IconData? heroIcon;
  final String primaryLabel;
  final String dismissLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: context.h * 0.92),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.s,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            if (heroIcon != null) ...[
              SizedBox(height: context.l),
              Center(
                child: Container(
                  width: context.w * 0.2,
                  height: context.w * 0.2,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    shape: BoxShape.circle,
                    border: Border.all(color: cs.primary, width: 1.5),
                  ),
                  child: Icon(
                    heroIcon,
                    color: cs.primary,
                    size: context.w * 0.1,
                  ),
                ),
              ),
              SizedBox(height: context.m),
            ] else
              SizedBox(height: context.m),
            PaywallBody(
              triggerSource: triggerSource,
              headline: headline,
              subhead: subhead,
              benefits: benefits,
              primaryLabel: primaryLabel,
              dismissLabel: dismissLabel,
              onSuccess: () => Navigator.of(context).pop(true),
              onDismiss: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}

/// Convenience wrapper for the group-limit gate so callers don't have to
/// know the headline/benefits copy.
Future<bool> showGroupLimitPaywall(
  BuildContext context, {
  required int currentGroupCount,
}) {
  return showPaywallSheet(
    context,
    triggerSource: 'group_limit',
    heroIcon: PhosphorIconsRegular.usersThree,
    headline: 'Unlock unlimited groups',
    subhead:
        'You\'re on all $currentGroupCount free groups. Pro lifts the '
        'limit and adds leaderboards plus deeper insights.',
    benefits: const [
      (
        icon: PhosphorIconsRegular.usersThree,
        title: 'Unlimited groups & members',
        subtitle: 'Bring your whole tasting circle.',
      ),
      (
        icon: PhosphorIconsRegular.trophy,
        title: 'Group leaderboards',
        subtitle: 'See who rates strict, who shares your taste.',
      ),
      (
        icon: PhosphorIconsRegular.chartLineUp,
        title: 'Deep stats & taste insights',
        subtitle: 'Map · prices · top regions.',
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../paywall/presentation/widgets/paywall_body.widget.dart';

/// Onboarding-flow paywall step. Renders the same PaywallBody as the
/// standalone paywall screen (animated wine-glass hero, eyebrow,
/// Playfair headline, plan cards) so the user sees one consistent
/// upgrade pitch wherever it surfaces. The outer onboarding chrome
/// (progress bar + back arrow + step counter) replaces the X close;
/// "Maybe later" inside the body provides an explicit forward-skip
/// since the back arrow only walks the funnel backwards.
class OnboardingPaywallPage extends StatelessWidget {
  const OnboardingPaywallPage({super.key, required this.onFinish});

  /// Called for both purchase-success and "Maybe later". Either path
  /// hands off to the next onboarding step the same way.
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        context.paddingH,
        0,
        context.paddingH,
        context.l,
      ),
      child: PaywallBody(
        triggerSource: 'onboarding',
        showHero: true,
        eyebrow: 'Sippd Pro',
        headline: 'See how you\nreally taste.',
        subhead:
            'Map every bottle, leaderboard with your friends, '
            'and share cards that actually look good.',
        benefits: const [
          (
            icon: PhosphorIconsRegular.usersThree,
            title: 'Unlimited groups & members',
            subtitle: 'Bring your whole tasting circle.',
          ),
          (
            icon: PhosphorIconsRegular.chartLineUp,
            title: 'Deep stats & taste insights',
            subtitle: 'Map · prices · top regions · podium.',
          ),
          (
            icon: PhosphorIconsRegular.shareNetwork,
            title: 'Premium share-cards & themes',
            subtitle: 'Stand out everywhere you post.',
          ),
        ],
        primaryLabel: 'Start 7-day free trial',
        dismissLabel: 'Maybe later',
        onSuccess: onFinish,
        onDismiss: onFinish,
      ),
    );
  }
}

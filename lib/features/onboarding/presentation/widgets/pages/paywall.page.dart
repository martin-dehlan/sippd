import 'package:flutter/material.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../paywall/presentation/widgets/paywall_body.widget.dart';
import '../onboarding_page_shell.widget.dart';

class OnboardingPaywallPage extends StatelessWidget {
  const OnboardingPaywallPage({
    super.key,
    required this.onFinish,
  });

  /// Called for both purchase-success and "Maybe later" — onboarding has no
  /// screen left to render after this step, so either path hands off to the
  /// auth flow / app shell the same way.
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return OnboardingPageShell(
      eyebrow: 'Sippd Pro',
      title: 'Try Pro free\nfor 7 days.',
      subtitle:
          'Unlock the full picture of how you taste — or stay on Free, '
          'we\'ll never push.',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.l),
        child: PaywallBody(
          triggerSource: 'onboarding',
          benefits: const [
            'Unlimited groups & members',
            'Deep stats — prices, regions, map',
            'Premium share-cards & themes',
          ],
          showTrialTimeline: true,
          primaryLabel: 'Start 7-day free trial',
          dismissLabel: 'Maybe later',
          onSuccess: onFinish,
          onDismiss: onFinish,
        ),
      ),
    );
  }
}

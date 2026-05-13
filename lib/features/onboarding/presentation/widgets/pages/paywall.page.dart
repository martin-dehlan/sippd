import 'package:flutter/material.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../paywall/presentation/widgets/paywall_body.widget.dart';
import '../../../../paywall/presentation/widgets/paywall_pitch.dart';

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
    final l10n = AppLocalizations.of(context);
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
        eyebrow: proPitchEyebrow(l10n),
        headline: proPitchHeadline(l10n),
        subhead: proPitchSubhead(l10n),
        benefits: proPitchBenefits(l10n),
        primaryLabel: l10n.paywallCtaStartTrial,
        dismissLabel: l10n.paywallCtaMaybeLater,
        onSuccess: onFinish,
        onDismiss: onFinish,
      ),
    );
  }
}

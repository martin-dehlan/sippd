import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'paywall_benefit.widget.dart';

/// Single source of truth for the Pro pitch (eyebrow, headline, subhead,
/// benefits). Shared by the onboarding step, the stand-alone paywall
/// screen and the contextual paywall sheet so any copy change lands in
/// one place.
const String kProPitchEyebrow = 'Sippd Pro';

const String kProPitchHeadline = 'See how you\nreally taste.';

const String kProPitchSubhead =
    'Map every bottle, leaderboard with your friends, '
    'and share cards that actually look good.';

const List<PaywallBenefit> kProPitchBenefits = [
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
];

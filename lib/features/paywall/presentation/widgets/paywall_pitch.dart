import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'paywall_benefit.widget.dart';

/// Single source of truth for the Pro pitch (eyebrow, headline, subhead,
/// benefits). Shared by the onboarding step, the stand-alone paywall
/// screen and the contextual paywall sheet so any copy change lands in
/// one place.
const String kProPitchEyebrow = 'Sippd Pro';

const String kProPitchHeadline = 'See how you\nreally taste.';

const String kProPitchSubhead =
    'Map every bottle, match with friends who drink like you, '
    'and dig deeper into every tasting.';

const List<PaywallBenefit> kProPitchBenefits = [
  (
    icon: PhosphorIconsRegular.usersThree,
    title: 'Unlimited groups & friend matching',
    subtitle: 'Bring your circle. See who drinks like you.',
  ),
  (
    icon: PhosphorIconsRegular.compass,
    title: 'Taste compass & deep stats',
    subtitle: 'Your wine personality, mapped.',
  ),
  (
    icon: PhosphorIconsRegular.notepad,
    title: 'Expert tasting notes',
    subtitle: 'Nose · body · tannins · finish.',
  ),
];

import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import 'paywall_benefit.widget.dart';

/// Single source of truth for the Pro pitch (eyebrow, headline, subhead,
/// benefits). Shared by the onboarding step, the stand-alone paywall
/// screen and the contextual paywall sheet so any copy change lands in
/// one place. Localized: callers pass [AppLocalizations] from the build
/// context; we keep icons as compile-time constants but pull all user-
/// visible strings from the ARB bundles.
String proPitchEyebrow(AppLocalizations l) => l.paywallPitchEyebrow;

String proPitchHeadline(AppLocalizations l) => l.paywallPitchHeadline;

String proPitchSubhead(AppLocalizations l) => l.paywallPitchSubhead;

List<PaywallBenefit> proPitchBenefits(AppLocalizations l) => [
  (
    icon: PhosphorIconsRegular.usersThree,
    title: l.paywallBenefitFriendsTitle,
    subtitle: l.paywallBenefitFriendsSubtitle,
  ),
  (
    icon: PhosphorIconsRegular.compass,
    title: l.paywallBenefitCompassTitle,
    subtitle: l.paywallBenefitCompassSubtitle,
  ),
  (
    icon: PhosphorIconsRegular.notepad,
    title: l.paywallBenefitNotesTitle,
    subtitle: l.paywallBenefitNotesSubtitle,
  ),
];

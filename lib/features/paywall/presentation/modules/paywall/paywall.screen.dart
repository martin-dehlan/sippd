import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../widgets/paywall_body.widget.dart';
import '../../widgets/paywall_pitch.dart';

/// Stand-alone paywall screen — used for entry points that don't have a
/// natural surface to embed into (deep-links, manual upgrade taps from
/// profile, locked stats sections). Onboarding and group-limit flows host
/// [PaywallBody] inline instead of pushing this screen.
class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key, this.triggerSource});

  final String? triggerSource;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.x),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            context.paddingH,
            0,
            context.paddingH,
            context.l,
          ),
          child: PaywallBody(
            triggerSource: triggerSource ?? 'standalone',
            showHero: true,
            eyebrow: proPitchEyebrow(l10n),
            headline: proPitchHeadline(l10n),
            subhead: proPitchSubhead(l10n),
            benefits: proPitchBenefits(l10n),
            primaryLabel: l10n.paywallCtaContinue,
            onSuccess: () => Navigator.of(context).pop(true),
          ),
        ),
      ),
    );
  }
}

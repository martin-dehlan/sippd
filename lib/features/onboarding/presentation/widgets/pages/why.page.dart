import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../onboarding_page_shell.widget.dart';

class WhyPage extends StatelessWidget {
  const WhyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return OnboardingPageShell(
      eyebrow: l10n.onbWhyEyebrow,
      title: l10n.onbWhyTitle,
      child: ListView(
        padding: EdgeInsets.only(top: context.l),
        children: [
          _Principle(
            number: '01',
            icon: PhosphorIconsThin.camera,
            headline: l10n.onbWhyPrinciple1Headline,
            line: l10n.onbWhyPrinciple1Line,
          ),
          _Principle(
            number: '02',
            icon: PhosphorIconsThin.usersThree,
            headline: l10n.onbWhyPrinciple2Headline,
            line: l10n.onbWhyPrinciple2Line,
          ),
          _Principle(
            number: '03',
            icon: PhosphorIconsThin.wifiSlash,
            headline: l10n.onbWhyPrinciple3Headline,
            line: l10n.onbWhyPrinciple3Line,
          ),
        ],
      ),
    );
  }
}

class _Principle extends StatelessWidget {
  final String number;
  final IconData icon;
  final String headline;
  final String line;

  const _Principle({
    required this.number,
    required this.icon,
    required this.headline,
    required this.line,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final badgeSize = context.w * 0.13;

    return Padding(
      padding: EdgeInsets.only(bottom: context.xl * 1.1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(context.w * 0.035),
              border: Border.all(
                color: cs.outlineVariant.withValues(alpha: 0.6),
                width: 0.5,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: badgeSize * 0.55,
              color: cs.onSurface.withValues(alpha: 0.85),
            ),
          ),
          SizedBox(width: context.w * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 1.4,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                SizedBox(height: context.xs * 0.6),
                Text(
                  headline,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 0.68,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                    height: 1.1,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(height: context.xs),
                Text(
                  line,
                  style: TextStyle(
                    fontSize: context.bodyFont * 0.9,
                    height: 1.35,
                    color: cs.onSurfaceVariant,
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

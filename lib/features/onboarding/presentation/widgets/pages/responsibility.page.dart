import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../common/utils/responsive.dart';
import '../onboarding_page_shell.widget.dart';

const _helpUrl = 'https://sippd.xyz/help';

/// A note about responsible drinking shown once during onboarding.
/// Not a quiz step — just an acknowledgment with a link to help
/// resources. Required by App Store Guideline 1.4.3 for alcohol-
/// related apps and good practice regardless.
class ResponsibilityPage extends StatelessWidget {
  const ResponsibilityPage({super.key});

  Future<void> _openHelp() async {
    final uri = Uri.parse(_helpUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return OnboardingPageShell(
      eyebrow: 'A note from us',
      title: 'Drink less,\ntaste more.',
      subtitle:
          'Sippd is for remembering and rating wines you\'ve enjoyed — '
          'not pressure to drink more. We don\'t do streaks or daily '
          'quotas, on purpose.',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Quiet ringed lifebuoy — adds focal point without card weight.
            Container(
                  width: context.w * 0.18,
                  height: context.w * 0.18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: cs.outlineVariant, width: 1),
                  ),
                  child: Icon(
                    PhosphorIconsRegular.lifebuoy,
                    color: cs.primary,
                    size: context.w * 0.085,
                  ),
                )
                .animate()
                .fadeIn(duration: 360.ms)
                .scale(
                  begin: const Offset(0.85, 0.85),
                  end: const Offset(1, 1),
                  duration: 420.ms,
                  curve: Curves.easeOutBack,
                ),
            SizedBox(height: context.l),
            Text(
                  'If alcohol is hurting you or someone close,\n'
                  'free confidential help is available.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    height: 1.5,
                    color: cs.onSurfaceVariant,
                  ),
                )
                .animate()
                .fadeIn(delay: 160.ms, duration: 360.ms)
                .moveY(begin: 6, end: 0, delay: 160.ms, duration: 360.ms),
            SizedBox(height: context.m),
            TextButton(
              onPressed: _openHelp,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.m,
                  vertical: context.s,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Find help',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(width: context.xs),
                  Icon(
                    PhosphorIconsBold.arrowRight,
                    size: context.w * 0.04,
                    color: cs.primary,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 280.ms, duration: 320.ms),
          ],
        ),
      ),
    );
  }
}

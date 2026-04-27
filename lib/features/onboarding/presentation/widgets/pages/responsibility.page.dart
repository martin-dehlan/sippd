import 'package:flutter/material.dart';
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
          'Sippd is for remembering and rating wines you’ve enjoyed — '
          'not pressure to drink more. We don’t do streaks or daily '
          'quotas, on purpose.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(context.m),
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(context.w * 0.04),
              border: Border.all(color: cs.outlineVariant, width: 0.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  PhosphorIconsRegular.lifebuoy,
                  color: cs.primary,
                  size: context.w * 0.07,
                ),
                SizedBox(width: context.w * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'If alcohol is hurting you or someone close, '
                        'free confidential help is available.',
                        style: TextStyle(
                          fontSize: context.bodyFont * 0.95,
                          height: 1.4,
                          color: cs.onSurface,
                        ),
                      ),
                      SizedBox(height: context.s),
                      InkWell(
                        onTap: _openHelp,
                        borderRadius:
                            BorderRadius.circular(context.w * 0.02),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.xs,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Find help',
                                style: TextStyle(
                                  fontSize: context.bodyFont * 0.95,
                                  fontWeight: FontWeight.w800,
                                  color: cs.primary,
                                  letterSpacing: 0.2,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

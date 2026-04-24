import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/utils/responsive.dart';

class OnboardingPageShell extends StatelessWidget {
  final String? eyebrow;
  final String title;
  final String? subtitle;
  final Widget child;

  const OnboardingPageShell({
    super.key,
    this.eyebrow,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.m),
          if (eyebrow != null) ...[
            Text(
              eyebrow!.toUpperCase(),
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                fontWeight: FontWeight.w700,
                color: cs.primary,
                letterSpacing: 1.4,
              ),
            ),
            SizedBox(height: context.s),
          ],
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 1.05,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.1,
              color: cs.onSurface,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: context.s),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                height: 1.4,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
          SizedBox(height: context.l),
          Expanded(child: child),
        ],
      ),
    );
  }
}

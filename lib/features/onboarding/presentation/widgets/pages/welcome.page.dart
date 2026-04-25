import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/app_logo.widget.dart';
import '../../../../../core/routes/app.routes.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback? onTap;
  const WelcomePage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(size: context.w * 0.22),
            SizedBox(height: context.xl),
            Text(
              'Your wine\nmemory.',
              style: GoogleFonts.playfairDisplay(
                fontSize: context.titleFont * 1.6,
                fontWeight: FontWeight.w800,
                height: 1.05,
                letterSpacing: -0.8,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.m),
            Text(
              'Rate the wines you love. Remember them forever. '
              'Taste alongside friends.',
              style: TextStyle(
                fontSize: context.bodyFont * 1.05,
                height: 1.4,
                color: cs.onSurfaceVariant,
              ),
            ),
            SizedBox(height: context.l),
            Row(
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: context.w * 0.015),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.go(AppRoutes.login),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.xxl),
          ],
        ),
      ),
    );
  }
}

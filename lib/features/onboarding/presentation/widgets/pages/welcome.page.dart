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
      // Tapping anywhere outside the Sign-in button still advances the
      // funnel — preserves the original "tap to start" affordance.
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
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
          const Spacer(flex: 3),
          // "Sign in" sits as a prominent secondary action right above the
          // primary "Get started" CTA from the parent scaffold so returning
          // users can skip the funnel without scanning the body copy.
          Center(
            child: TextButton(
              onPressed: () => context.go(AppRoutes.login),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.l,
                  vertical: context.s,
                ),
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        color: cs.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: context.s),
        ],
        ),
      ),
    );
  }
}

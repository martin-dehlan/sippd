import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/l10n/generated/app_localizations.dart';

const shareCardWidth = 1080.0;
const shareCardHeight = 1920.0;
const shareCardUrl = 'sippd.xyz';

/// Tiny "SIPPD" wordmark used at the top of every share card.
class ShareCardWordmark extends StatelessWidget {
  final Color color;
  final double size;
  const ShareCardWordmark({super.key, required this.color, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return Text(
      'SIPPD',
      style: GoogleFonts.playfairDisplay(
        fontSize: size,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: -1.5,
        height: 1,
      ),
    );
  }
}

/// Footer block: thin divider + tagline. Used at the bottom of every
/// share card so the branding is consistent across templates.
class ShareCardFooter extends StatelessWidget {
  final Color textColor;
  final Color dividerColor;

  /// Optional override tagline. When null, falls back to the localized
  /// "rate yours at [url]" line.
  final String? tagline;
  const ShareCardFooter({
    super.key,
    required this.textColor,
    required this.dividerColor,
    this.tagline,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final resolvedTagline = tagline ?? l.shareFooterRateYours(shareCardUrl);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 1, color: dividerColor),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // logo_icon.png is RGBA with a transparent canvas — logo.png
                // bakes in a dark background and renders as a solid square
                // on light card variants, so use _icon here.
                Image.asset(
                  'assets/branding/logo_icon.png',
                  height: 70,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
                const SizedBox(width: 12),
                Text(
                  'SIPPD',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
              ],
            ),
            Text(
              resolvedTagline,
              style: TextStyle(
                fontSize: 28,
                color: textColor,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

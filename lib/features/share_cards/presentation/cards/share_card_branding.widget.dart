import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const shareCardWidth = 1080.0;
const shareCardHeight = 1920.0;
const shareCardUrl = 'sippd.xyz';

/// Tiny "SIPPD" wordmark used at the top of every share card.
class ShareCardWordmark extends StatelessWidget {
  final Color color;
  final double size;
  const ShareCardWordmark({
    super.key,
    required this.color,
    this.size = 56,
  });

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
  final String tagline;
  const ShareCardFooter({
    super.key,
    required this.textColor,
    required this.dividerColor,
    this.tagline = 'rate yours at $shareCardUrl',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 1, color: dividerColor),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
            Text(
              tagline,
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

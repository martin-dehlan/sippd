import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../wines/domain/entities/wine.entity.dart';
import 'share_card_branding.widget.dart';

/// 1080x1920 IG-story format share card for a single rated wine.
/// Pure typographic, theme-aligned, no gradients (per design rules).
class WineRatingCard extends StatelessWidget {
  final WineEntity wine;
  final String? username;

  const WineRatingCard({
    super.key,
    required this.wine,
    this.username,
  });

  @override
  Widget build(BuildContext context) {
    // Hardcoded brand palette so the card renders identically off-screen
    // regardless of the host theme.
    const bg = Color(0xFF14101A);
    const onBg = Color(0xFFEFE8F1);
    const onBgMuted = Color(0xFF8A7E92);
    const primary = Color(0xFF6B3A51);
    const divider = Color(0xFF2A2330);

    final origin = wine.region ?? wine.country ?? '';
    final dateLine = DateFormat('d MMM yyyy').format(wine.createdAt);
    final byLine = username == null ? null : 'by @$username';

    return Container(
      width: shareCardWidth,
      height: shareCardHeight,
      color: bg,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ShareCardWordmark(color: onBg, size: 56),
              if (byLine != null)
                Text(
                  byLine,
                  style: TextStyle(
                    fontSize: 28,
                    color: onBgMuted,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
            ],
          ),
          const Spacer(flex: 1),
          Text(
            'WINE RATED',
            style: TextStyle(
              fontSize: 26,
              color: onBgMuted,
              letterSpacing: 4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            wine.name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              fontSize: 110,
              fontWeight: FontWeight.w900,
              color: onBg,
              height: 1.05,
              letterSpacing: -2,
            ),
          ),
          if (wine.winery != null && wine.winery!.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              wine.winery!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 36,
                color: onBgMuted,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const Spacer(flex: 1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                PhosphorIconsFill.star,
                color: primary,
                size: 130,
              ),
              const SizedBox(width: 18),
              Text(
                wine.rating.toStringAsFixed(1),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 220,
                  fontWeight: FontWeight.w900,
                  color: onBg,
                  height: 1,
                  letterSpacing: -8,
                ),
              ),
              const SizedBox(width: 14),
              Padding(
                padding: const EdgeInsets.only(bottom: 36),
                child: Text(
                  '/ 10',
                  style: TextStyle(
                    fontSize: 56,
                    color: onBgMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 56),
          if (origin.isNotEmpty)
            _MetaRow(
              icon: PhosphorIconsFill.mapPin,
              label: origin,
              color: primary,
              textColor: onBg,
            ),
          if (origin.isNotEmpty) const SizedBox(height: 18),
          _MetaRow(
            icon: PhosphorIconsFill.calendarBlank,
            label: dateLine,
            color: primary,
            textColor: onBg,
          ),
          const Spacer(flex: 2),
          ShareCardFooter(textColor: onBg, dividerColor: divider),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  const _MetaRow({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: 40),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: textColor,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }
}

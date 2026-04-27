import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../wines/domain/entities/wine.entity.dart';
import 'share_card_branding.widget.dart';

const _bg = Color(0xFF14101A);
const _onBg = Color(0xFFEFE8F1);
const _onBgMuted = Color(0xFF8A7E92);
const _primary = Color(0xFF6B3A51);
const _divider = Color(0xFF2A2330);

/// 1080x1920 IG-story share card. Photo-first layout when the wine has
/// an image (full-bleed top 58%, content on a dark surface bottom 42%);
/// pure typographic fallback when there is no photo.
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
    final image = _resolveImage(wine);
    if (image != null) {
      return _PhotoLayout(
        wine: wine,
        username: username,
        image: image,
      );
    }
    return _TypographicLayout(wine: wine, username: username);
  }
}

ImageProvider? _resolveImage(WineEntity wine) {
  final local = wine.localImagePath;
  if (local != null && local.isNotEmpty) {
    final file = File(local);
    if (file.existsSync()) return FileImage(file);
  }
  final url = wine.imageUrl;
  if (url != null && url.isNotEmpty) return NetworkImage(url);
  return null;
}

class _PhotoLayout extends StatelessWidget {
  final WineEntity wine;
  final String? username;
  final ImageProvider image;

  const _PhotoLayout({
    required this.wine,
    required this.username,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final origin = wine.region ?? wine.country ?? '';
    final dateLine = DateFormat('d MMM yyyy').format(wine.createdAt);
    final byLine = username == null ? null : '@$username';

    return Container(
      width: shareCardWidth,
      height: shareCardHeight,
      color: _bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header bar — small, sits above the photo on the same dark BG.
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 70, 80, 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ShareCardWordmark(color: _onBg, size: 52),
                if (byLine != null)
                  Text(
                    byLine,
                    style: TextStyle(
                      fontSize: 28,
                      color: _onBgMuted,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
              ],
            ),
          ),
          // Photo — full bleed, fixed height, BoxFit.cover crops user photos
          // to the share-card aspect cleanly.
          SizedBox(
            height: 1020,
            width: shareCardWidth,
            child: Image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          // Content — name, rating, meta, footer.
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(80, 50, 80, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wine.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 78,
                      fontWeight: FontWeight.w900,
                      color: _onBg,
                      height: 1.05,
                      letterSpacing: -1.5,
                    ),
                  ),
                  if (wine.winery != null && wine.winery!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      wine.winery!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 32,
                        color: _onBgMuted,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),
                  _RatingPill(rating: wine.rating),
                  const Spacer(),
                  if (origin.isNotEmpty)
                    _MetaRow(
                      icon: PhosphorIconsFill.mapPin,
                      label: '$origin · $dateLine',
                    )
                  else
                    _MetaRow(
                      icon: PhosphorIconsFill.calendarBlank,
                      label: dateLine,
                    ),
                  const SizedBox(height: 36),
                  const ShareCardFooter(
                    textColor: _onBg,
                    dividerColor: _divider,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypographicLayout extends StatelessWidget {
  final WineEntity wine;
  final String? username;

  const _TypographicLayout({required this.wine, required this.username});

  @override
  Widget build(BuildContext context) {
    final origin = wine.region ?? wine.country ?? '';
    final dateLine = DateFormat('d MMM yyyy').format(wine.createdAt);
    final byLine = username == null ? null : '@$username';

    return Container(
      width: shareCardWidth,
      height: shareCardHeight,
      color: _bg,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ShareCardWordmark(color: _onBg, size: 56),
              if (byLine != null)
                Text(
                  byLine,
                  style: TextStyle(
                    fontSize: 28,
                    color: _onBgMuted,
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
              color: _onBgMuted,
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
              color: _onBg,
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
                color: _onBgMuted,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          const Spacer(flex: 1),
          _RatingPill(rating: wine.rating, big: true),
          const SizedBox(height: 56),
          if (origin.isNotEmpty)
            _MetaRow(
              icon: PhosphorIconsFill.mapPin,
              label: origin,
            ),
          if (origin.isNotEmpty) const SizedBox(height: 18),
          _MetaRow(
            icon: PhosphorIconsFill.calendarBlank,
            label: dateLine,
          ),
          const Spacer(flex: 2),
          const ShareCardFooter(textColor: _onBg, dividerColor: _divider),
        ],
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  final double rating;
  final bool big;
  const _RatingPill({required this.rating, this.big = false});

  @override
  Widget build(BuildContext context) {
    final numberSize = big ? 220.0 : 150.0;
    final iconSize = big ? 130.0 : 96.0;
    final suffixSize = big ? 56.0 : 44.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          PhosphorIconsFill.star,
          color: _primary,
          size: iconSize,
        ),
        SizedBox(width: big ? 18 : 12),
        Text(
          rating.toStringAsFixed(1),
          style: GoogleFonts.playfairDisplay(
            fontSize: numberSize,
            fontWeight: FontWeight.w900,
            color: _onBg,
            height: 1,
            letterSpacing: big ? -8 : -5,
          ),
        ),
        SizedBox(width: 14),
        Padding(
          padding: EdgeInsets.only(bottom: big ? 36 : 24),
          child: Text(
            '/ 10',
            style: TextStyle(
              fontSize: suffixSize,
              color: _onBgMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: _primary, size: 36),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: _onBg,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ],
    );
  }
}

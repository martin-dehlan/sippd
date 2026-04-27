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

/// 1080x1920 IG-story share card. Photo-led when the wine has an
/// image, typographic fallback when not.
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

String _formatRated(DateTime d) =>
    DateFormat('d MMM yyyy').format(d).toUpperCase();

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
    final origin = wine.region ?? wine.country;
    final byLine = username == null ? null : '@$username';
    final notesTeaser = _teaserFromNotes(wine.notes);

    return Container(
      width: shareCardWidth,
      height: shareCardHeight,
      color: _bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          SizedBox(
            height: 980,
            width: shareCardWidth,
            child: Image(image: image, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(80, 50, 80, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RATED · ${_formatRated(wine.createdAt)}',
                    style: TextStyle(
                      fontSize: 24,
                      color: _onBgMuted,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _NameBlock(wine: wine, maxLines: 2, fontSize: 110),
                  if (origin != null && origin.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    _OriginRow(origin: origin),
                  ],
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIconsFill.star,
                        color: _primary,
                        size: 110,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        wine.rating.toStringAsFixed(1),
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 180,
                          fontWeight: FontWeight.w900,
                          color: _onBg,
                          height: 0.95,
                          letterSpacing: -7,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Text(
                          '/ 10',
                          style: TextStyle(
                            fontSize: 50,
                            color: _onBgMuted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (notesTeaser != null) ...[
                    const SizedBox(height: 22),
                    Text(
                      '“$notesTeaser”',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 32,
                        color: _onBg,
                        fontStyle: FontStyle.italic,
                        height: 1.25,
                      ),
                    ),
                  ],
                  const Spacer(),
                  _Footer(),
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
    final origin = wine.region ?? wine.country;
    final byLine = username == null ? null : '@$username';
    final notesTeaser = _teaserFromNotes(wine.notes);

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
            'RATED · ${_formatRated(wine.createdAt)}',
            style: TextStyle(
              fontSize: 26,
              color: _onBgMuted,
              letterSpacing: 4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 22),
          _NameBlock(wine: wine, maxLines: 3, fontSize: 130),
          if (origin != null && origin.isNotEmpty) ...[
            const SizedBox(height: 22),
            _OriginRow(origin: origin),
          ],
          const Spacer(flex: 1),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                PhosphorIconsFill.star,
                color: _primary,
                size: 140,
              ),
              const SizedBox(width: 18),
              Text(
                wine.rating.toStringAsFixed(1),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 240,
                  fontWeight: FontWeight.w900,
                  color: _onBg,
                  height: 1,
                  letterSpacing: -9,
                ),
              ),
              const SizedBox(width: 14),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text(
                  '/ 10',
                  style: TextStyle(
                    fontSize: 60,
                    color: _onBgMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (notesTeaser != null) ...[
            const SizedBox(height: 36),
            Text(
              '“$notesTeaser”',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.playfairDisplay(
                fontSize: 36,
                color: _onBg,
                fontStyle: FontStyle.italic,
                height: 1.25,
              ),
            ),
          ],
          const Spacer(flex: 2),
          _Footer(),
        ],
      ),
    );
  }
}

/// Wine name (Playfair big) + winery (italic) + vintage badge if set.
class _NameBlock extends StatelessWidget {
  final WineEntity wine;
  final int maxLines;
  final double fontSize;

  const _NameBlock({
    required this.wine,
    required this.maxLines,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final showWinery = wine.winery != null &&
        wine.winery!.isNotEmpty &&
        wine.winery!.toLowerCase() != wine.name.toLowerCase();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                wine.name,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.playfairDisplay(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w900,
                  color: _onBg,
                  height: 1,
                  letterSpacing: -2,
                ),
              ),
            ),
            if (wine.vintage != null) ...[
              const SizedBox(width: 18),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  wine.vintage.toString(),
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: _onBg,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (showWinery) ...[
          const SizedBox(height: 10),
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
      ],
    );
  }
}

class _OriginRow extends StatelessWidget {
  final String origin;
  const _OriginRow({required this.origin});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(PhosphorIconsFill.mapPin, color: _primary, size: 32),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            origin,
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

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 1, color: _divider),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'SIPPD',
              style: GoogleFonts.playfairDisplay(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: _onBg,
                letterSpacing: -0.5,
                height: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: _primary,
                borderRadius: BorderRadius.circular(36),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'rate yours at sippd.xyz',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: _onBg,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    PhosphorIconsBold.arrowRight,
                    color: _onBg,
                    size: 28,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Take the first sentence (or first 90 chars) of notes for the
/// share-card teaser. Returns null when the user has no notes.
String? _teaserFromNotes(String? notes) {
  if (notes == null) return null;
  final trimmed = notes.trim();
  if (trimmed.isEmpty) return null;
  final firstSentenceEnd = trimmed.indexOf(RegExp(r'[.!?]'));
  String snippet =
      firstSentenceEnd > 20 ? trimmed.substring(0, firstSentenceEnd) : trimmed;
  if (snippet.length > 90) snippet = '${snippet.substring(0, 87)}…';
  return snippet;
}

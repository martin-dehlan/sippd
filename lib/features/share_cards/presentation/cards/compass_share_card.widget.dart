import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../taste_match/domain/entities/user_style_dna.entity.dart';
import '../../../taste_match/presentation/widgets/dna_shape.widget.dart';
import 'share_card_branding.widget.dart';

const _bg = Color(0xFF14101A);
const _onBg = Color(0xFFEFE8F1);
const _onBgMuted = Color(0xFF8A7E92);
const _divider = Color(0xFF2A2330);

/// Bundled, JSON-friendly value type for the card's render needs. Built
/// from the user's compass + DNA + archetype-match in the call site so
/// the widget itself stays presentation-pure.
class CompassShareCardData {
  final String? username;
  final String archetypeName;
  final String archetypeTagline;
  final Color archetypeColor;
  final UserStyleDna? dna;
  final int totalWines;
  final DateTime date;

  const CompassShareCardData({
    required this.username,
    required this.archetypeName,
    required this.archetypeTagline,
    required this.archetypeColor,
    required this.dna,
    required this.totalWines,
    required this.date,
  });
}

/// 1080×1920 IG-story share card celebrating the user's wine
/// personality. Editorial typographic layout — Playfair big-name +
/// large DNA shape on dark bg, matching the brand voice of
/// `WineRatingCard` and `TastingRecapCard`. Hidden behind the caller
/// when the archetype is "Curious Newcomer" (data-thin) so we don't
/// push a half-baked identity to a public IG story.
class CompassShareCard extends StatelessWidget {
  const CompassShareCard({super.key, required this.data});

  final CompassShareCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: shareCardWidth,
      height: shareCardHeight,
      color: _bg,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(date: data.date, username: data.username),
          const Spacer(flex: 1),
          _Eyebrow(color: data.archetypeColor),
          const SizedBox(height: 24),
          _ArchetypeName(name: data.archetypeName),
          const SizedBox(height: 22),
          _Tagline(tagline: data.archetypeTagline),
          const Spacer(flex: 1),
          _DnaHero(dna: data.dna, color: data.archetypeColor),
          const Spacer(flex: 1),
          _SampleSize(total: data.totalWines),
          const SizedBox(height: 36),
          const ShareCardFooter(
            textColor: _onBg,
            dividerColor: _divider,
            tagline: 'find your taste at $shareCardUrl',
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime date;
  final String? username;
  const _Header({required this.date, required this.username});

  @override
  Widget build(BuildContext context) {
    final stamp = DateFormat('d MMM yyyy').format(date).toUpperCase();
    final byLine = (username ?? '').trim().isEmpty
        ? stamp
        : '@$username · $stamp';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ShareCardWordmark(color: _onBg, size: 44),
        Flexible(
          child: Text(
            byLine,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 26,
              color: _onBgMuted,
              letterSpacing: 4,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

class _Eyebrow extends StatelessWidget {
  final Color color;
  const _Eyebrow({required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 18),
        Text(
          'WINE PERSONALITY',
          style: TextStyle(
            fontSize: 30,
            color: _onBgMuted,
            letterSpacing: 5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _ArchetypeName extends StatelessWidget {
  final String name;
  const _ArchetypeName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.playfairDisplay(
        fontSize: 130,
        fontWeight: FontWeight.w900,
        color: _onBg,
        height: 0.95,
        letterSpacing: -3,
      ),
    );
  }
}

class _Tagline extends StatelessWidget {
  final String tagline;
  const _Tagline({required this.tagline});

  @override
  Widget build(BuildContext context) {
    return Text(
      tagline,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.playfairDisplay(
        fontSize: 38,
        fontStyle: FontStyle.italic,
        color: _onBgMuted,
        height: 1.3,
      ),
    );
  }
}

class _DnaHero extends StatelessWidget {
  final UserStyleDna? dna;
  final Color color;
  const _DnaHero({required this.dna, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DnaShape(dna: dna, color: color, size: 640),
    );
  }
}

class _SampleSize extends StatelessWidget {
  final int total;
  const _SampleSize({required this.total});

  @override
  Widget build(BuildContext context) {
    final label = total == 1 ? 'based on 1 wine' : 'based on $total wines';
    return Text(
      label,
      style: TextStyle(
        fontSize: 28,
        color: _onBgMuted,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
    );
  }
}

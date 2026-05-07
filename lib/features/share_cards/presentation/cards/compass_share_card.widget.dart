import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../taste_match/domain/entities/user_style_dna.entity.dart';
import '../../../taste_match/domain/trait_descriptors.dart';
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
/// personality. Carries actual narrative weight so the artifact reads
/// as a statement, not a decorative blob: archetype name + tagline +
/// editorial top-three traits ranked by how opinionated they are. The
/// DnaShape silhouette stays as a smaller centerpiece accent.
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
          const Spacer(flex: 2),
          Center(
            child: _LabeledShape(
              dna: data.dna,
              color: data.archetypeColor,
            ),
          ),
          const Spacer(flex: 2),
          _TraitsBlock(dna: data.dna, accent: data.archetypeColor),
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

/// DnaShape with the six axis labels positioned around it at the same
/// angles the painter uses for vertices. Lean — no grid, no rings, no
/// axis lines — but viewer can immediately read each lobe of the shape
/// as Body / Tannin / etc, which is what the previous "naked blob"
/// version was missing.
class _LabeledShape extends StatelessWidget {
  final UserStyleDna? dna;
  final Color color;
  const _LabeledShape({required this.dna, required this.color});

  // Same axis order DnaShape paints, top-anchored. The painter uses
  // (2π/n)*i - π/2, so axes go: top → upper-right → lower-right →
  // bottom → lower-left → upper-left.
  static const _axes = [
    'body',
    'tannin',
    'acidity',
    'sweetness',
    'oak',
    'intensity',
  ];

  static const double _shapeSize = 380;
  static const double _labelRadius = 250;
  static const double _outerSize = 620;

  @override
  Widget build(BuildContext context) {
    final cx = _outerSize / 2;
    final cy = _outerSize / 2;
    return SizedBox(
      width: _outerSize,
      height: _outerSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: DnaShape(
              dna: dna,
              color: color,
              size: _shapeSize,
            ),
          ),
          for (var i = 0; i < _axes.length; i++)
            _axisLabel(i: i, cx: cx, cy: cy, label: traitLabel(_axes[i])),
        ],
      ),
    );
  }

  Widget _axisLabel({
    required int i,
    required double cx,
    required double cy,
    required String label,
  }) {
    final angle = (math.pi * 2 / _axes.length) * i - math.pi / 2;
    final dx = math.cos(angle) * _labelRadius;
    final dy = math.sin(angle) * _labelRadius;
    // Anchor the label box around its centre so each label sits exactly
    // on the axis tick. Box is sized generously to absorb the longest
    // copy ("SWEETNESS") at the chosen typography.
    const boxW = 220.0;
    const boxH = 60.0;
    return Positioned(
      left: cx + dx - boxW / 2,
      top: cy + dy - boxH / 2,
      width: boxW,
      height: boxH,
      child: Center(
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _onBgMuted,
            letterSpacing: 4,
            height: 1,
          ),
        ),
      ),
    );
  }
}

/// Ranked top-three trait statements — the actual "what defines me"
/// payload. Falls back silently when the user has no DNA signal yet
/// (newcomer flag is the caller's gate, but this stays defensive).
class _TraitsBlock extends StatelessWidget {
  final UserStyleDna? dna;
  final Color accent;
  const _TraitsBlock({required this.dna, required this.accent});

  @override
  Widget build(BuildContext context) {
    final ranked = rankedTraits(dna).take(3).toList(growable: false);
    if (ranked.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WHAT DEFINES ME',
          style: TextStyle(
            fontSize: 26,
            color: _onBgMuted,
            letterSpacing: 4,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 24),
        for (var i = 0; i < ranked.length; i++) ...[
          if (i > 0) const SizedBox(height: 18),
          _TraitRow(axis: ranked[i].$1, value: ranked[i].$2),
        ],
      ],
    );
  }
}

class _TraitRow extends StatelessWidget {
  final String axis;
  final double value;
  const _TraitRow({required this.axis, required this.value});

  @override
  Widget build(BuildContext context) {
    final pct = (value * 100).round();
    final descriptor = traitDescriptor(axis, value);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            '$pct%',
            style: GoogleFonts.playfairDisplay(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              color: _onBg,
              height: 1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            '${descriptor.toUpperCase()}  ·  ${traitLabel(axis).toUpperCase()}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 30,
              color: _onBg,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              height: 1.1,
            ),
          ),
        ),
      ],
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

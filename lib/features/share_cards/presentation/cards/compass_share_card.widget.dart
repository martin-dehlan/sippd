import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
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
          _Header(
            date: data.date,
            username: data.username,
            accent: data.archetypeColor,
          ),
          const Spacer(flex: 1),
          _ArchetypeName(name: data.archetypeName),
          const SizedBox(height: 22),
          _Tagline(tagline: data.archetypeTagline),
          const Spacer(flex: 2),
          Center(
            child: _LabeledShape(dna: data.dna, color: data.archetypeColor),
          ),
          const Spacer(flex: 2),
          _TraitsBlock(dna: data.dna, accent: data.archetypeColor),
          const Spacer(flex: 1),
          _SampleSize(total: data.totalWines),
          const SizedBox(height: 36),
          const _BrandedFooter(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime date;
  final String? username;
  final Color accent;
  const _Header({
    required this.date,
    required this.username,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final tag = Localizations.localeOf(context).toLanguageTag();
    final stamp = DateFormat('d MMM yyyy', tag).format(date).toUpperCase();
    final byLine = (username ?? '').trim().isEmpty
        ? stamp
        : '@$username · $stamp';
    // Top-of-card category line. The wine glyph carries the "this is a
    // wine app" tell — brand lockup (logo + SIPPD) lives in the footer
    // so the top bar reads as a contextual eyebrow rather than a
    // logo header.
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(PhosphorIconsRegular.wine, color: accent, size: 38),
            const SizedBox(width: 16),
            Text(
              l.shareCompassEyebrow,
              style: TextStyle(
                fontSize: 28,
                color: _onBgMuted,
                letterSpacing: 4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
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

/// Footer lockup — divider rule, then the brand glyph beside the
/// SIPPD wordmark on the left, tagline on the right. Custom (rather
/// than reusing ShareCardFooter) because this card moves the brand
/// mark out of the top bar; other share cards still reach for the
/// stock footer.
class _BrandedFooter extends StatelessWidget {
  const _BrandedFooter();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 1, color: _divider),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    color: _onBg,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                ),
              ],
            ),
            Text(
              l.shareFooterFindYours(shareCardUrl),
              style: TextStyle(
                fontSize: 28,
                color: _onBg,
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
    final l = AppLocalizations.of(context);
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
              // The default 1.4px stroke disappears at the export
              // resolution; bump so the silhouette reads at a glance.
              strokeWidth: 4.0,
              vertexRadius: 5.0,
            ),
          ),
          for (var i = 0; i < _axes.length; i++)
            _axisLabel(i: i, cx: cx, cy: cy, label: traitLabel(_axes[i], l)),
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
    const boxW = 260.0;
    const boxH = 64.0;
    return Positioned(
      left: cx + dx - boxW / 2,
      top: cy + dy - boxH / 2,
      width: boxW,
      height: boxH,
      child: Center(
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            // Brighter than the muted body copy — labels need to read
            // immediately even when the silhouette gets the eye first.
            color: _onBg.withValues(alpha: 0.85),
            letterSpacing: 3,
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
    final l = AppLocalizations.of(context);
    final ranked = rankedTraits(dna).take(3).toList(growable: false);
    if (ranked.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.shareCompassWhatDefinesMe,
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
          _TraitRow(rank: i + 1, axis: ranked[i].$1, value: ranked[i].$2),
        ],
      ],
    );
  }
}

class _TraitRow extends StatelessWidget {
  final int rank;
  final String axis;
  final double value;
  const _TraitRow({
    required this.rank,
    required this.axis,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final descriptor = traitDescriptor(axis, value, l);
    final phrase = l.shareCompassPhrase(
      descriptor,
      traitLabel(axis, l).toLowerCase(),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        SizedBox(
          width: 86,
          child: Text(
            rank.toString().padLeft(2, '0'),
            style: GoogleFonts.playfairDisplay(
              fontSize: 44,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400,
              color: _onBgMuted,
              height: 1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            phrase,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              fontSize: 42,
              color: _onBg,
              fontWeight: FontWeight.w700,
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
    final l = AppLocalizations.of(context);
    final label = total == 1
        ? l.shareCompassSampleSizeOne
        : l.shareCompassSampleSizeMany(total);
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

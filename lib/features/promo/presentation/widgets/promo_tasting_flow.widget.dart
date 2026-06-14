import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../../wines/presentation/widgets/wine_card.widget.dart';
import '../promo_sample_data.dart';

/// Self-driving, looping showcase of the **whole tasting lifecycle** —
/// upcoming → live → concluded — rendered true-to-app on a single
/// phone-screen canvas. Network- and Riverpod-free (everything reads
/// [PromoSampleData] / hardcoded fixtures) so it captures deterministically.
///
/// It is one *temporal* screen, not three stacked: the header, guests and
/// phase banner persist while the night moves forward. The bottom region
/// morphs lineup → ratings → recap, the banner morphs UPCOMING → LIVE →
/// CONCLUDED, and a slim phase rail at the top narrates where we are.
///
/// Drop it in the showcase and OS-screen-record or hit **Record** — it loops
/// forever, so any window of one full cycle (~18 s) is a clean clip.
class PromoTastingFlow extends StatefulWidget {
  const PromoTastingFlow({super.key, this.cycle = const Duration(seconds: 18)});

  /// One full upcoming→live→concluded loop.
  final Duration cycle;

  @override
  State<PromoTastingFlow> createState() => _PromoTastingFlowState();
}

/// The three lifecycle phases, mirroring [TastingState] with promo copy.
enum _Phase { upcoming, live, concluded }

class _PromoTastingFlowState extends State<PromoTastingFlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: widget.cycle,
  )..repeat();

  // ── Timeline marks (master t, 0..1) ────────────────────────────────
  // Kept here so the beats read top-to-bottom and stay easy to retune.
  static const _introEnd = 0.05;
  static const _guestsIn = 0.10;
  static const _lineupStart = 0.10;
  static const _lineupEnd = 0.26;
  static const _startPress = 0.30;
  static const _liveAt = 0.345; // banner flips to LIVE
  static const _rateStart = 0.37;
  static const _rateEnd = 0.58;
  static const _endPress = 0.61;
  static const _concludedAt = 0.645; // banner flips to CONCLUDED
  static const _recapStart = 0.66;
  static const _recapEnd = 0.92;

  static const _lineup = 4; // wines on the night

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  /// Eased, clamped progress of a [a]→[b] window of the master timeline.
  double _seg(double t, double a, double b,
      [Curve curve = Curves.easeOutCubic]) {
    if (b <= a) return t >= b ? 1 : 0;
    return curve.transform(((t - a) / (b - a)).clamp(0.0, 1.0));
  }

  _Phase _phaseAt(double t) => t < _liveAt
      ? _Phase.upcoming
      : t < _concludedAt
          ? _Phase.live
          : _Phase.concluded;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final wines = PromoSampleData.wines.take(_lineup).toList();
    // Recap ranking: highest rated first (the night's leaderboard).
    final ranked = [...wines]..sort((a, b) => b.rating.compareTo(a.rating));

    return AnimatedBuilder(
      animation: _c,
      builder: (context, _) {
        final t = _c.value;
        final phase = _phaseAt(t);
        final intro = _seg(t, 0, _introEnd, Curves.easeOut);

        return Opacity(
          opacity: intro,
          child: Transform.scale(
            scale: 0.97 + 0.03 * intro,
            child: SizedBox(
              width: double.infinity,
              height: context.h * 0.78,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.w * 0.07),
                child: Container(
                  color: const Color(0xFF14101A),
                  padding: EdgeInsets.fromLTRB(
                    context.w * 0.05,
                    context.l,
                    context.w * 0.05,
                    context.m,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PhaseRail(phase: phase, cs: cs),
                      SizedBox(height: context.l),
                      _Header(t: t, seg: _seg, cs: cs),
                      SizedBox(height: context.m),
                      _FlowBanner(
                        phase: phase,
                        cs: cs,
                        t: t,
                        startPress: _seg(t, _startPress - 0.04, _startPress,
                            Curves.easeInOut),
                        endPress:
                            _seg(t, _endPress - 0.04, _endPress, Curves.easeInOut),
                      ),
                      SizedBox(height: context.l),
                      _GuestsBlock(t: t, seg: _seg, cs: cs, guestsIn: _guestsIn),
                      SizedBox(height: context.l),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 520),
                          switchInCurve: Curves.easeOutCubic,
                          switchOutCurve: Curves.easeInCubic,
                          transitionBuilder: (child, anim) => FadeTransition(
                            opacity: anim,
                            child: SlideTransition(
                              position: Tween(
                                begin: const Offset(0, 0.04),
                                end: Offset.zero,
                              ).animate(anim),
                              child: child,
                            ),
                          ),
                          child: phase == _Phase.concluded
                              ? _RecapBlock(
                                  key: const ValueKey('recap'),
                                  ranked: ranked,
                                  cs: cs,
                                  reveal: _seg(t, _recapStart, _recapEnd),
                                )
                              : _LineupBlock(
                                  key: const ValueKey('lineup'),
                                  wines: wines,
                                  cs: cs,
                                  phase: phase,
                                  popT: _seg(t, _lineupStart, _lineupEnd),
                                  rateT: _seg(t, _rateStart, _rateEnd),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Phase rail — slim "upcoming · live · recap" stepper narrating the flow.
// ─────────────────────────────────────────────────────────────────────
class _PhaseRail extends StatelessWidget {
  const _PhaseRail({required this.phase, required this.cs});
  final _Phase phase;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    const steps = [
      (_Phase.upcoming, 'Upcoming'),
      (_Phase.live, 'Live'),
      (_Phase.concluded, 'Recap'),
    ];
    final activeIndex = phase.index;
    return Row(
      children: [
        for (final (i, step) in steps.indexed) ...[
          _RailDot(active: i <= activeIndex, current: i == activeIndex, cs: cs),
          SizedBox(width: context.w * 0.015),
          Text(
            step.$2.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.78,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: i == activeIndex
                  ? cs.onSurface
                  : cs.onSurface.withValues(alpha: 0.32),
            ),
          ),
          if (i < steps.length - 1)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w * 0.02),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 1.5,
                  color: i < activeIndex
                      ? cs.primary.withValues(alpha: 0.6)
                      : cs.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _RailDot extends StatelessWidget {
  const _RailDot({required this.active, required this.current, required this.cs});
  final bool active;
  final bool current;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final size = context.w * 0.02;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: current ? size * 1.4 : size,
      height: current ? size * 1.4 : size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? cs.primary : cs.outlineVariant.withValues(alpha: 0.5),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Header — title + when row (calendar / clock), true to the detail screen.
// ─────────────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  const _Header({required this.t, required this.seg, required this.cs});
  final double t;
  final double Function(double, double, double, [Curve]) seg;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final inT = seg(t, 0.02, 0.12, Curves.easeOutCubic);
    return Opacity(
      opacity: inT,
      child: Transform.translate(
        offset: Offset(0, (1 - inT) * context.s * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PIEDMONT NIGHT',
              style: GoogleFonts.playfairDisplay(
                fontSize: context.titleFont * 1.05,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                height: 1.05,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.s),
            Row(
              children: [
                Icon(PhosphorIconsRegular.calendarBlank,
                    size: context.w * 0.04, color: cs.onSurfaceVariant),
                SizedBox(width: context.xs),
                Text(
                  'Fri, May 9',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(width: context.m),
                Icon(PhosphorIconsRegular.clock,
                    size: context.w * 0.04, color: cs.onSurfaceVariant),
                SizedBox(width: context.xs),
                Text(
                  '19:30',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(width: context.m),
                Icon(PhosphorIconsRegular.mapPin,
                    size: context.w * 0.04, color: cs.onSurfaceVariant),
                SizedBox(width: context.xs),
                Text(
                  'Berlin',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w500,
                    color: cs.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Phase banner — cross-fades UPCOMING → LIVE → CONCLUDED, mirroring the
// real _PhaseBanner shell (tone, icon, CTA). The host CTA presses just
// before each transition so the morph reads as "host taps Start / End".
// ─────────────────────────────────────────────────────────────────────
class _FlowBanner extends StatelessWidget {
  const _FlowBanner({
    required this.phase,
    required this.cs,
    required this.t,
    required this.startPress,
    required this.endPress,
  });

  final _Phase phase;
  final ColorScheme cs;
  final double t;
  final double startPress;
  final double endPress;

  @override
  Widget build(BuildContext context) {
    // Live dot pulse — ~14 beats across the clip, only while LIVE.
    final blink = 0.55 + 0.45 * math.sin(t * 2 * math.pi * 14);

    final (icon, label, tone, fg, cta, ctaFilled, press) = switch (phase) {
      _Phase.upcoming => (
          PhosphorIconsRegular.calendarBlank,
          'UPCOMING',
          cs.surfaceContainerHigh,
          cs.onSurface,
          'Start tasting',
          true,
          startPress,
        ),
      _Phase.live => (
          PhosphorIconsFill.circle,
          'LIVE',
          cs.primaryContainer,
          cs.onPrimaryContainer,
          'End tasting',
          false,
          endPress,
        ),
      _Phase.concluded => (
          PhosphorIconsRegular.checkCircle,
          'CONCLUDED',
          cs.surfaceContainer,
          cs.onSurfaceVariant,
          null,
          false,
          0.0,
        ),
    };

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 420),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween(begin: 0.96, end: 1.0).animate(anim),
          child: child,
        ),
      ),
      child: Container(
        key: ValueKey(phase),
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.s * 1.2,
        ),
        decoration: BoxDecoration(
          color: tone,
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: Row(
          children: [
            Opacity(
              opacity: phase == _Phase.live ? blink : 1,
              child: Icon(icon, size: context.bodyFont * 0.95, color: fg),
            ),
            SizedBox(width: context.w * 0.02),
            Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                fontWeight: FontWeight.w800,
                color: fg,
                letterSpacing: 1.4,
              ),
            ),
            const Spacer(),
            if (cta != null)
              Transform.scale(
                // Quick press-in dip just before the phase flips.
                scale: 1 - 0.08 * math.sin(press * math.pi),
                child: _BannerCta(label: cta, filled: ctaFilled, cs: cs),
              ),
          ],
        ),
      ),
    );
  }
}

class _BannerCta extends StatelessWidget {
  const _BannerCta(
      {required this.label, required this.filled, required this.cs});
  final String label;
  final bool filled;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.s * 0.9,
      ),
      decoration: BoxDecoration(
        color: filled ? cs.primary : cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: context.captionFont,
          fontWeight: FontWeight.w700,
          color: filled ? cs.onPrimary : cs.onSurface,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Guests — overlapping avatar cluster with RSVP status dots, popping in.
// ─────────────────────────────────────────────────────────────────────
class _GuestsBlock extends StatelessWidget {
  const _GuestsBlock({
    required this.t,
    required this.seg,
    required this.cs,
    required this.guestsIn,
  });
  final double t;
  final double Function(double, double, double, [Curve]) seg;
  final ColorScheme cs;
  final double guestsIn;

  // (initial, rsvp colour) — going green, maybe amber.
  static const _guests = [
    ('L', Color(0xFF6DC383)),
    ('T', Color(0xFF6DC383)),
    ('S', Color(0xFF6DC383)),
    ('M', Color(0xFFE0A860)),
    ('A', Color(0xFF6DC383)),
    ('J', Color(0xFFE0A860)),
  ];

  @override
  Widget build(BuildContext context) {
    final size = context.w * 0.10;
    final step = size * 0.72;
    final labelT = seg(t, 0.04, 0.12);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: labelT,
          child: Text(
            'GUESTS',
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              fontWeight: FontWeight.w700,
              color: cs.onSurface.withValues(alpha: 0.72),
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(height: context.s),
        SizedBox(
          width: step * (_guests.length - 1) + size,
          height: size,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (final (i, g) in _guests.indexed)
                Positioned(
                  left: i * step,
                  child: _pop(
                    context,
                    // Stagger each avatar across the guests-in window.
                    seg(t, guestsIn * 0.4 + i * 0.012,
                        guestsIn * 0.4 + i * 0.012 + 0.06, Curves.easeOutBack),
                    _Avatar(initial: g.$1, dot: g.$2, size: size, cs: cs),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: context.s),
        Opacity(
          opacity: labelT,
          child: Text(
            '4 going · 2 maybe',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _pop(BuildContext context, double p, Widget child) => Opacity(
        opacity: p.clamp(0.0, 1.0),
        child: Transform.scale(scale: 0.6 + 0.4 * p.clamp(0.0, 1.0), child: child),
      );
}

class _Avatar extends StatelessWidget {
  const _Avatar(
      {required this.initial,
      required this.dot,
      required this.size,
      required this.cs});
  final String initial;
  final Color dot;
  final double size;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final dotSize = size * 0.32;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(color: cs.surface, shape: BoxShape.circle),
            child: Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: dot,
                shape: BoxShape.circle,
                border: Border.all(color: cs.surface, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Lineup — the wine list for upcoming + live. Cards pop in one-by-one
// while upcoming (no rating), then their rating pills count up live.
// ─────────────────────────────────────────────────────────────────────
class _LineupBlock extends StatelessWidget {
  const _LineupBlock({
    super.key,
    required this.wines,
    required this.cs,
    required this.phase,
    required this.popT,
    required this.rateT,
  });

  final List<WineEntity> wines;
  final ColorScheme cs;
  final _Phase phase;
  final double popT;
  final double rateT;

  @override
  Widget build(BuildContext context) {
    final live = phase == _Phase.live;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'WINES',
                style: TextStyle(
                  fontSize: context.captionFont * 0.95,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface.withValues(alpha: 0.72),
                  letterSpacing: 1.2,
                ),
              ),
            ),
            if (!live)
              Row(
                children: [
                  Icon(PhosphorIconsRegular.plus,
                      size: context.w * 0.04, color: cs.primary),
                  SizedBox(width: context.w * 0.01),
                  Text(
                    'Add wines',
                    style: TextStyle(
                      fontSize: context.captionFont,
                      fontWeight: FontWeight.w600,
                      color: cs.primary,
                    ),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(height: context.s),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: wines.length,
            separatorBuilder: (_, _) => SizedBox(height: context.s),
            itemBuilder: (_, i) {
              // Stagger the pop-in across the lineup window.
              final slot = i / wines.length;
              final p = ((popT - slot * 0.7) / 0.3).clamp(0.0, 1.0);
              final ease = Curves.easeOutBack.transform(p.clamp(0.0, 1.0));

              // Live: each rating counts up, staggered after the previous.
              final rStart = i * 0.18;
              final rp = ((rateT - rStart) / 0.5).clamp(0.0, 1.0);
              final rating = live
                  ? wines[i].rating * Curves.easeOutCubic.transform(rp)
                  : 0.0;

              return Opacity(
                opacity: p,
                child: Transform.translate(
                  offset: Offset(0, (1 - ease) * context.m),
                  child: WineCardWidget(
                    wine: wines[i],
                    rank: i + 1,
                    ratingOverride: rating,
                    hideRatingIfEmpty: true,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────
// Recap — concluded state. Top wine trophy card rises in, then the ranked
// leaderboard cascades with avg pills and filling bars. Share-recap CTA.
// ─────────────────────────────────────────────────────────────────────
class _RecapBlock extends StatelessWidget {
  const _RecapBlock({
    super.key,
    required this.ranked,
    required this.cs,
    required this.reveal,
  });

  final List<WineEntity> ranked;
  final ColorScheme cs;
  final double reveal;

  @override
  Widget build(BuildContext context) {
    final top = ranked.first;
    final headerT = ((reveal - 0.0) / 0.12).clamp(0.0, 1.0);
    final topCardT =
        Curves.easeOutCubic.transform(((reveal - 0.06) / 0.22).clamp(0.0, 1.0));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Opacity(
          opacity: headerT,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'RESULTS',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.72),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Icon(PhosphorIconsRegular.shareNetwork,
                  size: context.w * 0.04, color: cs.primary),
              SizedBox(width: context.w * 0.012),
              Text(
                'Share recap',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: cs.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.m),
        Opacity(
          opacity: topCardT,
          child: Transform.translate(
            offset: Offset(0, (1 - topCardT) * context.l),
            child: _TopWineCard(wine: top, cs: cs),
          ),
        ),
        SizedBox(height: context.l),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: ranked.length,
            separatorBuilder: (_, _) => Padding(
              padding: EdgeInsets.symmetric(vertical: context.xs),
              child: Divider(
                color: cs.outlineVariant.withValues(alpha: 0.6),
                height: 1,
              ),
            ),
            itemBuilder: (_, i) {
              // Rows cascade in after the top card lands.
              final start = 0.30 + i * 0.13;
              final rp = ((reveal - start) / 0.28).clamp(0.0, 1.0);
              return _RecapRow(
                rank: i + 1,
                wine: ranked[i],
                cs: cs,
                reveal: rp,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TopWineCard extends StatelessWidget {
  const _TopWineCard({required this.wine, required this.cs});
  final WineEntity wine;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    final imageSize = context.w * 0.18;
    final subtitle = [
      if (wine.winery != null) wine.winery!,
      if (wine.vintage != null) wine.vintage.toString(),
    ].join(' · ');

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.045),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: imageSize,
            height: imageSize,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    color: cs.surface.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(context.w * 0.03),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    PhosphorIconsFill.wine,
                    size: imageSize * 0.5,
                    color: cs.onPrimaryContainer.withValues(alpha: 0.55),
                  ),
                ),
                Positioned(
                  top: -context.xs * 0.8,
                  left: -context.xs * 0.8,
                  child: Container(
                    padding: EdgeInsets.all(context.xs * 0.7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.onPrimaryContainer,
                    ),
                    child: Icon(PhosphorIconsFill.trophy,
                        size: context.captionFont, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOP WINE OF THE NIGHT',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: cs.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(height: context.xs),
                Text(
                  wine.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 0.8,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: cs.onPrimaryContainer,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: context.xs * 0.6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: context.w * 0.02),
          _AvgPill(value: wine.rating, cs: cs, onPrimary: true),
        ],
      ),
    );
  }
}

class _RecapRow extends StatelessWidget {
  const _RecapRow({
    required this.rank,
    required this.wine,
    required this.cs,
    required this.reveal,
  });
  final int rank;
  final WineEntity wine;
  final ColorScheme cs;
  final double reveal;

  @override
  Widget build(BuildContext context) {
    final ease = Curves.easeOutCubic.transform(reveal);
    final barPct = (wine.rating / 10).clamp(0.0, 1.0) * ease;
    final barH = context.w * 0.02;
    return Opacity(
      opacity: ease,
      child: Transform.translate(
        offset: Offset((1 - ease) * context.w * 0.06, 0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.xs * 0.6),
          child: Row(
            children: [
              SizedBox(
                width: context.w * 0.06,
                child: Text(
                  '$rank.',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wine.name,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.xs * 0.8),
                    // Group-average fill bar, animating to the wine's score.
                    LayoutBuilder(
                      builder: (_, c) => SizedBox(
                        width: c.maxWidth,
                        height: barH,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: cs.surfaceContainer,
                                  borderRadius: BorderRadius.circular(barH / 2),
                                ),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: barPct,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: rank == 1
                                      ? cs.primary
                                      : cs.primary.withValues(alpha: 0.55),
                                  borderRadius: BorderRadius.circular(barH / 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.w * 0.03),
              _AvgPill(value: wine.rating, cs: cs, onPrimary: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvgPill extends StatelessWidget {
  const _AvgPill(
      {required this.value, required this.cs, required this.onPrimary});
  final double value;
  final ColorScheme cs;
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    final fg = onPrimary ? cs.onPrimaryContainer : cs.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.bodyFont * 1.1,
            fontWeight: FontWeight.bold,
            color: fg,
            fontFeatures: tabularFigures,
          ),
        ),
        SizedBox(width: context.w * 0.008),
        Text(
          '/ 10',
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: fg.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

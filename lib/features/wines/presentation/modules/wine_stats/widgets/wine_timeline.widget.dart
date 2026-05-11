import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../controller/wine_stats.provider.dart';
import '../../../../domain/entities/wine.entity.dart';
import '../../../widgets/wine_thumb.widget.dart';

const _maxMonths = 6;
const _maxThumbsPerMonth = 6;

/// Vertical timeline that frames the user's wine history as a diary —
/// each rated month becomes a chapter on a continuous accent rail.
/// Skips empty months to keep the narrative tight (one wine in three
/// months doesn't deserve a wall of voids).
class WineTimeline extends StatelessWidget {
  final List<TimelineMonth> months;

  const WineTimeline({super.key, required this.months});

  @override
  Widget build(BuildContext context) {
    if (months.isEmpty) {
      return _Card(
        child: Skeleton(
          child: Column(
            children: [
              for (int i = 0; i < 3; i++) ...[
                if (i > 0) SizedBox(height: context.l),
                _ChapterSkeleton(isLast: i == 2),
              ],
            ],
          ),
        ),
      );
    }

    final visible = months.take(_maxMonths).toList(growable: false);
    final hidden = months.length - visible.length;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < visible.length; i++)
            _Chapter(
              month: visible[i],
              isLast: i == visible.length - 1 && hidden == 0,
              delay: i * 90,
            ),
          if (hidden > 0) ...[
            SizedBox(height: context.s),
            _RailFootnote(
              text: hidden == 1
                  ? AppLocalizations.of(context).winesStatsTimelineEarlierOne
                  : AppLocalizations.of(
                      context,
                    ).winesStatsTimelineEarlierMany(hidden),
            ),
          ],
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.w * 0.045,
        context.w * 0.05,
        context.w * 0.045,
        context.w * 0.05,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: child,
    );
  }
}

class _Chapter extends StatelessWidget {
  final TimelineMonth month;
  final bool isLast;
  final int delay;

  const _Chapter({
    required this.month,
    required this.isLast,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dotSize = context.w * 0.035;
    final railWidth = context.w * 0.055;

    return Animate(
      effects: [
        FadeEffect(
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
        ),
        SlideEffect(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
          duration: 420.ms,
          delay: Duration(milliseconds: delay),
          curve: Curves.easeOut,
        ),
      ],
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Accent rail. Dot at the top, line stretching down to the
            // next chapter (omitted on the last row so the timeline
            // doesn't dangle into empty space).
            SizedBox(
              width: railWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: dotSize,
                    height: dotSize,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: cs.surface,
                        width: dotSize * 0.18,
                      ),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: EdgeInsets.only(top: context.xs * 0.6),
                        color: cs.outlineVariant,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: context.s),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : context.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(month: month),
                    SizedBox(height: context.s),
                    _IntensityRow(month: month),
                    SizedBox(height: context.m),
                    _ThumbStrip(wines: month.wines),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final TimelineMonth month;
  const _Header({required this.month});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final monthLabel = DateFormat('MMMM').format(month.month).toUpperCase();
    final yearLabel = DateFormat('yyyy').format(month.month);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: GoogleFonts.playfairDisplay(
                fontSize: context.headingFont * 0.95,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: -0.5,
                height: 1,
              ),
              children: [
                TextSpan(text: monthLabel),
                TextSpan(
                  text: ' $yearLabel',
                  style: TextStyle(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: context.s),
        _RatingChip(value: month.avgRating),
      ],
    );
  }
}

class _RatingChip extends StatelessWidget {
  final double value;
  const _RatingChip({required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.xs * 1.4,
        vertical: context.xs * 0.6,
      ),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(context.w * 0.025),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsFill.star,
            color: cs.primary,
            size: context.captionFont * 1.1,
          ),
          SizedBox(width: context.xs * 0.5),
          Text(
            value.toStringAsFixed(1),
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated bar that stretches based on the month's count relative to a
/// soft cap of 8 wines/month. Adds a count label so the bar is also a
/// readable stat, not just decoration.
class _IntensityRow extends StatelessWidget {
  final TimelineMonth month;
  const _IntensityRow({required this.month});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ratio = (month.count / 8).clamp(0.05, 1.0);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.w * 0.012),
            child: Stack(
              children: [
                Container(
                  height: context.w * 0.018,
                  color: cs.outlineVariant.withValues(alpha: 0.35),
                ),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: ratio),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  builder: (_, v, _) => FractionallySizedBox(
                    widthFactor: v,
                    child: Container(
                      height: context.w * 0.018,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            cs.primary,
                            cs.primary.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: context.s),
        Text(
          AppLocalizations.of(context).winesStatsTimelineWines(month.count),
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _ThumbStrip extends StatelessWidget {
  final List<WineEntity> wines;
  const _ThumbStrip({required this.wines});

  @override
  Widget build(BuildContext context) {
    final visible = wines.take(_maxThumbsPerMonth).toList(growable: false);
    final overflow = wines.length - visible.length;
    final size = context.w * 0.13;

    return SizedBox(
      height: size,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: visible.length + (overflow > 0 ? 1 : 0),
        separatorBuilder: (_, _) => SizedBox(width: context.xs * 1.2),
        itemBuilder: (_, i) {
          if (i < visible.length) {
            return _Thumb(wine: visible[i], size: size);
          }
          return _OverflowThumb(count: overflow, size: size);
        },
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final WineEntity wine;
  final double size;
  const _Thumb({required this.wine, required this.size});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${wine.name} · ${wine.rating.toStringAsFixed(1)}',
      child: WineThumb(wine: wine, size: size, radiusFactor: 0.18),
    );
  }
}

class _OverflowThumb extends StatelessWidget {
  final int count;
  final double size;
  const _OverflowThumb({required this.count, required this.size});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(size * 0.18),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Text(
        '+$count',
        style: TextStyle(
          fontSize: size * 0.28,
          fontWeight: FontWeight.w800,
          color: cs.onSurfaceVariant,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

class _RailFootnote extends StatelessWidget {
  final String text;
  const _RailFootnote({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.075),
      child: Text(
        text,
        style: TextStyle(
          fontSize: context.captionFont * 0.95,
          color: cs.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _ChapterSkeleton extends StatelessWidget {
  final bool isLast;
  const _ChapterSkeleton({required this.isLast});

  @override
  Widget build(BuildContext context) {
    final dotSize = context.w * 0.035;
    final railWidth = context.w * 0.055;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: railWidth,
            child: Column(
              children: [
                SkeletonBox.circle(size: dotSize),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: EdgeInsets.only(top: context.xs * 0.6),
                      color: Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: context.s),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SkeletonBox(
                      width: context.w * 0.35,
                      height: context.headingFont * 0.95,
                    ),
                    const Spacer(),
                    SkeletonBox(
                      width: context.w * 0.13,
                      height: context.bodyFont * 1.2,
                      radius: context.w * 0.025,
                    ),
                  ],
                ),
                SizedBox(height: context.s),
                SkeletonBox(
                  width: double.infinity,
                  height: context.w * 0.018,
                  radius: context.w * 0.012,
                ),
                SizedBox(height: context.m),
                Row(
                  children: [
                    for (int i = 0; i < 4; i++) ...[
                      if (i > 0) SizedBox(width: context.xs * 1.2),
                      SkeletonBox(
                        width: context.w * 0.13,
                        height: context.w * 0.13,
                        radius: context.w * 0.13 * 0.18,
                      ),
                    ],
                  ],
                ),
                if (!isLast) SizedBox(height: context.l),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

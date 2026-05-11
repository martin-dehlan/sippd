import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../common/widgets/skeleton.widget.dart';
import '../../../../controller/wine_stats.provider.dart';

/// Wine-rating-first hero. Headline is the user's unified average rating
/// (personal + group + tasting, deduped latest-wins per canonical) with
/// a visual meter — that's the metric that defines them as a rater on
/// a 0–10 scale. Volume splits across three context chips underneath so
/// the user sees where their ratings actually come from.
class StatsHero extends ConsumerWidget {
  const StatsHero({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localHero = ref.watch(statsHeroProvider);
    final summaryAsync = ref.watch(userRatingSummaryProvider);
    final cs = Theme.of(context).colorScheme;
    final hasLocalWines = localHero.totalWines > 0;

    return Animate(
      effects: [
        FadeEffect(duration: 420.ms),
        SlideEffect(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
          duration: 420.ms,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: Container(
        padding: EdgeInsets.fromLTRB(
          context.w * 0.05,
          context.m,
          context.w * 0.05,
          context.m,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: hasLocalWines
            ? summaryAsync.when(
                data: (summary) => _RatedContent(
                  avgRating: summary.avgRating ?? localHero.avgRating,
                  personalCount: summary.personalCount,
                  groupCount: summary.groupCount,
                  tastingCount: summary.tastingCount,
                  cs: cs,
                ),
                // Loading: pre-fill with personal sync data so the avg
                // doesn't flash to "—" between RPC fires. Group/tasting
                // counts stay hidden until the RPC lands.
                loading: () => _RatedContent(
                  avgRating: localHero.avgRating,
                  personalCount: localHero.totalWines,
                  groupCount: 0,
                  tastingCount: 0,
                  cs: cs,
                ),
                // Error: still show personal-only so the screen never
                // feels broken. RPC retries on next invalidation.
                error: (_, _) => _RatedContent(
                  avgRating: localHero.avgRating,
                  personalCount: localHero.totalWines,
                  groupCount: 0,
                  tastingCount: 0,
                  cs: cs,
                ),
              )
            : const _EmptyContent(),
      ),
    );
  }
}

class _RatedContent extends StatelessWidget {
  final double avgRating;
  final int personalCount;
  final int groupCount;
  final int tastingCount;
  final ColorScheme cs;

  const _RatedContent({
    required this.avgRating,
    required this.personalCount,
    required this.groupCount,
    required this.tastingCount,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = (avgRating / 10).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'YOUR AVG',
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                color: cs.onSurfaceVariant,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: context.s),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              PhosphorIconsFill.star,
              color: cs.primary,
              size: context.titleFont * 0.95,
            ),
            SizedBox(width: context.xs),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: avgRating),
              duration: const Duration(milliseconds: 1100),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => Text(
                v.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: context.titleFont * 1.4,
                  fontWeight: FontWeight.w900,
                  color: cs.onSurface,
                  height: 1,
                  letterSpacing: -1.5,
                ),
              ),
            ),
            SizedBox(width: context.xs),
            Padding(
              padding: EdgeInsets.only(bottom: context.xs * 0.6),
              child: Text(
                '/ 10',
                style: TextStyle(
                  fontSize: context.bodyFont * 1.05,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.s),
        ClipRRect(
          borderRadius: BorderRadius.circular(context.w * 0.012),
          child: Stack(
            children: [
              Container(
                height: context.w * 0.018,
                color: cs.outlineVariant.withValues(alpha: 0.35),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: ratio),
                duration: const Duration(milliseconds: 1100),
                curve: Curves.easeOutCubic,
                builder: (_, v, _) => FractionallySizedBox(
                  widthFactor: v,
                  child: Container(
                    height: context.w * 0.018,
                    color: cs.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.m),
        // Context chips: only render the ones with > 0 ratings so a
        // brand-new user (just personal logs) doesn't see lonely zeroes.
        _ContextChipsRow(
          personalCount: personalCount,
          groupCount: groupCount,
          tastingCount: tastingCount,
          cs: cs,
        ),
      ],
    );
  }
}

class _ContextChipsRow extends StatelessWidget {
  final int personalCount;
  final int groupCount;
  final int tastingCount;
  final ColorScheme cs;

  const _ContextChipsRow({
    required this.personalCount,
    required this.groupCount,
    required this.tastingCount,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final chips = <Widget>[
      if (personalCount > 0)
        _ContextChip(
          icon: PhosphorIconsFill.wine,
          count: personalCount,
          label: 'personal',
          cs: cs,
        ),
      if (groupCount > 0)
        _ContextChip(
          icon: PhosphorIconsFill.usersThree,
          count: groupCount,
          label: 'group',
          cs: cs,
        ),
      if (tastingCount > 0)
        _ContextChip(
          icon: PhosphorIconsFill.sparkle,
          count: tastingCount,
          label: 'tasting',
          cs: cs,
        ),
    ];
    if (chips.isEmpty) return const SizedBox.shrink();
    return Row(
      children: [
        for (var i = 0; i < chips.length; i++) ...[
          if (i > 0) SizedBox(width: context.l),
          chips[i],
        ],
      ],
    );
  }
}

class _ContextChip extends StatelessWidget {
  final IconData icon;
  final int count;
  final String label;
  final ColorScheme cs;

  const _ContextChip({
    required this.icon,
    required this.count,
    required this.label,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: cs.primary, size: context.captionFont * 1.05),
            SizedBox(width: context.xs),
            Text(
              count.toString(),
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        SizedBox(height: context.xs * 0.3),
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont * 0.9,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent();

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(
            width: context.w * 0.18,
            height: context.captionFont * 0.85,
          ),
          SizedBox(height: context.s),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SkeletonBox.circle(size: context.titleFont * 0.95),
              SizedBox(width: context.xs),
              SkeletonBox(
                width: context.w * 0.22,
                height: context.titleFont * 1.4,
                radius: 4,
              ),
              SizedBox(width: context.xs),
              Padding(
                padding: EdgeInsets.only(bottom: context.xs * 0.6),
                child: SkeletonBox(
                  width: context.w * 0.1,
                  height: context.bodyFont * 1.05,
                ),
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
              const _ChipSkeleton(),
              SizedBox(width: context.l),
              const _ChipSkeleton(),
              SizedBox(width: context.l),
              const _ChipSkeleton(),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChipSkeleton extends StatelessWidget {
  const _ChipSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SkeletonBox.circle(size: context.captionFont * 1.05),
            SizedBox(width: context.xs),
            SkeletonBox(width: context.w * 0.06, height: context.bodyFont),
          ],
        ),
        SizedBox(height: context.xs * 0.3),
        SkeletonBox(width: context.w * 0.12, height: context.captionFont * 0.9),
      ],
    );
  }
}

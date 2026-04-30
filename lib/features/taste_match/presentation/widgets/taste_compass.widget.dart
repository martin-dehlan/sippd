import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/taste_compass.entity.dart';

class TasteCompassWidget extends StatelessWidget {
  const TasteCompassWidget({
    super.key,
    required this.compass,
    required this.title,
  });

  final TasteCompassEntity compass;
  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: context.s),
          if (!compass.hasMinimumData)
            _CompassEmpty(totalCount: compass.totalCount)
          else ...[
            if (compass.topRegions.isNotEmpty) ...[
              _SectionLabel(label: 'Top regions'),
              SizedBox(height: context.xs),
              for (final b in compass.topRegions)
                _BucketRow(label: b.label, count: b.count, avg: b.avgRating),
              SizedBox(height: context.m),
            ],
            if (compass.topCountries.isNotEmpty) ...[
              _SectionLabel(label: 'Top countries'),
              SizedBox(height: context.xs),
              for (final b in compass.topCountries)
                _BucketRow(label: b.label, count: b.count, avg: b.avgRating),
              SizedBox(height: context.m),
            ],
            if (compass.typeBreakdown.isNotEmpty) ...[
              _SectionLabel(label: 'Palette'),
              SizedBox(height: context.xs),
              _PaletteRow(buckets: compass.typeBreakdown),
              SizedBox(height: context.m),
            ],
            _Footer(
              totalCount: compass.totalCount,
              overallAvg: compass.overallAvg,
            ),
          ],
        ],
      ),
    );
  }
}

class _CompassEmpty extends StatelessWidget {
  const _CompassEmpty({required this.totalCount});

  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final missing = (5 - totalCount).clamp(1, 5);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s),
      child: Row(
        children: [
          Icon(
            PhosphorIconsRegular.compass,
            color: cs.onSurfaceVariant,
            size: context.w * 0.05,
          ),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Text(
              'Rate $missing more wine${missing == 1 ? '' : 's'} to unlock the compass.',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      label,
      style: TextStyle(
        fontSize: context.captionFont * 0.85,
        fontWeight: FontWeight.w600,
        color: cs.outline,
        letterSpacing: 0.6,
      ),
    );
  }
}

class _BucketRow extends StatelessWidget {
  const _BucketRow({
    required this.label,
    required this.count,
    required this.avg,
  });

  final String label;
  final int count;
  final double avg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.xs * 0.6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                color: cs.onSurface,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '$count',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
          SizedBox(width: context.w * 0.025),
          Text(
            '${avg.toStringAsFixed(1)} ★',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaletteRow extends StatelessWidget {
  const _PaletteRow({required this.buckets});

  final List<CompassBucket> buckets;

  @override
  Widget build(BuildContext context) {
    final total = buckets.fold<int>(0, (sum, b) => sum + b.count);
    if (total == 0) return const SizedBox.shrink();

    return Wrap(
      spacing: context.w * 0.02,
      runSpacing: context.w * 0.015,
      children: [
        for (final b in buckets)
          _PalettePill(
            label: b.label,
            percent: (b.count * 100 / total).round(),
          ),
      ],
    );
  }
}

class _PalettePill extends StatelessWidget {
  const _PalettePill({required this.label, required this.percent});

  final String label;
  final int percent;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.h * 0.008,
      ),
      decoration: BoxDecoration(
        color: cs.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Text(
        '${_capitalize(label)} $percent%',
        style: TextStyle(
          fontSize: context.captionFont * 0.95,
          color: cs.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _Footer extends StatelessWidget {
  const _Footer({required this.totalCount, required this.overallAvg});

  final int totalCount;
  final double? overallAvg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(
          '$totalCount wine${totalCount == 1 ? '' : 's'}',
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
          ),
        ),
        if (overallAvg != null) ...[
          Text(
            ' · ',
            style: TextStyle(color: cs.outlineVariant),
          ),
          Text(
            '${overallAvg!.toStringAsFixed(1)} ★ avg',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

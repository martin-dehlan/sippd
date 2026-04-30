import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/taste_compass.entity.dart';
import 'compass_radar.widget.dart';

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

    // Radar axes: top regions when we have ≥3 distinct regions, fall
    // back to top countries otherwise. Below 3 axes the radar is
    // geometrically degenerate and we render nothing — the country
    // list + palette still cover the bases.
    final radarSource = compass.topRegions.length >= 3
        ? compass.topRegions
        : compass.topCountries;
    final radarAxes = radarSource
        .take(6)
        .map((b) => RadarAxisData(
              label: b.label,
              sublabel: '${b.count} · ${b.avgRating.toStringAsFixed(1)}★',
              value: b.count.toDouble(),
            ))
        .toList();
    final showRadar = radarAxes.length >= 3;

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
            if (showRadar) ...[
              SizedBox(height: context.s),
              CompassRadar(axes: radarAxes),
              SizedBox(height: context.s),
            ] else if (compass.topRegions.isNotEmpty ||
                compass.topCountries.isNotEmpty) ...[
              _CompactList(
                buckets: compass.topCountries.isNotEmpty
                    ? compass.topCountries
                    : compass.topRegions,
                heading: compass.topCountries.isNotEmpty
                    ? 'Top countries'
                    : 'Top regions',
              ),
              SizedBox(height: context.m),
            ],
            if (showRadar && compass.topCountries.isNotEmpty) ...[
              _CountryStrip(buckets: compass.topCountries),
              SizedBox(height: context.m),
            ],
            if (compass.typeBreakdown.isNotEmpty) ...[
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

class _CompactList extends StatelessWidget {
  const _CompactList({required this.buckets, required this.heading});

  final List<CompassBucket> buckets;
  final String heading;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            fontWeight: FontWeight.w600,
            color: cs.outline,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: context.xs),
        for (final b in buckets)
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.xs * 0.6),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    b.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: context.bodyFont * 0.95,
                      color: cs.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  '${b.count}',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: context.w * 0.025),
                Text(
                  '${b.avgRating.toStringAsFixed(1)} ★',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CountryStrip extends StatelessWidget {
  const _CountryStrip({required this.buckets});

  final List<CompassBucket> buckets;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      spacing: context.w * 0.02,
      runSpacing: context.w * 0.015,
      children: [
        for (final b in buckets.take(6))
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.w * 0.025,
              vertical: context.h * 0.006,
            ),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(context.w * 0.04),
              border: Border.all(color: cs.outlineVariant, width: 0.5),
            ),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: context.captionFont * 0.9,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(text: b.label),
                  TextSpan(
                    text: '  ${b.count}',
                    style: TextStyle(
                      color: cs.outline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
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

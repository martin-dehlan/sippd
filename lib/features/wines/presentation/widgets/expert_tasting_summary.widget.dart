import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../controller/expert_tasting.provider.dart';
import '../../domain/entities/expert_tasting.entity.dart';

/// Read-only display of the user's expert tasting (Pro feature) for a
/// canonical wine. Renders nothing when the wine has no canonical id, no
/// stored tasting, or the row is empty — keeps the wine detail page
/// clean for users who haven't filled it out.
///
/// Editorial layout: each WSET axis renders as a sommelier-style trio —
/// uppercase eyebrow label, descriptive word in Playfair, then a 5-dot
/// (or 3-dot) intensity track. Reads as a tasting note rather than a
/// data dashboard. Aromas land as a comma-separated bullet line, like
/// a notebook annotation. Tap anywhere on the section to edit.
class ExpertTastingSummary extends ConsumerWidget {
  const ExpertTastingSummary({
    super.key,
    required this.canonicalWineId,
    this.onEdit,
  });

  final String canonicalWineId;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTasting = ref.watch(myExpertTastingProvider(canonicalWineId));
    return asyncTasting.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (t) {
        if (t == null || t.isEmpty) return const SizedBox.shrink();
        return _Body(tasting: t, onEdit: onEdit);
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.tasting, required this.onEdit});
  final ExpertTastingEntity tasting;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final axes = <_AxisData>[
      if (tasting.body != null)
        _AxisData(
          label: 'BODY',
          value: tasting.body!,
          max: 5,
          descriptor: _bodyDescriptors[tasting.body!.clamp(1, 5)]!,
        ),
      if (tasting.tannin != null)
        _AxisData(
          label: 'TANNIN',
          value: tasting.tannin!,
          max: 5,
          descriptor: _tanninDescriptors[tasting.tannin!.clamp(1, 5)]!,
        ),
      if (tasting.acidity != null)
        _AxisData(
          label: 'ACIDITY',
          value: tasting.acidity!,
          max: 5,
          descriptor: _acidityDescriptors[tasting.acidity!.clamp(1, 5)]!,
        ),
      if (tasting.sweetness != null)
        _AxisData(
          label: 'SWEETNESS',
          value: tasting.sweetness!,
          max: 5,
          descriptor: _sweetnessDescriptors[tasting.sweetness!.clamp(1, 5)]!,
        ),
      if (tasting.oak != null)
        _AxisData(
          label: 'OAK',
          value: tasting.oak!,
          max: 5,
          descriptor: _oakDescriptors[tasting.oak!.clamp(1, 5)]!,
        ),
      if (tasting.finish != null)
        _AxisData(
          label: 'FINISH',
          value: tasting.finish!,
          max: 3,
          descriptor: _finishDescriptors[tasting.finish!.clamp(1, 3)]!,
        ),
    ];

    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH * 1.3,
          vertical: context.s,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(showAffordance: onEdit != null),
            SizedBox(height: context.m),
            if (axes.isNotEmpty) _AxesGrid(axes: axes),
            if (tasting.aromaTags.isNotEmpty) ...[
              SizedBox(height: context.m),
              Container(height: 1, color: cs.outlineVariant.withValues(alpha: 0.4)),
              SizedBox(height: context.m),
              _AromaLine(tags: tasting.aromaTags),
            ],
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.showAffordance});
  final bool showAffordance;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'TASTING NOTES',
          style: TextStyle(
            fontSize: context.captionFont * 0.95,
            fontWeight: FontWeight.w700,
            color: cs.onSurface.withValues(alpha: 0.72),
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        if (showAffordance)
          Icon(
            PhosphorIconsRegular.caretRight,
            size: context.captionFont * 1.05,
            color: cs.onSurfaceVariant.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}

class _AxesGrid extends StatelessWidget {
  const _AxesGrid({required this.axes});
  final List<_AxisData> axes;

  @override
  Widget build(BuildContext context) {
    // Two-column grid. Iterate in pairs so each row stretches its two
    // cells via IntrinsicHeight — keeps the dot tracks aligned even
    // when one descriptor wraps to two lines (e.g. "off-dry").
    final rows = <Widget>[];
    for (var i = 0; i < axes.length; i += 2) {
      final left = axes[i];
      final right = i + 1 < axes.length ? axes[i + 1] : null;
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: context.m),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _AxisCell(data: left)),
                SizedBox(width: context.w * 0.04),
                Expanded(
                  child: right == null
                      ? const SizedBox.shrink()
                      : _AxisCell(data: right),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

class _AxisCell extends StatelessWidget {
  const _AxisCell({required this.data});
  final _AxisData data;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.label,
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: context.xs * 0.6),
        Text(
          data.descriptor,
          style: GoogleFonts.playfairDisplay(
            fontSize: context.bodyFont * 1.18,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
            color: cs.onSurface,
            letterSpacing: -0.2,
            height: 1.1,
          ),
        ),
        SizedBox(height: context.xs * 1.2),
        _DotTrack(value: data.value, max: data.max),
      ],
    );
  }
}

class _DotTrack extends StatelessWidget {
  const _DotTrack({required this.value, required this.max});
  final int value;
  final int max;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.018;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(max, (i) {
        final filled = i < value;
        return Padding(
          padding: EdgeInsets.only(right: i == max - 1 ? 0 : context.w * 0.012),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled ? cs.primary : cs.outlineVariant.withValues(alpha: 0.7),
            ),
          ),
        );
      }),
    );
  }
}

class _AromaLine extends StatelessWidget {
  const _AromaLine({required this.tags});
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AROMAS',
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: context.xs * 1.2),
        Text.rich(
          TextSpan(
            children: _interleave(tags, cs).toList(),
          ),
          style: GoogleFonts.playfairDisplay(
            fontSize: context.bodyFont,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: cs.onSurface,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Iterable<TextSpan> _interleave(List<String> ts, ColorScheme cs) sync* {
    for (var i = 0; i < ts.length; i++) {
      if (i > 0) {
        yield TextSpan(
          text: '  ·  ',
          style: TextStyle(color: cs.outline, fontWeight: FontWeight.w400),
        );
      }
      yield TextSpan(text: ts[i].toLowerCase());
    }
  }
}

class _AxisData {
  const _AxisData({
    required this.label,
    required this.value,
    required this.max,
    required this.descriptor,
  });

  final String label;
  final int value;
  final int max;
  final String descriptor;
}

// Sommelier-style descriptors. Frozen 1..N maps so the cell never
// renders a raw number — the descriptor *is* the value.
const _bodyDescriptors = {
  1: 'very light',
  2: 'light',
  3: 'medium',
  4: 'full',
  5: 'heavy',
};
const _tanninDescriptors = {
  1: 'silky',
  2: 'soft',
  3: 'medium',
  4: 'firm',
  5: 'gripping',
};
const _acidityDescriptors = {
  1: 'flat',
  2: 'soft',
  3: 'balanced',
  4: 'crisp',
  5: 'sharp',
};
const _sweetnessDescriptors = {
  1: 'bone dry',
  2: 'dry',
  3: 'off-dry',
  4: 'sweet',
  5: 'lush',
};
const _oakDescriptors = {
  1: 'unoaked',
  2: 'subtle',
  3: 'present',
  4: 'oak-forward',
  5: 'heavy',
};
const _finishDescriptors = {1: 'short', 2: 'medium', 3: 'long'};

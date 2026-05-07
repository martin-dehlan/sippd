import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/responsive.dart';
import '../../controller/expert_tasting.provider.dart';
import '../../domain/entities/expert_tasting.entity.dart';

/// Read-only display of the user's expert tasting (Pro feature) for a
/// canonical wine. Renders nothing when the wine has no canonical id, no
/// stored tasting, or the row is empty — keeps the wine detail page clean
/// for users who haven't filled it out.
///
/// The bars deliberately don't ape the editor's slider chrome — bigger
/// proportional fills and labels read better at glance speed and avoid
/// signalling "tap me" on a non-interactive widget. Tap the section to
/// jump back into the rating sheet for edits.
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
    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.s,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(
                  'TASTING NOTES',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 1.6,
                  ),
                ),
                const Spacer(),
                if (onEdit != null)
                  Text(
                    'edit',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.85,
                      fontWeight: FontWeight.w600,
                      color: cs.primary,
                    ),
                  ),
              ],
            ),
            SizedBox(height: context.m),
            if (tasting.body != null)
              _Axis(label: 'Body', value: tasting.body!, max: 5),
            if (tasting.tannin != null)
              _Axis(label: 'Tannin', value: tasting.tannin!, max: 5),
            if (tasting.acidity != null)
              _Axis(label: 'Acidity', value: tasting.acidity!, max: 5),
            if (tasting.sweetness != null)
              _Axis(label: 'Sweetness', value: tasting.sweetness!, max: 5),
            if (tasting.oak != null)
              _Axis(label: 'Oak', value: tasting.oak!, max: 5),
            if (tasting.finish != null)
              _Axis(
                label: 'Finish',
                value: tasting.finish!,
                max: 3,
                lowLabel: 'short',
                highLabel: 'long',
              ),
            if (tasting.aromaTags.isNotEmpty) ...[
              SizedBox(height: context.s),
              Wrap(
                spacing: context.w * 0.02,
                runSpacing: context.h * 0.008,
                children: tasting.aromaTags.map((t) => _AromaChip(t)).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Axis extends StatelessWidget {
  const _Axis({
    required this.label,
    required this.value,
    required this.max,
    this.lowLabel,
    this.highLabel,
  });

  final String label;
  final int value;
  final int max;
  final String? lowLabel;
  final String? highLabel;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fraction = value.clamp(0, max) / max;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.h * 0.006),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.w * 0.22,
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.bodyFont * 0.95,
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: Stack(
                children: [
                  Container(height: 6, color: cs.outlineVariant),
                  FractionallySizedBox(
                    widthFactor: fraction,
                    child: Container(height: 6, color: cs.primary),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: context.w * 0.025),
          SizedBox(
            width: context.w * 0.08,
            child: Text(
              '$value/$max',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AromaChip extends StatelessWidget {
  const _AromaChip(this.tag);
  final String tag;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.025,
        vertical: context.h * 0.005,
      ),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: context.captionFont * 0.85,
          color: cs.onPrimaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

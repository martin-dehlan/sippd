import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/expert_tasting.entity.dart';
import '../../domain/entities/wine.entity.dart';
import 'expert_tasting_sheet.dart' as ets;

/// Pro chip that toggles the expert rating panel inline. For non-Pro
/// users it visually locks and the parent should route to the paywall
/// rather than expanding. Reused across the unified wine rating sheet
/// (tasting + personal) and the group rating sheet so the entry point
/// looks identical regardless of context.
class ExpertRatingChip extends StatelessWidget {
  const ExpertRatingChip({
    super.key,
    required this.isPro,
    required this.expanded,
    required this.onTap,
  });

  final bool isPro;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final filled = expanded;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.025,
          vertical: context.h * 0.006,
        ),
        decoration: BoxDecoration(
          color: filled ? cs.primary : cs.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(context.w * 0.04),
          border: Border.all(
            color: cs.primary.withValues(alpha: filled ? 0 : 0.4),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPro
                  ? (expanded
                      ? PhosphorIconsFill.caretUp
                      : PhosphorIconsFill.notebook)
                  : PhosphorIconsFill.lock,
              size: context.captionFont * 1.0,
              color: filled ? cs.onPrimary : cs.primary,
            ),
            SizedBox(width: context.xs * 0.8),
            Text(
              'Tasting notes',
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                fontWeight: FontWeight.w700,
                color: filled ? cs.onPrimary : cs.primary,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stateless WSET-style perception panel: 5×(1..5) sliders, finish pill,
/// aroma chip picker. The parent owns the [ExpertTastingEntity] state
/// and drives load + save semantics — this widget only renders. That
/// keeps the load/persist control flow localised to whichever context
/// (personal / tasting / group) actually owns the rating context.
class ExpertRatingPanel extends StatelessWidget {
  const ExpertRatingPanel({
    super.key,
    required this.loading,
    required this.wineType,
    required this.tasting,
    required this.aromasExpanded,
    required this.onTastingChange,
    required this.onToggleAromas,
  });

  final bool loading;
  final WineType wineType;
  final ExpertTastingEntity tasting;
  final bool aromasExpanded;
  final ValueChanged<ExpertTastingEntity> onTastingChange;
  final VoidCallback onToggleAromas;

  bool get _isRed => wineType == WineType.red;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: context.l),
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: context.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.xs),
            child: Container(
              height: 1,
              color: cs.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          Text(
            'WSET-style perceptions',
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              fontWeight: FontWeight.w600,
              color: cs.outline,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: context.xs),
          ets.TastingCompactRow(
            label: 'Body',
            lowLabel: 'light',
            highLabel: 'full',
            value: tasting.body,
            onChanged: (v) => onTastingChange(tasting.copyWith(body: v)),
          ),
          if (_isRed)
            ets.TastingCompactRow(
              label: 'Tannin',
              lowLabel: 'soft',
              highLabel: 'gripping',
              value: tasting.tannin,
              onChanged: (v) =>
                  onTastingChange(tasting.copyWith(tannin: v)),
            ),
          ets.TastingCompactRow(
            label: 'Acidity',
            lowLabel: 'soft',
            highLabel: 'crisp',
            value: tasting.acidity,
            onChanged: (v) =>
                onTastingChange(tasting.copyWith(acidity: v)),
          ),
          ets.TastingCompactRow(
            label: 'Sweetness',
            lowLabel: 'dry',
            highLabel: 'sweet',
            value: tasting.sweetness,
            onChanged: (v) =>
                onTastingChange(tasting.copyWith(sweetness: v)),
          ),
          ets.TastingCompactRow(
            label: 'Oak',
            lowLabel: 'unoaked',
            highLabel: 'heavy',
            value: tasting.oak,
            onChanged: (v) => onTastingChange(tasting.copyWith(oak: v)),
          ),
          SizedBox(height: context.xs),
          ets.TastingFinishRow(
            value: tasting.finish,
            onChanged: (v) => onTastingChange(tasting.copyWith(finish: v)),
          ),
          SizedBox(height: context.s),
          ets.TastingAromaSection(
            expanded: aromasExpanded,
            selected: tasting.aromaTags,
            onToggleExpand: onToggleAromas,
            onToggleTag: (tag) {
              final next = [...tasting.aromaTags];
              if (next.contains(tag)) {
                next.remove(tag);
              } else {
                next.add(tag);
              }
              onTastingChange(tasting.copyWith(aromaTags: next));
            },
          ),
        ],
      ),
    );
  }
}

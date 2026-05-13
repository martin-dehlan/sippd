import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/expert_tasting.entity.dart';
import '../../domain/entities/wine.entity.dart';
import 'expert_tasting_sheet.dart' as ets;

/// Pro chip that toggles the expert rating panel inline. Outline-only
/// when collapsed (low visual weight on dark surface), filled when
/// expanded. Locked icon for non-Pro users — parent routes to paywall.
/// Reused across the unified wine rating sheet (personal + tasting) and
/// the group rating sheet so the entry point is identical everywhere.
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
    // Three-state palette: expanded = filled primary lockup; collapsed =
    // soft primaryContainer pill (discoverable on light + dark sheets, no
    // outline-on-outline aliasing); locked (non-Pro) = neutral surface so
    // the upsell doesn't shout in the rating eyebrow.
    final Color bg;
    final Color fg;
    if (filled) {
      bg = cs.primary;
      fg = cs.onPrimary;
    } else if (isPro) {
      bg = cs.primaryContainer;
      fg = cs.onPrimaryContainer;
    } else {
      bg = cs.surfaceContainerHighest;
      fg = cs.onSurfaceVariant;
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.035,
          vertical: context.h * 0.007,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(context.w * 0.05),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPro
                  ? (expanded
                        ? PhosphorIconsFill.caretUp
                        : PhosphorIconsRegular.notebook)
                  : PhosphorIconsFill.lock,
              size: context.captionFont * 1.05,
              color: fg,
            ),
            SizedBox(width: context.xs * 1.2),
            Text(
              AppLocalizations.of(context).winesRatingChipTasting,
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                fontWeight: FontWeight.w700,
                color: fg,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shared eyebrow row — `YOUR RATING` label on the left, optional
/// [ExpertRatingChip] on the right. Single source of truth for the
/// rating-sheet header used by both the unified sheet and the group
/// sheet, so the entry surface stays identical and spacing stays in
/// sync across contexts.
class YourRatingHeader extends StatelessWidget {
  const YourRatingHeader({
    super.key,
    required this.showChip,
    required this.isPro,
    required this.expanded,
    required this.onChipTap,
  });

  final bool showChip;
  final bool isPro;
  final bool expanded;
  final VoidCallback onChipTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocalizations.of(context).winesRatingHeaderLabel,
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.6,
            ),
          ),
        ),
        if (showChip)
          ExpertRatingChip(isPro: isPro, expanded: expanded, onTap: onChipTap),
      ],
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
    final l10n = AppLocalizations.of(context);
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
            l10n.winesExpertSheetSubtitle,
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              fontWeight: FontWeight.w600,
              color: cs.outline,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: context.xs),
          ets.TastingCompactRow(
            label: l10n.winesExpertAxisBody,
            lowLabel: l10n.winesExpertBodyLow,
            highLabel: l10n.winesExpertBodyHigh,
            value: tasting.body,
            onChanged: (v) => onTastingChange(tasting.copyWith(body: v)),
          ),
          if (_isRed)
            ets.TastingCompactRow(
              label: l10n.winesExpertAxisTannin,
              lowLabel: l10n.winesExpertTanninLow,
              highLabel: l10n.winesExpertTanninHigh,
              value: tasting.tannin,
              onChanged: (v) => onTastingChange(tasting.copyWith(tannin: v)),
            ),
          ets.TastingCompactRow(
            label: l10n.winesExpertAxisAcidity,
            lowLabel: l10n.winesExpertAcidityLow,
            highLabel: l10n.winesExpertAcidityHigh,
            value: tasting.acidity,
            onChanged: (v) => onTastingChange(tasting.copyWith(acidity: v)),
          ),
          ets.TastingCompactRow(
            label: l10n.winesExpertAxisSweetness,
            lowLabel: l10n.winesExpertSweetnessLow,
            highLabel: l10n.winesExpertSweetnessHigh,
            value: tasting.sweetness,
            onChanged: (v) => onTastingChange(tasting.copyWith(sweetness: v)),
          ),
          ets.TastingCompactRow(
            label: l10n.winesExpertAxisOak,
            lowLabel: l10n.winesExpertOakLow,
            highLabel: l10n.winesExpertOakHigh,
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../paywall/controller/paywall.provider.dart';
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
    final isPro = ref.watch(isProProvider);
    return asyncTasting.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (t) {
        final hasData = t != null && !t.isEmpty;
        if (hasData) return _Body(tasting: t, onEdit: onEdit);
        // Empty + non-Pro: render an upsell preview so the value of
        // expert tasting is visible at the section level, not hidden
        // behind a tap.
        if (!isPro) return _ProLockedPreview(onTap: onEdit);
        // Empty + Pro: keep current behaviour (render nothing so the
        // wine detail stays clean for users who haven't filled it out
        // yet).
        return const SizedBox.shrink();
      },
    );
  }
}

/// Locked-state for non-Pro users. Collapsed by default — renders a
/// single-row teaser so the section doesn't dominate the rating-first
/// stack. Tapping the row expands to the full six-axis blurred
/// preview + paywall CTA. Two-step funnel: see → curious → expand →
/// unlock.
class _ProLockedPreview extends StatefulWidget {
  const _ProLockedPreview({required this.onTap});
  final VoidCallback? onTap;

  @override
  State<_ProLockedPreview> createState() => _ProLockedPreviewState();
}

class _ProLockedPreviewState extends State<_ProLockedPreview> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final axes = <String>[
      l10n.winesExpertSummaryAxisBody,
      l10n.winesExpertSummaryAxisTannin,
      l10n.winesExpertSummaryAxisAcidity,
      l10n.winesExpertSummaryAxisSweetness,
      l10n.winesExpertSummaryAxisOak,
      l10n.winesExpertSummaryAxisFinish,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH * 1.3,
        vertical: context.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Slim collapsible teaser row. Always rendered so the
          // section header stays consistent with the filled state.
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(context.w * 0.02),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.s),
              child: Row(
                children: [
                  Text(
                    l10n.winesExpertSummaryHeader,
                    style: TextStyle(
                      fontSize: context.captionFont * 0.95,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface.withValues(alpha: 0.72),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(width: context.s),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.xs * 1.4,
                      vertical: context.xs * 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: cs.primary,
                      borderRadius: BorderRadius.circular(context.w * 0.015),
                    ),
                    child: Text(
                      'PRO',
                      style: TextStyle(
                        fontSize: context.captionFont * 0.7,
                        fontWeight: FontWeight.w800,
                        color: cs.onPrimary,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _expanded
                        ? PhosphorIconsRegular.caretUp
                        : PhosphorIconsRegular.caretDown,
                    size: context.captionFont * 1.1,
                    color: cs.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: _expanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: context.s),
                      for (var i = 0; i < axes.length; i += 2)
                        Padding(
                          padding: EdgeInsets.only(bottom: context.m),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _LockedCell(label: axes[i])),
                                SizedBox(width: context.w * 0.04),
                                Expanded(
                                  child: i + 1 < axes.length
                                      ? _LockedCell(label: axes[i + 1])
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(height: context.xs),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: widget.onTap,
                          borderRadius: BorderRadius.circular(context.w * 0.02),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: context.xs,
                              horizontal: context.xs,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  PhosphorIconsRegular.lockKey,
                                  size: context.captionFont,
                                  color: cs.primary,
                                ),
                                SizedBox(width: context.xs * 1.2),
                                Text(
                                  l10n.winesExpertProUnlock,
                                  style: TextStyle(
                                    fontSize: context.captionFont,
                                    fontWeight: FontWeight.w600,
                                    color: cs.primary,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                SizedBox(width: context.xs * 0.6),
                                Icon(
                                  PhosphorIconsRegular.caretRight,
                                  size: context.captionFont,
                                  color: cs.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

class _LockedCell extends StatelessWidget {
  const _LockedCell({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: context.xs * 0.6),
        // Placeholder bar — same vertical rhythm as the descriptor
        // line in the filled state.
        Container(
          height: context.bodyFont * 1.18,
          width: context.w * 0.22,
          decoration: BoxDecoration(
            color: cs.surfaceContainer,
            borderRadius: BorderRadius.circular(context.w * 0.012),
          ),
        ),
        SizedBox(height: context.xs * 1.2),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (i) {
            return Padding(
              padding: EdgeInsets.only(right: i == 4 ? 0 : context.w * 0.012),
              child: Container(
                width: context.w * 0.018,
                height: context.w * 0.018,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.outlineVariant.withValues(alpha: 0.4),
                ),
              ),
            );
          }),
        ),
      ],
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
    final l10n = AppLocalizations.of(context);
    final body = _bodyDescriptors(l10n);
    final tannin = _tanninDescriptors(l10n);
    final acidity = _acidityDescriptors(l10n);
    final sweetness = _sweetnessDescriptors(l10n);
    final oak = _oakDescriptors(l10n);
    final finish = _finishDescriptors(l10n);
    final axes = <_AxisData>[
      _AxisData(
        label: l10n.winesExpertSummaryAxisBody,
        value: tasting.body,
        max: 5,
        descriptor: tasting.body != null
            ? body[tasting.body!.clamp(1, 5)]
            : null,
      ),
      _AxisData(
        label: l10n.winesExpertSummaryAxisTannin,
        value: tasting.tannin,
        max: 5,
        descriptor: tasting.tannin != null
            ? tannin[tasting.tannin!.clamp(1, 5)]
            : null,
      ),
      _AxisData(
        label: l10n.winesExpertSummaryAxisAcidity,
        value: tasting.acidity,
        max: 5,
        descriptor: tasting.acidity != null
            ? acidity[tasting.acidity!.clamp(1, 5)]
            : null,
      ),
      _AxisData(
        label: l10n.winesExpertSummaryAxisSweetness,
        value: tasting.sweetness,
        max: 5,
        descriptor: tasting.sweetness != null
            ? sweetness[tasting.sweetness!.clamp(1, 5)]
            : null,
      ),
      _AxisData(
        label: l10n.winesExpertSummaryAxisOak,
        value: tasting.oak,
        max: 5,
        descriptor: tasting.oak != null ? oak[tasting.oak!.clamp(1, 5)] : null,
      ),
      _AxisData(
        label: l10n.winesExpertSummaryAxisFinish,
        value: tasting.finish,
        max: 3,
        descriptor: tasting.finish != null
            ? finish[tasting.finish!.clamp(1, 3)]
            : null,
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
            _AxesGrid(axes: axes),
            if (tasting.aromaTags.isNotEmpty) ...[
              SizedBox(height: context.m),
              Container(
                height: 1,
                color: cs.outlineVariant.withValues(alpha: 0.4),
              ),
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
        Expanded(
          child: Text(
            AppLocalizations.of(context).winesExpertSummaryHeader,
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              fontWeight: FontWeight.w700,
              color: cs.onSurface.withValues(alpha: 0.72),
              letterSpacing: 1.2,
            ),
          ),
        ),
        if (showAffordance)
          Icon(
            PhosphorIconsRegular.pencilSimple,
            size: context.captionFont * 1.05,
            color: cs.onSurface.withValues(alpha: 0.72),
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
    final filled = data.value != null && data.descriptor != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          data.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            color: filled
                ? cs.onSurfaceVariant
                : cs.onSurfaceVariant.withValues(alpha: 0.55),
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: context.xs * 0.6),
        if (filled)
          Text(
            data.descriptor!,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.bodyFont * 1.18,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: cs.onSurface,
              letterSpacing: -0.2,
              height: 1.1,
            ),
          )
        else
          // Placeholder row keeps the descriptor line's vertical
          // rhythm so axes stay aligned even when some cells are
          // empty. A faint en-dash reads as "not set yet" without
          // shouting "add".
          Text(
            '—',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.bodyFont * 1.18,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: cs.onSurface.withValues(alpha: 0.25),
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
  final int? value;
  final int max;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.018;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(max, (i) {
        final filled = value != null && i < value!;
        return Padding(
          padding: EdgeInsets.only(right: i == max - 1 ? 0 : context.w * 0.012),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: filled
                  ? cs.primary
                  : cs.outlineVariant.withValues(alpha: 0.7),
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
          AppLocalizations.of(context).winesExpertSummaryAromasHeader,
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            color: cs.onSurfaceVariant,
            letterSpacing: 1.4,
          ),
        ),
        SizedBox(height: context.xs * 1.2),
        Text.rich(
          TextSpan(children: _interleave(tags, cs).toList()),
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

  /// Null value renders as an unfilled placeholder cell — same axis
  /// label and dot-track shape, but no descriptor and no lit dots.
  /// Lets the summary surface ALL six WSET axes even when the user
  /// only filled in a couple.
  final String label;
  final int? value;
  final int max;
  final String? descriptor;
}

// Sommelier-style descriptors. Helper functions so the cell never
// renders a raw number — the descriptor *is* the value. Localized via
// AppLocalizations so each locale picks the appropriate wine words.
Map<int, String> _bodyDescriptors(AppLocalizations l) => {
  1: l.winesExpertDescriptorBody1,
  2: l.winesExpertDescriptorBody2,
  3: l.winesExpertDescriptorBody3,
  4: l.winesExpertDescriptorBody4,
  5: l.winesExpertDescriptorBody5,
};
Map<int, String> _tanninDescriptors(AppLocalizations l) => {
  1: l.winesExpertDescriptorTannin1,
  2: l.winesExpertDescriptorTannin2,
  3: l.winesExpertDescriptorTannin3,
  4: l.winesExpertDescriptorTannin4,
  5: l.winesExpertDescriptorTannin5,
};
Map<int, String> _acidityDescriptors(AppLocalizations l) => {
  1: l.winesExpertDescriptorAcidity1,
  2: l.winesExpertDescriptorAcidity2,
  3: l.winesExpertDescriptorAcidity3,
  4: l.winesExpertDescriptorAcidity4,
  5: l.winesExpertDescriptorAcidity5,
};
Map<int, String> _sweetnessDescriptors(AppLocalizations l) => {
  1: l.winesExpertDescriptorSweetness1,
  2: l.winesExpertDescriptorSweetness2,
  3: l.winesExpertDescriptorSweetness3,
  4: l.winesExpertDescriptorSweetness4,
  5: l.winesExpertDescriptorSweetness5,
};
Map<int, String> _oakDescriptors(AppLocalizations l) => {
  1: l.winesExpertDescriptorOak1,
  2: l.winesExpertDescriptorOak2,
  3: l.winesExpertDescriptorOak3,
  4: l.winesExpertDescriptorOak4,
  5: l.winesExpertDescriptorOak5,
};
Map<int, String> _finishDescriptors(AppLocalizations l) => {
  1: l.winesExpertDescriptorFinish1,
  2: l.winesExpertDescriptorFinish2,
  3: l.winesExpertDescriptorFinish3,
};

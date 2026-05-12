import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../paywall/controller/paywall.provider.dart';
import '../../controller/taste_match.provider.dart';
import '../../domain/entities/taste_compass.entity.dart';
import '../../domain/entities/user_grape_share.entity.dart';
import '../../domain/entities/user_style_dna.entity.dart';
import 'archetype_headline.widget.dart';
import 'compass_modes.dart';
import 'compass_radar.widget.dart';

/// Orchestrates the four compass modes (Style / World / Grapes / DNA),
/// the count-vs-rating sub-toggle, the personality headline, and the
/// Pro lock affordance for non-Style modes.
class TasteCompassWidget extends ConsumerStatefulWidget {
  const TasteCompassWidget({
    super.key,
    required this.compass,
    required this.title,
    this.userId,
    this.allowProGated = true,
  });

  final TasteCompassEntity compass;
  final String title;
  final String? userId;

  /// When false, Pro modes (World/Grapes/DNA) are hidden — used when
  /// rendering another user's compass where we never want to show
  /// the Pro lock affordance.
  final bool allowProGated;

  @override
  ConsumerState<TasteCompassWidget> createState() => _TasteCompassWidgetState();
}

class _TasteCompassWidgetState extends ConsumerState<TasteCompassWidget> {
  CompassMode _mode = CompassMode.style;
  CompassMetric _metric = CompassMetric.count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final compass = widget.compass;
    final isPro = ref.watch(isProProvider);
    final hasMin = compass.hasMinimumData;

    // Provider data for grapes / DNA modes (only fetch when needed and
    // user id is available).
    final grapesAsync = (widget.userId != null && _mode == CompassMode.grapes)
        ? ref.watch(userTopGrapesProvider(widget.userId!))
        : null;
    final dnaAsync =
        (widget.userId != null &&
            (_mode == CompassMode.dna || _mode == CompassMode.style))
        ? ref.watch(userStyleDnaProvider(widget.userId!))
        : null;

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
            widget.title.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: context.s),
          if (!hasMin) ...[
            _CompassEmpty(totalCount: compass.totalCount),
          ] else ...[
            ArchetypeHeadline(compass: compass, dna: dnaAsync?.valueOrNull),
            SizedBox(height: context.s),
            _ModeSelector(
              selected: _mode,
              isPro: isPro,
              showLocks: widget.allowProGated,
              onSelected: (m) {
                if (m.isProGated && !isPro && widget.allowProGated) {
                  context.push(
                    AppRoutes.paywall,
                    extra: const {'source': 'compass_mode'},
                  );
                  return;
                }
                setState(() => _mode = m);
              },
            ),
            SizedBox(height: context.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _MetricToggle(
                  selected: _metric,
                  onSelected: (m) => setState(() => _metric = m),
                ),
              ],
            ),
            SizedBox(height: context.xs),
            _ModeBody(
              mode: _mode,
              metric: _metric,
              compass: compass,
              grapes: grapesAsync?.valueOrNull ?? const [],
              grapesLoading: grapesAsync?.isLoading ?? false,
              dna: dnaAsync?.valueOrNull,
              dnaLoading: dnaAsync?.isLoading ?? false,
            ),
            SizedBox(height: context.m),
            if (_mode == CompassMode.style && compass.topRegions.isNotEmpty)
              _BucketStrip(
                heading: AppLocalizations.of(context).tasteCompassTopRegions,
                buckets: compass.topRegions,
              ),
            if (_mode == CompassMode.style &&
                compass.topCountries.isNotEmpty) ...[
              SizedBox(height: context.s),
              _BucketStrip(
                heading: AppLocalizations.of(context).tasteCompassTopCountries,
                buckets: compass.topCountries,
              ),
            ],
            SizedBox(height: context.m),
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
    final l = AppLocalizations.of(context);
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
              missing == 1
                  ? l.tasteCompassEmptyPromptOne
                  : l.tasteCompassEmptyPromptMany(missing),
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

class _ModeSelector extends StatelessWidget {
  const _ModeSelector({
    required this.selected,
    required this.isPro,
    required this.showLocks,
    required this.onSelected,
  });

  final CompassMode selected;
  final bool isPro;
  final bool showLocks;
  final ValueChanged<CompassMode> onSelected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.025),
        border: Border.all(color: cs.outlineVariant, width: 0.6),
      ),
      child: Row(
        children: [
          for (final m in CompassMode.values)
            Expanded(
              child: _ModeButton(
                mode: m,
                selected: m == selected,
                locked: m.isProGated && !isPro && showLocks,
                onTap: () => onSelected(m),
              ),
            ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.mode,
    required this.selected,
    required this.locked,
    required this.onTap,
  });

  final CompassMode mode;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(vertical: context.h * 0.01),
        decoration: BoxDecoration(
          color: selected ? cs.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(context.w * 0.02),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              mode.displayName(l),
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                fontWeight: FontWeight.w700,
                color: selected
                    ? cs.onPrimary
                    : (locked ? cs.outline : cs.onSurface),
                letterSpacing: -0.1,
              ),
            ),
            if (locked) ...[
              SizedBox(width: context.xs * 0.6),
              Icon(
                PhosphorIconsFill.lock,
                size: context.captionFont * 0.85,
                color: cs.outline,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MetricToggle extends StatelessWidget {
  const _MetricToggle({required this.selected, required this.onSelected});

  final CompassMetric selected;
  final ValueChanged<CompassMetric> onSelected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final m in CompassMetric.values)
            GestureDetector(
              onTap: () => onSelected(m),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.03,
                  vertical: context.h * 0.005,
                ),
                decoration: BoxDecoration(
                  color: m == selected
                      ? cs.primary.withValues(alpha: 0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                ),
                child: Text(
                  m.displayName(AppLocalizations.of(context)),
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w600,
                    color: m == selected ? cs.primary : cs.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ModeBody extends StatelessWidget {
  const _ModeBody({
    required this.mode,
    required this.metric,
    required this.compass,
    required this.grapes,
    required this.grapesLoading,
    required this.dna,
    required this.dnaLoading,
  });

  final CompassMode mode;
  final CompassMetric metric;
  final TasteCompassEntity compass;
  final List<UserGrapeShare> grapes;
  final bool grapesLoading;
  final UserStyleDna? dna;
  final bool dnaLoading;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final axes = switch (mode) {
      CompassMode.style => buildStyleAxes(compass, metric, l),
      CompassMode.world => buildWorldAxes(compass, metric, l),
      CompassMode.grapes => buildGrapeAxes(grapes, metric, l),
      CompassMode.dna => dna == null ? <RadarAxis>[] : buildDnaAxes(dna!, l),
    };

    final loading =
        (mode == CompassMode.grapes && grapesLoading) ||
        (mode == CompassMode.dna && dnaLoading);

    if (loading) {
      return SizedBox(
        height: context.h * 0.32,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (axes.isEmpty) {
      return SizedBox(
        height: context.h * 0.32,
        child: Center(
          child: Text(
            l.tasteCompassNotEnoughData,
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
        ),
      );
    }
    if (mode == CompassMode.dna && dna != null && dna!.attributedCount < 3) {
      return SizedBox(
        height: context.h * 0.32,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.l),
            child: Text(
              l.tasteCompassDnaNeedsGrapes,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: context.captionFont,
                height: 1.4,
              ),
            ),
          ),
        ),
      );
    }

    return CompassRadar(axes: axes);
  }
}

class _BucketStrip extends StatelessWidget {
  const _BucketStrip({required this.heading, required this.buckets});

  final String heading;
  final List<CompassBucket> buckets;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading.toUpperCase(),
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            color: cs.outline,
            letterSpacing: 0.9,
          ),
        ),
        SizedBox(height: context.xs * 1.2),
        Wrap(
          spacing: context.w * 0.02,
          runSpacing: context.w * 0.018,
          children: [
            for (final b in buckets.take(6))
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.03,
                  vertical: context.h * 0.007,
                ),
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                  border: Border.all(color: cs.outlineVariant, width: 0.6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      b.label,
                      style: TextStyle(
                        fontSize: context.captionFont * 0.95,
                        color: cs.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: context.w * 0.02),
                    Text(
                      b.avgRating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: context.captionFont * 0.9,
                        color: cs.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '★',
                      style: TextStyle(
                        fontSize: context.captionFont * 0.9,
                        color: cs.primary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.totalCount, required this.overallAvg});

  final int totalCount;
  final double? overallAvg;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);
    return Row(
      children: [
        Text(
          totalCount == 1
              ? l.tasteCompassFooterWinesOne
              : l.tasteCompassFooterWinesMany(totalCount),
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
          ),
        ),
        if (overallAvg != null) ...[
          Text(' · ', style: TextStyle(color: cs.outlineVariant)),
          Text(
            l.tasteCompassFooterAvg(overallAvg!.toStringAsFixed(1)),
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

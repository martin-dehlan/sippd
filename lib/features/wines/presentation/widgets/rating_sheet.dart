import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../../paywall/controller/paywall.provider.dart';
import '../../data/data_sources/expert_tasting.api.dart';
import '../../domain/entities/expert_tasting.entity.dart';
import '../../domain/entities/wine.entity.dart';
import 'expert_tasting_sheet.dart';

/// Lean rating sheet that grows inline into expert tasting mode when
/// a Pro user taps the "Tasting notes" chip top-right. Free users are
/// routed to the paywall instead. Returns the rating value on save;
/// expert fields are persisted internally before the pop.
Future<double?> showRatingSheet({
  required BuildContext context,
  required double initial,
  WineEntity? wine,
}) {
  return showModalBottomSheet<double>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (ctx) => _RatingSheet(initial: initial, wine: wine),
  );
}

class _RatingSheet extends ConsumerStatefulWidget {
  final double initial;
  final WineEntity? wine;
  const _RatingSheet({required this.initial, this.wine});

  @override
  ConsumerState<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends ConsumerState<_RatingSheet> {
  late double _value = widget.initial;
  bool _expertExpanded = false;
  bool _expertLoading = false;
  bool _aromasExpanded = false;
  bool _saving = false;
  ExpertTastingEntity _tasting = const ExpertTastingEntity();

  bool get _isRed => widget.wine?.type == WineType.red;
  String? get _canonicalId => widget.wine?.canonicalWineId;

  Future<void> _toggleExpert() async {
    final wine = widget.wine;
    if (wine == null || _canonicalId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Save the wine first — tasting notes attach to it.'),
        ),
      );
      return;
    }
    final isPro = ref.read(isProProvider);
    if (!isPro) {
      Navigator.pop(context, _value);
      // ignore: use_build_context_synchronously
      context.push(
        AppRoutes.paywall,
        extra: const {'source': 'expert_tasting'},
      );
      return;
    }

    if (_expertExpanded) {
      setState(() => _expertExpanded = false);
      return;
    }

    setState(() {
      _expertExpanded = true;
      _expertLoading = true;
    });
    final api = ExpertTastingApi(ref.read(supabaseClientProvider));
    final existing = await api.getMine(canonicalWineId: _canonicalId!);
    if (!mounted) return;
    setState(() {
      _tasting = existing ?? const ExpertTastingEntity();
      _aromasExpanded = (existing?.aromaTags ?? const []).isNotEmpty;
      _expertLoading = false;
    });
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    HapticFeedback.lightImpact();
    if (_expertExpanded && _canonicalId != null) {
      final api = ExpertTastingApi(ref.read(supabaseClientProvider));
      try {
        await api.upsert(
          canonicalWineId: _canonicalId!,
          tasting: _tasting,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tasting save failed: $e')),
          );
        }
      }
    }
    if (mounted) Navigator.pop(context, _value);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isPro = ref.watch(isProProvider);
    final canExpert = widget.wine != null;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Handle(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingH,
                  vertical: context.s,
                ),
                child: Row(
                  children: [
                    Text(
                      'Rating',
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    if (canExpert)
                      _ProTastingChip(
                        isPro: isPro,
                        expanded: _expertExpanded,
                        onTap: _toggleExpert,
                      ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: context.paddingH),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              _value.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: context.titleFont * 1.8,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            SizedBox(width: context.w * 0.02),
                            Text(
                              '/ 10',
                              style: TextStyle(
                                fontSize: context.bodyFont,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: context.s),
                      SliderTheme(
                        data: SliderThemeData(
                          activeTrackColor: cs.primary,
                          inactiveTrackColor: cs.outlineVariant,
                          thumbColor: cs.primary,
                          overlayColor:
                              cs.primary.withValues(alpha: 0.12),
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 10),
                        ),
                        child: Slider(
                          value: _value,
                          min: 0,
                          max: 10,
                          divisions: 20,
                          onChanged: (v) => setState(() => _value = v),
                        ),
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        alignment: Alignment.topCenter,
                        child: _expertExpanded
                            ? _ExpertBody(
                                loading: _expertLoading,
                                isRed: _isRed,
                                tasting: _tasting,
                                aromasExpanded: _aromasExpanded,
                                onTastingChange: (t) =>
                                    setState(() => _tasting = t),
                                onToggleAromas: () => setState(
                                    () => _aromasExpanded = !_aromasExpanded),
                              )
                            : const SizedBox(width: double.infinity),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.paddingH,
                  context.s,
                  context.paddingH,
                  context.s,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: context.h * 0.055,
                  child: FilledButton(
                    onPressed: _saving ? null : _save,
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.w * 0.03),
                      ),
                    ),
                    child: _saving
                        ? SizedBox(
                            width: context.w * 0.05,
                            height: context.w * 0.05,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: cs.onPrimary,
                            ),
                          )
                        : Text(
                            'Save',
                            style: TextStyle(
                              fontSize: context.bodyFont,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Handle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(top: context.m, bottom: context.xs),
      child: Center(
        child: Container(
          width: context.w * 0.1,
          height: 4,
          decoration: BoxDecoration(
            color: cs.outlineVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}

class _ProTastingChip extends StatelessWidget {
  const _ProTastingChip({
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
          color: filled
              ? cs.primary
              : cs.primary.withValues(alpha: 0.12),
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

class _ExpertBody extends StatelessWidget {
  const _ExpertBody({
    required this.loading,
    required this.isRed,
    required this.tasting,
    required this.aromasExpanded,
    required this.onTastingChange,
    required this.onToggleAromas,
  });

  final bool loading;
  final bool isRed;
  final ExpertTastingEntity tasting;
  final bool aromasExpanded;
  final ValueChanged<ExpertTastingEntity> onTastingChange;
  final VoidCallback onToggleAromas;

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
          TastingCompactRow(
            label: 'Body',
            lowLabel: 'light',
            highLabel: 'full',
            value: tasting.body,
            onChanged: (v) => onTastingChange(tasting.copyWith(body: v)),
          ),
          if (isRed)
            TastingCompactRow(
              label: 'Tannin',
              lowLabel: 'soft',
              highLabel: 'gripping',
              value: tasting.tannin,
              onChanged: (v) => onTastingChange(tasting.copyWith(tannin: v)),
            ),
          TastingCompactRow(
            label: 'Acidity',
            lowLabel: 'soft',
            highLabel: 'crisp',
            value: tasting.acidity,
            onChanged: (v) => onTastingChange(tasting.copyWith(acidity: v)),
          ),
          TastingCompactRow(
            label: 'Sweetness',
            lowLabel: 'dry',
            highLabel: 'sweet',
            value: tasting.sweetness,
            onChanged: (v) => onTastingChange(tasting.copyWith(sweetness: v)),
          ),
          TastingCompactRow(
            label: 'Oak',
            lowLabel: 'unoaked',
            highLabel: 'heavy',
            value: tasting.oak,
            onChanged: (v) => onTastingChange(tasting.copyWith(oak: v)),
          ),
          SizedBox(height: context.xs),
          TastingFinishRow(
            value: tasting.finish,
            onChanged: (v) => onTastingChange(tasting.copyWith(finish: v)),
          ),
          SizedBox(height: context.s),
          TastingAromaSection(
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

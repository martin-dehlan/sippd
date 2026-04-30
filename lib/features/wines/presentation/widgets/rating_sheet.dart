import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../paywall/controller/paywall.provider.dart';
import '../../domain/entities/wine.entity.dart';
import 'expert_tasting_sheet.dart';

/// Result of dismissing the rating sheet via Save. The Pro toggle and
/// expert tasting fields persist in their own sheet, so this still
/// only carries the headline rating value.
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

  Future<void> _openExpert() async {
    final wine = widget.wine;
    if (wine == null || wine.canonicalWineId == null) {
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
    // Persist the current rating, then open the expert sheet on top.
    Navigator.pop(context, _value);
    if (!mounted) return;
    // ignore: use_build_context_synchronously
    await showExpertTastingSheet(context: context, wine: wine);
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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: context.paddingH, vertical: context.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: context.w * 0.1,
                  height: 4,
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: context.m),
              Row(
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
                      onTap: _openExpert,
                    ),
                ],
              ),
              SizedBox(height: context.m),
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
              SizedBox(height: context.m),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: cs.primary,
                  inactiveTrackColor: cs.outlineVariant,
                  thumbColor: cs.primary,
                  overlayColor: cs.primary.withValues(alpha: 0.12),
                  trackHeight: 4,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 10),
                ),
                child: Slider(
                  value: _value,
                  min: 0,
                  max: 10,
                  divisions: 20,
                  onChanged: (v) => setState(() => _value = v),
                ),
              ),
              SizedBox(height: context.l),
              SizedBox(
                width: double.infinity,
                height: context.h * 0.055,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, _value),
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.s),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProTastingChip extends StatelessWidget {
  const _ProTastingChip({required this.isPro, required this.onTap});

  final bool isPro;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.025,
          vertical: context.h * 0.006,
        ),
        decoration: BoxDecoration(
          color: cs.primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(context.w * 0.04),
          border: Border.all(
            color: cs.primary.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPro
                  ? PhosphorIconsFill.notebook
                  : PhosphorIconsFill.lock,
              size: context.captionFont * 1.0,
              color: cs.primary,
            ),
            SizedBox(width: context.xs * 0.8),
            Text(
              'Tasting notes',
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                fontWeight: FontWeight.w700,
                color: cs.primary,
                letterSpacing: -0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

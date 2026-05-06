import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/utils/responsive.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../controller/tastings.provider.dart';

/// Bottom sheet that lets an attendee submit (or update) their rating
/// for a wine inside a tasting flight. Slider matches the app-wide 0–10
/// scale (0.5 steps), prefilled with the user's existing rating if one
/// exists. On save the rating writes to `tasting_ratings` and the
/// lineup card refreshes via the invalidated providers.
Future<void> showTastingRateSheet({
  required BuildContext context,
  required String tastingId,
  required WineEntity wine,
}) {
  final cs = Theme.of(context).colorScheme;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: cs.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.06)),
    ),
    builder: (ctx) => _TastingRateSheet(
      tastingId: tastingId,
      wine: wine,
    ),
  );
}

class _TastingRateSheet extends ConsumerStatefulWidget {
  const _TastingRateSheet({required this.tastingId, required this.wine});

  final String tastingId;
  final WineEntity wine;

  @override
  ConsumerState<_TastingRateSheet> createState() => _TastingRateSheetState();
}

class _TastingRateSheetState extends ConsumerState<_TastingRateSheet> {
  double _rating = 7.0;
  bool _initialised = false;
  bool _saving = false;

  String get _canonicalId => widget.wine.canonicalWineId ?? widget.wine.id;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final priorAsync = ref.watch(
      myTastingRatingProvider(widget.tastingId, _canonicalId),
    );

    if (!_initialised) {
      priorAsync.whenData((value) {
        if (value != null && value != _rating) {
          _rating = value.clamp(0.0, 10.0);
        }
        _initialised = true;
      });
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH,
        vertical: context.m,
      ),
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
          SizedBox(height: context.l),
          Text(
            'YOUR RATING',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w800,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.4,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            widget.wine.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 0.9,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
              height: 1.1,
              color: cs.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.xl),
          _RatingHero(value: _rating, cs: cs),
          SizedBox(height: context.l),
          _Slider(
            value: _rating,
            onChanged: (v) => setState(() => _rating = v),
          ),
          SizedBox(height: context.xl),
          SizedBox(
            height: context.h * 0.065,
            child: FilledButton(
              onPressed: _saving ? null : _save,
              style: FilledButton.styleFrom(
                elevation: 0,
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.045),
                ),
              ),
              child: _saving
                  ? SizedBox(
                      width: context.w * 0.045,
                      height: context.w * 0.045,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: cs.onPrimary,
                      ),
                    )
                  : Text(
                      'Save rating',
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          SizedBox(height: context.s),
          Center(
            child: TextButton(
              onPressed: _saving ? null : () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: context.bodyFont * 0.95,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: context.s),
        ],
      ),
    );
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref.read(tastingsControllerProvider.notifier).rateTastingWine(
            tastingId: widget.tastingId,
            canonicalWineId: _canonicalId,
            rating: _rating,
          );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
        Navigator.of(context).pop();
      }
    }
  }
}

class _RatingHero extends StatelessWidget {
  const _RatingHero({required this.value, required this.cs});

  final double value;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toStringAsFixed(1),
          style: GoogleFonts.playfairDisplay(
            fontSize: context.titleFont * 2.2,
            fontWeight: FontWeight.w800,
            color: cs.onSurface,
            height: 1,
            fontFeatures: tabularFigures,
          ),
        ),
        SizedBox(width: context.w * 0.015),
        Text(
          '/ 10',
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Slider extends StatelessWidget {
  const _Slider({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4,
        activeTrackColor: cs.primary,
        inactiveTrackColor: cs.outlineVariant,
        thumbColor: cs.primary,
        overlayColor: cs.primary.withValues(alpha: 0.12),
        valueIndicatorColor: cs.primary,
        valueIndicatorTextStyle: TextStyle(
          fontSize: context.bodyFont,
          color: cs.onPrimary,
          fontWeight: FontWeight.w700,
        ),
        showValueIndicator: ShowValueIndicator.onDrag,
      ),
      child: Slider(
        min: 0,
        max: 10,
        divisions: 20,
        value: value,
        label: value.toStringAsFixed(1),
        onChanged: onChanged,
      ),
    );
  }
}

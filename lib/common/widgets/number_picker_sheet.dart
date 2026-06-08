import 'package:flutter/material.dart';

import '../l10n/generated/app_localizations.dart';
import '../utils/responsive.dart';

class NumberPickerResult {
  /// Null means the user tapped Clear (field should be unset). A null
  /// Future (sheet dismissed) means no change.
  final double? value;
  const NumberPickerResult(this.value);
}

/// Wheel number picker matching [showYearPickerSheet]. Handles both integer
/// and decimal ranges via [step] + [fractionDigits], with an optional unit
/// suffix (e.g. "°C", " min", "%").
Future<NumberPickerResult?> showNumberPickerSheet({
  required BuildContext context,
  required String title,
  required double min,
  required double max,
  required double step,
  double? initial,
  String unit = '',
  int fractionDigits = 0,
}) async {
  final count = ((max - min) / step).round() + 1;
  final values = List<double>.generate(count, (i) => min + i * step);

  String fmt(double v) => '${v.toStringAsFixed(fractionDigits)}$unit';

  final initialIndex = initial == null
      ? (values.length / 2).floor()
      : ((initial - min) / step).round().clamp(0, values.length - 1);

  final controller = FixedExtentScrollController(initialItem: initialIndex);
  double selected = values[initialIndex];

  return showModalBottomSheet<NumberPickerResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      final l10n = AppLocalizations.of(ctx);
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ctx.paddingH,
            vertical: ctx.m,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: ctx.w * 0.1,
                  height: 4,
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: ctx.m),
              Text(
                title,
                style: TextStyle(
                  fontSize: ctx.bodyFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurfaceVariant,
                ),
              ),
              SizedBox(height: ctx.s),
              SizedBox(
                height: ctx.h * 0.28,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: ctx.h * 0.06,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerHighest.withValues(alpha: .4),
                        borderRadius: BorderRadius.circular(ctx.w * 0.025),
                      ),
                    ),
                    ListWheelScrollView.useDelegate(
                      controller: controller,
                      itemExtent: ctx.h * 0.06,
                      perspective: 0.003,
                      diameterRatio: 1.6,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (i) => selected = values[i],
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: values.length,
                        builder: (_, i) => Center(
                          child: Text(
                            fmt(values[i]),
                            style: TextStyle(
                              fontSize: ctx.titleFont * 1.1,
                              fontWeight: FontWeight.bold,
                              color: cs.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ctx.l),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: ctx.h * 0.055,
                      child: OutlinedButton(
                        onPressed: () =>
                            Navigator.pop(ctx, const NumberPickerResult(null)),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ctx.w * 0.03),
                          ),
                          side: BorderSide(color: cs.outlineVariant),
                        ),
                        child: Text(
                          l10n.commonClear,
                          style: TextStyle(
                            fontSize: ctx.bodyFont,
                            fontWeight: FontWeight.w600,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ctx.w * 0.03),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: ctx.h * 0.055,
                      child: FilledButton(
                        onPressed: () =>
                            Navigator.pop(ctx, NumberPickerResult(selected)),
                        style: FilledButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ctx.w * 0.03),
                          ),
                        ),
                        child: Text(
                          l10n.commonSave,
                          style: TextStyle(
                            fontSize: ctx.bodyFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ctx.s),
            ],
          ),
        ),
      );
    },
  );
}

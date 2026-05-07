import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class YearPickerResult {
  final int? year;
  const YearPickerResult(this.year);
}

Future<YearPickerResult?> showYearPickerSheet({
  required BuildContext context,
  int? initial,
  int? min,
  int? max,
}) async {
  final maxYear = max ?? DateTime.now().year + 1;
  final minYear = min ?? 1900;
  final years = List<int>.generate(maxYear - minYear + 1, (i) => maxYear - i);

  final initialIndex = initial == null
      ? years.indexOf(DateTime.now().year)
      : years.indexOf(initial).clamp(0, years.length - 1);

  final controller = FixedExtentScrollController(initialItem: initialIndex);
  int selected = years[initialIndex];

  return showModalBottomSheet<YearPickerResult>(
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
                'Year',
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
                      onSelectedItemChanged: (i) => selected = years[i],
                      childDelegate: ListWheelChildBuilderDelegate(
                        childCount: years.length,
                        builder: (_, i) => Center(
                          child: Text(
                            years[i].toString(),
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
                            Navigator.pop(ctx, const YearPickerResult(null)),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ctx.w * 0.03),
                          ),
                          side: BorderSide(color: cs.outlineVariant),
                        ),
                        child: Text(
                          'Clear',
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
                            Navigator.pop(ctx, YearPickerResult(selected)),
                        style: FilledButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ctx.w * 0.03),
                          ),
                        ),
                        child: Text(
                          'Save',
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

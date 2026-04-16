import 'package:flutter/material.dart';
import '../../../../common/utils/responsive.dart';

Future<double?> showRatingSheet({
  required BuildContext context,
  required double initial,
}) {
  return showModalBottomSheet<double>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (ctx) => _RatingSheet(initial: initial),
  );
}

class _RatingSheet extends StatefulWidget {
  final double initial;
  const _RatingSheet({required this.initial});

  @override
  State<_RatingSheet> createState() => _RatingSheetState();
}

class _RatingSheetState extends State<_RatingSheet> {
  late double _value = widget.initial;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
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
              Text('Rating',
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant)),
              SizedBox(height: context.m),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(_value.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: context.titleFont * 1.8,
                            fontWeight: FontWeight.bold,
                            height: 1)),
                    SizedBox(width: context.w * 0.02),
                    Text('/ 10',
                        style: TextStyle(
                            fontSize: context.bodyFont,
                            color: cs.onSurfaceVariant)),
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
                  child: Text('Save',
                      style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w600)),
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

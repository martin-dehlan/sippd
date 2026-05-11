import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../common/utils/responsive.dart';

class WineCompareAttributeRow extends StatelessWidget {
  final String label;
  final String? leftValue;
  final String? rightValue;

  const WineCompareAttributeRow({
    super.key,
    required this.label,
    required this.leftValue,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    final hasLeft = (leftValue ?? '').isNotEmpty;
    final hasRight = (rightValue ?? '').isNotEmpty;
    if (!hasLeft && !hasRight) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: _Value(text: leftValue, align: TextAlign.right),
          ),
          SizedBox(width: context.w * 0.025),
          Expanded(
            flex: 4,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont * 0.78,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.6,
                color: cs.outline,
              ),
            ),
          ),
          SizedBox(width: context.w * 0.025),
          Expanded(
            flex: 5,
            child: _Value(text: rightValue, align: TextAlign.left),
          ),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final String? text;
  final TextAlign align;

  const _Value({required this.text, required this.align});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final empty = (text ?? '').isEmpty;
    final alignment = align == TextAlign.right
        ? Alignment.centerRight
        : Alignment.centerLeft;
    if (empty) {
      return Align(
        alignment: alignment,
        child: Text(
          '—',
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant.withValues(alpha: 0.45),
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return Align(
      alignment: alignment,
      child: Text(
        text!,
        textAlign: align,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.playfairDisplay(
          fontSize: context.bodyFont * 1.05,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: cs.onSurface,
          height: 1.2,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../../common/utils/responsive.dart';

enum CompareWinner { left, right, none }

const _winnerGold = Color(0xFFD4A84B);

class WineCompareAttributeRow extends StatelessWidget {
  final String label;
  final String? leftValue;
  final String? rightValue;
  final CompareWinner winner;

  const WineCompareAttributeRow({
    super.key,
    required this.label,
    required this.leftValue,
    required this.rightValue,
    this.winner = CompareWinner.none,
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
            child: _Value(
              text: leftValue,
              align: TextAlign.right,
              isWinner: winner == CompareWinner.left,
            ),
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
            child: _Value(
              text: rightValue,
              align: TextAlign.left,
              isWinner: winner == CompareWinner.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _Value extends StatelessWidget {
  final String? text;
  final TextAlign align;
  final bool isWinner;

  const _Value({
    required this.text,
    required this.align,
    required this.isWinner,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final empty = (text ?? '').isEmpty;
    if (empty) {
      return Align(
        alignment: align == TextAlign.right
            ? Alignment.centerRight
            : Alignment.centerLeft,
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
    final valueText = Text(
      text!,
      textAlign: align,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.playfairDisplay(
        fontSize: context.bodyFont * 1.05,
        fontWeight: isWinner ? FontWeight.w800 : FontWeight.w600,
        fontStyle: FontStyle.italic,
        color: cs.onSurface,
        height: 1.2,
      ),
    );
    if (!isWinner) {
      return Align(
        alignment: align == TextAlign.right
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: valueText,
      );
    }
    final marker = Icon(
      PhosphorIconsFill.checkCircle,
      size: context.w * 0.035,
      color: _winnerGold,
    );
    final isRight = align == TextAlign.right;
    return Align(
      alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: isRight
            ? [
                Flexible(child: valueText),
                SizedBox(width: context.w * 0.014),
                marker,
              ]
            : [
                marker,
                SizedBox(width: context.w * 0.014),
                Flexible(child: valueText),
              ],
      ),
    );
  }
}

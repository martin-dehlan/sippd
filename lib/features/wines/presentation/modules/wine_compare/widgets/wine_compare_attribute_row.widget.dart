import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../../common/utils/responsive.dart';

enum CompareWinner { left, right, none }

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
    final cs = Theme.of(context).colorScheme;
    final hasLeft = (leftValue ?? '').isNotEmpty;
    final hasRight = (rightValue ?? '').isNotEmpty;
    if (!hasLeft && !hasRight) return const SizedBox.shrink();

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
              onSurface: cs.onSurface,
              winnerColor: cs.primary,
              dimColor: cs.onSurfaceVariant,
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
              onSurface: cs.onSurface,
              winnerColor: cs.primary,
              dimColor: cs.onSurfaceVariant,
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
  final Color onSurface;
  final Color winnerColor;
  final Color dimColor;

  const _Value({
    required this.text,
    required this.align,
    required this.isWinner,
    required this.onSurface,
    required this.winnerColor,
    required this.dimColor,
  });

  @override
  Widget build(BuildContext context) {
    final empty = (text ?? '').isEmpty;
    if (empty) {
      return Text(
        '—',
        textAlign: align,
        style: TextStyle(
          fontSize: context.bodyFont,
          color: dimColor.withValues(alpha: 0.5),
          fontWeight: FontWeight.w500,
        ),
      );
    }
    final row = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: align == TextAlign.right
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (isWinner && align == TextAlign.left) ...[
          _WinnerDot(color: winnerColor),
          SizedBox(width: context.w * 0.012),
        ],
        Flexible(
          child: Text(
            text!,
            textAlign: align,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.bodyFont * 1.05,
              fontWeight: isWinner ? FontWeight.w800 : FontWeight.w600,
              fontStyle: FontStyle.italic,
              color: isWinner ? winnerColor : onSurface,
              height: 1.2,
            ),
          ),
        ),
        if (isWinner && align == TextAlign.right) ...[
          SizedBox(width: context.w * 0.012),
          _WinnerDot(color: winnerColor),
        ],
      ],
    );
    return Align(
      alignment: align == TextAlign.right
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: row,
    );
  }
}

class _WinnerDot extends StatelessWidget {
  final Color color;
  const _WinnerDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(
      PhosphorIconsFill.checkCircle,
      size: context.w * 0.04,
      color: color,
    );
  }
}

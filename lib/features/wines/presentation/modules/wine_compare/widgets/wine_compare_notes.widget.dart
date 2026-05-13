import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../domain/entities/wine.entity.dart';

class WineCompareNotesWidget extends StatelessWidget {
  final WineEntity left;
  final WineEntity right;

  const WineCompareNotesWidget({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    final hasLeft = (left.notes ?? '').isNotEmpty;
    final hasRight = (right.notes ?? '').isNotEmpty;
    if (!hasLeft && !hasRight) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.winesCompareNotesEyebrow,
            style: TextStyle(
              fontSize: context.captionFont * 0.85,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              color: cs.onSurface.withValues(alpha: 0.72),
            ),
          ),
          SizedBox(height: context.m),
          if (hasLeft)
            _NoteBlock(
              slot: l10n.winesCompareSlotWineLabel('A'),
              text: left.notes!,
            ),
          if (hasLeft && hasRight) ...[
            SizedBox(height: context.m),
            Container(
              height: 0.5,
              color: cs.outlineVariant.withValues(alpha: 0.6),
            ),
            SizedBox(height: context.m),
          ],
          if (hasRight)
            _NoteBlock(
              slot: l10n.winesCompareSlotWineLabel('B'),
              text: right.notes!,
            ),
        ],
      ),
    );
  }
}

class _NoteBlock extends StatelessWidget {
  final String slot;
  final String text;
  const _NoteBlock({required this.slot, required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          slot,
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
            color: cs.outline,
          ),
        ),
        SizedBox(height: context.xs),
        Text(
          text,
          style: GoogleFonts.playfairDisplay(
            fontSize: context.bodyFont * 0.98,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: cs.onSurface,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

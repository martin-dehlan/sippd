import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../domain/entities/wine.entity.dart';
import '../../../widgets/wine_card.widget.dart';

class WineCompareHeroWidget extends StatelessWidget {
  final WineEntity left;
  final WineEntity right;

  const WineCompareHeroWidget({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.l,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _Side(wine: left, slot: 'A')),
            _VsRule(),
            Expanded(child: _Side(wine: right, slot: 'B')),
          ],
        ),
      ),
    );
  }
}

class _Side extends StatelessWidget {
  final WineEntity wine;
  final String slot;

  const _Side({required this.wine, required this.slot});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'WINE $slot',
          style: TextStyle(
            fontSize: context.captionFont * 0.78,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
            color: cs.outline,
          ),
        ),
        SizedBox(height: context.s),
        SizedBox(
          width: context.w * 0.28,
          height: context.w * 0.28,
          child: WineCardImage(wine: wine, compact: true),
        ),
        SizedBox(height: context.m),
        Text(
          wine.name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.playfairDisplay(
            fontSize: context.bodyFont * 1.15,
            fontWeight: FontWeight.w700,
            height: 1.15,
            color: cs.onSurface,
          ),
        ),
        if ((wine.winery ?? '').isNotEmpty) ...[
          SizedBox(height: context.xs * 0.5),
          Text(
            wine.winery!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              fontStyle: FontStyle.italic,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
        SizedBox(height: context.s),
        if (wine.rating > 0) _RatingPill(rating: wine.rating),
      ],
    );
  }
}

class _RatingPill extends StatelessWidget {
  final double rating;
  const _RatingPill({required this.rating});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.028,
        vertical: context.xs * 0.9,
      ),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.025),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsRegular.star,
            size: context.w * 0.04,
            color: const Color(0xFFD4A84B),
          ),
          SizedBox(width: context.w * 0.012),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w800,
              color: cs.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _VsRule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(width: 0.5, color: cs.outlineVariant),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.xs),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.022,
                vertical: context.xs * 0.4,
              ),
              decoration: BoxDecoration(
                color: cs.surface,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(context.w * 0.015),
                border: Border.all(color: cs.outlineVariant, width: 0.5),
              ),
              child: Text(
                'VS',
                style: GoogleFonts.playfairDisplay(
                  fontSize: context.captionFont * 0.9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(width: 0.5, color: cs.outlineVariant),
          ),
        ],
      ),
    );
  }
}

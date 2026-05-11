import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../../common/utils/responsive.dart';
import '../../../../domain/entities/wine.entity.dart';
import '../../../widgets/wine_card.widget.dart';

class WineComparePanelWidget extends StatelessWidget {
  final WineEntity wine;
  final String slotLabel;

  const WineComparePanelWidget({
    super.key,
    required this.wine,
    required this.slotLabel,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final grape = wine.grape ?? wine.grapeFreetext;
    final origin = [wine.region, wine.country].whereType<String>().join(', ');

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      padding: EdgeInsets.all(context.w * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                slotLabel,
                style: TextStyle(
                  fontSize: context.captionFont * 0.85,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: cs.outline,
                ),
              ),
              const Spacer(),
              WineTypeBadge(type: wine.type),
            ],
          ),
          SizedBox(height: context.s),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WineCardImage(wine: wine, compact: true),
              SizedBox(width: context.w * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wine.name,
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.1,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if ((wine.winery ?? '').isNotEmpty) ...[
                      SizedBox(height: context.xs * 0.5),
                      Text(
                        wine.winery!,
                        style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    SizedBox(height: context.xs),
                    _RatingChip(rating: wine.rating),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.m),
          _AttrRow(label: 'Vintage', value: wine.vintage?.toString()),
          _AttrRow(label: 'Grape', value: grape),
          _AttrRow(label: 'Origin', value: origin.isEmpty ? null : origin),
          _AttrRow(
            label: 'Price',
            value: wine.price != null
                ? '${wine.currency} ${wine.price!.toStringAsFixed(0)}'
                : null,
          ),
          if ((wine.notes ?? '').isNotEmpty) ...[
            SizedBox(height: context.m),
            Text(
              'NOTES',
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: cs.outline,
              ),
            ),
            SizedBox(height: context.xs),
            Text(
              wine.notes!,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurface,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AttrRow extends StatelessWidget {
  final String label;
  final String? value;

  const _AttrRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(top: context.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.w * 0.2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value!,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  final double rating;
  const _RatingChip({required this.rating});

  @override
  Widget build(BuildContext context) {
    if (rating <= 0) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.025,
        vertical: context.xs * 0.8,
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
          SizedBox(width: context.w * 0.01),
          Text(
            '${rating.toStringAsFixed(1)} / 10',
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              fontWeight: FontWeight.w800,
              color: cs.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

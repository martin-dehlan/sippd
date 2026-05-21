import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';

/// Background-free highlight chips, styled to match the wine-card surfaces,
/// for overlaying on top of screen recordings in the edit. Each paints only
/// its own pill/text, so the exported PNG has a transparent surround — drop
/// it straight over the footage and pop/scale it in the editor.

/// Gold rating pill — mirrors the badge inside [WineCardWidget].
class PromoRatingBadge extends StatelessWidget {
  const PromoRatingBadge({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.035,
        vertical: context.h * 0.009,
      ),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsFill.star,
            size: context.w * 0.055,
            color: const Color(0xFFD4A84B),
          ),
          SizedBox(width: context.w * 0.012),
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: context.headingFont,
              fontWeight: FontWeight.w800,
              color: cs.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

/// Price chip, e.g. "€48".
class PromoPriceTag extends StatelessWidget {
  const PromoPriceTag({super.key, required this.price, this.currencySymbol = '€'});

  final double price;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = price == price.roundToDouble()
        ? price.toStringAsFixed(0)
        : price.toStringAsFixed(2);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.035,
        vertical: context.h * 0.009,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Text(
        '$currencySymbol$text',
        style: TextStyle(
          fontSize: context.headingFont,
          fontWeight: FontWeight.w800,
          color: cs.onSurface,
        ),
      ),
    );
  }
}

/// Region / country chip with a location pin.
class PromoRegionChip extends StatelessWidget {
  const PromoRegionChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.035,
        vertical: context.h * 0.009,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsFill.mapPin,
            size: context.w * 0.05,
            color: cs.primary,
          ),
          SizedBox(width: context.w * 0.015),
          Text(
            label,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/shared_bottle.entity.dart';

class SharedBottlesWidget extends StatelessWidget {
  const SharedBottlesWidget({
    super.key,
    required this.bottles,
    this.maxItems = 5,
  });

  final List<SharedBottleEntity> bottles;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);

    if (bottles.isEmpty) return const SizedBox.shrink();

    final visible = bottles.take(maxItems).toList();
    final remaining = bottles.length - visible.length;

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.tasteFriendSharedHeading,
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w700,
              color: cs.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: context.s),
          for (var i = 0; i < visible.length; i++) ...[
            _BottleRow(bottle: visible[i]),
            if (i < visible.length - 1)
              Divider(
                height: context.m,
                thickness: 1,
                color: cs.outlineVariant.withValues(alpha: 0.5),
              ),
          ],
          if (remaining > 0) ...[
            SizedBox(height: context.s),
            Text(
              l.tasteFriendSharedMore(remaining),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.outline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _BottleRow extends StatelessWidget {
  const _BottleRow({required this.bottle});

  final SharedBottleEntity bottle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final subtitle = [
      if (bottle.winery != null && bottle.winery!.isNotEmpty) bottle.winery!,
      if (bottle.vintage != null) bottle.vintage.toString(),
      if (bottle.region != null && bottle.region!.isNotEmpty) bottle.region!,
    ].join(' · ');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bottle.wineName,
                style: TextStyle(
                  fontSize: context.bodyFont * 0.95,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle.isNotEmpty) ...[
                SizedBox(height: context.xs * 0.5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.9,
                    color: cs.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
        SizedBox(width: context.w * 0.03),
        _RatingPair(
          mine: bottle.myRating,
          theirs: bottle.theirRating,
          delta: bottle.delta,
        ),
      ],
    );
  }
}

class _RatingPair extends StatelessWidget {
  const _RatingPair({
    required this.mine,
    required this.theirs,
    required this.delta,
  });

  final double mine;
  final double theirs;
  final double delta;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);
    final agree = delta <= 0.5;
    final deltaColor = agree ? cs.primary : cs.error;
    final deltaIcon = agree
        ? PhosphorIconsBold.checkCircle
        : PhosphorIconsBold.warningCircle;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _Score(label: l.tasteFriendRatingYou, value: mine, color: cs.onSurface),
            SizedBox(height: context.xs * 0.4),
            _Score(
              label: l.tasteFriendRatingThem,
              value: theirs,
              color: cs.onSurfaceVariant,
            ),
          ],
        ),
        SizedBox(width: context.w * 0.025),
        Icon(deltaIcon, size: context.w * 0.04, color: deltaColor),
      ],
    );
  }
}

class _Score extends StatelessWidget {
  const _Score({required this.label, required this.value, required this.color});

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: cs.outline,
          ),
        ),
        SizedBox(width: context.w * 0.015),
        Text(
          '${value.toStringAsFixed(1)} ★',
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}

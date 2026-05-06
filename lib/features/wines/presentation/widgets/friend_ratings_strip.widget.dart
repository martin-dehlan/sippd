import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../controller/friend_ratings.provider.dart';
import '../../domain/entities/friend_rating.entity.dart';

class FriendRatingsStrip extends ConsumerWidget {
  const FriendRatingsStrip({
    super.key,
    required this.canonicalWineId,
    this.maxItems = 3,
  });

  final String canonicalWineId;
  final int maxItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async =
        ref.watch(friendRatingsForCanonicalWineProvider(canonicalWineId));

    return async.maybeWhen(
      data: (ratings) {
        if (ratings.isEmpty) return const SizedBox.shrink();
        return _Card(ratings: ratings, maxItems: maxItems);
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.ratings, required this.maxItems});

  final List<FriendRatingEntity> ratings;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final visible = ratings.take(maxItems).toList(growable: false);
    final remaining = ratings.length - visible.length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: Container(
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
              'FRIENDS WHO RATED',
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                fontWeight: FontWeight.w700,
                color: cs.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: context.s),
            for (var i = 0; i < visible.length; i++) ...[
              _FriendRow(rating: visible[i]),
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
                '+ $remaining more',
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FriendRow extends StatelessWidget {
  const _FriendRow({required this.rating});

  final FriendRatingEntity rating;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final label =
        (rating.displayName?.trim().isNotEmpty ?? false)
            ? rating.displayName!.trim()
            : (rating.username?.trim().isNotEmpty ?? false)
                ? rating.username!.trim()
                : 'Friend';

    return InkWell(
      onTap: () => context.push(AppRoutes.friendProfilePath(rating.userId)),
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.xs),
        child: Row(
          children: [
            _Avatar(url: rating.avatarUrl, label: label),
            SizedBox(width: context.w * 0.03),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                  color: cs.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _RatingValue(rating: rating.rating),
            SizedBox(width: context.w * 0.02),
            Icon(
              PhosphorIconsRegular.caretRight,
              size: context.bodyFont,
              color: cs.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.label});

  final String? url;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.085;
    final initial = label.isNotEmpty ? label.characters.first.toUpperCase() : '?';

    if (url != null && url!.isNotEmpty) {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: cs.surfaceContainerHigh,
        backgroundImage: NetworkImage(url!),
      );
    }
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: cs.surfaceContainerHigh,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: context.bodyFont * 0.9,
          fontWeight: FontWeight.w700,
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _RatingValue extends StatelessWidget {
  const _RatingValue({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.bodyFont * 1.15,
            fontWeight: FontWeight.bold,
            color: cs.onSurface,
            fontFeatures: tabularFigures,
          ),
        ),
        SizedBox(width: context.w * 0.008),
        Text(
          '/ 10',
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: cs.onSurface.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

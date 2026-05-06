import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../wines/domain/entities/wine.entity.dart';
import '../../../wines/presentation/widgets/wine_rating_sheet.dart';
import '../../controller/tastings.provider.dart';

/// Thin wrapper that hands the unified [showWineRatingSheet] the
/// tasting context (table = `tasting_ratings`, rating context =
/// `'tasting'`) so attendees rate inline with the same sheet they
/// see in their personal log + the post-create flow. Keeps the public
/// entry point stable for `_WineLineupCard.onTap`.
Future<void> showTastingRateSheet({
  required BuildContext context,
  required WidgetRef ref,
  required String tastingId,
  required WineEntity wine,
  double initial = 7.0,
}) async {
  // Prefill the sheet with the user's existing rating (if any) so
  // re-opening shows their last value rather than the default seed.
  final canonicalId = wine.canonicalWineId ?? wine.id;
  final prior = await ref.read(
    myTastingRatingProvider(tastingId, canonicalId).future,
  );
  if (!context.mounted) return;
  await showWineRatingSheet(
    context: context,
    wine: wine,
    initial: prior ?? initial,
    ratingContext: 'tasting',
    tastingId: tastingId,
    onSave: (rating) async {
      await ref.read(tastingsControllerProvider.notifier).rateTastingWine(
            tastingId: tastingId,
            canonicalWineId: canonicalId,
            rating: rating,
          );
    },
  );
}

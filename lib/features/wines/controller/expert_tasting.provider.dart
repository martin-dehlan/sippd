import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/controller/auth.provider.dart';
import '../data/data_sources/expert_tasting.api.dart';
import '../domain/entities/expert_tasting.entity.dart';

part 'expert_tasting.provider.g.dart';

@riverpod
ExpertTastingApi expertTastingApi(ExpertTastingApiRef ref) {
  return ExpertTastingApi(ref.watch(supabaseClientProvider));
}

/// Authenticated user's personal expert tasting for a single canonical
/// wine. Returns null if there is no row, or the wine has never received
/// dimensions. Family by canonical id so each wine detail page subscribes
/// to its own state and edits in the rating sheet propagate via
/// `ref.invalidate(myExpertTastingProvider(canonicalId))` from the caller.
@riverpod
Future<ExpertTastingEntity?> myExpertTasting(
  MyExpertTastingRef ref,
  String canonicalWineId,
) {
  return ref.watch(expertTastingApiProvider).getMine(
    canonicalWineId: canonicalWineId,
    context: 'personal',
  );
}

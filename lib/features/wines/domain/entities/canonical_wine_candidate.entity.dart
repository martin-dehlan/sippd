import 'package:freezed_annotation/freezed_annotation.dart';

part 'canonical_wine_candidate.entity.freezed.dart';

/// One row returned by the suggest_canonical_match RPC. When [isExact]
/// is true the input matched an existing canonical_wine on
/// (name_norm + winery_norm + vintage); otherwise it's a Tier 2 fuzzy
/// candidate (trigram >= 0.6, same winery_norm, not previously
/// declined by the user).
@freezed
class CanonicalWineCandidate with _$CanonicalWineCandidate {
  const factory CanonicalWineCandidate({
    required String id,
    required String name,
    String? winery,
    int? vintage,
    required double similarity,
    required bool isExact,
  }) = _CanonicalWineCandidate;
}

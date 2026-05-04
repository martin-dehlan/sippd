import 'package:freezed_annotation/freezed_annotation.dart';

part 'expert_tasting.entity.freezed.dart';

/// One expert tasting note — five 1..5 perception sliders, a 1..3
/// finish pill, optional aroma tags. Stored per (user, canonical_wine,
/// context) and aggregated server-side into canonical_wine_attributes
/// once at least three users have entered notes for the same wine.
@freezed
class ExpertTastingEntity with _$ExpertTastingEntity {
  const factory ExpertTastingEntity({
    String? id,
    int? body,
    int? tannin,
    int? acidity,
    int? sweetness,
    int? oak,
    int? finish,
    @Default(<String>[]) List<String> aromaTags,
  }) = _ExpertTastingEntity;

  const ExpertTastingEntity._();

  bool get isEmpty =>
      body == null &&
      tannin == null &&
      acidity == null &&
      sweetness == null &&
      oak == null &&
      finish == null &&
      aromaTags.isEmpty;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'wine_alias.entity.freezed.dart';

/// Discriminates how an alias was created. Must stay in sync with the
/// `source` check constraint on `public.wine_aliases`.
enum WineAliasSource { shareMatch, manualMerge, adminMerge, duplicateDetection }

extension WineAliasSourceX on WineAliasSource {
  String get wireValue => switch (this) {
    WineAliasSource.shareMatch => 'share_match',
    WineAliasSource.manualMerge => 'manual_merge',
    WineAliasSource.adminMerge => 'admin_merge',
    WineAliasSource.duplicateDetection => 'duplicate_detection',
  };

  static WineAliasSource fromWire(String raw) => switch (raw) {
    'share_match' => WineAliasSource.shareMatch,
    'manual_merge' => WineAliasSource.manualMerge,
    'admin_merge' => WineAliasSource.adminMerge,
    'duplicate_detection' => WineAliasSource.duplicateDetection,
    _ => WineAliasSource.shareMatch,
  };
}

/// Links a user's local wine id to the canonical wine id for dedup-on-share.
@freezed
class WineAliasEntity with _$WineAliasEntity {
  const factory WineAliasEntity({
    required String userId,
    required String localWineId,
    required String canonicalWineId,
    @Default(WineAliasSource.shareMatch) WineAliasSource source,
    required DateTime createdAt,
  }) = _WineAliasEntity;
}

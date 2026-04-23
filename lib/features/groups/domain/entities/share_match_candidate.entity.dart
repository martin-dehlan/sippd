import '../../../wines/domain/entities/wine.entity.dart';

/// A wine already shared in a group that matches (by normalized name) the
/// wine a member is about to share. Surfaces the original sharer so the
/// user can make an informed same/different choice.
class ShareMatchCandidate {
  final WineEntity wine;
  final String? sharedByUsername;

  const ShareMatchCandidate({
    required this.wine,
    this.sharedByUsername,
  });
}

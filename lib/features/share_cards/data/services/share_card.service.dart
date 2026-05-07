import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/services/analytics/analytics.service.dart';
import '../../../../common/utils/share_origin.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../presentation/cards/compass_share_card.widget.dart';
import '../../presentation/cards/friend_invite_card.widget.dart';
import '../../presentation/cards/share_card_branding.widget.dart';
import '../../presentation/cards/tasting_recap_card.widget.dart';
import '../../presentation/cards/wine_rating_card.widget.dart';

class ShareCardService {
  final AnalyticsService _analytics;

  ShareCardService({required AnalyticsService analytics})
    : _analytics = analytics;

  /// Renders a wine rating card off-screen at IG-story dimensions and
  /// hands it to the native share sheet.
  Future<void> shareWineRatingCard({
    required BuildContext context,
    required WineEntity wine,
    String? username,
    required String source,
  }) async {
    _analytics.capture(
      'share_card_generated',
      properties: {'card_type': 'wine_rating', 'source': source},
    );

    // Capture the share-sheet anchor *before* the async render — the
    // triggering widget's render box is the right popover anchor on iPad,
    // and BuildContext should not cross async gaps.
    final shareOrigin = shareOriginFor(context);

    // Precache the wine photo so the off-screen render captures the
    // actual pixels rather than an empty placeholder.
    await _precacheWineImage(context, wine);
    if (!context.mounted) return;

    final card = WineRatingCard(wine: wine, username: username);
    final file = await _renderToFile(
      context: context,
      card: card,
      filenamePrefix: 'sippd_wine_${wine.id}',
    );
    if (file == null) return;

    final result = await Share.shareXFiles(
      [XFile(file.path, mimeType: 'image/png')],
      text:
          'Just rated ${wine.name} ${wine.rating.toStringAsFixed(1)}/10 '
          'on Sippd · $shareCardUrl',
      sharePositionOrigin: shareOrigin,
    );

    _analytics.capture(
      result.status == ShareResultStatus.success
          ? 'share_card_shared'
          : 'share_card_cancelled',
      properties: {'card_type': 'wine_rating', 'source': source},
    );
  }

  /// Renders the user's wine-personality (archetype + DNA shape) as a
  /// 1080×1920 IG-story card and hands it to the native share sheet.
  /// Caller should suppress the entry point when the archetype is the
  /// `curious_newcomer` placeholder so users don't share an unformed
  /// identity.
  Future<void> shareCompassCard({
    required BuildContext context,
    required CompassShareCardData data,
    required String source,
  }) async {
    _analytics.capture(
      'share_card_generated',
      properties: {'card_type': 'compass', 'source': source},
    );

    final shareOrigin = shareOriginFor(context);

    final card = CompassShareCard(data: data);
    final file = await _renderToFile(
      context: context,
      card: card,
      filenamePrefix: 'sippd_personality_${data.username ?? 'me'}',
    );
    if (file == null) return;

    final result = await Share.shareXFiles(
      [XFile(file.path, mimeType: 'image/png')],
      text:
          'My wine personality: ${data.archetypeName} · '
          'find yours at $shareCardUrl',
      sharePositionOrigin: shareOrigin,
    );

    _analytics.capture(
      result.status == ShareResultStatus.success
          ? 'share_card_shared'
          : 'share_card_cancelled',
      properties: {'card_type': 'compass', 'source': source},
    );
  }

  /// Renders a tasting recap card off-screen at IG-story dimensions
  /// and hands it to the native share sheet. Top wine photo + group
  /// avatar are remote URLs — precache them first so the off-screen
  /// render captures the actual pixels rather than empty placeholders.
  Future<void> shareTastingRecapCard({
    required BuildContext context,
    required String tastingId,
    required TastingRecapCardData data,
    required String source,
  }) async {
    _analytics.capture(
      'share_card_generated',
      properties: {'card_type': 'tasting_recap', 'source': source},
    );

    final shareOrigin = shareOriginFor(context);

    for (final url in [data.topWineImageUrl, data.groupAvatarUrl]) {
      if (url == null || url.trim().isEmpty) continue;
      try {
        await precacheImage(NetworkImage(url), context);
      } catch (_) {
        // Card falls back to placeholder.
      }
      if (!context.mounted) return;
    }

    final card = TastingRecapCard(data: data);
    final file = await _renderToFile(
      context: context,
      card: card,
      filenamePrefix: 'sippd_tasting_$tastingId',
    );
    if (file == null) return;

    final topLine = data.topWineName != null && data.topWineAvg != null
        ? '${data.topWineName} took the night at '
              '${data.topWineAvg!.toStringAsFixed(1)}/10'
        : data.tastingTitle;
    final result = await Share.shareXFiles(
      [XFile(file.path, mimeType: 'image/png')],
      text: '$topLine · hosted on Sippd · $shareCardUrl',
      sharePositionOrigin: shareOrigin,
    );

    _analytics.capture(
      result.status == ShareResultStatus.success
          ? 'share_card_shared'
          : 'share_card_cancelled',
      properties: {'card_type': 'tasting_recap', 'source': source},
    );
  }

  /// Renders a friend-invite IG-story card and hands it to the share
  /// sheet alongside the inviter's profile deep-link. The card is the
  /// payload — the URL in [text] is the call-to-action so chat apps
  /// like WhatsApp surface a tap target even when the image is the
  /// hero. Drops the URL down to plain text if rendering fails so the
  /// invite still goes out.
  Future<void> shareFriendInviteCard({
    required BuildContext context,
    required FriendInviteCardData data,
    required String inviteUrl,
    required String source,
  }) async {
    _analytics.capture(
      'share_card_generated',
      properties: {'card_type': 'friend_invite', 'source': source},
    );

    final shareOrigin = shareOriginFor(context);

    if (data.avatarUrl != null && data.avatarUrl!.trim().isNotEmpty) {
      try {
        await precacheImage(NetworkImage(data.avatarUrl!), context);
      } catch (_) {
        // Card falls back to initials.
      }
      if (!context.mounted) return;
    }

    final card = FriendInviteCard(data: data);
    final file = await _renderToFile(
      context: context,
      card: card,
      filenamePrefix: 'sippd_invite_${(data.username ?? 'me').replaceAll(RegExp(r"[^A-Za-z0-9_-]"), "_")}',
    );

    final fallbackText =
        "${data.displayName} wants to taste with you on Sippd · $inviteUrl";
    final imageText = "Join me on Sippd 🍷  $inviteUrl";

    final result = file == null
        ? await Share.share(
            fallbackText,
            subject: 'Join me on Sippd',
            sharePositionOrigin: shareOrigin,
          )
        : await Share.shareXFiles(
            [XFile(file.path, mimeType: 'image/png')],
            text: imageText,
            sharePositionOrigin: shareOrigin,
          );

    _analytics.capture(
      result.status == ShareResultStatus.success
          ? 'share_card_shared'
          : 'share_card_cancelled',
      properties: {'card_type': 'friend_invite', 'source': source},
    );
  }

  Future<void> _precacheWineImage(BuildContext context, WineEntity wine) async {
    final local = wine.localImagePath;
    if (local != null && local.isNotEmpty) {
      final file = File(local);
      if (file.existsSync() && context.mounted) {
        await precacheImage(FileImage(file), context);
        return;
      }
    }
    final url = wine.imageUrl;
    if (url != null && url.isNotEmpty && context.mounted) {
      try {
        await precacheImage(NetworkImage(url), context);
      } catch (_) {
        // Network image failed; the card falls back to typographic layout
        // when neither image source resolves.
      }
    }
  }

  /// Renders [card] off-screen at the share-card dimensions and saves
  /// the resulting PNG to a temp file. Returns null on failure.
  Future<File?> _renderToFile({
    required BuildContext context,
    required Widget card,
    required String filenamePrefix,
  }) async {
    final controller = ScreenshotController();
    final bytes = await controller.captureFromWidget(
      SizedBox(width: shareCardWidth, height: shareCardHeight, child: card),
      context: context,
      pixelRatio: 1,
      delay: const Duration(milliseconds: 80),
      targetSize: const Size(shareCardWidth, shareCardHeight),
    );
    if (bytes.isEmpty) return null;

    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final file = File(p.join(dir.path, '${filenamePrefix}_$stamp.png'));
    await file.writeAsBytes(bytes);
    return file;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/services/analytics/analytics.service.dart';
import '../../../wines/domain/entities/wine.entity.dart';
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
      properties: {
        'card_type': 'wine_rating',
        'source': source,
      },
    );

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
      text: 'Just rated ${wine.name} ${wine.rating.toStringAsFixed(1)}/10 '
          'on Sippd · $shareCardUrl',
    );

    _analytics.capture(
      result.status == ShareResultStatus.success
          ? 'share_card_shared'
          : 'share_card_cancelled',
      properties: {
        'card_type': 'wine_rating',
        'source': source,
      },
    );
  }

  /// Renders a tasting recap card off-screen at IG-story dimensions
  /// and hands it to the native share sheet. Card is fully typographic
  /// (no remote images), so no precache step is needed.
  Future<void> shareTastingRecapCard({
    required BuildContext context,
    required String tastingId,
    required TastingRecapCardData data,
    required String source,
  }) async {
    _analytics.capture(
      'share_card_generated',
      properties: {
        'card_type': 'tasting_recap',
        'source': source,
      },
    );

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
    );

    _analytics.capture(
      result.status == ShareResultStatus.success
          ? 'share_card_shared'
          : 'share_card_cancelled',
      properties: {
        'card_type': 'tasting_recap',
        'source': source,
      },
    );
  }

  Future<void> _precacheWineImage(
    BuildContext context,
    WineEntity wine,
  ) async {
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
      SizedBox(
        width: shareCardWidth,
        height: shareCardHeight,
        child: card,
      ),
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

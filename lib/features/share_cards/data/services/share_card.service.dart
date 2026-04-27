import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/services/analytics/analytics.service.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../presentation/cards/share_card_branding.widget.dart';
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

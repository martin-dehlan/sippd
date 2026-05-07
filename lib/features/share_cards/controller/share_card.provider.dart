import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../common/services/analytics/analytics.provider.dart';
import '../data/services/share_card.service.dart';

part 'share_card.provider.g.dart';

@Riverpod(keepAlive: true)
ShareCardService shareCard(ShareCardRef ref) {
  return ShareCardService(analytics: ref.read(analyticsProvider));
}

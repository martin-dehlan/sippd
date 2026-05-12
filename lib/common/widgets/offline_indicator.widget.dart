import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/connectivity/connectivity.provider.dart';
import '../utils/responsive.dart';

/// Slim inline strip shown when the device is offline. Designed to live
/// at the top of a screen body — not a floating overlay. Collapses to
/// zero height when online so layouts don't shift on first frame.
class OfflineIndicator extends ConsumerWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final online = ref.watch(isOnlineProvider);
    final cs = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, anim) => SizeTransition(
        sizeFactor: anim,
        axisAlignment: -1,
        child: FadeTransition(opacity: anim, child: child),
      ),
      child: online
          ? const SizedBox.shrink(key: ValueKey('online'))
          : Container(
              key: const ValueKey('offline'),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: context.paddingH,
                vertical: context.xs * 1.4,
              ),
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                border: Border(
                  bottom: BorderSide(color: cs.outlineVariant, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsRegular.wifiSlash,
                    size: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                  SizedBox(width: context.xs * 1.4),
                  Text(
                    AppLocalizations.of(context).commonOffline,
                    style: TextStyle(
                      fontSize: context.captionFont * 0.95,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

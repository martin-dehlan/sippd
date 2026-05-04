import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/connectivity/connectivity.provider.dart';
import '../utils/responsive.dart';

/// Lean error view used everywhere a screen fails to load. Hides raw
/// exceptions in release builds, distinguishes offline from generic
/// failures, and offers a single Retry action when relevant. In debug
/// builds the underlying [error] is shown below the friendly copy so
/// developers don't need to chase logs.
class ErrorView extends ConsumerWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onRetry;
  final bool compact;
  final Object? error;

  const ErrorView({
    super.key,
    this.title,
    this.subtitle,
    this.onRetry,
    this.compact = false,
    this.error,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final online = ref.watch(isOnlineProvider);

    final resolvedTitle = title ?? (online ? "Couldn't load" : "You're offline");
    final resolvedSubtitle = subtitle ??
        (online ? 'Pull to retry or try again later.' : 'Reconnect to load this.');
    final icon = online
        ? PhosphorIconsRegular.warningCircle
        : PhosphorIconsRegular.wifiSlash;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH * 1.4,
        vertical: context.l,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: context.w * (compact ? 0.07 : 0.09), color: cs.outline),
          SizedBox(height: context.s * 1.4),
          Text(
            resolvedTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: context.xs * 1.5),
          Text(
            resolvedSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: context.m),
            TextButton.icon(
              onPressed: onRetry,
              icon: Icon(
                PhosphorIconsRegular.arrowClockwise,
                size: context.bodyFont,
                color: cs.tertiary,
              ),
              label: Text(
                'Retry',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: cs.tertiary,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.m,
                  vertical: context.s,
                ),
              ),
            ),
          ],
          if (kDebugMode && error != null) ...[
            SizedBox(height: context.m),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: context.captionFont * 0.85,
                color: cs.outline,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ],
      ),
    );
  }
}

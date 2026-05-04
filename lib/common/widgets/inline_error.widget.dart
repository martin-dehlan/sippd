import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../errors/app_error.dart';
import '../services/connectivity/connectivity.provider.dart';
import '../utils/responsive.dart';

/// Maps any thrown object to a single short user-facing line. Offline /
/// network failures get a connectivity-specific copy; everything else
/// falls back to [fallback]. Centralized so every error UI tells the
/// user the same thing.
String describeAppError(Object error, {String fallback = "Something went wrong."}) {
  return switch (error) {
    OfflineError() => "You're offline. Reconnect to try again.",
    NetworkError() => "Network error. Check your connection.",
    _ => fallback,
  };
}

/// Slim inline caption shown beneath a form field or action button when a
/// mutation fails. Theme-tinted, single line, no overlay. Use for
/// validation feedback or post-action errors that need a short hint
/// without a snackbar.
class InlineFieldError extends ConsumerWidget {
  final Object? error;
  final String? message;
  final String? fallback;

  const InlineFieldError({
    super.key,
    this.error,
    this.message,
    this.fallback,
  }) : assert(error != null || message != null,
            'Provide either error or message');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    // Re-render on connectivity change so a stale "Network error" caption
    // updates to the right state once the user reconnects.
    ref.watch(isOnlineProvider);
    final text = message ??
        describeAppError(
          error!,
          fallback: fallback ?? 'Something went wrong.',
        );

    return Padding(
      padding: EdgeInsets.only(top: context.xs * 1.4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsRegular.warningCircle,
            size: context.captionFont,
            color: cs.error,
          ),
          SizedBox(width: context.xs * 1.2),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                color: cs.error,
                height: 1.3,
              ),
            ),
          ),
          if (kDebugMode && error != null) ...[
            SizedBox(width: context.xs),
            Flexible(
              child: Text(
                '· ${error.toString()}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: context.captionFont * 0.8,
                  color: cs.outline,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// A primary action button that morphs based on lifecycle state:
/// `idle → loading → error/idle`. On error the label switches to
/// "Couldn't save · Retry" with an error-tinted border so the failure
/// is visible *exactly* where the user acted — no snackbar required.
///
/// Pass [onPressed] for the action and [error] (set after a failure)
/// to flip into the retry state. Clear [error] back to null on the
/// next attempt or on success.
class RetryActionButton extends ConsumerWidget {
  final String idleLabel;
  final String? retryLabel;
  final bool loading;
  final Object? error;
  final VoidCallback? onPressed;
  final IconData? icon;

  const RetryActionButton({
    super.key,
    required this.idleLabel,
    required this.onPressed,
    this.retryLabel,
    this.loading = false,
    this.error,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    ref.watch(isOnlineProvider);
    final hasError = error != null;
    final label = hasError
        ? (retryLabel ??
            (error is OfflineError || error is NetworkError
                ? "Offline · Retry"
                : "Couldn't save · Retry"))
        : idleLabel;

    return SizedBox(
      width: double.infinity,
      height: context.h * 0.06,
      child: FilledButton(
        onPressed: loading ? null : onPressed,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: hasError ? cs.errorContainer : null,
          foregroundColor: hasError ? cs.onErrorContainer : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.w * 0.03),
            side: hasError
                ? BorderSide(color: cs.error.withValues(alpha: 0.4), width: 1)
                : BorderSide.none,
          ),
        ),
        child: loading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: cs.onPrimary,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: context.bodyFont),
                    SizedBox(width: context.xs * 1.4),
                  ],
                  // Flexible so longer error labels (e.g. "Couldn't
                  // save · Retry") fade gracefully on narrow phones
                  // instead of overflowing the FilledButton.
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/responsive.dart';

enum _SnackKind { success, error, info }

class AppSnack {
  const AppSnack._();

  static void success(BuildContext context, String message) =>
      _show(context, message, _SnackKind.success);

  static void error(BuildContext context, String message) =>
      _show(context, message, _SnackKind.error);

  static void info(BuildContext context, String message) =>
      _show(context, message, _SnackKind.info);

  static void _show(
    BuildContext context,
    String message,
    _SnackKind kind,
  ) {
    final cs = Theme.of(context).colorScheme;
    final (IconData icon, Color accent) = switch (kind) {
      _SnackKind.success => (PhosphorIconsRegular.checkCircle, cs.secondary),
      _SnackKind.error => (PhosphorIconsRegular.warningCircle, cs.error),
      _SnackKind.info => (PhosphorIconsRegular.info, cs.primary),
    };

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Row(
            children: [
              Container(
                width: context.w * 0.085,
                height: context.w * 0.085,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(context.w * 0.025),
                ),
                child: Icon(icon, color: accent, size: context.w * 0.05),
              ),
              SizedBox(width: context.w * 0.03),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: cs.onSurface,
                    fontSize: context.bodyFont * 0.95,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

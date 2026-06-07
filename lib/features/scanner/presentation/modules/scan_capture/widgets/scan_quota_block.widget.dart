import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';

/// Shown when the user has used today's 5 free scans. Resets tomorrow;
/// a decent (non-pushy) nudge to go Pro for more, plus the always-present
/// manual-entry path.
class ScanQuotaBlock extends StatelessWidget {
  final VoidCallback onUpgrade;
  final VoidCallback onAddManually;

  const ScanQuotaBlock({
    super.key,
    required this.onUpgrade,
    required this.onAddManually,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(context.w * 0.045),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsRegular.sparkle,
              size: context.w * 0.1,
              color: cs.primary,
            ),
          ),
        ),
        SizedBox(height: context.l),
        Text(
          'That\'s all 5 scans for today',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        SizedBox(height: context.s),
        Text(
          'They reset tomorrow. Want to keep scanning now? Go Pro for more.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.bodyFont,
            height: 1.4,
            color: cs.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.xl),
        FilledButton.icon(
          onPressed: onUpgrade,
          icon: const Icon(PhosphorIconsRegular.sparkle),
          label: const Text('Go Pro'),
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: context.m),
          ),
        ),
        SizedBox(height: context.xs),
        TextButton(
          onPressed: onAddManually,
          child: Text(
            'Add by hand',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

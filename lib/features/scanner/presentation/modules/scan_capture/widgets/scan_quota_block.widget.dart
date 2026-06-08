import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';

/// Shown when the user has used today's scans. Free users get a (non-pushy)
/// nudge to go Pro for more; Pro users — who are already on the higher limit
/// — just see that it resets tomorrow. Manual entry is always offered.
class ScanQuotaBlock extends StatelessWidget {
  final bool isPro;
  final VoidCallback onUpgrade;
  final VoidCallback onAddManually;

  const ScanQuotaBlock({
    super.key,
    required this.isPro,
    required this.onUpgrade,
    required this.onAddManually,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final title = isPro
        ? 'You\'ve hit today\'s scan limit'
        : 'That\'s all 5 scans for today';
    final body = isPro
        ? 'Your scans reset tomorrow. Add one by hand in the meantime.'
        : 'They reset tomorrow. Want to keep scanning now? Go Pro for more.';

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
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        SizedBox(height: context.s),
        Text(
          body,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.bodyFont,
            height: 1.4,
            color: cs.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.xl),
        // Pro users are already on the higher limit — no upgrade nudge; the
        // manual path becomes the primary action.
        if (isPro)
          FilledButton.icon(
            onPressed: onAddManually,
            icon: const Icon(PhosphorIconsRegular.pencilSimple),
            label: const Text('Add by hand'),
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: context.m),
            ),
          )
        else ...[
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
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';

/// Shown when the user has used all their free scans this month. Single
/// CTA to the paywall (Pro lifts the cap).
class ScanQuotaBlock extends StatelessWidget {
  final VoidCallback onUpgrade;

  const ScanQuotaBlock({super.key, required this.onUpgrade});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          PhosphorIconsRegular.sparkle,
          size: context.w * 0.18,
          color: cs.primary,
        ),
        SizedBox(height: context.l),
        Text(
          'You\'ve used all your free scans',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        SizedBox(height: context.s),
        Text(
          'Upgrade to Pro for unlimited label scanning, or add this wine '
          'by hand.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.xl),
        FilledButton(
          onPressed: onUpgrade,
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: context.m),
          ),
          child: const Text('See Pro'),
        ),
      ],
    );
  }
}

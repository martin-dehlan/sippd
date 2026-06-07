import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';

/// Shown when the user has used today's 5 scans. The scanner is free for
/// everyone, so there is no upsell — just a clear reset hint and a path
/// to add the wine by hand right now.
class ScanQuotaBlock extends StatelessWidget {
  final VoidCallback onAddManually;

  const ScanQuotaBlock({super.key, required this.onAddManually});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          PhosphorIconsRegular.clockCountdown,
          size: context.w * 0.18,
          color: cs.primary,
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
          'Your scans reset tomorrow. You can still add this wine by hand.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant,
          ),
        ),
        SizedBox(height: context.xl),
        FilledButton(
          onPressed: onAddManually,
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: context.m),
          ),
          child: const Text('Add by hand'),
        ),
      ],
    );
  }
}

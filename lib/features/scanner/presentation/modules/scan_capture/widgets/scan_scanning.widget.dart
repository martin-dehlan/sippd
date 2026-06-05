import 'package:flutter/material.dart';

import '../../../../../../common/utils/responsive.dart';

/// Loading state while the label is being recognized.
class ScanScanning extends StatelessWidget {
  const ScanScanning({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        SizedBox(height: context.l),
        Text(
          'Reading the label…',
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

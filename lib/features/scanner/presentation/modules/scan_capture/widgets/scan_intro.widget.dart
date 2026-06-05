import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';

/// Idle state: explains scan-to-add, shows remaining scans, and offers
/// camera (primary) + gallery (secondary) capture — max two actions.
class ScanIntro extends StatelessWidget {
  final int? remaining;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const ScanIntro({
    super.key,
    required this.remaining,
    required this.onCamera,
    required this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          PhosphorIconsRegular.scan,
          size: context.w * 0.22,
          color: cs.primary,
        ),
        SizedBox(height: context.l),
        Text(
          'Point at a wine label',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        SizedBox(height: context.s),
        Text(
          'We fill in the producer, vintage, grapes and more — you just '
          'check it and save.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant,
          ),
        ),
        if (remaining != null) ...[
          SizedBox(height: context.m),
          Text(
            remaining == 0
                ? 'No scans left this month'
                : '$remaining scan${remaining == 1 ? '' : 's'} left this month',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: context.captionFont, color: cs.outline),
          ),
        ],
        SizedBox(height: context.xl),
        FilledButton.icon(
          onPressed: onCamera,
          icon: const Icon(PhosphorIconsRegular.camera),
          label: const Text('Take a photo'),
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: context.m),
          ),
        ),
        SizedBox(height: context.s),
        TextButton.icon(
          onPressed: onGallery,
          icon: const Icon(PhosphorIconsRegular.image),
          label: const Text('Choose from gallery'),
        ),
      ],
    );
  }
}

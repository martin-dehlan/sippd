import 'package:flutter/material.dart';

import '../icons/sippd_icons.dart';

/// Sippd brand mark — renders the custom glyph from the Sippd icon font.
///
/// Scales with `size`, tints with `tint` (falls back to theme.secondary).
/// No black backdrop, no matrix tricks — the font is a true vector glyph.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size,
    this.tint,
  });

  final double? size;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final side = size ?? w * 0.22;
    final color = tint ?? Theme.of(context).colorScheme.secondary;

    return Icon(
      SippdIcons.logo,
      size: side,
      color: color,
    );
  }
}

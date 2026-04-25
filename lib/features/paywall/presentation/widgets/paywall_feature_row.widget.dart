import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';

class PaywallFeatureRow extends StatelessWidget {
  const PaywallFeatureRow({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.xs),
      child: Row(
        children: [
          Icon(
            PhosphorIconsRegular.checkCircle,
            color: cs.primary,
            size: context.bodyFont * 1.4,
          ),
          SizedBox(width: context.s),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

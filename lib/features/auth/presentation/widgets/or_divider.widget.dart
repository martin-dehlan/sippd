import 'package:flutter/material.dart';
import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(child: Divider(color: cs.outlineVariant)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.m),
          child: Text(
            l10n.authOrDivider,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(child: Divider(color: cs.outlineVariant)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);
    final title = isPro ? l10n.scanQuotaProTitle : l10n.scanQuotaFreeTitle;
    final body = isPro ? l10n.scanQuotaProBody : l10n.scanQuotaFreeBody;

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
            label: Text(l10n.scanAddByHand),
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: context.m),
            ),
          )
        else ...[
          FilledButton.icon(
            onPressed: onUpgrade,
            icon: const Icon(PhosphorIconsRegular.sparkle),
            label: Text(l10n.scanGoPro),
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: context.m),
            ),
          ),
          SizedBox(height: context.xs),
          TextButton(
            onPressed: onAddManually,
            child: Text(
              l10n.scanAddByHand,
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
          ),
        ],
      ],
    );
  }
}

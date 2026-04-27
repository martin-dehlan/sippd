import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';
import '../../../../../../core/routes/app.routes.dart';
import 'package:go_router/go_router.dart';

/// Single Pro-gated block summarising the locked stats sections so the
/// free user sees one unified upsell instead of three repeated lock cards.
/// Tapping the CTA pushes the stand-alone paywall screen with a
/// stats-specific trigger source.
class StatsProLock extends StatelessWidget {
  const StatsProLock({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pills = [
      (icon: PhosphorIconsRegular.coins, label: 'Prices'),
      (icon: PhosphorIconsRegular.mapPin, label: 'Where'),
      (icon: PhosphorIconsRegular.globeHemisphereWest, label: 'Top regions'),
    ];

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.w * 0.022),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsRegular.lockKey,
                  color: cs.primary,
                  size: context.w * 0.05,
                ),
              ),
              SizedBox(width: context.w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unlock 3 more insights',
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      'See where your bottles came from, what you spend, '
                      'and which regions you back the most.',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.m),
          Wrap(
            spacing: context.w * 0.02,
            runSpacing: context.w * 0.02,
            children: [
              for (final p in pills) _Pill(icon: p.icon, label: p.label),
            ],
          ),
          SizedBox(height: context.m),
          SizedBox(
            width: double.infinity,
            height: context.h * 0.055,
            child: FilledButton.tonal(
              onPressed: () => context.push(
                AppRoutes.paywall,
                extra: const {'source': 'stats_pro_block'},
              ),
              style: FilledButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                ),
              ),
              child: Text(
                'Unlock with Pro',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.w * 0.015,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.06),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.w * 0.04, color: cs.onSurfaceVariant),
          SizedBox(width: context.w * 0.015),
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

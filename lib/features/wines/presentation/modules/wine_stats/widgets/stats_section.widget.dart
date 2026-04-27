import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../../common/utils/responsive.dart';

/// Wraps a stats card with title + (optional) Pro lock overlay.
///
/// Free preview: pass [child] = teaser content.
/// Pro-locked: pass [locked] = true so the overlay is rendered on top
/// of the child with a "Unlock with Pro" CTA. The child still paints
/// underneath so the user gets a glimpse of what they'd unlock.
class StatsSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final bool locked;
  final VoidCallback? onLockedTap;

  const StatsSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.locked = false,
    this.onLockedTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final card = Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w800,
              color: cs.onSurface,
              letterSpacing: -0.2,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: context.xs),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
          SizedBox(height: context.m),
          child,
        ],
      ),
    );

    if (!locked) return card;

    return Stack(
      children: [
        card,
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(context.w * 0.04),
            child: Material(
              color: cs.surface.withValues(alpha: 0.85),
              child: InkWell(
                onTap: onLockedTap,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(context.m),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PhosphorIconsFill.lock,
                          color: cs.primary,
                          size: context.w * 0.08,
                        ),
                        SizedBox(height: context.s),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w800,
                            color: cs.onSurface,
                          ),
                        ),
                        SizedBox(height: context.xs),
                        Text(
                          'Unlock with Sippd Pro',
                          style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: context.m),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.w * 0.05,
                            vertical: context.s,
                          ),
                          decoration: BoxDecoration(
                            color: cs.primary,
                            borderRadius:
                                BorderRadius.circular(context.w * 0.06),
                          ),
                          child: Text(
                            'Unlock',
                            style: TextStyle(
                              fontSize: context.captionFont,
                              fontWeight: FontWeight.w700,
                              color: cs.onPrimary,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

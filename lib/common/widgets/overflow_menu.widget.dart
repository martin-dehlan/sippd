import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../utils/responsive.dart';

/// A single action inside an [OverflowMenu].
///
/// `destructive` flips the icon + label tint to `cs.error` for actions
/// that delete/leave/cancel — the only colour rule we apply at the
/// menu-item level.
class OverflowMenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  const OverflowMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
  });
}

/// App-wide overflow (`⋮`) menu.
///
/// Items are passed as a list of groups. A `PopupMenuDivider` is drawn
/// automatically between groups, never within. Single-group menus stay
/// clean — divider noise only appears when the design actually has two
/// semantic clusters (e.g. universal actions vs. owner-only actions, or
/// constructive vs. destructive).
class OverflowMenu extends StatelessWidget {
  final List<List<OverflowMenuItem>> groups;

  /// When true, wraps the trigger in a circular surface-container chip
  /// matching the style used on detail screens. Off by default for
  /// app-bar contexts where the framework draws its own background.
  final bool circleBackground;

  const OverflowMenu({
    super.key,
    required this.groups,
    this.circleBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final flat = groups.expand((g) => g).toList();
    final button = PopupMenuButton<int>(
      icon: Icon(
        PhosphorIconsRegular.dotsThreeVertical,
        size: context.w * (circleBackground ? 0.05 : 0.06),
        color: circleBackground ? cs.onSurface : cs.onSurfaceVariant,
      ),
      tooltip: 'More',
      padding: EdgeInsets.zero,
      color: cs.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      onSelected: (idx) => flat[idx].onTap(),
      itemBuilder: (ctx) {
        final entries = <PopupMenuEntry<int>>[];
        var index = 0;
        for (var g = 0; g < groups.length; g++) {
          if (g > 0) entries.add(const PopupMenuDivider());
          for (final item in groups[g]) {
            final colour = item.destructive ? cs.error : cs.onSurface;
            final i = index;
            entries.add(
              PopupMenuItem<int>(
                value: i,
                child: Row(
                  children: [
                    Icon(item.icon, size: context.w * 0.045, color: colour),
                    SizedBox(width: context.s),
                    Text(item.label, style: TextStyle(color: colour)),
                  ],
                ),
              ),
            );
            index++;
          }
        }
        return entries;
      },
    );

    if (!circleBackground) return button;

    final size = context.w * 0.1;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        shape: BoxShape.circle,
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: button,
    );
  }
}

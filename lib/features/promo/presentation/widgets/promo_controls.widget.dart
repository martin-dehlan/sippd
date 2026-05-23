import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../promo_registry.dart';
import 'promo_entrance.widget.dart';

/// Always-visible control bar for the showcase. Capture/record exports grab
/// only the widget subtree, so this bar never appears in exported PNG/MP4 —
/// only in OS-level screen recordings, which is why the screen lets you tap
/// to hide it.
class PromoControlsBar extends StatelessWidget {
  const PromoControlsBar({
    super.key,
    required this.entry,
    required this.recording,
    required this.motion,
    required this.shadow,
    required this.onPrev,
    required this.onNext,
    required this.onReplay,
    required this.onCycleMotion,
    required this.onToggleShadow,
    required this.onCapture,
    required this.onSequence,
    required this.onToggleRecord,
    required this.onOpenList,
  });

  final PromoEntry entry;
  final bool recording;
  final PromoMotion motion;
  final bool shadow;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onReplay;
  final VoidCallback onCycleMotion;
  final VoidCallback onToggleShadow;
  final VoidCallback onCapture;
  final VoidCallback onSequence;
  final VoidCallback onToggleRecord;
  final VoidCallback onOpenList;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03,
          vertical: context.s,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: context.w * 0.01),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.w * 0.06),
            border: Border.all(color: cs.outlineVariant, width: 0.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: context.xs),
                child: Text(
                  entry.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _BarButton(
                    icon: PhosphorIconsRegular.list,
                    onTap: onOpenList,
                    tooltip: 'Pick widget',
                  ),
                  _BarButton(
                    icon: PhosphorIconsRegular.caretLeft,
                    onTap: onPrev,
                    tooltip: 'Previous',
                  ),
                  _BarButton(
                    icon: PhosphorIconsRegular.caretRight,
                    onTap: onNext,
                    tooltip: 'Next',
                  ),
                  _BarButton(
                    icon: PhosphorIconsRegular.arrowCounterClockwise,
                    onTap: onReplay,
                    tooltip: 'Replay',
                  ),
                  _BarButton(
                    icon: PhosphorIconsRegular.sparkle,
                    onTap: onCycleMotion,
                    tooltip: 'Motion: ${motion.label}',
                  ),
                  _BarButton(
                    icon: Icons.layers_outlined,
                    onTap: onToggleShadow,
                    tooltip: 'Drop shadow',
                    color: shadow ? cs.primary : null,
                  ),
                  _BarButton(
                    icon: PhosphorIconsRegular.camera,
                    onTap: onCapture,
                    tooltip: 'Export PNG',
                  ),
                  _BarButton(
                    icon: Icons.burst_mode_outlined,
                    onTap: onSequence,
                    tooltip: 'Export alpha sequence',
                  ),
                  _BarButton(
                    icon: recording
                        ? PhosphorIconsFill.stop
                        : PhosphorIconsFill.record,
                    onTap: onToggleRecord,
                    tooltip: recording ? 'Stop' : 'Record MP4',
                    color: recording ? const Color(0xFFE5484D) : cs.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BarButton extends StatelessWidget {
  const _BarButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.color,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final side = context.w * 0.092;
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      iconSize: context.w * 0.05,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: BoxConstraints(minWidth: side, minHeight: side),
      icon: Icon(icon, color: color ?? cs.onSurfaceVariant),
    );
  }
}

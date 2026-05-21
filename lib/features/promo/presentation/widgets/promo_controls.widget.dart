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
    required this.onPrev,
    required this.onNext,
    required this.onReplay,
    required this.onCycleMotion,
    required this.onCapture,
    required this.onToggleRecord,
    required this.onOpenList,
  });

  final PromoEntry entry;
  final bool recording;
  final PromoMotion motion;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final VoidCallback onReplay;
  final VoidCallback onCycleMotion;
  final VoidCallback onCapture;
  final VoidCallback onToggleRecord;
  final VoidCallback onOpenList;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.s,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.02,
            vertical: context.xs,
          ),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(context.w * 0.06),
            border: Border.all(color: cs.outlineVariant, width: 0.5),
          ),
          child: Row(
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
              Expanded(
                child: Text(
                  entry.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ),
              _BarButton(
                icon: PhosphorIconsRegular.caretRight,
                onTap: onNext,
                tooltip: 'Next',
              ),
              _BarButton(
                icon: PhosphorIconsRegular.arrowCounterClockwise,
                onTap: onReplay,
                tooltip: 'Replay animation',
              ),
              _BarButton(
                icon: PhosphorIconsRegular.sparkle,
                onTap: onCycleMotion,
                tooltip: 'Motion: ${motion.label}',
              ),
              _BarButton(
                icon: PhosphorIconsRegular.camera,
                onTap: onCapture,
                tooltip: 'Export PNG',
              ),
              _BarButton(
                icon: recording
                    ? PhosphorIconsFill.stop
                    : PhosphorIconsFill.record,
                onTap: onToggleRecord,
                tooltip: recording ? 'Stop recording' : 'Record MP4',
                color: recording ? const Color(0xFFE5484D) : cs.primary,
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
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      iconSize: context.w * 0.055,
      icon: Icon(icon, color: color ?? cs.onSurfaceVariant),
    );
  }
}

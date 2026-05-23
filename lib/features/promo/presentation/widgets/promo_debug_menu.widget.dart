import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../promo_registry.dart';

/// Hidden control panel for the promo showcase, opened by the 5-tap corner
/// gesture. Lets you jump to any widget by name, replay the entrance, and
/// trigger PNG / MP4 exports — none of which appears on the clean canvas
/// while recording.
class PromoDebugMenu extends StatelessWidget {
  const PromoDebugMenu({
    super.key,
    required this.entries,
    required this.currentIndex,
    required this.recording,
    required this.onSelect,
    required this.onReplay,
    required this.onCapture,
    required this.onToggleRecord,
  });

  final List<PromoEntry> entries;
  final int currentIndex;
  final bool recording;
  final ValueChanged<int> onSelect;
  final VoidCallback onReplay;
  final VoidCallback onCapture;
  final VoidCallback onToggleRecord;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.05,
          vertical: context.m,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Promo showcase',
              style: TextStyle(
                fontSize: context.headingFont,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.s),
            Row(
              children: [
                Expanded(
                  child: _PromoAction(
                    icon: PhosphorIconsRegular.arrowCounterClockwise,
                    label: 'Replay',
                    onTap: onReplay,
                  ),
                ),
                SizedBox(width: context.w * 0.03),
                Expanded(
                  child: _PromoAction(
                    icon: PhosphorIconsRegular.camera,
                    label: 'PNG',
                    onTap: onCapture,
                  ),
                ),
                SizedBox(width: context.w * 0.03),
                Expanded(
                  child: _PromoAction(
                    icon: recording
                        ? PhosphorIconsFill.stop
                        : PhosphorIconsFill.record,
                    label: recording ? 'Stop' : 'Record',
                    highlighted: recording,
                    onTap: onToggleRecord,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.m),
            Divider(color: cs.outlineVariant, height: 1),
            SizedBox(height: context.s),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (context, i) {
                  final selected = i == currentIndex;
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.w * 0.02,
                    ),
                    leading: Icon(
                      selected
                          ? PhosphorIconsFill.circle
                          : PhosphorIconsRegular.circle,
                      size: context.w * 0.04,
                      color: selected ? cs.primary : cs.outline,
                    ),
                    title: Text(
                      entries[i].name,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: selected ? cs.onSurface : cs.onSurfaceVariant,
                      ),
                    ),
                    onTap: () => onSelect(i),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromoAction extends StatelessWidget {
  const _PromoAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.highlighted = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fg = highlighted ? cs.onPrimary : cs.onSurface;

    return Material(
      color: highlighted ? cs.primary : cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: context.w * 0.055, color: fg),
              SizedBox(height: context.xs),
              Text(
                label,
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

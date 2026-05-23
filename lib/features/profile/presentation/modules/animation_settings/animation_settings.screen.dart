import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/services/motion/motion.provider.dart';
import '../../../../../common/utils/responsive.dart';

class AnimationSettingsScreen extends ConsumerWidget {
  const AnimationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prefs = ref.watch(motionControllerProvider);
    final controller = ref.read(motionControllerProvider.notifier);
    final systemReduced = MediaQuery.of(context).disableAnimations;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.animationsTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.l,
        ),
        children: [
          if (systemReduced) ...[
            _SystemReducedNote(text: l10n.animationsReducedBySystemNote),
            SizedBox(height: context.l),
          ],
          _ToggleTile(
            icon: PhosphorIconsRegular.sparkle,
            label: l10n.animationsMasterLabel,
            subtitle: l10n.animationsMasterSubtitle,
            value: prefs.master,
            enabled: !systemReduced,
            onChanged: controller.setMaster,
          ),
          SizedBox(height: context.l),
          _ToggleTile(
            icon: PhosphorIconsRegular.cardsThree,
            label: l10n.animationsScreenTransitionsLabel,
            subtitle: l10n.animationsScreenTransitionsSubtitle,
            value: prefs.screenTransitions,
            enabled: !systemReduced && prefs.master,
            onChanged: (v) =>
                controller.setFeature(MotionFeature.screenTransitions, v),
          ),
          _ToggleTile(
            icon: PhosphorIconsRegular.stack,
            label: l10n.animationsListEntrancesLabel,
            subtitle: l10n.animationsListEntrancesSubtitle,
            value: prefs.listEntrances,
            enabled: !systemReduced && prefs.master,
            onChanged: (v) =>
                controller.setFeature(MotionFeature.listEntrances, v),
          ),
          _ToggleTile(
            icon: PhosphorIconsRegular.arrowsLeftRight,
            label: l10n.animationsTabCrossfadeLabel,
            subtitle: l10n.animationsTabCrossfadeSubtitle,
            value: prefs.tabCrossfade,
            enabled: !systemReduced && prefs.master,
            onChanged: (v) =>
                controller.setFeature(MotionFeature.tabCrossfade, v),
          ),
          _ToggleTile(
            icon: PhosphorIconsRegular.chartBar,
            label: l10n.animationsValueAnimationsLabel,
            subtitle: l10n.animationsValueAnimationsSubtitle,
            value: prefs.valueAnimations,
            enabled: !systemReduced && prefs.master,
            onChanged: (v) =>
                controller.setFeature(MotionFeature.valueAnimations, v),
          ),
        ],
      ),
    );
  }
}

class _SystemReducedNote extends StatelessWidget {
  final String text;
  const _SystemReducedNote({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIconsRegular.info,
            color: cs.onSurfaceVariant,
            size: context.w * 0.05,
          ),
          SizedBox(width: context.w * 0.03),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.m,
          horizontal: context.w * 0.04,
        ),
        margin: EdgeInsets.only(bottom: context.xs),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Icon(icon, color: cs.primary, size: context.w * 0.05),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurface,
                    ),
                  ),
                  SizedBox(height: context.xs * 0.5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.captionFont * 0.95,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Switch(value: value, onChanged: enabled ? onChanged : null),
          ],
        ),
      ),
    );
  }
}

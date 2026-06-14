import 'package:flutter/material.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/tasting.entity.dart';

/// Slim lifecycle rail for the tasting detail header: three connected steps —
/// upcoming → live → concluded — so anyone opening a tasting can see at a
/// glance where the night stands.
///
/// Reached steps and the track behind them take the primary accent; steps
/// still ahead sit muted (hollow dot, grey label). Everything animates
/// implicitly, so when the host taps Start / End the rail advances smoothly.
class TastingPhaseStepper extends StatelessWidget {
  const TastingPhaseStepper({super.key, required this.state});

  final TastingState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final labels = <String>[
      l10n.tastingLifecycleUpcoming,
      l10n.tastingLifecycleLive,
      l10n.tastingLifecycleConcluded,
    ];
    // Enum declaration order is upcoming, active, concluded.
    final activeIndex = state.index;
    final last = labels.length - 1;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < labels.length; i++)
          Expanded(
            child: _Step(
              label: labels[i],
              status: i < activeIndex
                  ? _StepStatus.done
                  : i == activeIndex
                  ? _StepStatus.current
                  : _StepStatus.upcoming,
              // A connector half is "reached" once the step it leads into has
              // been reached, so the track fills up to the current step.
              showLeft: i != 0,
              showRight: i != last,
              leftReached: i != 0 && i <= activeIndex,
              rightReached: i != last && i + 1 <= activeIndex,
            ),
          ),
      ],
    );
  }
}

enum _StepStatus { done, current, upcoming }

class _Step extends StatelessWidget {
  const _Step({
    required this.label,
    required this.status,
    required this.showLeft,
    required this.showRight,
    required this.leftReached,
    required this.rightReached,
  });

  final String label;
  final _StepStatus status;
  final bool showLeft;
  final bool showRight;
  final bool leftReached;
  final bool rightReached;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final muted = cs.outlineVariant;

    final dotSize = status == _StepStatus.current
        ? context.w * 0.035
        : context.w * 0.024;

    final (Color dotColor, Color? dotBorder) = switch (status) {
      _StepStatus.done => (cs.primary, null),
      _StepStatus.current => (cs.primary, null),
      _StepStatus.upcoming => (Colors.transparent, muted),
    };

    final (Color labelColor, FontWeight labelWeight) = switch (status) {
      _StepStatus.done => (cs.onSurfaceVariant, FontWeight.w600),
      _StepStatus.current => (cs.onSurface, FontWeight.w700),
      _StepStatus.upcoming => (
        cs.onSurface.withValues(alpha: 0.38),
        FontWeight.w500,
      ),
    };

    return Column(
      children: [
        SizedBox(
          height: context.w * 0.04,
          child: Row(
            children: [
              Expanded(
                child: showLeft
                    ? _Connector(reached: leftReached)
                    : const SizedBox(),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 360),
                curve: Curves.easeOutCubic,
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                  border: dotBorder == null
                      ? null
                      : Border.all(color: dotBorder, width: 1.5),
                ),
              ),
              Expanded(
                child: showRight
                    ? _Connector(reached: rightReached)
                    : const SizedBox(),
              ),
            ],
          ),
        ),
        SizedBox(height: context.xs),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 360),
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            fontWeight: labelWeight,
            color: labelColor,
            letterSpacing: 0.2,
          ),
          child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}

class _Connector extends StatelessWidget {
  const _Connector({required this.reached});
  final bool reached;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
      height: 2,
      margin: EdgeInsets.symmetric(horizontal: context.w * 0.012),
      decoration: BoxDecoration(
        color: reached ? cs.primary : cs.outlineVariant,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }
}

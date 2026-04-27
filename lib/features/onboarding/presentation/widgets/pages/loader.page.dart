import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../../common/utils/responsive.dart';

class LoaderPage extends StatefulWidget {
  final VoidCallback onDone;
  const LoaderPage({super.key, required this.onDone});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> with TickerProviderStateMixin {
  static const _steps = [
    'Matching your taste',
    'Curating your styles',
    'Setting up your journal',
  ];
  int _step = 0;
  bool _finished = false;
  Timer? _timer;
  late final AnimationController _ringCtrl;
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _ringCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..forward();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _timer = Timer.periodic(const Duration(milliseconds: 1300), (t) {
      if (_step < _steps.length - 1) {
        setState(() => _step++);
      } else {
        t.cancel();
        Future.delayed(const Duration(milliseconds: 600), () {
          if (!mounted) return;
          setState(() {
            _finished = true;
            _step = _steps.length;
          });
          _pulseCtrl.stop();
          // Do NOT auto-advance — the user taps the button to proceed.
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ringCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _LoaderRing(
                  ringCtrl: _ringCtrl,
                  pulseCtrl: _pulseCtrl,
                  finished: _finished,
                ),
                SizedBox(height: context.xl * 1.2),
                Text(
                  'ALMOST THERE',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.82,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                    letterSpacing: 1.6,
                  ),
                ),
                SizedBox(height: context.s),
                Text(
                  _finished ? 'All set.' : 'Crafting your profile.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 0.95,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.1,
                    color: cs.onSurface,
                  ),
                ),
                SizedBox(height: context.xl),
                _ChecklistBlock(
                  steps: _steps,
                  activeIndex: _step,
                  pulseCtrl: _pulseCtrl,
                  finished: _finished,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: context.m),
            child: SizedBox(
              width: double.infinity,
              height: context.h * 0.065,
              child: FilledButton(
                onPressed: _finished ? widget.onDone : null,
                style: FilledButton.styleFrom(
                  elevation: 0,
                  disabledBackgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainer,
                  disabledForegroundColor: Theme.of(
                    context,
                  ).colorScheme.outline,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.04),
                  ),
                ),
                child: Text(
                  _finished ? 'See your profile' : 'Continue',
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoaderRing extends StatelessWidget {
  final AnimationController ringCtrl;
  final AnimationController pulseCtrl;
  final bool finished;
  const _LoaderRing({
    required this.ringCtrl,
    required this.pulseCtrl,
    required this.finished,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.32;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: pulseCtrl,
            builder: (_, _) {
              final t = finished ? 1.0 : pulseCtrl.value;
              return Container(
                width: size * (0.85 + t * 0.1),
                height: size * (0.85 + t * 0.1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primary.withValues(alpha: 0.06 + t * 0.04),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: ringCtrl,
            builder: (_, _) => SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: finished ? 1.0 : ringCtrl.value,
                strokeWidth: 2.5,
                color: cs.primary,
                backgroundColor: cs.outlineVariant.withValues(alpha: 0.35),
                strokeCap: StrokeCap.round,
              ),
            ),
          ),
          Container(
            width: size * 0.5,
            height: size * 0.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cs.primary.withValues(alpha: 0.14),
            ),
            alignment: Alignment.center,
            child: Icon(
              finished ? PhosphorIconsFill.check : PhosphorIconsRegular.wine,
              size: size * 0.25,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChecklistBlock extends StatelessWidget {
  final List<String> steps;
  final int activeIndex;
  final AnimationController pulseCtrl;
  final bool finished;

  const _ChecklistBlock({
    required this.steps,
    required this.activeIndex,
    required this.pulseCtrl,
    required this.finished,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(steps.length, (i) {
        final done = finished || i < activeIndex;
        final active = !finished && i == activeIndex;
        return Padding(
          padding: EdgeInsets.only(bottom: context.s),
          child: _ChecklistRow(
            label: steps[i],
            done: done,
            active: active,
            pulseCtrl: pulseCtrl,
          ),
        );
      }),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  final String label;
  final bool done;
  final bool active;
  final AnimationController pulseCtrl;

  const _ChecklistRow({
    required this.label,
    required this.done,
    required this.active,
    required this.pulseCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tickWidth = context.w * 0.055;
    final tickHeight = 1.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: tickWidth,
          height: context.bodyFont * 1.2,
          child: Center(
            child: done
                ? Container(
                    width: tickWidth,
                    height: tickHeight,
                    decoration: BoxDecoration(
                      color: cs.primary,
                      borderRadius: BorderRadius.circular(tickHeight),
                    ),
                  )
                : AnimatedBuilder(
                    animation: pulseCtrl,
                    builder: (_, _) {
                      if (!active) {
                        return Container(
                          width: tickWidth,
                          height: tickHeight,
                          decoration: BoxDecoration(
                            color: cs.outlineVariant.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(tickHeight),
                          ),
                        );
                      }
                      // Active: bar fills left-to-right as it pulses.
                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            width: tickWidth,
                            height: tickHeight,
                            decoration: BoxDecoration(
                              color: cs.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(tickHeight),
                            ),
                          ),
                          Container(
                            width: tickWidth * pulseCtrl.value,
                            height: tickHeight,
                            decoration: BoxDecoration(
                              color: cs.primary,
                              borderRadius: BorderRadius.circular(tickHeight),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ),
        SizedBox(width: context.w * 0.035),
        Text(
          label,
          style: TextStyle(
            fontSize: context.bodyFont * 0.92,
            fontWeight: done || active ? FontWeight.w600 : FontWeight.w400,
            color: done || active
                ? cs.onSurface
                : cs.onSurfaceVariant.withValues(alpha: 0.7),
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

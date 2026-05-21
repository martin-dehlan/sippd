import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/utils/responsive.dart';

/// Global, app-wide caption shown during the demo auto-tour. The tour sets
/// this; [DemoCaptionLayer] (wrapped around the whole app in demo builds)
/// renders it over whatever screen is on top — Apple-keynote-style section
/// labels that persist across navigation.
final ValueNotifier<String?> demoCaption = ValueNotifier<String?>(null);

/// Wraps the app so the [demoCaption] floats above every route. Mounted only
/// in demo builds (via MaterialApp.builder), so production is untouched.
class DemoCaptionLayer extends StatelessWidget {
  const DemoCaptionLayer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(child: IgnorePointer(child: const _Caption())),
      ],
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: demoCaption,
      builder: (context, text, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.18),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: text == null
              ? const SizedBox.shrink(key: ValueKey('empty'))
              : Align(
                  key: ValueKey(text),
                  alignment: const Alignment(0, -0.58),
                  child: _CaptionLabel(text: text),
                ),
        );
      },
    );
  }
}

class _CaptionLabel extends StatelessWidget {
  const _CaptionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.w * 0.1),
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.055,
        vertical: context.h * 0.014,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(context.w * 0.06),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.playfairDisplay(
          fontSize: context.titleFont * 0.92,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.1,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

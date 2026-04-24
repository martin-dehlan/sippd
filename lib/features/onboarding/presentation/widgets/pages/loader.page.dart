import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../common/utils/responsive.dart';

class LoaderPage extends StatefulWidget {
  final VoidCallback onDone;
  const LoaderPage({super.key, required this.onDone});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage>
    with SingleTickerProviderStateMixin {
  static const _steps = [
    'Matching your taste…',
    'Curating your styles…',
    'Setting up your journal…',
  ];
  int _step = 0;
  Timer? _timer;
  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..forward();
    _timer = Timer.periodic(const Duration(milliseconds: 1300), (t) {
      if (_step < _steps.length - 1) {
        setState(() => _step++);
      } else {
        t.cancel();
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) widget.onDone();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.w * 0.35,
            height: context.w * 0.35,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animCtrl,
                  builder: (_, _) => CircularProgressIndicator(
                    value: _animCtrl.value,
                    strokeWidth: 4,
                    color: cs.primary,
                    backgroundColor: cs.outlineVariant,
                  ),
                ),
                Text('🍇', style: TextStyle(fontSize: context.w * 0.14)),
              ],
            ),
          ),
          SizedBox(height: context.xl),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              _steps[_step],
              key: ValueKey(_step),
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: context.headingFont,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
          ),
          SizedBox(height: context.m),
          Text(
            'This only takes a moment.',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../controller/onboarding.provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  static const _pages = <_PageData>[
    _PageData(
      icon: Icons.wine_bar_rounded,
      title: 'Track every bottle',
      body:
          'Rate, photograph and remember every wine you try. Your notes '
          'stay on your phone — sync when you sign in.',
    ),
    _PageData(
      icon: Icons.qr_code_scanner_rounded,
      title: 'Scan & discover',
      body:
          'Scan a bottle to auto-fill details. Add memories, pin the place '
          'you tried it, keep your cellar honest.',
    ),
    _PageData(
      icon: Icons.groups_2_rounded,
      title: 'Taste together',
      body:
          'Create groups with friends, share ratings, plan tastings. '
          'Requires an account — groups run on the cloud.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _skipToLogin() async {
    await ref.read(onboardingControllerProvider.notifier).markSeen();
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  Future<void> _skipAsGuest() async {
    await ref.read(onboardingControllerProvider.notifier).enterGuest();
    if (!mounted) return;
    context.go(AppRoutes.wines);
  }

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _skipToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLast = _index == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingH,
                  vertical: context.s,
                ),
                child: TextButton(
                  onPressed: _skipToLogin,
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: context.bodyFont * 0.95,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _index = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _Page(data: _pages[i]),
              ),
            ),
            _Dots(count: _pages.length, index: _index),
            SizedBox(height: context.l),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.paddingH),
              child: SizedBox(
                width: double.infinity,
                height: context.h * 0.065,
                child: FilledButton(
                  onPressed: _next,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.w * 0.04),
                    ),
                  ),
                  child: Text(
                    isLast ? 'Sign in or sign up' : 'Next',
                    style: TextStyle(
                      fontSize: context.bodyFont * 1.05,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            if (isLast) ...[
              SizedBox(height: context.s),
              TextButton(
                onPressed: _skipAsGuest,
                child: Text(
                  'Skip for now — try without signing in',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ] else
              SizedBox(height: context.xl),
            SizedBox(height: context.m),
          ],
        ),
      ),
    );
  }
}

class _PageData {
  final IconData icon;
  final String title;
  final String body;
  const _PageData({
    required this.icon,
    required this.title,
    required this.body,
  });
}

class _Page extends StatelessWidget {
  final _PageData data;
  const _Page({required this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.w * 0.22,
            height: context.w * 0.22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              data.icon,
              size: context.w * 0.12,
              color: cs.primary,
            ),
          ),
          SizedBox(height: context.xl),
          Text(
            data.title.toUpperCase(),
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 1.15,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          SizedBox(height: context.m),
          Text(
            data.body,
            style: TextStyle(
              fontSize: context.bodyFont,
              height: 1.4,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int index;
  const _Dots({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(horizontal: context.w * 0.01),
            width: i == index ? context.w * 0.06 : context.w * 0.02,
            height: context.w * 0.02,
            decoration: BoxDecoration(
              color: i == index ? cs.primary : cs.outlineVariant,
              borderRadius: BorderRadius.circular(context.w * 0.01),
            ),
          ),
      ],
    );
  }
}

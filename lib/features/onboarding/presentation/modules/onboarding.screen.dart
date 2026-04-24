import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../controller/onboarding.provider.dart';
import '../../domain/onboarding_answers.dart';
import '../widgets/pages/frequency.page.dart';
import '../widgets/pages/goals.page.dart';
import '../widgets/pages/level.page.dart';
import '../widgets/pages/loader.page.dart';
import '../widgets/pages/name.page.dart';
import '../widgets/pages/notifications.page.dart';
import '../widgets/pages/results.page.dart';
import '../widgets/pages/styles.page.dart';
import '../widgets/pages/welcome.page.dart';
import '../widgets/pages/why.page.dart';

enum _Step {
  welcome,
  level,
  goals,
  styles,
  frequency,
  why,
  notifications,
  name,
  loader,
  results,
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageCtrl = PageController();
  int _index = 0;

  List<_Step> get _steps => _Step.values;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  bool _canAdvance(OnboardingAnswers a) {
    switch (_steps[_index]) {
      case _Step.welcome:
      case _Step.why:
      case _Step.loader:
      case _Step.results:
        return true;
      case _Step.level:
        return a.tasteLevel != null;
      case _Step.goals:
        return a.goals.isNotEmpty;
      case _Step.styles:
        return a.styles.isNotEmpty;
      case _Step.frequency:
        return a.frequency != null;
      case _Step.notifications:
        return a.notificationsAsked;
      case _Step.name:
        return (a.displayName ?? '').trim().isNotEmpty;
    }
  }

  void _goTo(int i) {
    if (i < 0 || i >= _steps.length) return;
    _pageCtrl.animateToPage(
      i,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> _finish() async {
    final answers = ref.read(onboardingAnswersControllerProvider);
    final notifier = ref.read(onboardingAnswersControllerProvider.notifier);
    if ((answers.displayName ?? '').isNotEmpty) {
      await notifier.markProfileSeedPending();
    }
    await ref.read(onboardingControllerProvider.notifier).markSeen();
    if (!mounted) return;
    context.go(AppRoutes.login);
  }

  void _next() {
    if (_index == _steps.length - 1) {
      _finish();
    } else {
      _goTo(_index + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final step = _steps[_index];
    final canAdvance = _canAdvance(answers);
    final showChrome = step != _Step.loader;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (showChrome)
              _Header(
                index: _index,
                total: _steps.length,
                onBack: _index == 0 ? null : () => _goTo(_index - 1),
              ),
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _index = i),
                children: [
                  const WelcomePage(),
                  const LevelPage(),
                  const GoalsPage(),
                  const StylesPage(),
                  const FrequencyPage(),
                  const WhyPage(),
                  const NotificationsPage(),
                  const NamePage(),
                  LoaderPage(onDone: () => _goTo(_index + 1)),
                  const ResultsPage(),
                ],
              ),
            ),
            if (showChrome && step != _Step.notifications)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.paddingH,
                  context.s,
                  context.paddingH,
                  context.xl,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: context.h * 0.065,
                  child: FilledButton(
                    onPressed: canAdvance ? _next : null,
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      disabledBackgroundColor:
                          cs.surfaceContainer,
                      disabledForegroundColor: cs.outline,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.w * 0.04),
                      ),
                    ),
                    child: Text(
                      step == _Step.results
                          ? 'Sign in to save it'
                          : step == _Step.welcome
                              ? 'Get started'
                              : 'Continue',
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            if (step == _Step.notifications)
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.paddingH,
                  context.s,
                  context.paddingH,
                  context.xl,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: context.h * 0.065,
                  child: OutlinedButton(
                    onPressed: canAdvance ? _next : null,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: cs.outlineVariant),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.w * 0.04),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w600,
                        color: canAdvance ? cs.onSurface : cs.outline,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int index;
  final int total;
  final VoidCallback? onBack;
  const _Header({
    required this.index,
    required this.total,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final progress = (index + 1) / total;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.paddingH,
        context.s,
        context.paddingH,
        context.s,
      ),
      child: Row(
        children: [
          SizedBox(
            width: context.w * 0.1,
            child: onBack == null
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: onBack,
                    icon: Icon(Icons.arrow_back_ios_new,
                        size: context.w * 0.05, color: cs.onSurface),
                  ),
          ),
          SizedBox(width: context.w * 0.02),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.w * 0.01),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: context.w * 0.015,
                backgroundColor: cs.outlineVariant,
                valueColor: AlwaysStoppedAnimation(cs.primary),
              ),
            ),
          ),
          SizedBox(width: context.w * 0.02),
          SizedBox(
            width: context.w * 0.1,
            child: Text(
              '${index + 1}/$total',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.captionFont * 0.9,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

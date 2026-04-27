import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../../profile/controller/profile.provider.dart';
import '../../controller/onboarding.provider.dart';
import '../../domain/onboarding_answers.dart';
import '../widgets/pages/frequency.page.dart';
import '../widgets/pages/goals.page.dart';
import '../widgets/pages/level.page.dart';
import '../widgets/pages/loader.page.dart';
import '../widgets/pages/name.page.dart';
import '../widgets/pages/notifications.page.dart';
import '../widgets/pages/paywall.page.dart';
import '../widgets/pages/responsibility.page.dart';
import '../widgets/pages/results.page.dart';
import '../widgets/pages/styles.page.dart';
import '../widgets/pages/welcome.page.dart';
import '../widgets/pages/why.page.dart';

// Funnel order: pure value first (quiz → archetype reveal → Pro pitch),
// then the low-stakes asks (notifications). The paywall sits *immediately*
// after the archetype reveal — that's the peak engagement moment, while
// the user is still riding the "the app gets me" feeling. Asking later
// (e.g. after notifications) pushes it past the dopamine window and
// stacks two asks back-to-back.
enum _Step {
  welcome,
  responsibility,
  level,
  goals,
  styles,
  frequency,
  why,
  name,
  loader,
  results,
  paywall,
  notifications,
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageCtrl;
  late int _index;
  late final List<_Step> _steps;

  @override
  void initState() {
    super.initState();
    // Authed users (signing up a second account on this device) skip the
    // pre-auth welcome page — they're already past the marketing pitch.
    // Unauthed users see the full flow including the paywall:
    // RevenueCat handles anonymous purchases by attaching them to an
    // anonymous user-id, then merges them into the real user as soon as
    // main.dart's auth listener calls paywall.identify(...) on signup.
    // Skipping the step would mean missing the peak-engagement window
    // right after the archetype reveal.
    final authed = ref.read(isAuthenticatedProvider);
    _steps = authed
        ? _Step.values.where((s) => s != _Step.welcome).toList()
        : _Step.values;
    _index = 0;
    _pageCtrl = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  bool _canAdvance(OnboardingAnswers a) {
    switch (_steps[_index]) {
      case _Step.welcome:
      case _Step.responsibility:
      case _Step.why:
      case _Step.loader:
      case _Step.results:
      case _Step.paywall:
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
    setState(() => _index = i);
    // Force controller sync after the frame — protects against hot-reload
    // or any state where `_pageCtrl.page` drifted from `_index`, which
    // otherwise makes PageView render the wrong child.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_pageCtrl.hasClients) return;
      if ((_pageCtrl.page ?? _pageCtrl.initialPage.toDouble()).round() != i) {
        _pageCtrl.jumpToPage(i);
      } else {
        _pageCtrl.animateToPage(
          i,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _finish() async {
    final authed = ref.read(isAuthenticatedProvider);
    try {
      final answers = ref.read(onboardingAnswersControllerProvider);
      final notifier = ref.read(onboardingAnswersControllerProvider.notifier);
      if (authed) {
        // Account already exists — write taste fields + displayName +
        // completion flag in one shot. Router redirects to wines after the
        // profile stream emits.
        final profileCtrl = ref.read(profileControllerProvider.notifier);
        await profileCtrl.updateTasteProfile(answers);
        final pending = (answers.displayName ?? '').trim();
        if (pending.isNotEmpty) {
          try {
            await profileCtrl.setDisplayName(pending);
          } catch (_) {
            /* non-fatal */
          }
        }
        await profileCtrl.markOnboardingCompleted();
        await ref.read(onboardingControllerProvider.notifier).markSeen();
      } else {
        // Pre-auth flow: answers stay in SharedPreferences. choose_username
        // reads them and runs a single atomic UPDATE on the profile.
        await notifier.markProfileSeedPending();
        await ref.read(onboardingControllerProvider.notifier).markSeen();
      }
    } catch (_) {
      // write failed — still exit the flow so the user isn't trapped.
    }
    if (!mounted) return;
    context.go(authed ? AppRoutes.wines : AppRoutes.login);
  }

  void _next() {
    // Drop the keyboard when leaving any text-input step (currently just
    // the name page) so it doesn't sit open over the next page — the
    // loader page has nothing to focus and the open keyboard hides half
    // of its content.
    FocusManager.instance.primaryFocus?.unfocus();
    if (_index == _steps.length - 1) {
      _finish();
    } else {
      _goTo(_index + 1);
    }
  }

  String _ctaLabel(_Step step) {
    final isLast = _index == _steps.length - 1;
    if (isLast) {
      return ref.read(isAuthenticatedProvider)
          ? 'Save and continue'
          : 'Sign in to save it';
    }
    if (step == _Step.welcome) return 'Get started';
    if (step == _Step.responsibility) return 'I understand';
    return 'Continue';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final answers = ref.watch(onboardingAnswersControllerProvider);
    final step = _steps[_index];
    final canAdvance = _canAdvance(answers);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              index: _index,
              total: _steps.length,
              onBack: _index == 0 || step == _Step.loader
                  ? null
                  : () => _goTo(_index - 1),
            ),
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _index = i),
                children: _steps.map((s) {
                  switch (s) {
                    case _Step.responsibility:
                      return const ResponsibilityPage();
                    case _Step.welcome:
                      return WelcomePage(onTap: _next);
                    case _Step.level:
                      return const LevelPage();
                    case _Step.goals:
                      return const GoalsPage();
                    case _Step.styles:
                      return const StylesPage();
                    case _Step.frequency:
                      return const FrequencyPage();
                    case _Step.why:
                      return const WhyPage();
                    case _Step.notifications:
                      return const NotificationsPage();
                    case _Step.name:
                      return const NamePage();
                    case _Step.loader:
                      return LoaderPage(onDone: () => _goTo(_index + 1));
                    case _Step.results:
                      return const ResultsPage();
                    case _Step.paywall:
                      return OnboardingPaywallPage(onFinish: _next);
                  }
                }).toList(),
              ),
            ),
            if (step != _Step.loader && step != _Step.paywall)
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
                      disabledBackgroundColor: cs.surfaceContainer,
                      disabledForegroundColor: cs.outline,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(context.w * 0.04),
                      ),
                    ),
                    child: Text(
                      _ctaLabel(step),
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
                    icon: Icon(
                      PhosphorIconsRegular.arrowLeft,
                      size: context.w * 0.05,
                      color: cs.onSurface,
                    ),
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

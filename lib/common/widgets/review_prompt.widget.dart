import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../l10n/generated/app_localizations.dart';
import '../services/analytics/analytics.provider.dart';
import '../services/review/review.provider.dart';
import '../utils/responsive.dart';

/// Two-step "soft ask" for a store review. The custom overlay gauges intent
/// first; only a positive tap hands off to the native StoreKit / Play review
/// sheet. Apple rate-limits the native prompt, so spending it on users who
/// already said they love the app keeps conversion high and avoids burning
/// the quota on the undecided.
///
/// The caller is responsible for gating (see [ReviewPromptController]) and
/// for marking the ask surfaced before showing this sheet.
Future<void> showReviewPromptSheet({required BuildContext context}) {
  final cs = Theme.of(context).colorScheme;
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: cs.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.06),
      ),
    ),
    builder: (_) => const _ReviewPromptSheet(),
  );
}

class _ReviewPromptSheet extends ConsumerStatefulWidget {
  const _ReviewPromptSheet();

  @override
  ConsumerState<_ReviewPromptSheet> createState() => _ReviewPromptSheetState();
}

class _ReviewPromptSheetState extends ConsumerState<_ReviewPromptSheet> {
  bool _busy = false;

  Future<void> _onLove() async {
    if (_busy) return;
    setState(() => _busy = true);
    ref
        .read(analyticsProvider)
        .capture('review_prompt_response', properties: {'outcome': 'liked'});
    await ref
        .read(reviewPromptControllerProvider.notifier)
        .requestNativeReview();
    if (mounted) Navigator.of(context).pop();
  }

  void _onLater() {
    ref
        .read(analyticsProvider)
        .capture(
          'review_prompt_response',
          properties: {'outcome': 'dismissed'},
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        context.paddingH,
        context.m,
        context.paddingH,
        context.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: context.w * 0.1,
              height: 4,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: context.xl),
          Center(
            child: Container(
              padding: EdgeInsets.all(context.m),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                PhosphorIconsFill.heart,
                color: cs.primary,
                size: context.titleFont,
              ),
            ),
          ).animate().scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
            duration: 420.ms,
            curve: Curves.easeOutBack,
          ),
          SizedBox(height: context.m),
          Text(
            l.reviewPromptTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 0.95,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
              height: 1.1,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: context.xs * 1.4),
          Text(
            l.reviewPromptBody,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          SizedBox(height: context.xl),
          SizedBox(
            height: context.h * 0.065,
            child: FilledButton.icon(
              onPressed: _busy ? null : _onLove,
              style: FilledButton.styleFrom(
                elevation: 0,
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                disabledBackgroundColor: cs.primary.withValues(alpha: 0.5),
                disabledForegroundColor: cs.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.045),
                ),
              ),
              icon: _busy
                  ? SizedBox(
                      width: context.w * 0.045,
                      height: context.w * 0.045,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: cs.onPrimary,
                      ),
                    )
                  : Icon(PhosphorIconsFill.star, size: context.w * 0.05),
              label: Text(
                l.reviewPromptCtaPositive,
                style: TextStyle(
                  fontSize: context.bodyFont * 1.05,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.1,
                ),
              ),
            ),
          ),
          SizedBox(height: context.xs * 1.6),
          Center(
            child: TextButton(
              onPressed: _busy ? null : _onLater,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.06,
                  vertical: context.s,
                ),
              ),
              child: Text(
                l.reviewPromptCtaNegative,
                style: TextStyle(
                  fontSize: context.bodyFont * 0.95,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

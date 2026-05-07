import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../profile/controller/profile.provider.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../controller/share_card.provider.dart';
import '../cards/share_card_branding.widget.dart';
import '../cards/wine_rating_card.widget.dart';

/// Post-create share nudge — shows a scaled preview of the wine's rating
/// card and offers one tap to push it to the system share sheet. Routed
/// through the existing ShareCardService so analytics events
/// (share_card_generated / shared / cancelled) stay consistent with the
/// other entry points.
Future<void> showWineSharePromptSheet({
  required BuildContext context,
  required WineEntity wine,
  required String triggerSource,
}) {
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
    builder: (ctx) =>
        _WineSharePromptSheet(wine: wine, triggerSource: triggerSource),
  );
}

class _WineSharePromptSheet extends ConsumerStatefulWidget {
  const _WineSharePromptSheet({
    required this.wine,
    required this.triggerSource,
  });

  final WineEntity wine;
  final String triggerSource;

  @override
  ConsumerState<_WineSharePromptSheet> createState() =>
      _WineSharePromptSheetState();
}

class _WineSharePromptSheetState extends ConsumerState<_WineSharePromptSheet> {
  bool _sharing = false;

  Future<void> _share() async {
    if (_sharing) return;
    setState(() => _sharing = true);
    final username = ref.read(currentProfileProvider).valueOrNull?.username;
    try {
      await ref
          .read(shareCardProvider)
          .shareWineRatingCard(
            context: context,
            wine: widget.wine,
            username: username,
            source: widget.triggerSource,
          );
    } finally {
      if (mounted) {
        setState(() => _sharing = false);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final username = ref.watch(currentProfileProvider).valueOrNull?.username;

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
              padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.035,
                vertical: context.xs * 0.9,
              ),
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(context.w * 0.05),
                border: Border.all(color: cs.outlineVariant, width: 0.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    PhosphorIconsFill.checkCircle,
                    color: cs.onSurface,
                    size: context.bodyFont * 1.05,
                  ),
                  SizedBox(width: context.xs * 1.2),
                  Text(
                    'WINE SAVED',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.85,
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.m),
          Text(
            'Your card is ready',
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
            'Send it to friends or post it to your story.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          SizedBox(height: context.xl),
          Center(
            child: _PreviewFrame(
              child: WineRatingCard(wine: widget.wine, username: username),
            ),
          ),
          SizedBox(height: context.xl),
          SizedBox(
            height: context.h * 0.065,
            child: FilledButton.icon(
              onPressed: _sharing ? null : _share,
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
              icon: _sharing
                  ? SizedBox(
                      width: context.w * 0.045,
                      height: context.w * 0.045,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: cs.onPrimary,
                      ),
                    )
                  : Icon(
                      PhosphorIconsBold.shareNetwork,
                      size: context.w * 0.05,
                    ),
              label: Text(
                _sharing ? 'Preparing…' : 'Share card',
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
              onPressed: _sharing ? null : () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w * 0.06,
                  vertical: context.s,
                ),
              ),
              child: Text(
                'Not now',
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

/// Frames the scaled-down [WineRatingCard] with a soft elevated shadow
/// and a slight rotation so the preview feels like a tangible object the
/// user can pick up and pass on.
class _PreviewFrame extends StatelessWidget {
  final Widget child;
  const _PreviewFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final width = context.w * 0.6;
    return Animate(
      effects: [
        FadeEffect(duration: 420.ms),
        ScaleEffect(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 460.ms,
          curve: Curves.easeOutBack,
        ),
      ],
      child: Transform.rotate(
        angle: -0.025,
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.w * 0.05),
            boxShadow: [
              BoxShadow(
                color: cs.shadow.withValues(alpha: 0.45),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: cs.primary.withValues(alpha: 0.18),
                blurRadius: 40,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AspectRatio(
            aspectRatio: shareCardWidth / shareCardHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.w * 0.05),
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: shareCardWidth,
                  height: shareCardHeight,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

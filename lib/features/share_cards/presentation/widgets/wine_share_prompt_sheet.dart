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
    builder: (ctx) => _WineSharePromptSheet(
      wine: wine,
      triggerSource: triggerSource,
    ),
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
    final username =
        ref.read(currentProfileProvider).valueOrNull?.username;
    try {
      await ref.read(shareCardProvider).shareWineRatingCard(
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
    final username =
        ref.watch(currentProfileProvider).valueOrNull?.username;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH,
        vertical: context.s,
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
          SizedBox(height: context.l),
          Text(
            'Wine saved.',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 0.9,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.1,
              color: cs.onSurface,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            'Share it with your friends?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.bodyFont * 0.95,
              color: cs.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          SizedBox(height: context.l),
          Center(
            child: SizedBox(
              width: context.w * 0.55,
              child: AspectRatio(
                aspectRatio: shareCardWidth / shareCardHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: shareCardWidth,
                      height: shareCardHeight,
                      child: WineRatingCard(
                        wine: widget.wine,
                        username: username,
                      ),
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 360.ms)
                .scale(
                  begin: const Offset(0.92, 0.92),
                  end: const Offset(1, 1),
                  duration: 420.ms,
                  curve: Curves.easeOutBack,
                ),
          ),
          SizedBox(height: context.l),
          SizedBox(
            height: context.h * 0.06,
            child: FilledButton.icon(
              onPressed: _sharing ? null : _share,
              style: FilledButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                ),
              ),
              icon: _sharing
                  ? SizedBox(
                      width: context.w * 0.045,
                      height: context.w * 0.045,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(
                      PhosphorIconsBold.shareNetwork,
                      size: context.w * 0.05,
                    ),
              label: Text(
                _sharing ? 'Preparing…' : 'Share',
                style: TextStyle(
                  fontSize: context.bodyFont * 1.05,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: context.s),
          Center(
            child: TextButton(
              onPressed: _sharing ? null : () => Navigator.of(context).pop(),
              child: Text(
                'Maybe later',
                style: TextStyle(
                  fontSize: context.bodyFont * 0.95,
                  color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: context.xs),
        ],
      ),
    );
  }
}

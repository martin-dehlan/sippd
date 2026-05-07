import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../core/routes/app.routes.dart';
import '../../../paywall/controller/paywall.provider.dart';
import '../../controller/taste_match.provider.dart';
import 'shared_bottles.widget.dart';
import 'taste_match_score.widget.dart';
class FriendTasteMatchSection extends ConsumerWidget {
  const FriendTasteMatchSection({
    super.key,
    required this.friendId,
    required this.friendDisplayName,
  });

  final String friendId;
  final String friendDisplayName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProProvider);

    if (!isPro) {
      return _TasteMatchUpsell(friendDisplayName: friendDisplayName);
    }

    final matchAsync = ref.watch(tasteMatchProvider(friendId));
    final sharedAsync = ref.watch(sharedBottlesProvider(friendId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        matchAsync.when(
          data: (match) => TasteMatchScoreWidget(match: match),
          loading: () => const _LoadingCard(),
          error: (_, _) => const SizedBox.shrink(),
        ),
        SizedBox(height: context.m),
        sharedAsync.when(
          data: (bottles) => bottles.isEmpty
              ? const SizedBox.shrink()
              : SharedBottlesWidget(bottles: bottles),
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: context.h * 0.12,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: context.w * 0.05,
        height: context.w * 0.05,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _TasteMatchUpsell extends StatelessWidget {
  const _TasteMatchUpsell({required this.friendDisplayName});

  final String friendDisplayName;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final firstName = friendDisplayName.split(' ').first;

    final pills = [
      (icon: PhosphorIconsRegular.percent, label: 'Taste match'),
      (icon: PhosphorIconsRegular.handshake, label: 'Shared bottles'),
    ];

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.05),
        border: Border.all(color: cs.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(context.w * 0.022),
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsRegular.lockKey,
                  color: cs.primary,
                  size: context.w * 0.05,
                ),
              ),
              SizedBox(width: context.w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'See how $firstName tastes',
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: context.xs * 0.5),
                    Text(
                      'Compare your palettes, find wines you both love, '
                      'and spot where your taste diverges.',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.m),
          Wrap(
            spacing: context.w * 0.02,
            runSpacing: context.w * 0.02,
            children: [
              for (final p in pills) _Pill(icon: p.icon, label: p.label),
            ],
          ),
          SizedBox(height: context.m),
          SizedBox(
            width: double.infinity,
            height: context.h * 0.055,
            child: FilledButton.tonal(
              onPressed: () => context.push(
                AppRoutes.paywall,
                extra: const {'source': 'friend_taste_match'},
              ),
              style: FilledButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.04),
                ),
              ),
              child: Text(
                'Unlock Sippd Pro',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.h * 0.008,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.w * 0.038, color: cs.onSurfaceVariant),
          SizedBox(width: context.w * 0.015),
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              color: cs.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

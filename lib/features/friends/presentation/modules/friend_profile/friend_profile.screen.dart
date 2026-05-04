import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../common/widgets/stats_card.widget.dart';
import '../../../../groups/presentation/widgets/friend_actions_sheet.widget.dart';
import '../../../../taste_match/presentation/widgets/friend_taste_match_section.widget.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/friends.provider.dart';
import '../../../domain/entities/friend_profile.entity.dart';
import '../../widgets/friend_avatar.widget.dart';

class FriendProfileScreen extends ConsumerWidget {
  final String friendId;
  const FriendProfileScreen({super.key, required this.friendId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(friendProfileProvider(friendId));
    final winesAsync = ref.watch(friendWinesProvider(friendId));

    return Scaffold(
      body: SafeArea(
        child: profileAsync.when(
          data: (profile) {
            if (profile == null) {
              return const Center(child: Text('Profile not found'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(friendProfileProvider(friendId));
                ref.invalidate(friendWinesProvider(friendId));
              },
              child: _Body(profile: profile, winesAsync: winesAsync),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
        ),
      ),
      floatingActionButton: const _BackFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _BackFab extends StatelessWidget {
  const _BackFab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'friend-profile-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => context.pop(),
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final FriendProfileEntity profile;
  final AsyncValue<List<WineEntity>> winesAsync;
  const _Body({required this.profile, required this.winesAsync});

  @override
  Widget build(BuildContext context) {
    final padH = context.paddingH * 1.3;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.2),
        _HeroHeader(profile: profile),
        SizedBox(height: context.xl),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: winesAsync.when(
            data: (wines) => StatsCard(stats: _statsFor(wines)),
            loading: () => StatsCard(stats: _statsFor(const [])),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ),
        SizedBox(height: context.xl),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: FriendTasteMatchSection(
            friendId: profile.id,
            friendDisplayName:
                profile.displayName ?? profile.username ?? 'Friend',
          ),
        ),
        SizedBox(height: context.xl),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padH),
          child: Text(
            'RECENT WINES',
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              letterSpacing: 1.2,
            ),
          ),
        ),
        SizedBox(height: context.s),
        winesAsync.when(
          data: (wines) => _WinesList(wines: wines),
          loading: () => Padding(
            padding: EdgeInsets.all(context.l),
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (e, __) => ErrorView(
            title: "Couldn't load wines",
            compact: true,
            error: e,
          ),
        ),
        SizedBox(height: context.xl * 2),
      ],
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final FriendProfileEntity profile;
  const _HeroHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final displayName = profile.displayName ?? profile.username ?? 'Friend';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => showFriendActionsSheet(
              context: context,
              friendId: profile.id,
              friendDisplayName: displayName,
            ),
            child: FriendAvatar(profile: profile, size: context.w * 0.24),
          ),
          SizedBox(height: context.m),
          Text(
            displayName.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 1.15,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.05,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (profile.username != null) ...[
            SizedBox(height: context.xs),
            Text(
              '@${profile.username}',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

List<StatEntry> _statsFor(List<WineEntity> wines) {
  final avg = wines.isEmpty
      ? '—'
      : (wines.map((w) => w.rating).reduce((a, b) => a + b) / wines.length)
          .toStringAsFixed(1);
  final countries = wines
      .map((w) => w.country)
      .whereType<String>()
      .toSet()
      .length;
  return [
    (label: 'Wines', value: wines.length.toString()),
    (label: 'Avg', value: avg),
    (label: countries == 1 ? 'Country' : 'Countries', value: countries.toString()),
  ];
}

class _WinesList extends StatelessWidget {
  final List<WineEntity> wines;
  const _WinesList({required this.wines});

  @override
  Widget build(BuildContext context) {
    if (wines.isEmpty) {
      return const _EmptyWinesState();
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      itemCount: wines.length,
      separatorBuilder: (_, __) => SizedBox(height: context.s),
      itemBuilder: (_, i) => _WineRow(wine: wines[i]),
    );
  }
}

class _EmptyWinesState extends StatelessWidget {
  const _EmptyWinesState();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final padH = context.paddingH * 1.3;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padH),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.06,
          vertical: context.xl,
        ),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.05),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              PhosphorIconsRegular.wine,
              size: context.w * 0.08,
              color: cs.onSurfaceVariant,
            ),
            SizedBox(height: context.s),
            Text(
              'No wines shared yet',
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WineRow extends StatelessWidget {
  final WineEntity wine;
  const _WineRow({required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final subtitle = [
      if (wine.vintage != null) wine.vintage.toString(),
      if (wine.country != null) wine.country,
    ].join(' · ');

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.035,
        vertical: context.w * 0.035,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Row(
        children: [
          _WineThumbnail(wine: wine, size: context.w * 0.13),
          SizedBox(width: context.w * 0.035),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wine.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: context.xs * 0.4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: context.w * 0.03),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                wine.rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: context.headingFont * 1.1,
                  fontWeight: FontWeight.w800,
                  color: cs.primary,
                  height: 1.0,
                ),
              ),
              SizedBox(width: context.w * 0.01),
              Padding(
                padding: EdgeInsets.only(bottom: context.xs * 0.4),
                child: Text(
                  '/10',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WineThumbnail extends StatelessWidget {
  final WineEntity wine;
  final double size;
  const _WineThumbnail({required this.wine, required this.size});

  @override
  Widget build(BuildContext context) {
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
      WineType.sparkling => const Color(0xFFD4A84B),
    };
    final radius = context.w * 0.025;
    final hasImage = wine.imageUrl != null && wine.imageUrl!.isNotEmpty;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: size,
        height: size,
        child: hasImage
            ? CachedNetworkImage(
                imageUrl: wine.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    _TypePlaceholder(typeColor: typeColor, size: size),
                errorWidget: (_, __, ___) =>
                    _TypePlaceholder(typeColor: typeColor, size: size),
              )
            : _TypePlaceholder(typeColor: typeColor, size: size),
      ),
    );
  }
}

class _TypePlaceholder extends StatelessWidget {
  final Color typeColor;
  final double size;
  const _TypePlaceholder({required this.typeColor, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: typeColor.withValues(alpha: 0.18),
      alignment: Alignment.center,
      child: Icon(
        PhosphorIconsRegular.wine,
        size: size * 0.45,
        color: typeColor,
      ),
    );
  }
}

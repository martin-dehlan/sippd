import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../common/utils/responsive.dart';
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
            return _Body(profile: profile, winesAsync: winesAsync);
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
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
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
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.5),
        _Header(profile: profile),
        SizedBox(height: context.l),
        winesAsync.when(
          data: (wines) => _Stats(wines: wines),
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
        SizedBox(height: context.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Text('Recent wines',
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 0.3,
              )),
        ),
        SizedBox(height: context.s),
        winesAsync.when(
          data: (wines) => _WinesList(wines: wines),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text('Could not load wines',
                style: TextStyle(
                    fontSize: context.captionFont,
                    color: Theme.of(context).colorScheme.error)),
          ),
        ),
        SizedBox(height: context.xl * 2),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final FriendProfileEntity profile;
  const _Header({required this.profile});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final displayName = profile.displayName ?? profile.username ?? 'Friend';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Row(
        children: [
          FriendAvatar(profile: profile, size: context.w * 0.2),
          SizedBox(width: context.w * 0.05),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName.toUpperCase(),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.05,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (profile.username != null) ...[
                  SizedBox(height: context.xs),
                  Text('@${profile.username}',
                      style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.onSurfaceVariant)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stats extends StatelessWidget {
  final List<WineEntity> wines;
  const _Stats({required this.wines});

  @override
  Widget build(BuildContext context) {
    final avg = wines.isEmpty
        ? '—'
        : (wines.map((w) => w.rating).reduce((a, b) => a + b) / wines.length)
            .toStringAsFixed(1);
    final countries = wines
        .map((w) => w.country)
        .whereType<String>()
        .toSet()
        .length
        .toString();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Row(
        children: [
          _StatCell(label: 'Wines', value: wines.length.toString()),
          _StatCell(label: 'Avg', value: avg),
          _StatCell(label: 'Countries', value: countries),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String label;
  final String value;
  const _StatCell({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.primary,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              )),
          SizedBox(height: context.xs * 0.3),
          Text(value,
              style: TextStyle(
                fontSize: context.headingFont * 1.2,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}

class _WinesList extends StatelessWidget {
  final List<WineEntity> wines;
  const _WinesList({required this.wines});

  @override
  Widget build(BuildContext context) {
    if (wines.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: Text('No wines shared yet.',
            style: TextStyle(
                fontSize: context.captionFont,
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
      );
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

class _WineRow extends StatelessWidget {
  final WineEntity wine;
  const _WineRow({required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
      WineType.sparkling => const Color(0xFFD4A84B),
    };
    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Row(
        children: [
          Container(
            width: context.w * 0.03,
            height: context.w * 0.1,
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(context.w * 0.01),
            ),
          ),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wine.name.toUpperCase(),
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
                SizedBox(height: context.xs * 0.4),
                Text(
                  [
                    if (wine.vintage != null) wine.vintage.toString(),
                    if (wine.country != null) wine.country,
                  ].join(' · '),
                  style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
          Text(wine.rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: context.bodyFont * 1.2,
                fontWeight: FontWeight.bold,
                color: cs.primary,
              )),
        ],
      ),
    );
  }
}

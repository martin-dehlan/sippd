import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../controller/tastings.provider.dart';
import '../../../domain/entities/tasting.entity.dart';
import '../../../domain/entities/tasting_attendee.entity.dart';
import '../../widgets/calendar_export_sheet.dart';

class TastingDetailScreen extends ConsumerWidget {
  final String tastingId;
  const TastingDetailScreen({super.key, required this.tastingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tastingAsync = ref.watch(tastingDetailProvider(tastingId));
    return Scaffold(
      body: SafeArea(
        child: tastingAsync.when(
          data: (t) {
            if (t == null) {
              return const Center(child: Text('Tasting not found'));
            }
            return _Body(tasting: t);
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

class _CalendarIconButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CalendarIconButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: context.w * 0.1,
        height: context.w * 0.1,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          shape: BoxShape.circle,
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Icon(Icons.event_outlined,
            size: context.w * 0.045, color: cs.onSurface),
      ),
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
        heroTag: 'tasting-detail-back',
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

class _Body extends ConsumerWidget {
  final TastingEntity tasting;
  const _Body({required this.tasting});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final currentUid = ref.watch(currentUserIdProvider);
    final isOwner = currentUid == tasting.createdBy;
    final local = tasting.scheduledAt.toLocal();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.5),
        Padding(
          padding: EdgeInsets.only(
              left: context.paddingH * 1.3,
              right: context.paddingH * 0.8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  tasting.title.toUpperCase(),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 1.2,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.05,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _CalendarIconButton(
                onTap: () => showCalendarExportSheet(
                    context: context, tasting: tasting),
              ),
            ],
          ),
        ),
        SizedBox(height: context.s),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Text(
            '${DateFormat.yMMMMEEEEd().format(local)} · ${DateFormat.Hm().format(local)}',
            style: TextStyle(
              fontSize: context.bodyFont,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: context.s),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Text(
            '${DateFormat.yMMMMEEEEd().format(local)} · ${DateFormat.Hm().format(local)}',
            style: TextStyle(
              fontSize: context.bodyFont,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (tasting.description != null &&
            tasting.description!.isNotEmpty) ...[
          SizedBox(height: context.s),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text(
              tasting.description!,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurface,
                height: 1.5,
              ),
            ),
          ),
        ],
        SizedBox(height: context.l),
        _RsvpBar(tasting: tasting),
        SizedBox(height: context.l),
        if (tasting.location != null) ...[
          _Section(
            label: 'Place',
            child: _PlaceCard(
              location: tasting.location!,
              latitude: tasting.latitude,
              longitude: tasting.longitude,
            ),
          ),
          SizedBox(height: context.l),
        ],
        _Section(
          label: 'Going',
          child: _AttendeesStrip(tastingId: tasting.id),
        ),
        SizedBox(height: context.l),
        _Section(
          label: 'Wines',
          child: _WinesList(tastingId: tasting.id),
        ),
        SizedBox(height: context.xl),
        if (isOwner)
          Center(
            child: TextButton(
              onPressed: () => _confirmDelete(context, ref, tasting),
              child: Text('Cancel tasting',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w500,
                    color: cs.error,
                  )),
            ),
          ),
        SizedBox(height: context.xl * 2),
      ],
    );
  }

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, TastingEntity t) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel tasting?'),
        content: const Text('This removes it for everyone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Cancel',
                style:
                    TextStyle(color: Theme.of(ctx).colorScheme.error)),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await ref
        .read(tastingsControllerProvider.notifier)
        .deleteTasting(t.id, groupId: t.groupId);
    if (context.mounted) context.pop();
  }
}

class _Section extends StatelessWidget {
  final String label;
  final Widget child;
  const _Section({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Text(label,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w700,
                color: cs.primary,
                letterSpacing: 0.3,
              )),
        ),
        SizedBox(height: context.s),
        child,
      ],
    );
  }
}

class _RsvpBar extends ConsumerWidget {
  final TastingEntity tasting;
  const _RsvpBar({required this.tasting});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendeesAsync =
        ref.watch(tastingAttendeesProvider(tasting.id));
    final currentUid = ref.watch(currentUserIdProvider);
    final myStatus = attendeesAsync.whenOrNull(data: (list) {
          try {
            return list.firstWhere((a) => a.userId == currentUid).status;
          } catch (_) {
            return RsvpStatus.noResponse;
          }
        }) ??
        RsvpStatus.noResponse;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Row(
        children: [
          _RsvpButton(
            label: 'Going',
            active: myStatus == RsvpStatus.going,
            onTap: () => ref
                .read(tastingsControllerProvider.notifier)
                .setRsvp(tasting.id, RsvpStatus.going),
          ),
          SizedBox(width: context.w * 0.02),
          _RsvpButton(
            label: 'Maybe',
            active: myStatus == RsvpStatus.maybe,
            onTap: () => ref
                .read(tastingsControllerProvider.notifier)
                .setRsvp(tasting.id, RsvpStatus.maybe),
          ),
          SizedBox(width: context.w * 0.02),
          _RsvpButton(
            label: 'Decline',
            active: myStatus == RsvpStatus.declined,
            onTap: () => ref
                .read(tastingsControllerProvider.notifier)
                .setRsvp(tasting.id, RsvpStatus.declined),
          ),
        ],
      ),
    );
  }
}

class _RsvpButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _RsvpButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: context.h * 0.055,
          decoration: BoxDecoration(
            color: active ? cs.primary : cs.surfaceContainer,
            borderRadius: BorderRadius.circular(context.w * 0.03),
            border: Border.all(
              color: active ? cs.primary : cs.outlineVariant,
              width: 0.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w600,
              color: active ? cs.onPrimary : cs.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final String location;
  final double? latitude;
  final double? longitude;

  const _PlaceCard({
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasCoords = latitude != null && longitude != null;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: context.h * 0.2,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
        ),
        child: hasCoords
            ? Stack(
                children: [
                  IgnorePointer(
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(latitude!, longitude!),
                        initialZoom: 14,
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.none,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.sippd.sippd',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            point: LatLng(latitude!, longitude!),
                            width: context.w * 0.1,
                            height: context.w * 0.1,
                            child: Icon(Icons.place,
                                size: context.w * 0.1, color: cs.primary),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  Positioned(
                    left: context.m,
                    right: context.m,
                    bottom: context.m,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.m, vertical: context.s),
                      decoration: BoxDecoration(
                        color: cs.surface.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(context.w * 0.02),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.place,
                              size: context.w * 0.045, color: cs.primary),
                          SizedBox(width: context.w * 0.02),
                          Expanded(
                            child: Text(location,
                                style: TextStyle(
                                  fontSize: context.bodyFont,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(location,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    )),
              ),
      ),
    );
  }
}

class _AttendeesStrip extends ConsumerWidget {
  final String tastingId;
  const _AttendeesStrip({required this.tastingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final attendeesAsync =
        ref.watch(tastingAttendeesProvider(tastingId));
    return attendeesAsync.when(
      data: (all) {
        final going =
            all.where((a) => a.status == RsvpStatus.going).toList();
        if (going.isEmpty) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text('No one confirmed yet.',
                style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant)),
          );
        }
        return SizedBox(
          height: context.w * 0.2,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            itemCount: going.length,
            separatorBuilder: (_, __) => SizedBox(width: context.w * 0.03),
            itemBuilder: (_, i) {
              final a = going[i];
              final name = a.profile?.displayName ??
                  a.profile?.username ??
                  '?';
              return GestureDetector(
                onTap: a.profile != null
                    ? () => context.push(
                        AppRoutes.friendProfilePath(a.profile!.id))
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (a.profile != null)
                      FriendAvatar(
                          profile: a.profile!, size: context.w * 0.13)
                    else
                      Container(
                        width: context.w * 0.13,
                        height: context.w * 0.13,
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.person,
                            color: cs.primary, size: context.w * 0.06),
                      ),
                    SizedBox(height: context.xs * 0.5),
                    SizedBox(
                      width: context.w * 0.16,
                      child: Text(name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: context.captionFont * 0.85,
                            color: cs.onSurfaceVariant,
                          )),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

class _WinesList extends ConsumerWidget {
  final String tastingId;
  const _WinesList({required this.tastingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(tastingWinesProvider(tastingId));
    return winesAsync.when(
      data: (wines) {
        if (wines.isEmpty) {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text('No wines lined up yet.',
                style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant)),
          );
        }
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          itemCount: wines.length,
          separatorBuilder: (_, __) => SizedBox(height: context.s),
          itemBuilder: (_, i) => _WineRow(wine: wines[i]),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
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
            width: context.w * 0.025,
            height: context.w * 0.1,
            decoration: BoxDecoration(
              color: typeColor,
              borderRadius: BorderRadius.circular(context.w * 0.01),
            ),
          ),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Text(wine.name.toUpperCase(),
                style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.2),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}

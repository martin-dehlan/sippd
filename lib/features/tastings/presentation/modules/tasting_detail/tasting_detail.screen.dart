import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/overflow_menu.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../friends/presentation/widgets/friend_avatar.widget.dart';
import '../../../../groups/controller/group.provider.dart';
import '../../../../wines/controller/wine.provider.dart';
import '../../../../wines/domain/entities/wine.entity.dart';
import '../../../../wines/presentation/widgets/wine_card.widget.dart';
import '../../../controller/tastings.provider.dart';
import '../../../domain/entities/tasting.entity.dart';
import '../../../domain/entities/tasting_attendee.entity.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../common/services/deep_link/deep_link.service.dart';
import '../../widgets/calendar_export_sheet.dart';
import '../../widgets/tasting_rate_sheet.dart';
import '../../widgets/tasting_recap_section.widget.dart';
import '../../widgets/wine_picker_sheet.dart';

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


class _WhenRow extends StatelessWidget {
  final DateTime when;
  const _WhenRow({required this.when});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(PhosphorIconsRegular.calendarBlank,
            size: context.w * 0.04, color: cs.onSurfaceVariant),
        SizedBox(width: context.xs),
        Text(
          DateFormat.yMMMEd().format(when),
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: context.m),
        Icon(PhosphorIconsRegular.clock,
            size: context.w * 0.04, color: cs.onSurfaceVariant),
        SizedBox(width: context.xs),
        Text(
          DateFormat.Hm().format(when),
          style: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
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
            crossAxisAlignment: CrossAxisAlignment.end,
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
              OverflowMenu(
                circleBackground: true,
                groups: [
                  [
                    OverflowMenuItem(
                      icon: PhosphorIconsRegular.calendarBlank,
                      label: 'Add to calendar',
                      onTap: () => addTastingToCalendar(
                          context: context, tasting: tasting),
                    ),
                    OverflowMenuItem(
                      icon: PhosphorIconsRegular.shareNetwork,
                      label: 'Share',
                      onTap: () => Share.share(
                        '${tasting.title}\n\n${DeepLinkService.tastingHttpsUri(tasting.id)}',
                        subject: tasting.title,
                      ),
                    ),
                  ],
                  if (isOwner)
                    [
                      OverflowMenuItem(
                        icon: PhosphorIconsRegular.pencilSimple,
                        label: 'Edit tasting',
                        onTap: () => context
                            .push(AppRoutes.tastingEditPath(tasting.id)),
                      ),
                      OverflowMenuItem(
                        icon: PhosphorIconsRegular.calendarX,
                        label: 'Cancel tasting',
                        destructive: true,
                        onTap: () => _confirmDelete(context, ref, tasting),
                      ),
                    ],
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: context.s),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: _WhenRow(when: local),
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: _PhaseBanner(tasting: tasting, isOwner: isOwner),
        ),
        SizedBox(height: context.l),
        _Section(
          label: 'People',
          child: _AttendeesCard(tasting: tasting),
        ),
        SizedBox(height: context.l),
        _RsvpBar(tasting: tasting),
        SizedBox(height: context.l),
        if (tasting.location != null) ...[
          if (tasting.state == TastingState.upcoming)
            _Section(
              label: 'Place',
              child: _PlaceCard(
                location: tasting.location!,
                latitude: tasting.latitude,
                longitude: tasting.longitude,
              ),
            )
          else
            _PlaceStrip(location: tasting.location!),
          SizedBox(height: context.l),
        ],
        if (tasting.state == TastingState.concluded)
          _RecapSwitcher(tasting: tasting)
        else
          _WinesSection(tasting: tasting, isOwner: isOwner),
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

/// Phase-aware banner showing current lifecycle state. Hosts get the
/// transition CTA inline (Start / End). Non-hosts see a non-interactive
/// state pill so they know whether ratings are open yet. The Start CTA
/// is only surfaced near scheduledAt (±6h) to avoid premature firing.
class _PhaseBanner extends ConsumerWidget {
  final TastingEntity tasting;
  final bool isOwner;
  const _PhaseBanner({required this.tasting, required this.isOwner});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return switch (tasting.state) {
      TastingState.upcoming => _UpcomingBanner(
          tasting: tasting,
          isOwner: isOwner,
          cs: cs,
          onStart: () => _start(context, ref),
        ),
      TastingState.active => _ActiveBanner(
          tasting: tasting,
          isOwner: isOwner,
          cs: cs,
          onEnd: () => _confirmEnd(context, ref),
        ),
      TastingState.concluded => _ConcludedBanner(cs: cs),
    };
  }

  Future<void> _start(BuildContext context, WidgetRef ref) async {
    await ref
        .read(tastingsControllerProvider.notifier)
        .startTasting(tasting.id, groupId: tasting.groupId);
  }

  Future<void> _confirmEnd(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('End tasting?'),
        content: const Text(
            'This locks the recap. Attendees can still add ratings briefly afterwards.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep going'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('End'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref
        .read(tastingsControllerProvider.notifier)
        .endTasting(tasting.id, groupId: tasting.groupId);
  }
}

class _UpcomingBanner extends StatelessWidget {
  final TastingEntity tasting;
  final bool isOwner;
  final ColorScheme cs;
  final VoidCallback onStart;
  const _UpcomingBanner({
    required this.tasting,
    required this.isOwner,
    required this.cs,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final hoursUntil = tasting.scheduledAt.difference(now).inHours;
    // Surface the Start CTA only inside a ±6h window around scheduledAt.
    // Outside that window, host still sees the pill but no button — keeps
    // the screen calm for far-future events.
    final canStart = isOwner && hoursUntil <= 6 && hoursUntil >= -12;
    return _BannerShell(
      cs: cs,
      icon: PhosphorIconsRegular.calendarBlank,
      label: 'UPCOMING',
      tone: cs.surfaceContainerHigh,
      foreground: cs.onSurface,
      action: canStart
          ? _BannerAction(
              label: 'Start tasting',
              onTap: onStart,
              filled: true,
              cs: cs,
            )
          : null,
    );
  }
}

class _ActiveBanner extends StatelessWidget {
  final TastingEntity tasting;
  final bool isOwner;
  final ColorScheme cs;
  final VoidCallback onEnd;
  const _ActiveBanner({
    required this.tasting,
    required this.isOwner,
    required this.cs,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    return _BannerShell(
      cs: cs,
      icon: PhosphorIconsFill.circle,
      label: 'LIVE',
      tone: cs.primaryContainer,
      foreground: cs.onPrimaryContainer,
      action: isOwner
          ? _BannerAction(
              label: 'End tasting',
              onTap: onEnd,
              filled: false,
              cs: cs,
            )
          : null,
    );
  }
}

class _ConcludedBanner extends StatelessWidget {
  final ColorScheme cs;
  const _ConcludedBanner({required this.cs});

  @override
  Widget build(BuildContext context) {
    return _BannerShell(
      cs: cs,
      icon: PhosphorIconsRegular.checkCircle,
      label: 'CONCLUDED',
      tone: cs.surfaceContainer,
      foreground: cs.onSurfaceVariant,
      action: null,
    );
  }
}

class _BannerShell extends StatelessWidget {
  final ColorScheme cs;
  final IconData icon;
  final String label;
  final Color tone;
  final Color foreground;
  final _BannerAction? action;

  const _BannerShell({
    required this.cs,
    required this.icon,
    required this.label,
    required this.tone,
    required this.foreground,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.04,
        vertical: context.s * 1.2,
      ),
      decoration: BoxDecoration(
        color: tone,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Row(
        children: [
          Icon(icon, size: context.bodyFont * 0.95, color: foreground),
          SizedBox(width: context.w * 0.02),
          Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              fontWeight: FontWeight.w800,
              color: foreground,
              letterSpacing: 1.4,
            ),
          ),
          const Spacer(),
          ?action,
        ],
      ),
    );
  }
}

class _BannerAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;
  final ColorScheme cs;

  const _BannerAction({
    required this.label,
    required this.onTap,
    required this.filled,
    required this.cs,
  });

  @override
  Widget build(BuildContext context) {
    final bg = filled ? cs.primary : cs.surface;
    final fg = filled ? cs.onPrimary : cs.onSurface;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(context.w * 0.04),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.w * 0.04),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.04,
            vertical: context.s * 0.9,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w700,
              color: fg,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}

/// Reads the catalog lineup once and hands it to the recap section.
/// Kept thin so TastingRecapSection itself stays presentation-only.
class _RecapSwitcher extends ConsumerWidget {
  const _RecapSwitcher({required this.tasting});
  final TastingEntity tasting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(tastingWinesProvider(tasting.id));
    final wines = winesAsync.valueOrNull ?? const [];
    return TastingRecapSection(
      tastingId: tasting.id,
      groupId: tasting.groupId,
      tastingTitle: tasting.title,
      scheduledAt: tasting.scheduledAt,
      location: tasting.location,
      wines: wines,
    );
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
          child: Text(label.toUpperCase(),
              style: TextStyle(
                fontSize: context.captionFont * 0.95,
                fontWeight: FontWeight.w700,
                color: cs.onSurface.withValues(alpha: 0.72),
                letterSpacing: 1.2,
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
    final cs = Theme.of(context).colorScheme;
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
          Text('Your response',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              )),
          const Spacer(),
          SegmentedButton<RsvpStatus>(
            showSelectedIcon: false,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: WidgetStateProperty.all(TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w600,
              )),
            ),
            segments: const [
              ButtonSegment(
                  value: RsvpStatus.going, label: Text('Going')),
              ButtonSegment(
                  value: RsvpStatus.maybe, label: Text('Maybe')),
              ButtonSegment(
                  value: RsvpStatus.declined, label: Text('No')),
            ],
            selected: myStatus == RsvpStatus.noResponse
                ? const <RsvpStatus>{}
                : {myStatus},
            emptySelectionAllowed: true,
            onSelectionChanged: (s) {
              if (s.isEmpty) return;
              ref
                  .read(tastingsControllerProvider.notifier)
                  .setRsvp(tasting.id, s.first);
            },
          ),
        ],
      ),
    );
  }
}

/// Compact place reference shown during Active and Concluded states.
/// During Upcoming the full map-tile [_PlaceCard] is preferred since
/// users still need to navigate; once people are at the venue (or the
/// night is over) the location is read-only context, not an action,
/// so we drop the map tile and keep just the name.
class _PlaceStrip extends StatelessWidget {
  final String location;
  const _PlaceStrip({required this.location});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Row(
        children: [
          Icon(
            PhosphorIconsRegular.mapPin,
            size: context.bodyFont * 0.95,
            color: cs.onSurfaceVariant,
          ),
          SizedBox(width: context.w * 0.02),
          Expanded(
            child: Text(
              location,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
                          userAgentPackageName: 'xyz.sippd.app',
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            point: LatLng(latitude!, longitude!),
                            width: context.w * 0.1,
                            height: context.w * 0.1,
                            child: Icon(PhosphorIconsFill.mapPin,
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
                          Icon(PhosphorIconsRegular.mapPin,
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

typedef _AttendeeEntry = ({FriendProfileEntity profile, RsvpStatus status});

Color _rsvpColor(RsvpStatus s, ColorScheme cs) => switch (s) {
      RsvpStatus.going => const Color(0xFF6DC383),
      RsvpStatus.maybe => const Color(0xFFE0A860),
      RsvpStatus.declined => cs.error,
      RsvpStatus.noResponse => cs.outline,
    };

int _rsvpOrder(RsvpStatus s) => switch (s) {
      RsvpStatus.going => 0,
      RsvpStatus.maybe => 1,
      RsvpStatus.noResponse => 2,
      RsvpStatus.declined => 3,
    };

class _AttendeesCard extends ConsumerWidget {
  final TastingEntity tasting;
  const _AttendeesCard({required this.tasting});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final attendeesAsync =
        ref.watch(tastingAttendeesProvider(tasting.id));
    final membersAsync = ref.watch(groupMembersProvider(tasting.groupId));

    final attendees = attendeesAsync.valueOrNull ?? const [];
    final members = membersAsync.valueOrNull ?? const [];

    if (members.isEmpty && attendeesAsync.isLoading ||
        membersAsync.isLoading && members.isEmpty) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: SizedBox(
          height: context.w * 0.11,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: context.w * 0.05,
              height: context.w * 0.05,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: cs.primary),
            ),
          ),
        ),
      );
    }

    final statusById = <String, RsvpStatus>{
      for (final a in attendees)
        if (a.profile != null) a.profile!.id: a.status,
    };

    final combined = <_AttendeeEntry>[
      for (final m in members)
        (profile: m, status: statusById[m.id] ?? RsvpStatus.noResponse),
    ]..sort((a, b) => _rsvpOrder(a.status).compareTo(_rsvpOrder(b.status)));

    if (combined.isEmpty) {
      return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: Text('No one invited yet.',
            style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant)),
      );
    }

    final going =
        combined.where((e) => e.status == RsvpStatus.going).length;
    final maybe =
        combined.where((e) => e.status == RsvpStatus.maybe).length;
    final declined =
        combined.where((e) => e.status == RsvpStatus.declined).length;
    final pending = combined
        .where((e) => e.status == RsvpStatus.noResponse)
        .length;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _showAttendeesSheet(context, combined),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AvatarCluster(items: combined, maxVisible: 6),
            SizedBox(height: context.s),
            Text(
              [
                if (going > 0) '$going going',
                if (maybe > 0) '$maybe maybe',
                if (declined > 0) '$declined declined',
                if (pending > 0) '$pending pending',
              ].join(' · '),
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAttendeesSheet(
    BuildContext context, List<_AttendeeEntry> all) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
    isScrollControlled: true,
    builder: (_) => _AttendeesSheet(all: all),
  );
}

class _AvatarCluster extends StatelessWidget {
  final List<_AttendeeEntry> items;
  final int maxVisible;
  const _AvatarCluster({required this.items, required this.maxVisible});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final avatarSize = context.w * 0.11;
    final step = avatarSize * 0.72;
    final showOverflow = items.length > maxVisible;
    final visibleCount = showOverflow ? maxVisible - 1 : items.length;
    final overflow = items.length - visibleCount;
    final slots = visibleCount + (showOverflow ? 1 : 0);
    final totalWidth = step * (slots - 1) + avatarSize;

    return SizedBox(
      width: totalWidth,
      height: avatarSize,
      child: Stack(
        children: [
          for (int i = 0; i < visibleCount; i++)
            Positioned(
              left: i * step,
              child: _AvatarWithStatus(
                item: items[i],
                size: avatarSize,
              ),
            ),
          if (showOverflow)
            Positioned(
              left: visibleCount * step,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: cs.surface,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text('+$overflow',
                      style: TextStyle(
                        fontSize: context.captionFont * 0.9,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AvatarWithStatus extends StatelessWidget {
  final _AttendeeEntry item;
  final double size;
  const _AvatarWithStatus({required this.item, required this.size});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dotSize = size * 0.32;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: cs.surface,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: FriendAvatar(profile: item.profile, size: size - 4),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: _rsvpColor(item.status, cs),
                shape: BoxShape.circle,
                border: Border.all(color: cs.surface, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendeesSheet extends StatelessWidget {
  final List<_AttendeeEntry> all;
  const _AttendeesSheet({required this.all});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final groups = <(String, RsvpStatus)>[
      ('Going', RsvpStatus.going),
      ('Maybe', RsvpStatus.maybe),
      ('Declined', RsvpStatus.declined),
      ('Pending', RsvpStatus.noResponse),
    ];

    final children = <Widget>[];
    children.add(Center(
      child: Container(
        width: context.w * 0.12,
        height: 4,
        margin: EdgeInsets.only(bottom: context.m),
        decoration: BoxDecoration(
          color: cs.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    ));

    for (final (label, status) in groups) {
      final members =
          all.where((a) => a.status == status).toList();
      if (members.isEmpty) continue;
      children.add(Padding(
        padding: EdgeInsets.only(top: context.s, bottom: context.xs),
        child: Row(
          children: [
            Container(
              width: context.w * 0.025,
              height: context.w * 0.025,
              decoration: BoxDecoration(
                color: _rsvpColor(status, cs),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: context.s),
            Text('$label · ${members.length}',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface.withValues(alpha: 0.72),
                  letterSpacing: 1.2,
                )),
          ],
        ),
      ));
      for (final m in members) {
        children.add(InkWell(
          onTap: () {
            Navigator.pop(context);
            context.push(AppRoutes.friendProfilePath(m.profile.id));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: context.xs),
            child: Row(
              children: [
                FriendAvatar(
                    profile: m.profile, size: context.w * 0.1),
                SizedBox(width: context.m),
                Expanded(
                  child: Text(
                    m.profile.displayName ??
                        m.profile.username ??
                        'Unknown',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      }
    }

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.paddingH * 1.3, vertical: context.m),
        child: ListView(
          shrinkWrap: true,
          children: children,
        ),
      ),
    );
  }
}

class _WinesSection extends ConsumerWidget {
  final TastingEntity tasting;
  final bool isOwner;
  const _WinesSection({required this.tasting, required this.isOwner});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(tastingWinesProvider(tasting.id));
    final ratingsAsync = ref.watch(tastingWineRatingsProvider(tasting.id));
    final ratings = ratingsAsync.valueOrNull ?? const {};

    // Add-wines visibility:
    //   * Upcoming  → host curates the lineup (planning phase)
    //   * Active    → any going-attendee can drop a bottle in (everyone
    //                 -brings home tastings + winery walk-ups need this)
    //   * Concluded → lineup is locked
    final attendees = ref.watch(tastingAttendeesProvider(tasting.id))
            .valueOrNull ??
        const <TastingAttendeeEntity>[];
    final currentUid = ref.watch(currentUserIdProvider);
    final amGoing = attendees.any((a) =>
        a.userId == currentUid && a.status == RsvpStatus.going);
    final canAdd = (tasting.state == TastingState.upcoming && isOwner) ||
        (tasting.state == TastingState.active && (amGoing || isOwner));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Row(
            children: [
              Expanded(
                child: Text('WINES',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.95,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface.withValues(alpha: 0.72),
                      letterSpacing: 1.2,
                    )),
              ),
              if (canAdd)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    final existing = winesAsync.valueOrNull ?? const [];
                    // existing wines come from the catalog (id ==
                    // canonical_wine_id), so the picker matches user's
                    // personal wines by their canonicalWineId field.
                    final existingCanonicalIds = existing
                        .map((w) => w.canonicalWineId ?? w.id)
                        .toSet();
                    final picked = await showWinePickerSheet(
                      context: context,
                      alreadyInLineup: existingCanonicalIds,
                    );
                    if (picked != null && picked.isNotEmpty) {
                      await ref
                          .read(tastingsControllerProvider.notifier)
                          .addWines(tasting.id, picked);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(PhosphorIconsRegular.plus,
                          size: context.w * 0.04, color: cs.primary),
                      SizedBox(width: context.w * 0.01),
                      Text('Add wines',
                          style: TextStyle(
                            fontSize: context.captionFont,
                            fontWeight: FontWeight.w600,
                            color: cs.primary,
                          )),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: context.s),
        winesAsync.when(
          data: (wines) {
            if (wines.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.paddingH * 1.3,
                    vertical: context.m),
                child: _WinesEmptyState(
                  isOwner: isOwner,
                  lineupMode: tasting.lineupMode,
                  state: tasting.state,
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: context.paddingH * 1.3),
              itemCount: wines.length,
              separatorBuilder: (_, __) => SizedBox(height: context.s),
              itemBuilder: (_, i) {
                final cid = wines[i].canonicalWineId ?? wines[i].id;
                return _WineLineupCard(
                  wine: wines[i],
                  rank: i + 1,
                  tastingId: tasting.id,
                  tastingState: tasting.state,
                  groupId: tasting.groupId,
                  canRemove: isOwner,
                  ratingOverride: ratings[cid],
                  onRemove: () => ref
                      .read(tastingsControllerProvider.notifier)
                      .removeWine(tasting.id, wines[i].id),
                );
              },
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
        ),
      ],
    );
  }
}

class _WinesEmptyState extends StatelessWidget {
  final bool isOwner;
  final TastingLineupMode lineupMode;
  final TastingState state;

  const _WinesEmptyState({
    required this.isOwner,
    required this.lineupMode,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.w * 0.2,
            height: context.w * 0.2,
            decoration: BoxDecoration(
                color: cs.primaryContainer, shape: BoxShape.circle),
            child: Icon(PhosphorIconsRegular.wine,
                size: context.w * 0.1, color: cs.primary),
          ),
          SizedBox(height: context.m),
          Text(_title,
              style: TextStyle(
                  fontSize: context.bodyFont, fontWeight: FontWeight.w600)),
          SizedBox(height: context.xs),
          Text(
            _hint(isOwner: isOwner),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  String get _title {
    if (lineupMode == TastingLineupMode.open &&
        state == TastingState.active) {
      return 'Lineup fills as you go';
    }
    return 'No wines lined up yet';
  }

  String _hint({required bool isOwner}) {
    if (lineupMode == TastingLineupMode.open &&
        state == TastingState.active) {
      return 'Anyone going can add bottles as they appear';
    }
    if (lineupMode == TastingLineupMode.open) {
      return isOwner
          ? 'Wines can be added once the tasting starts'
          : 'Wines will be added on the night';
    }
    return isOwner
        ? 'Tap “Add wines” to build the lineup'
        : 'The host hasn’t added wines yet';
  }
}

class _WineLineupCard extends ConsumerWidget {
  final WineEntity wine;
  final int rank;
  final String tastingId;
  final TastingState tastingState;
  final String groupId;
  final bool canRemove;
  final double? ratingOverride;
  final VoidCallback onRemove;

  const _WineLineupCard({
    required this.wine,
    required this.rank,
    required this.tastingId,
    required this.tastingState,
    required this.groupId,
    required this.canRemove,
    required this.onRemove,
    this.ratingOverride,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      children: [
        WineCardWidget(
          wine: wine,
          rank: rank,
          ratingOverride: ratingOverride,
          hideRatingIfEmpty: true,
          onTap: () {
            // While the tasting is live or concluded, the lineup card
            // is a rating surface — tap = open the rate sheet rather
            // than navigating away. Upcoming tastings keep the planning
            // drilldown to the wine's full detail screen.
            if (tastingState == TastingState.active ||
                tastingState == TastingState.concluded) {
              showTastingRateSheet(
                context: context,
                tastingId: tastingId,
                wine: wine,
              );
              return;
            }
            // Tasting wines are catalog-keyed (id == canonical_wine_id).
            // If the user owns a personal log row for this canonical
            // bottle, route to their full personal detail; otherwise
            // fall back to the canonical group wine detail screen.
            final cid = wine.canonicalWineId ?? wine.id;
            final localWines =
                ref.read(wineControllerProvider).valueOrNull ?? const [];
            WineEntity? mine;
            for (final w in localWines) {
              if (w.canonicalWineId == cid) {
                mine = w;
                break;
              }
            }
            if (mine != null) {
              context.push(AppRoutes.wineDetailPath(mine.id), extra: mine);
            } else {
              context.push(
                AppRoutes.groupWineDetailPath(groupId, cid),
                extra: wine,
              );
            }
          },
        ),
        if (canRemove)
          Positioned(
            top: context.xs,
            right: context.xs,
            child: GestureDetector(
              onTap: onRemove,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.all(context.xs),
                decoration: BoxDecoration(
                  color: cs.surface.withValues(alpha: 0.85),
                  shape: BoxShape.circle,
                ),
                child: Icon(PhosphorIconsRegular.x,
                    size: context.w * 0.04, color: cs.onSurfaceVariant),
              ),
            ),
          ),
      ],
    );
  }
}

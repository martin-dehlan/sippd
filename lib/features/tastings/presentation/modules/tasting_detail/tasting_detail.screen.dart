import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
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
import '../../../../../common/utils/share_origin.dart';
import '../../widgets/calendar_export_sheet.dart';
import '../../widgets/tasting_rate_sheet.dart';
import '../../widgets/tasting_recap_section.widget.dart';
import '../../widgets/wine_picker_sheet.dart';
import '../../../../promo/promo.config.dart';
import '../../../../promo/presentation/demo_spotlight.widget.dart';

class TastingDetailScreen extends ConsumerWidget {
  final String tastingId;
  const TastingDetailScreen({super.key, required this.tastingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    // Demo builds bypass the live provider entirely and play a curated,
    // self-driving walk through the whole lifecycle (upcoming → live →
    // concluded) so a recording always shows the full flow with full data,
    // regardless of what the signed-in account's tasting actually holds.
    if (kIsDemo) {
      return const Scaffold(
        body: SafeArea(child: _DemoTastingBody()),
        floatingActionButton: _BackFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      );
    }
    final tastingAsync = ref.watch(tastingDetailProvider(tastingId));
    return Scaffold(
      body: SafeArea(
        child: tastingAsync.when(
          data: (t) {
            if (t == null) {
              return Center(child: Text(l10n.tastingDetailNotFound));
            }
            return _Body(tasting: t);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: ErrorView(title: l10n.tastingDetailErrorLoad, error: e),
          ),
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
        Icon(
          PhosphorIconsRegular.calendarBlank,
          size: context.w * 0.04,
          color: cs.onSurfaceVariant,
        ),
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
        Icon(
          PhosphorIconsRegular.clock,
          size: context.w * 0.04,
          color: cs.onSurfaceVariant,
        ),
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
    final l10n = AppLocalizations.of(context);
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
            right: context.paddingH * 0.8,
          ),
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
                      label: l10n.tastingDetailMenuAddToCalendar,
                      onTap: () => addTastingToCalendar(
                        context: context,
                        tasting: tasting,
                      ),
                    ),
                    OverflowMenuItem(
                      icon: PhosphorIconsRegular.shareNetwork,
                      label: l10n.tastingDetailMenuShare,
                      onTap: () => Share.share(
                        '${tasting.title}\n\n${DeepLinkService.tastingHttpsUri(tasting.id)}',
                        subject: tasting.title,
                        sharePositionOrigin: shareOriginFor(context),
                      ),
                    ),
                  ],
                  if (isOwner)
                    [
                      OverflowMenuItem(
                        icon: PhosphorIconsRegular.pencilSimple,
                        label: l10n.tastingDetailMenuEdit,
                        onTap: () =>
                            context.push(AppRoutes.tastingEditPath(tasting.id)),
                      ),
                      OverflowMenuItem(
                        icon: PhosphorIconsRegular.calendarX,
                        label: l10n.tastingDetailMenuCancel,
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
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: _WhenRow(when: local),
        ),
        if (tasting.description != null && tasting.description!.isNotEmpty) ...[
          SizedBox(height: context.s),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
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
          label: l10n.tastingDetailSectionPeople,
          child: _AttendeesCard(tasting: tasting),
        ),
        SizedBox(height: context.l),
        _RsvpBar(tasting: tasting),
        SizedBox(height: context.l),
        if (tasting.location != null) ...[
          if (tasting.state == TastingState.upcoming)
            _Section(
              label: l10n.tastingDetailSectionPlace,
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
    BuildContext context,
    WidgetRef ref,
    TastingEntity t,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.tastingDetailCancelDialogTitle),
        content: Text(l10n.tastingDetailCancelDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.tastingDetailCancelDialogKeep),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.tastingDetailCancelDialogConfirm,
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
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
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.tastingDetailEndDialogTitle),
        content: Text(l10n.tastingDetailEndDialogBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.tastingDetailEndDialogKeep),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.tastingDetailEndDialogConfirm),
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
    final l10n = AppLocalizations.of(context);
    final now = DateTime.now();
    final hoursUntil = tasting.scheduledAt.difference(now).inHours;
    // Surface the Start CTA only inside a ±6h window around scheduledAt.
    // Outside that window, host still sees the pill but no button — keeps
    // the screen calm for far-future events.
    final canStart = isOwner && hoursUntil <= 6 && hoursUntil >= -12;
    return _BannerShell(
      cs: cs,
      icon: PhosphorIconsRegular.calendarBlank,
      label: l10n.tastingLifecycleUpcoming,
      tone: cs.surfaceContainerHigh,
      foreground: cs.onSurface,
      action: canStart
          ? _BannerAction(
              label: l10n.tastingLifecycleStartCta,
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
    final l10n = AppLocalizations.of(context);
    return _BannerShell(
      cs: cs,
      icon: PhosphorIconsFill.circle,
      label: l10n.tastingLifecycleLive,
      tone: cs.primaryContainer,
      foreground: cs.onPrimaryContainer,
      action: isOwner
          ? _BannerAction(
              label: l10n.tastingLifecycleEndCta,
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
      label: AppLocalizations.of(context).tastingLifecycleConcluded,
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

/// Thin wrapper — TastingRecapSection now owns its own wine + entries
/// fetches so loading vs empty can be distinguished cleanly.
class _RecapSwitcher extends StatelessWidget {
  const _RecapSwitcher({required this.tasting});
  final TastingEntity tasting;

  @override
  Widget build(BuildContext context) {
    return TastingRecapSection(
      tastingId: tasting.id,
      groupId: tasting.groupId,
      tastingTitle: tasting.title,
      scheduledAt: tasting.scheduledAt,
      location: tasting.location,
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
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: context.captionFont * 0.95,
              fontWeight: FontWeight.w700,
              color: cs.onSurface.withValues(alpha: 0.72),
              letterSpacing: 1.2,
            ),
          ),
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
    final attendeesAsync = ref.watch(tastingAttendeesProvider(tasting.id));
    final currentUid = ref.watch(currentUserIdProvider);
    final myStatus =
        attendeesAsync.whenOrNull(
          data: (list) {
            try {
              return list.firstWhere((a) => a.userId == currentUid).status;
            } catch (_) {
              return RsvpStatus.noResponse;
            }
          },
        ) ??
        RsvpStatus.noResponse;

    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Row(
        children: [
          Text(
            l10n.tastingDetailRsvpYour,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
          const Spacer(),
          SegmentedButton<RsvpStatus>(
            showSelectedIcon: false,
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            segments: [
              ButtonSegment(
                value: RsvpStatus.going,
                label: Text(l10n.tastingDetailRsvpGoing),
              ),
              ButtonSegment(
                value: RsvpStatus.maybe,
                label: Text(l10n.tastingDetailRsvpMaybe),
              ),
              ButtonSegment(
                value: RsvpStatus.declined,
                label: Text(l10n.tastingDetailRsvpDeclined),
              ),
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
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(latitude!, longitude!),
                              width: context.w * 0.1,
                              height: context.w * 0.1,
                              child: Icon(
                                PhosphorIconsFill.mapPin,
                                size: context.w * 0.1,
                                color: cs.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: context.m,
                    right: context.m,
                    bottom: context.m,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.m,
                        vertical: context.s,
                      ),
                      decoration: BoxDecoration(
                        color: cs.surface.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(context.w * 0.02),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIconsRegular.mapPin,
                            size: context.w * 0.045,
                            color: cs.primary,
                          ),
                          SizedBox(width: context.w * 0.02),
                          Expanded(
                            child: Text(
                              location,
                              style: TextStyle(
                                fontSize: context.bodyFont,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  location,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
    final attendeesAsync = ref.watch(tastingAttendeesProvider(tasting.id));
    final membersAsync = ref.watch(groupMembersProvider(tasting.groupId));

    final attendees = attendeesAsync.valueOrNull ?? const [];
    final members = membersAsync.valueOrNull ?? const [];

    if (members.isEmpty && attendeesAsync.isLoading ||
        membersAsync.isLoading && members.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: SizedBox(
          height: context.w * 0.11,
          child: Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: context.w * 0.05,
              height: context.w * 0.05,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: cs.primary,
              ),
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

    final l10n = AppLocalizations.of(context);

    if (combined.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
        child: Text(
          l10n.tastingDetailNoAttendees,
          style: TextStyle(
            fontSize: context.captionFont,
            color: cs.onSurfaceVariant,
          ),
        ),
      );
    }

    final going = combined.where((e) => e.status == RsvpStatus.going).length;
    final maybe = combined.where((e) => e.status == RsvpStatus.maybe).length;
    final declined = combined
        .where((e) => e.status == RsvpStatus.declined)
        .length;
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
                if (going > 0) l10n.tastingDetailAttendeesCountGoing(going),
                if (maybe > 0) l10n.tastingDetailAttendeesCountMaybe(maybe),
                if (declined > 0)
                  l10n.tastingDetailAttendeesCountDeclined(declined),
                if (pending > 0)
                  l10n.tastingDetailAttendeesCountPending(pending),
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

void _showAttendeesSheet(BuildContext context, List<_AttendeeEntry> all) {
  showModalBottomSheet<void>(
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
              child: _AvatarWithStatus(item: items[i], size: avatarSize),
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
                  child: Text(
                    '+$overflow',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.9,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
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
    final l10n = AppLocalizations.of(context);
    final groups = <(String, RsvpStatus)>[
      (l10n.tastingDetailAttendeesSheetGoing, RsvpStatus.going),
      (l10n.tastingDetailAttendeesSheetMaybe, RsvpStatus.maybe),
      (l10n.tastingDetailAttendeesSheetDeclined, RsvpStatus.declined),
      (l10n.tastingDetailAttendeesSheetPending, RsvpStatus.noResponse),
    ];

    final children = <Widget>[];
    children.add(
      Center(
        child: Container(
          width: context.w * 0.12,
          height: 4,
          margin: EdgeInsets.only(bottom: context.m),
          decoration: BoxDecoration(
            color: cs.outlineVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );

    for (final (label, status) in groups) {
      final members = all.where((a) => a.status == status).toList();
      if (members.isEmpty) continue;
      children.add(
        Padding(
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
              Text(
                '$label · ${members.length}',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface.withValues(alpha: 0.72),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      );
      for (final m in members) {
        children.add(
          InkWell(
            onTap: () {
              Navigator.pop(context);
              context.push(AppRoutes.friendProfilePath(m.profile.id));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.xs),
              child: Row(
                children: [
                  FriendAvatar(profile: m.profile, size: context.w * 0.1),
                  SizedBox(width: context.m),
                  Expanded(
                    child: Text(
                      m.profile.displayName ??
                          m.profile.username ??
                          l10n.tastingDetailUnknownAttendee,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH * 1.3,
          vertical: context.m,
        ),
        child: ListView(shrinkWrap: true, children: children),
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
    final l10n = AppLocalizations.of(context);
    final winesAsync = ref.watch(tastingWinesProvider(tasting.id));
    final ratingsAsync = ref.watch(tastingWineRatingsProvider(tasting.id));
    final ratings = ratingsAsync.valueOrNull ?? const {};

    // Add-wines visibility:
    //   * Upcoming  → host curates the lineup (planning phase)
    //   * Active    → any going-attendee can drop a bottle in (everyone
    //                 -brings home tastings + winery walk-ups need this)
    //   * Concluded → lineup is locked
    final attendees =
        ref.watch(tastingAttendeesProvider(tasting.id)).valueOrNull ??
        const <TastingAttendeeEntity>[];
    final currentUid = ref.watch(currentUserIdProvider);
    final amGoing = attendees.any(
      (a) => a.userId == currentUid && a.status == RsvpStatus.going,
    );
    final canAdd =
        (tasting.state == TastingState.upcoming && isOwner) ||
        (tasting.state == TastingState.active && (amGoing || isOwner));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.tastingDetailSectionWines,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.72),
                    letterSpacing: 1.2,
                  ),
                ),
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
                      Icon(
                        PhosphorIconsRegular.plus,
                        size: context.w * 0.04,
                        color: cs.primary,
                      ),
                      SizedBox(width: context.w * 0.01),
                      Text(
                        l10n.tastingDetailAddWines,
                        style: TextStyle(
                          fontSize: context.captionFont,
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
                        ),
                      ),
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
                  vertical: context.m,
                ),
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
              padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
              itemCount: wines.length,
              separatorBuilder: (_, _) => SizedBox(height: context.s),
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
          error: (_, _) => const SizedBox.shrink(),
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
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: context.w * 0.2,
            height: context.w * 0.2,
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              PhosphorIconsRegular.wine,
              size: context.w * 0.1,
              color: cs.primary,
            ),
          ),
          SizedBox(height: context.m),
          Text(
            _title(l10n),
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.xs),
          Text(
            _hint(l10n, isOwner: isOwner),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _title(AppLocalizations l10n) {
    if (lineupMode == TastingLineupMode.open && state == TastingState.active) {
      return l10n.tastingEmptyOpenActiveTitle;
    }
    return l10n.tastingEmptyDefaultTitle;
  }

  String _hint(AppLocalizations l10n, {required bool isOwner}) {
    if (lineupMode == TastingLineupMode.open && state == TastingState.active) {
      return l10n.tastingEmptyOpenActiveBody;
    }
    if (lineupMode == TastingLineupMode.open) {
      return isOwner
          ? l10n.tastingEmptyOpenUpcomingHost
          : l10n.tastingEmptyOpenUpcomingGuest;
    }
    return isOwner
        ? l10n.tastingEmptyPlannedHost
        : l10n.tastingEmptyPlannedGuest;
  }
}

// ═════════════════════════════════════════════════════════════════════
// DEMO ONLY — curated, self-driving lifecycle walkthrough.
//
// Renders the real detail chrome (title, when-row, phase banner, place
// strip, wine cards) but fed deterministic fixtures and driven through
// upcoming → live → concluded by a local director. Sets [demoScreenBusy]
// so the auto-tour holds here until the full flow has played. Tree-shaken
// from production via the `kIsDemo` guard at the call site.
// ═════════════════════════════════════════════════════════════════════

class _DemoTastingBody extends StatefulWidget {
  const _DemoTastingBody();

  @override
  State<_DemoTastingBody> createState() => _DemoTastingBodyState();
}

class _DemoTastingBodyState extends State<_DemoTastingBody>
    with TickerProviderStateMixin {
  TastingState _phase = TastingState.upcoming;

  // The night's lineup — names, wineries, regions and types all matched to
  // the bundled bottle photos. Recap ranks it high→low.
  static final List<WineEntity> _wines = [
    WineEntity(
      id: 'dw-cabernet',
      name: 'Cabernet Sauvignon',
      winery: "Stag's Leap Wine Cellars",
      vintage: 2019,
      type: WineType.red,
      grape: 'Cabernet Sauvignon',
      region: 'Napa Valley',
      country: 'United States',
      price: 120,
      rating: 9.3,
      imageUrl: 'assets/promo/wines/cabernet.png',
      userId: 'demo',
      createdAt: DateTime(2026, 5, 9),
    ),
    WineEntity(
      id: 'dw-riesling-mosel',
      name: 'Scharzhofberger Riesling',
      winery: 'Egon Müller',
      vintage: 2018,
      type: WineType.white,
      grape: 'Riesling',
      region: 'Mosel',
      country: 'Germany',
      price: 95,
      rating: 9.1,
      imageUrl: 'assets/promo/wines/riesling_mosel.png',
      userId: 'demo',
      createdAt: DateTime(2026, 5, 9),
    ),
    WineEntity(
      id: 'dw-malbec',
      name: 'Malbec',
      winery: 'Catena Zapata',
      vintage: 2020,
      type: WineType.red,
      grape: 'Malbec',
      region: 'Mendoza',
      country: 'Argentina',
      price: 45,
      rating: 8.8,
      imageUrl: 'assets/promo/wines/malbec.png',
      userId: 'demo',
      createdAt: DateTime(2026, 5, 9),
    ),
    WineEntity(
      id: 'dw-chardonnay',
      name: 'Chardonnay',
      winery: 'Bourgogne',
      vintage: 2019,
      type: WineType.white,
      grape: 'Chardonnay',
      region: 'Burgundy',
      country: 'France',
      price: 55,
      rating: 8.5,
      imageUrl: 'assets/promo/wines/chardonnay.png',
      userId: 'demo',
      createdAt: DateTime(2026, 5, 9),
    ),
    WineEntity(
      id: 'dw-riesling-pfalz',
      name: 'Riesling',
      winery: 'Müller-Catoir',
      vintage: 2018,
      type: WineType.white,
      grape: 'Riesling',
      region: 'Pfalz',
      country: 'Germany',
      price: 38,
      rating: 8.3,
      imageUrl: 'assets/promo/wines/riesling_pfalz.png',
      userId: 'demo',
      createdAt: DateTime(2026, 5, 9),
    ),
    WineEntity(
      id: 'dw-sauternes',
      name: 'Sauternes',
      winery: 'Bordeaux',
      vintage: 2016,
      type: WineType.white,
      grape: 'Sémillon',
      region: 'Sauternes',
      country: 'France',
      price: 75,
      rating: 8.0,
      imageUrl: 'assets/promo/wines/sauternes.png',
      userId: 'demo',
      createdAt: DateTime(2026, 5, 9),
    ),
  ];
  late final List<WineEntity> _ranked = [..._wines]
    ..sort((a, b) => b.rating.compareTo(a.rating));

  // Lineup cards pop in on mount; ratings count up when live; recap reveals
  // when concluded — each its own controller so beats can overlap cleanly.
  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..forward();
  late final AnimationController _rate = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1900),
  );
  late final AnimationController _recap = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  );

  late final TastingEntity _tasting = _buildTasting();

  TastingEntity _buildTasting() {
    final now = DateTime.now();
    return TastingEntity(
      id: 'demo-tasting',
      groupId: 'demo-group',
      title: 'Cellar Night',
      description: 'Six bottles, served blind, scored as a group.',
      location: 'Weinbar Mitte · Berlin',
      // Inside the ±6h Start window so the host's "Start tasting" CTA shows.
      scheduledAt: now.add(const Duration(hours: 1)),
      createdBy: 'demo-user',
      createdAt: now.subtract(const Duration(days: 3)),
      state: TastingState.upcoming,
    );
  }

  @override
  void initState() {
    super.initState();
    if (kIsDemo) _run();
  }

  Future<void> _wait(int ms) =>
      Future<void>.delayed(Duration(milliseconds: ms));

  /// Director: hold on each phase long enough for its entrance to read,
  /// flipping the banner + sections in turn. Busy flag gates the tour.
  Future<void> _run() async {
    demoScreenBusy.value = true;

    // Upcoming — title, guests, place and the lineup populate (planning).
    await _wait(3000);
    if (!mounted) return _end();

    // Live — host "starts" it; every bottle's score counts up.
    setState(() => _phase = TastingState.active);
    _rate.forward(from: 0);
    await _wait(3400);
    if (!mounted) return _end();

    // Concluded — host "ends" it; the recap + leaderboard reveal.
    setState(() => _phase = TastingState.concluded);
    _recap.forward(from: 0);
    await _wait(4200);

    _end();
  }

  void _end() {
    if (mounted) demoScreenBusy.value = false;
  }

  @override
  void dispose() {
    demoScreenBusy.value = false;
    _pop.dispose();
    _rate.dispose();
    _recap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tasting = _tasting.copyWith(state: _phase);
    final local = tasting.scheduledAt.toLocal();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Text(
            tasting.title.toUpperCase(),
            style: GoogleFonts.playfairDisplay(
              fontSize: context.titleFont * 1.2,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
              height: 1.05,
            ),
          ),
        ),
        SizedBox(height: context.s),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: _WhenRow(when: local),
        ),
        SizedBox(height: context.s),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Text(
            tasting.description!,
            style: TextStyle(
              fontSize: context.bodyFont,
              color: cs.onSurface,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: context.l),
        // Lifecycle stepper — lean status rail that highlights which phase
        // we're in and slides a progress fill forward as the night advances,
        // so the viewer clearly reads "oh — it's changing".
        _PhaseStepper(phase: _phase),
        SizedBox(height: context.l),
        // Phase banner — cross-fades as the night moves through its states.
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 460),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: ScaleTransition(
                scale: Tween(begin: 0.96, end: 1.0).animate(anim),
                child: child,
              ),
            ),
            child: KeyedSubtree(
              key: ValueKey(_phase),
              child: _PhaseBanner(tasting: tasting, isOwner: true),
            ),
          ),
        ),
        SizedBox(height: context.l),
        _Section(label: 'Guests', child: const _DemoGuests()),
        SizedBox(height: context.l),
        _PlaceStrip(location: tasting.location!),
        SizedBox(height: context.l),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 540),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(anim),
              child: child,
            ),
          ),
          child: _phase == TastingState.concluded
              ? _DemoRecap(
                  key: const ValueKey('recap'),
                  ranked: _ranked,
                  reveal: _recap,
                )
              : _DemoLineup(
                  key: const ValueKey('lineup'),
                  wines: _wines,
                  live: _phase == TastingState.active,
                  pop: _pop,
                  rate: _rate,
                ),
        ),
        SizedBox(height: context.xl * 2),
      ],
    );
  }
}

/// Lean lifecycle stepper. Three status pills (Upcoming · Live · Concluded):
/// the active one lifts with a primary fill + soft glow, completed ones stay
/// filled-subtle, future ones sit muted. A thin track underneath fills toward
/// the active pill's centre. Everything animates implicitly, so the phase flip
/// reads as one smooth, professional beat.
enum _StepState { todo, active, done }

class _PhaseStepper extends StatelessWidget {
  const _PhaseStepper({required this.phase});
  final TastingState phase;

  static const _steps = <(TastingState, String, IconData)>[
    (TastingState.upcoming, 'Upcoming', PhosphorIconsRegular.calendarBlank),
    (TastingState.active, 'Live', PhosphorIconsFill.circle),
    (TastingState.concluded, 'Concluded', PhosphorIconsRegular.checkCircle),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final activeIndex = phase.index;
    // Fill head lands on the active pill's centre (each pill = a third).
    final fill = (activeIndex + 0.5) / _steps.length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Column(
        children: [
          Row(
            children: [
              for (final (i, step) in _steps.indexed) ...[
                if (i > 0) SizedBox(width: context.w * 0.02),
                Expanded(
                  child: _StepPill(
                    label: step.$2,
                    icon: step.$3,
                    state: i < activeIndex
                        ? _StepState.done
                        : i == activeIndex
                            ? _StepState.active
                            : _StepState.todo,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: context.s),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: SizedBox(
              height: context.w * 0.012,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ColoredBox(
                      color: cs.onSurface.withValues(alpha: 0.08),
                    ),
                  ),
                  AnimatedFractionallySizedBox(
                    duration: const Duration(milliseconds: 620),
                    curve: Curves.easeOutCubic,
                    widthFactor: fill,
                    alignment: Alignment.centerLeft,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: cs.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepPill extends StatelessWidget {
  const _StepPill({
    required this.label,
    required this.icon,
    required this.state,
  });
  final String label;
  final IconData icon;
  final _StepState state;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final active = state == _StepState.active;
    final done = state == _StepState.done;

    final bg = active
        ? cs.primary
        : done
            ? cs.primaryContainer
            : cs.surfaceContainer;
    final fg = active
        ? cs.onPrimary
        : done
            ? cs.onPrimaryContainer
            : cs.onSurfaceVariant;

    return AnimatedScale(
      duration: const Duration(milliseconds: 440),
      curve: Curves.easeOutBack,
      scale: active ? 1.0 : 0.93,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.02,
          vertical: context.s * 1.05,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: cs.primary.withValues(alpha: 0.45),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: context.bodyFont * 0.9, color: fg),
            SizedBox(width: context.w * 0.012),
            Flexible(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 320),
                style: TextStyle(
                  fontSize: context.captionFont * 0.9,
                  fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                  color: fg,
                  letterSpacing: 0.3,
                ),
                child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Demo guests — overlapping avatar cluster with RSVP status dots, matching
/// the real attendees card silhouette without touching the friends provider.
class _DemoGuests extends StatelessWidget {
  const _DemoGuests();

  // (avatar asset, rsvp colour) — going green, maybe amber (real _rsvpColor
  // tones). Curated profile photos so the cluster reads like a real group.
  static const _people = [
    ('assets/promo/avatars/girl1.png', Color(0xFF6DC383)),
    ('assets/promo/avatars/men2.png', Color(0xFF6DC383)),
    ('assets/promo/avatars/girl2.png', Color(0xFF6DC383)),
    ('assets/promo/avatars/men3.png', Color(0xFFE0A860)),
    ('assets/promo/avatars/girl3.png', Color(0xFF6DC383)),
    ('assets/promo/avatars/men4.png', Color(0xFFE0A860)),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.11;
    final step = size * 0.72;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: step * (_people.length - 1) + size,
            height: size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (final (i, p) in _people.indexed)
                  Positioned(
                    left: i * step,
                    child: _DemoAvatar(
                      asset: p.$1,
                      dot: p.$2,
                      size: size,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: context.s),
          Text(
            '4 going · 2 maybe',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoAvatar extends StatelessWidget {
  const _DemoAvatar({
    required this.asset,
    required this.dot,
    required this.size,
  });
  final String asset;
  final Color dot;
  final double size;

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
              child: Image.asset(
                asset,
                width: size - 4,
                height: size - 4,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: dot,
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

/// Demo lineup — wine cards pop in (upcoming), then their ratings count up
/// once the night is live. Reuses the real [WineCardWidget].
class _DemoLineup extends StatelessWidget {
  const _DemoLineup({
    super.key,
    required this.wines,
    required this.live,
    required this.pop,
    required this.rate,
  });

  final List<WineEntity> wines;
  final bool live;
  final Animation<double> pop;
  final Animation<double> rate;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'WINES',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface.withValues(alpha: 0.72),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              if (!live)
                Row(
                  children: [
                    Icon(PhosphorIconsRegular.plus,
                        size: context.w * 0.04, color: cs.primary),
                    SizedBox(width: context.w * 0.01),
                    Text(
                      'Add wines',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        fontWeight: FontWeight.w600,
                        color: cs.primary,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        SizedBox(height: context.s),
        AnimatedBuilder(
          animation: Listenable.merge([pop, rate]),
          builder: (context, _) => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            itemCount: wines.length,
            separatorBuilder: (_, _) => SizedBox(height: context.s),
            itemBuilder: (_, i) {
              // Staggered pop-in across the lineup.
              final slot = i / wines.length;
              final p = ((pop.value - slot * 0.6) / 0.4).clamp(0.0, 1.0);
              final ease = Curves.easeOutBack.transform(p);

              // Live: each score counts up, staggered after the prior card.
              final rp = ((rate.value - i * 0.16) / 0.5).clamp(0.0, 1.0);
              final rating = live
                  ? wines[i].rating * Curves.easeOutCubic.transform(rp)
                  : 0.0;

              return Opacity(
                opacity: p,
                child: Transform.translate(
                  offset: Offset(0, (1 - ease) * context.m),
                  child: WineCardWidget(
                    wine: wines[i],
                    rank: i + 1,
                    ratingOverride: rating,
                    hideRatingIfEmpty: true,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Demo recap — concluded results: trophy top-wine card rises in, then the
/// ranked leaderboard cascades with avg pills and filling score bars.
class _DemoRecap extends StatelessWidget {
  const _DemoRecap({
    super.key,
    required this.ranked,
    required this.reveal,
  });

  final List<WineEntity> ranked;
  final Animation<double> reveal;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final top = ranked.first;

    return AnimatedBuilder(
      animation: reveal,
      builder: (context, _) {
        final r = reveal.value;
        final headerT = (r / 0.12).clamp(0.0, 1.0);
        final topT =
            Curves.easeOutCubic.transform(((r - 0.06) / 0.24).clamp(0.0, 1.0));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Opacity(
              opacity: headerT,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'RESULTS',
                        style: TextStyle(
                          fontSize: context.captionFont * 0.95,
                          fontWeight: FontWeight.w700,
                          color: cs.onSurface.withValues(alpha: 0.72),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    Icon(PhosphorIconsRegular.shareNetwork,
                        size: context.w * 0.04, color: cs.primary),
                    SizedBox(width: context.w * 0.012),
                    Text(
                      'Share recap',
                      style: TextStyle(
                        fontSize: context.captionFont,
                        fontWeight: FontWeight.w600,
                        color: cs.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: context.m),
            Opacity(
              opacity: topT,
              child: Transform.translate(
                offset: Offset(0, (1 - topT) * context.l),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
                  child: _DemoTopWine(wine: top),
                ),
              ),
            ),
            SizedBox(height: context.l),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
              child: Column(
                children: [
                  for (final (i, w) in ranked.indexed) ...[
                    if (i > 0)
                      Divider(
                        color: cs.outlineVariant.withValues(alpha: 0.6),
                        height: context.m,
                      ),
                    _DemoRecapRow(
                      rank: i + 1,
                      wine: w,
                      reveal:
                          ((r - (0.30 + i * 0.12)) / 0.28).clamp(0.0, 1.0),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DemoTopWine extends StatelessWidget {
  const _DemoTopWine({required this.wine});
  final WineEntity wine;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final imageSize = context.w * 0.18;
    final subtitle = [
      if (wine.winery != null) wine.winery!,
      if (wine.vintage != null) wine.vintage.toString(),
    ].join(' · ');

    return Container(
      padding: EdgeInsets.all(context.w * 0.045),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.045),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: imageSize,
            height: imageSize,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: imageSize,
                  height: imageSize,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: cs.surface.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(context.w * 0.03),
                  ),
                  alignment: Alignment.center,
                  child: wine.imageUrl != null
                      ? Image.asset(
                          wine.imageUrl!,
                          width: imageSize,
                          height: imageSize,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          PhosphorIconsFill.wine,
                          size: imageSize * 0.5,
                          color: cs.onPrimaryContainer.withValues(alpha: 0.55),
                        ),
                ),
                Positioned(
                  top: -context.xs * 0.8,
                  left: -context.xs * 0.8,
                  child: Container(
                    padding: EdgeInsets.all(context.xs * 0.7),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: cs.onPrimaryContainer,
                    ),
                    child: Icon(PhosphorIconsFill.trophy,
                        size: context.captionFont, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: context.w * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOP WINE OF THE NIGHT',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.85,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                    color: cs.onPrimaryContainer.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(height: context.xs),
                Text(
                  wine.name,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 0.85,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: cs.onPrimaryContainer,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: context.xs * 0.6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: context.w * 0.02),
          _DemoAvgPill(value: wine.rating, onPrimary: true),
        ],
      ),
    );
  }
}

class _DemoRecapRow extends StatelessWidget {
  const _DemoRecapRow({
    required this.rank,
    required this.wine,
    required this.reveal,
  });
  final int rank;
  final WineEntity wine;
  final double reveal;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ease = Curves.easeOutCubic.transform(reveal);
    final barH = context.w * 0.02;
    final barPct = (wine.rating / 10).clamp(0.0, 1.0) * ease;

    return Opacity(
      opacity: ease,
      child: Transform.translate(
        offset: Offset((1 - ease) * context.w * 0.06, 0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: context.xs * 0.6),
          child: Row(
            children: [
              SizedBox(
                width: context.w * 0.06,
                child: Text(
                  '$rank.',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wine.name,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600,
                        color: cs.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.xs * 0.8),
                    LayoutBuilder(
                      builder: (_, c) => SizedBox(
                        width: c.maxWidth,
                        height: barH,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: cs.surfaceContainer,
                                  borderRadius:
                                      BorderRadius.circular(barH / 2),
                                ),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: barPct,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: rank == 1
                                      ? cs.primary
                                      : cs.primary.withValues(alpha: 0.55),
                                  borderRadius:
                                      BorderRadius.circular(barH / 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.w * 0.03),
              _DemoAvgPill(value: wine.rating, onPrimary: false),
            ],
          ),
        ),
      ),
    );
  }
}

class _DemoAvgPill extends StatelessWidget {
  const _DemoAvgPill({required this.value, required this.onPrimary});
  final double value;
  final bool onPrimary;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fg = onPrimary ? cs.onPrimaryContainer : cs.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          value.toStringAsFixed(1),
          style: TextStyle(
            fontSize: context.bodyFont * 1.1,
            fontWeight: FontWeight.bold,
            color: fg,
            fontFeatures: tabularFigures,
          ),
        ),
        SizedBox(width: context.w * 0.008),
        Text(
          '/ 10',
          style: TextStyle(
            fontSize: context.captionFont * 0.85,
            color: fg.withValues(alpha: 0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
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
                ref: ref,
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
                child: Icon(
                  PhosphorIconsRegular.x,
                  size: context.w * 0.04,
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

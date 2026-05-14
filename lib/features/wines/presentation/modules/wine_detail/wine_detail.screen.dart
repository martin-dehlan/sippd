import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/l10n/generated/app_localizations.dart';
import '../../../../../common/utils/price_format.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/error_view.widget.dart';
import '../../../../../common/widgets/overflow_menu.widget.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../auth/controller/auth.provider.dart';
import '../../../../friends/controller/friends.provider.dart';
import '../../../../friends/domain/entities/friend_profile.entity.dart';
import '../../../../friends/presentation/widgets/friend_multi_picker.widget.dart';
import '../../../../groups/presentation/widgets/share_wine_sheet.dart';
import '../../../../paywall/controller/paywall.provider.dart';
import '../../../../profile/controller/profile.provider.dart';
import '../../../../share_cards/controller/share_card.provider.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../../domain/entities/wine_memory.entity.dart';
import '../../widgets/expert_tasting_sheet.dart';
import '../../widgets/expert_tasting_summary.widget.dart';
import '../../widgets/friend_ratings_strip.widget.dart';
import '../../widgets/wine_detail_blocks.widget.dart';
import '../moment_capture/moment_capture.screen.dart';
import '../moment_viewer/moment_viewer.screen.dart';
import '../wine_compare/wine_compare_flow.dart';

class WineDetailScreen extends ConsumerWidget {
  final String wineId;
  final WineEntity? initial;

  const WineDetailScreen({super.key, required this.wineId, this.initial});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineDetailProvider(wineId));
    final currentUserId = ref.watch(currentUserIdProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: wineAsync.when(
        data: (wine) {
          // Local lookup may miss for wines owned by other group members.
          // Fall back to the entity passed via go_router extra.
          final resolved = wine ?? initial;
          if (resolved == null) {
            return Center(child: Text(l10n.winesDetailNotFound));
          }
          final isOwner = resolved.userId == currentUserId;
          return WineDetailBody(
            wine: resolved,
            isOwner: isOwner,
            onDelete: isOwner
                ? () async {
                    await ref
                        .read(wineControllerProvider.notifier)
                        .deleteWine(wineId);
                    if (context.mounted) Navigator.pop(context);
                  }
                : null,
          );
        },
        loading: () {
          if (initial != null) {
            return WineDetailBody(
              wine: initial!,
              isOwner: initial!.userId == currentUserId,
              onDelete: null,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
        error: (e, _) {
          if (initial != null) {
            return WineDetailBody(
              wine: initial!,
              isOwner: initial!.userId == currentUserId,
              onDelete: null,
            );
          }
          return Center(
            child: ErrorView(title: l10n.winesDetailErrorLoad, error: e),
          );
        },
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class WineDetailBody extends ConsumerStatefulWidget {
  final WineEntity wine;
  final bool isOwner;
  final VoidCallback? onDelete;

  const WineDetailBody({
    super.key,
    required this.wine,
    required this.isOwner,
    required this.onDelete,
  });

  @override
  ConsumerState<WineDetailBody> createState() => _WineDetailBodyState();
}

class _WineDetailBodyState extends ConsumerState<WineDetailBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasCoords =
        widget.wine.latitude != null && widget.wine.longitude != null;

    return SafeArea(
      child: FadeTransition(
        opacity: _fadeIn,
        child: SlideTransition(
          position: _slideUp,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: context.xl * 1.5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: WineDetailTitle(name: widget.wine.name)),
                  if (widget.isOwner)
                    Padding(
                      padding: EdgeInsets.only(right: context.paddingH * 0.7),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Consumer(
                            builder: (context, ref, _) => _WineOverflowMenu(
                              onCompare: () => startCompareFlow(
                                context,
                                sourceWineId: widget.wine.id,
                              ),
                              onShareToGroup: () => showShareWineSheet(
                                context: context,
                                wineId: widget.wine.id,
                              ),
                              onShareToFriend: () =>
                                  _shareToFriend(context, ref),
                              onShareImage: () {
                                final username = ref
                                    .read(currentProfileProvider)
                                    .valueOrNull
                                    ?.username;
                                ref
                                    .read(shareCardProvider)
                                    .shareWineRatingCard(
                                      context: context,
                                      wine: widget.wine,
                                      username: username,
                                      source: 'wine_detail',
                                    );
                              },
                              onEdit: () => context.push(
                                AppRoutes.wineEditPath(widget.wine.id),
                              ),
                              onDelete: () => _confirmDelete(context),
                              onTastingNotes: () {
                                final isPro = ref.read(isProProvider);
                                if (!isPro) {
                                  context.push(
                                    AppRoutes.paywall,
                                    extra: const {'source': 'expert_tasting'},
                                  );
                                  return;
                                }
                                showExpertTastingSheet(
                                  context: context,
                                  wine: widget.wine,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              SizedBox(height: context.s),
              WineDetailMetaLine(
                type: widget.wine.type,
                winery: widget.wine.winery,
                vintage: widget.wine.vintage,
                canonicalGrapeId: widget.wine.canonicalGrapeId,
                grapeFreetext: widget.wine.grapeFreetext,
                legacyGrape: widget.wine.grape,
              ),
              SizedBox(height: context.xl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.paddingH),
                child: SizedBox(
                  height: context.h * 0.32,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: WineDetailImage(wine: widget.wine),
                      ),
                      Expanded(flex: 4, child: _StatsColumn(wine: widget.wine)),
                    ],
                  ),
                ),
              ),
              _MemoriesSection(wine: widget.wine),
              if (widget.wine.canonicalWineId != null) ...[
                SizedBox(height: context.xl),
                FriendRatingsStrip(
                  canonicalWineId: widget.wine.canonicalWineId!,
                ),
                SizedBox(height: context.l),
                // Read-only display of the user's own expert tasting
                // dimensions for this wine. Renders nothing when empty,
                // so non-Pro / unfilled wines stay clean.
                ExpertTastingSummary(
                  canonicalWineId: widget.wine.canonicalWineId!,
                  onEdit: () {
                    final isPro = ref.read(isProProvider);
                    if (!isPro) {
                      context.push(
                        AppRoutes.paywall,
                        extra: const {'source': 'expert_tasting_summary'},
                      );
                      return;
                    }
                    showExpertTastingSheet(context: context, wine: widget.wine);
                  },
                ),
              ],
              if (widget.wine.notes != null &&
                  widget.wine.notes!.isNotEmpty) ...[
                SizedBox(height: context.xl),
                WineDetailSectionHeader(
                  label: AppLocalizations.of(context).winesDetailSectionNotes,
                ),
                SizedBox(height: context.m),
                _NotesBlock(notes: widget.wine.notes!),
              ],
              SizedBox(height: context.xl),
              WineDetailSectionHeader(
                label: AppLocalizations.of(context).winesDetailSectionPlace,
              ),
              SizedBox(height: context.s),
              SizedBox(
                height: context.h * 0.28,
                child: _PlaceSection(wine: widget.wine, hasCoords: hasCoords),
              ),
              SizedBox(height: context.xxl * 1.5),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareToFriend(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final selected = await showFriendMultiPicker(
      context: context,
      initialSelected: const {},
      title: l10n.winesSharePickFriendsTitle,
    );
    if (selected == null || selected.isEmpty || !context.mounted) return;

    final friends =
        ref.read(friendsListProvider).valueOrNull ??
        const <FriendProfileEntity>[];
    final byId = {for (final f in friends) f.id: f};
    final repo = ref.read(wineRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    final sharedNames = <String>[];
    for (final friendId in selected) {
      try {
        await repo.shareToFriend(friendId: friendId, wineId: widget.wine.id);
        final f = byId[friendId];
        sharedNames.add(
          f?.displayName ?? f?.username ?? friendId.substring(0, 6),
        );
      } catch (_) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.winesShareError)));
        return;
      }
    }
    if (sharedNames.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.winesShareSuccess(sharedNames.join(', ')))),
      );
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.winesDetailDeleteTitle),
        content: Text(l10n.winesDetailDeleteBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.winesDetailDeleteCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              l10n.winesDetailDeleteConfirm,
              style: TextStyle(color: Theme.of(ctx).colorScheme.error),
            ),
          ),
        ],
      ),
    );
    if (confirmed == true) widget.onDelete?.call();
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'wine-detail-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => Navigator.pop(context),
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
      ),
    );
  }
}

class _WineOverflowMenu extends StatelessWidget {
  final VoidCallback onCompare;
  final VoidCallback onShareToGroup;
  final VoidCallback onShareToFriend;
  final VoidCallback onShareImage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTastingNotes;

  const _WineOverflowMenu({
    required this.onCompare,
    required this.onShareToGroup,
    required this.onShareToFriend,
    required this.onShareImage,
    required this.onEdit,
    required this.onDelete,
    this.onTastingNotes,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return OverflowMenu(
      circleBackground: true,
      groups: [
        [
          OverflowMenuItem(
            icon: PhosphorIconsRegular.swap,
            label: l10n.winesDetailMenuCompare,
            onTap: onCompare,
          ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.megaphoneSimple,
            label: l10n.winesDetailMenuShareRating,
            onTap: onShareImage,
          ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.usersThree,
            label: l10n.winesDetailMenuShareToGroup,
            onTap: onShareToGroup,
          ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.userPlus,
            label: l10n.winesShareToFriend,
            onTap: onShareToFriend,
          ),
        ],
        [
          OverflowMenuItem(
            icon: PhosphorIconsRegular.pencilSimple,
            label: l10n.winesDetailMenuEdit,
            onTap: onEdit,
          ),
          if (onTastingNotes != null)
            OverflowMenuItem(
              icon: PhosphorIconsRegular.notebook,
              label: l10n.winesDetailMenuTastingNotesPro,
              onTap: onTastingNotes!,
            ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.trash,
            label: l10n.winesDetailMenuDelete,
            destructive: true,
            onTap: onDelete,
          ),
        ],
      ],
    );
  }
}

class _StatsColumn extends StatelessWidget {
  final WineEntity wine;
  const _StatsColumn({required this.wine});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _StatItem(
            label: l10n.winesDetailStatRating,
            value: wine.rating.toStringAsFixed(1),
            unit: l10n.winesDetailStatRatingUnit,
          ),
          SizedBox(height: context.l),
          if (wine.price != null) ...[
            _StatItem(
              label: l10n.winesDetailStatPrice,
              value: formatPrice(wine.price!),
              unit: wine.currency,
            ),
            SizedBox(height: context.l),
          ],
          if (wine.region != null)
            _StatItem(
              label: l10n.winesDetailStatRegion,
              value: wine.region!,
              isText: true,
            )
          else if (wine.country != null)
            _StatItem(
              label: l10n.winesDetailStatCountry,
              value: wine.country!,
              isText: true,
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final bool isText;

  const _StatItem({
    required this.label,
    required this.value,
    this.unit,
    this.isText = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: context.captionFont * 0.95,
            fontWeight: FontWeight.w700,
            color: cs.onSurface.withValues(alpha: 0.72),
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: context.xs * 0.3),
        if (isText)
          Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: context.headingFont * 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (unit != null) ...[
                SizedBox(width: context.w * 0.01),
                Text(
                  unit!,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
      ],
    );
  }
}

class _NotesBlock extends StatelessWidget {
  final String notes;
  const _NotesBlock({required this.notes});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 2, color: cs.outlineVariant),
            SizedBox(width: context.w * 0.035),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.xs),
                child: Text(
                  notes,
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.02,
                    height: 1.55,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.1,
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

class _PlaceSection extends ConsumerStatefulWidget {
  final WineEntity wine;
  final bool hasCoords;

  const _PlaceSection({required this.wine, required this.hasCoords});

  @override
  ConsumerState<_PlaceSection> createState() => _PlaceSectionState();
}

class _PlaceSectionState extends ConsumerState<_PlaceSection>
    with TickerProviderStateMixin {
  late final MapController _mapCtrl = MapController();
  // Track the active mark so its pill reads as selected. -1 = whole
  // bounds (default). Tapping a pill flies the camera + selects.
  int _selectedIndex = -1;
  AnimationController? _flyCtrl;

  @override
  void dispose() {
    _flyCtrl?.dispose();
    _mapCtrl.dispose();
    super.dispose();
  }

  /// Smooth camera fly from current center+zoom to the target. Drops
  /// any in-flight animation so back-to-back pill taps feel snappy.
  void _flyTo(LatLng target, double zoom) {
    _flyCtrl?.dispose();
    final start = _mapCtrl.camera.center;
    final startZoom = _mapCtrl.camera.zoom;
    final ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    final latTween = Tween<double>(begin: start.latitude, end: target.latitude);
    final lngTween = Tween<double>(
      begin: start.longitude,
      end: target.longitude,
    );
    final zoomTween = Tween<double>(begin: startZoom, end: zoom);
    final anim = CurvedAnimation(parent: ctrl, curve: Curves.easeOutCubic);
    anim.addListener(() {
      _mapCtrl.move(
        LatLng(latTween.evaluate(anim), lngTween.evaluate(anim)),
        zoomTween.evaluate(anim),
      );
    });
    _flyCtrl = ctrl;
    ctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final memoriesAsync = ref.watch(
      wineMemoriesControllerProvider(widget.wine.id),
    );
    final momentPoints = (memoriesAsync.valueOrNull ?? const [])
        .where((m) => m.placeLat != null && m.placeLng != null)
        .toList();

    final winePoint = widget.hasCoords
        ? LatLng(widget.wine.latitude!, widget.wine.longitude!)
        : null;

    if (winePoint == null && momentPoints.isEmpty) {
      return _EmptyPlace(location: widget.wine.location);
    }

    final palette = <Color>[
      cs.primary,
      cs.tertiary,
      const Color(0xFFE3A6BA),
      const Color(0xFFB7C7DC),
      const Color(0xFFE8D9A1),
      cs.secondary,
    ];
    final marks = <_PlaceMark>[
      if (winePoint != null)
        _PlaceMark(
          label: widget.wine.location ?? '',
          point: winePoint,
          color: palette[0],
          glyph: PhosphorIconsFill.wine,
        ),
      for (var i = 0; i < momentPoints.length; i++)
        _PlaceMark(
          label: momentPoints[i].placeName ?? '·',
          point: LatLng(momentPoints[i].placeLat!, momentPoints[i].placeLng!),
          color: palette[(i + 1) % palette.length],
          number: i + 1,
        ),
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.paddingH),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapCtrl,
            options: MapOptions(
              initialCameraFit: marks.length == 1
                  ? null
                  : CameraFit.bounds(
                      bounds: LatLngBounds.fromPoints(
                        marks.map((m) => m.point).toList(),
                      ),
                      padding: EdgeInsets.all(context.w * 0.1),
                    ),
              initialCenter: marks.first.point,
              initialZoom: 14,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'xyz.sippd.app',
              ),
              MarkerLayer(
                markers: [
                  for (var i = 0; i < marks.length; i++)
                    Marker(
                      point: marks[i].point,
                      width: context.w * (i == _selectedIndex ? 0.095 : 0.075),
                      height: context.w * (i == _selectedIndex ? 0.095 : 0.075),
                      alignment: Alignment.bottomCenter,
                      child: _MapPin(
                        mark: marks[i],
                        selected: i == _selectedIndex,
                      ),
                    ),
                ],
              ),
            ],
          ),
          // Bottom pill row — tap a pill to fly the camera to its pin.
          Positioned(
            left: context.s,
            right: context.s,
            bottom: context.m,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: context.s),
              child: Row(
                children: [
                  for (var i = 0; i < marks.length; i++) ...[
                    if (i != 0) SizedBox(width: context.xs * 1.5),
                    _PlacePill(
                      mark: marks[i],
                      selected: i == _selectedIndex,
                      onTap: () {
                        setState(() => _selectedIndex = i);
                        _flyTo(marks[i].point, 15);
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceMark {
  final String label;
  final LatLng point;
  final Color color;
  final IconData? glyph;
  final int? number;

  const _PlaceMark({
    required this.label,
    required this.point,
    required this.color,
    this.glyph,
    this.number,
  });
}

class _MapPin extends StatelessWidget {
  final _PlaceMark mark;
  final bool selected;
  const _MapPin({required this.mark, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: mark.color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: selected ? 3 : 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: selected ? 0.45 : 0.25),
            blurRadius: selected ? 8 : 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: mark.glyph != null
          ? Icon(
              mark.glyph,
              color: Colors.white,
              size: context.w * (selected ? 0.046 : 0.04),
            )
          : Text(
              '${mark.number}',
              style: TextStyle(
                color: Colors.white,
                fontSize: context.w * (selected ? 0.038 : 0.034),
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
    );
  }
}

class _PlacePill extends StatelessWidget {
  final _PlaceMark mark;
  final bool selected;
  final VoidCallback onTap;
  const _PlacePill({
    required this.mark,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final label = mark.label.isEmpty ? '·' : mark.label;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(context.w * 0.05),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: context.s,
            vertical: context.xs,
          ),
          decoration: BoxDecoration(
            color: selected ? mark.color : cs.surface.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(context.w * 0.05),
            border: Border.all(
              color: selected ? mark.color : cs.outlineVariant,
              width: selected ? 1.5 : 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: context.w * 0.05,
                height: context.w * 0.05,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : mark.color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: mark.glyph != null
                    ? Icon(
                        mark.glyph,
                        color: selected ? mark.color : Colors.white,
                        size: context.w * 0.03,
                      )
                    : Text(
                        '${mark.number}',
                        style: TextStyle(
                          color: selected ? mark.color : Colors.white,
                          fontSize: context.w * 0.025,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
              ),
              SizedBox(width: context.xs * 1.5),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.w * 0.4),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.white : cs.onSurface,
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

class _MemoriesSection extends ConsumerWidget {
  final WineEntity wine;
  const _MemoriesSection({required this.wine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineId = wine.id;
    final memoriesAsync = ref.watch(wineMemoriesControllerProvider(wineId));
    final memories = memoriesAsync.valueOrNull ?? const [];
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;
    final padH = context.paddingH * 1.3;

    void openCapture() => pushMomentCapture(
      context,
      ref,
      wineId: wineId,
      wineLocationName: wine.location,
      wineLocationLat: wine.latitude,
      wineLocationLng: wine.longitude,
    );

    return Padding(
      padding: EdgeInsets.only(top: context.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header row matches WineDetailSectionHeader styling (dim
          // tracked uppercase) so the section sits in the same visual
          // tier as TASTING-NOTES / ORTE. Add affordance is a quiet
          // + glyph at the trailing edge — same colour as the label,
          // not a primary pill.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padH),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.momentSectionHeader.toUpperCase(),
                    style: TextStyle(
                      fontSize: context.captionFont * 0.95,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface.withValues(alpha: 0.72),
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: openCapture,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.xs,
                      vertical: context.xs,
                    ),
                    child: Icon(
                      PhosphorIconsRegular.plus,
                      size: context.w * 0.045,
                      color: cs.onSurface.withValues(alpha: 0.72),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.m),
          if (memories.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padH),
              child: GestureDetector(
                onTap: openCapture,
                child: Text(
                  l10n.momentSectionEmpty,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: padH),
              child: _MomentsBento(
                memories: memories,
                wineId: wineId,
                onAdd: openCapture,
              ),
            ),
        ],
      ),
    );
  }
}

/// Lean Instagram-style mosaic — one square thumb per moment. Caps
/// at 5 visible; if there are more, the 5th tile becomes a "+N"
/// overflow indicator that opens the viewer at the first hidden
/// moment. Single-row, bounded vertically, never scrolls — keeps the
/// section from elbowing the tasting-notes block below.
/// Content-driven moment mosaic. The pattern is picked from the
/// moment count (clamped 1..12), not from the wine id — so the layout
/// genuinely changes as the user adds moments. Each pattern fills the
/// container completely with that exact tile count: no placeholders,
/// no empty cells.
///
/// When the user has more than 12 moments, the 12-tile pattern is
/// used and its last tile becomes a "+N" inline expand toggle that
/// reveals the rest in a grid below (no navigation). Tap the trailing
/// caret-up in the grid to collapse.
class _MomentsBento extends ConsumerStatefulWidget {
  static const _kMaxBentoSlots = 12;

  final List<WineMemoryEntity> memories;
  final String wineId;
  final VoidCallback onAdd;

  const _MomentsBento({
    required this.memories,
    required this.wineId,
    required this.onAdd,
  });

  @override
  ConsumerState<_MomentsBento> createState() => _MomentsBentoState();
}

class _MomentsBentoState extends ConsumerState<_MomentsBento> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final memories = widget.memories;
    final wineId = widget.wineId;
    final gap = context.w * 0.015;

    final count = memories.length;
    final hasOverflow = count > _MomentsBento._kMaxBentoSlots;
    // Slot count snaps to the smallest tier (5, 9, 12) that holds the
    // moments plus a small placeholder buffer, so the section always
    // reads as a clean mosaic without dangling empty cells.
    final layoutCount = hasOverflow
        ? _MomentsBento._kMaxBentoSlots
        : _slotCountForCount(count);
    final realInBento = hasOverflow
        ? (_expanded
              ? _MomentsBento._kMaxBentoSlots
              : _MomentsBento._kMaxBentoSlots - 1)
        : count;
    final overflowStart = realInBento;
    final overflowCount = count - overflowStart;

    Widget tile(int index) => _BentoTile(
      memory: memories[index],
      onTap: () => pushMomentViewer(
        context,
        wineId: wineId,
        moments: memories,
        initialIndex: index,
      ),
    );

    Widget slot(int index) {
      if (index < realInBento) return tile(index);
      // Overflow toggle on the very last slot when collapsed.
      if (hasOverflow &&
          !_expanded &&
          index == _MomentsBento._kMaxBentoSlots - 1) {
        return _BentoOverflowTile(
          count: overflowCount,
          expanded: false,
          onTap: () => setState(() => _expanded = true),
        );
      }
      // Every remaining slot below layoutCount becomes an "invite to
      // capture" placeholder so the section never feels half-built.
      return _BentoPlaceholder(onTap: widget.onAdd);
    }

    final bento = _renderCountPattern(layoutCount, slot, gap, wineId);

    return Column(
      children: [
        bento,
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: (hasOverflow && _expanded)
              ? Padding(
                  padding: EdgeInsets.only(top: gap),
                  child: _ExpandedOverflowGrid(
                    memories: memories,
                    startIndex: overflowStart,
                    onTapMoment: (index) => pushMomentViewer(
                      context,
                      wineId: wineId,
                      moments: memories,
                      initialIndex: index,
                    ),
                    onCollapse: () => setState(() => _expanded = false),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// Square-cell mosaic pattern. Every cell of the grid is a clean
/// square (container aspect = cols/rows keeps cells equal), the hero
/// spans a 2×2 block at a chosen position, every other cell holds a
/// 1×1 tile. No thin rectangles, no extreme aspects — placeholders
/// and small thumbs are identical in shape.
class _SquareMosaic {
  final int cols;
  final int rows;
  final int heroCol;
  final int heroRow;
  const _SquareMosaic({
    required this.cols,
    required this.rows,
    required this.heroCol,
    required this.heroRow,
  });

  /// Slot count = total cells - hero cells (4) + hero itself (1).
  int get slotCount => cols * rows - 3;
}

// Twelve variants — three grid sizes × varying hero positions. The
// count tier chooses the grid; the wine-id hash chooses the hero
// position so neighbouring wines look distinct.
const _kP5 = [
  _SquareMosaic(cols: 4, rows: 2, heroCol: 0, heroRow: 0), // hero left
  _SquareMosaic(cols: 4, rows: 2, heroCol: 1, heroRow: 0), // hero centre
  _SquareMosaic(cols: 4, rows: 2, heroCol: 2, heroRow: 0), // hero right
];
const _kP9 = [
  _SquareMosaic(cols: 4, rows: 3, heroCol: 0, heroRow: 0), // top-left
  _SquareMosaic(cols: 4, rows: 3, heroCol: 2, heroRow: 0), // top-right
  _SquareMosaic(cols: 4, rows: 3, heroCol: 0, heroRow: 1), // bottom-left
  _SquareMosaic(cols: 4, rows: 3, heroCol: 2, heroRow: 1), // bottom-right
];
const _kP12 = [
  _SquareMosaic(cols: 5, rows: 3, heroCol: 0, heroRow: 0),
  _SquareMosaic(cols: 5, rows: 3, heroCol: 1, heroRow: 0),
  _SquareMosaic(cols: 5, rows: 3, heroCol: 3, heroRow: 0),
  _SquareMosaic(cols: 5, rows: 3, heroCol: 0, heroRow: 1),
  _SquareMosaic(cols: 5, rows: 3, heroCol: 3, heroRow: 1),
];

_SquareMosaic _pickMosaic(int slotCount, String wineId) {
  final variants = slotCount <= 5 ? _kP5 : (slotCount <= 9 ? _kP9 : _kP12);
  return variants[wineId.hashCode.abs() % variants.length];
}

/// Map a desired moment count + 2-placeholder buffer onto the
/// smallest tier that fits (5, 9, or 12 slots).
int _slotCountForCount(int count) {
  if (count <= 3) return 5; // P5: 1..3 real + placeholders
  if (count <= 4) return 5; // P5: 4 real + 1 placeholder
  if (count <= 7) return 9; // P9: 5..7 real + placeholders
  if (count <= 9) return 9; // P9: 8..9 real
  return 12; // P12 for everything ≥10
}

Widget _renderCountPattern(
  int count,
  Widget Function(int) slot,
  double gap,
  String wineId,
) {
  if (count <= 0) return const SizedBox.shrink();
  final pattern = _pickMosaic(count, wineId);

  return AspectRatio(
    aspectRatio: pattern.cols / pattern.rows,
    child: LayoutBuilder(
      builder: (_, c) {
        final cellW = c.maxWidth / pattern.cols;
        final cellH = c.maxHeight / pattern.rows;
        final half = gap / 2;
        final children = <Widget>[];

        // Hero first (slot 0), 2×2 at the chosen anchor.
        children.add(
          Positioned(
            left: pattern.heroCol * cellW + half,
            top: pattern.heroRow * cellH + half,
            width: 2 * cellW - gap,
            height: 2 * cellH - gap,
            child: slot(0),
          ),
        );

        // Walk the remaining cells row-major, skipping hero footprint.
        var slotIdx = 1;
        for (var r = 0; r < pattern.rows; r++) {
          for (var c2 = 0; c2 < pattern.cols; c2++) {
            final insideHero =
                r >= pattern.heroRow &&
                r < pattern.heroRow + 2 &&
                c2 >= pattern.heroCol &&
                c2 < pattern.heroCol + 2;
            if (insideHero) continue;
            children.add(
              Positioned(
                left: c2 * cellW + half,
                top: r * cellH + half,
                width: cellW - gap,
                height: cellH - gap,
                child: slot(slotIdx),
              ),
            );
            slotIdx++;
          }
        }

        return Stack(children: children);
      },
    ),
  );
}

/// Grid of the moments hidden behind the bento "+N" tile. Each tile
/// opens the viewer at the matching absolute index. The very last
/// tile in the grid is always the collapse toggle (caret-up) so the
/// expand/collapse affordance stays at the end of the section
/// regardless of state.
class _ExpandedOverflowGrid extends StatelessWidget {
  final List<WineMemoryEntity> memories;
  final int startIndex;
  final ValueChanged<int> onTapMoment;
  final VoidCallback onCollapse;

  const _ExpandedOverflowGrid({
    required this.memories,
    required this.startIndex,
    required this.onTapMoment,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    const cols = 4;
    final overflow = memories.sublist(startIndex);
    final gap = context.w * 0.015;
    // +1 for the trailing collapse-toggle tile.
    final totalCells = overflow.length + 1;
    final rows = (totalCells / cols).ceil();
    final cs = Theme.of(context).colorScheme;

    Widget cellFor(int localIndex) {
      if (localIndex < overflow.length) {
        final absoluteIndex = startIndex + localIndex;
        return _BentoTile(
          memory: overflow[localIndex],
          onTap: () => onTapMoment(absoluteIndex),
        );
      }
      if (localIndex == overflow.length) {
        return GestureDetector(
          onTap: onCollapse,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(context.w * 0.025),
              border: Border.all(color: cs.outlineVariant, width: 0.5),
            ),
            child: Center(
              child: Icon(
                PhosphorIconsRegular.caretUp,
                color: cs.onSurface.withValues(alpha: 0.85),
                size: context.w * 0.05,
              ),
            ),
          ),
        );
      }
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        for (var r = 0; r < rows; r++) ...[
          if (r != 0) SizedBox(height: gap),
          Row(
            children: [
              for (var c = 0; c < cols; c++) ...[
                if (c != 0) SizedBox(width: gap),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: cellFor(r * cols + c),
                  ),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

class _BentoTile extends StatelessWidget {
  final WineMemoryEntity memory;
  final VoidCallback onTap;
  const _BentoTile({required this.memory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.025),
        ),
        child: _thumb(memory, cs),
      ),
    );
  }

  Widget _thumb(WineMemoryEntity m, ColorScheme cs) {
    if (m.localImagePath != null) {
      return Image.file(File(m.localImagePath!), fit: BoxFit.cover);
    }
    if (m.imageUrl != null) {
      return Image.network(
        m.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            Icon(PhosphorIconsRegular.image, color: cs.outline),
      );
    }
    return Container(
      color: cs.surfaceContainer,
      alignment: Alignment.center,
      child: Icon(PhosphorIconsRegular.image, color: cs.outline),
    );
  }
}

class _BentoPlaceholder extends StatelessWidget {
  final VoidCallback onTap;
  const _BentoPlaceholder({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.025),
          border: Border.all(
            color: cs.outlineVariant.withValues(alpha: 0.6),
            width: 0.6,
          ),
        ),
        child: Center(
          child: Icon(
            PhosphorIconsRegular.plus,
            color: cs.onSurface.withValues(alpha: 0.35),
            size: context.w * 0.05,
          ),
        ),
      ),
    );
  }
}

class _BentoOverflowTile extends StatelessWidget {
  final int count;
  final bool expanded;
  final VoidCallback onTap;
  const _BentoOverflowTile({
    required this.count,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.025),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: expanded
                ? Icon(
                    PhosphorIconsRegular.caretUp,
                    key: const ValueKey('collapse'),
                    color: cs.onSurface.withValues(alpha: 0.85),
                    size: context.w * 0.06,
                  )
                : Text(
                    '+$count',
                    key: const ValueKey('overflow'),
                    style: TextStyle(
                      color: cs.onSurface.withValues(alpha: 0.85),
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _EmptyPlace extends StatelessWidget {
  final String? location;
  const _EmptyPlace({required this.location});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.paddingH),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.04),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              PhosphorIconsRegular.mapTrifold,
              size: context.w * 0.12,
              color: cs.outline,
            ),
            SizedBox(height: context.s),
            Text(
              location ?? AppLocalizations.of(context).winesDetailPlaceEmpty,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

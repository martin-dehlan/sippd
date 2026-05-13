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
              _MemoriesSection(wineId: widget.wine.id),
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
                child: _PlaceSection(
                  location: widget.wine.location,
                  latitude: widget.wine.latitude,
                  longitude: widget.wine.longitude,
                  hasCoords: hasCoords,
                ),
              ),
              SizedBox(height: context.xxl * 1.5),
            ],
          ),
        ),
      ),
    );
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
  final VoidCallback onShareImage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTastingNotes;

  const _WineOverflowMenu({
    required this.onCompare,
    required this.onShareToGroup,
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

class _PlaceSection extends StatelessWidget {
  final String? location;
  final double? latitude;
  final double? longitude;
  final bool hasCoords;

  const _PlaceSection({
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.hasCoords,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (!hasCoords) {
      return _EmptyPlace(location: location);
    }

    final point = LatLng(latitude!, longitude!);

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
            options: MapOptions(
              initialCenter: point,
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
                  Marker(
                    point: point,
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
          if (location != null)
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
                        location!,
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
      ),
    );
  }
}

class _MemoriesSection extends ConsumerWidget {
  final String wineId;
  const _MemoriesSection({required this.wineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memoriesAsync = ref.watch(wineMemoriesControllerProvider(wineId));
    final memories = memoriesAsync.valueOrNull ?? const [];
    final ringSize = context.w * 0.14;
    final l10n = AppLocalizations.of(context);
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(top: context.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.momentSectionHeader,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => pushMomentCapture(context, ref, wineId: wineId),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.s,
                      vertical: context.xs,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PhosphorIconsRegular.plus,
                          size: context.w * 0.04,
                          color: cs.primary,
                        ),
                        SizedBox(width: context.xs * 1.2),
                        Text(
                          l10n.momentSectionAdd,
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
              ],
            ),
          ),
          if (memories.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.paddingH,
                vertical: context.s,
              ),
              child: Text(
                l10n.momentSectionEmpty,
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                ),
              ),
            )
          else ...[
            SizedBox(height: context.s),
            SizedBox(
              height: ringSize,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: context.paddingH),
                itemCount: memories.length,
                separatorBuilder: (_, _) => SizedBox(width: context.w * 0.025),
                itemBuilder: (_, i) {
                  final memory = memories[i];
                  return _MomentStoryTile(
                    memory: memory,
                    size: ringSize,
                    onTap: () => pushMomentViewer(
                      context,
                      wineId: wineId,
                      moments: memories,
                      initialIndex: i,
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MomentStoryTile extends StatelessWidget {
  final WineMemoryEntity memory;
  final double size;
  final VoidCallback onTap;
  const _MomentStoryTile({
    required this.memory,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ringColors = [cs.primary, cs.tertiary, cs.primaryContainer];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(colors: [...ringColors, ringColors.first]),
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: cs.surface),
          padding: const EdgeInsets.all(2),
          child: ClipOval(child: _avatarImage(memory, cs)),
        ),
      ),
    );
  }

  Widget _avatarImage(WineMemoryEntity m, ColorScheme cs) {
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
      child: Icon(PhosphorIconsRegular.image, color: cs.outline),
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

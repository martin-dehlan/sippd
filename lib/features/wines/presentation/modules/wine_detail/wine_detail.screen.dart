import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/utils/responsive.dart';
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

class WineDetailScreen extends ConsumerWidget {
  final String wineId;
  final WineEntity? initial;

  const WineDetailScreen({super.key, required this.wineId, this.initial});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineDetailProvider(wineId));
    final currentUserId = ref.watch(currentUserIdProvider);

    return Scaffold(
      body: wineAsync.when(
        data: (wine) {
          // Local lookup may miss for wines owned by other group members.
          // Fall back to the entity passed via go_router extra.
          final resolved = wine ?? initial;
          if (resolved == null) {
            return const Center(child: Text('Wine not found'));
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
          return Center(child: Text('Error: $e'));
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
                const WineDetailSectionHeader(label: 'NOTES'),
                SizedBox(height: context.m),
                _NotesBlock(notes: widget.wine.notes!),
              ],
              SizedBox(height: context.xl),
              const WineDetailSectionHeader(label: 'PLACE'),
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
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete wine?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              'Delete',
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
  final VoidCallback onShareToGroup;
  final VoidCallback onShareImage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onTastingNotes;

  const _WineOverflowMenu({
    required this.onShareToGroup,
    required this.onShareImage,
    required this.onEdit,
    required this.onDelete,
    this.onTastingNotes,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowMenu(
      circleBackground: true,
      groups: [
        [
          OverflowMenuItem(
            icon: PhosphorIconsRegular.megaphoneSimple,
            label: 'Share rating',
            onTap: onShareImage,
          ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.usersThree,
            label: 'Share to group',
            onTap: onShareToGroup,
          ),
        ],
        [
          OverflowMenuItem(
            icon: PhosphorIconsRegular.pencilSimple,
            label: 'Edit wine',
            onTap: onEdit,
          ),
          if (onTastingNotes != null)
            OverflowMenuItem(
              icon: PhosphorIconsRegular.notebook,
              label: 'Tasting notes (Pro)',
              onTap: onTastingNotes!,
            ),
          OverflowMenuItem(
            icon: PhosphorIconsRegular.trash,
            label: 'Delete wine',
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
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _StatItem(
            label: 'Rating',
            value: wine.rating.toStringAsFixed(1),
            unit: '/ 10',
          ),
          SizedBox(height: context.l),
          if (wine.price != null) ...[
            _StatItem(
              label: 'Price',
              value: wine.price!.toStringAsFixed(2),
              unit: wine.currency,
            ),
            SizedBox(height: context.l),
          ],
          if (wine.region != null)
            _StatItem(label: 'Region', value: wine.region!, isText: true)
          else if (wine.country != null)
            _StatItem(label: 'Country', value: wine.country!, isText: true),
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
    if (memories.isEmpty) return const SizedBox.shrink();

    final size = context.w * 0.22;
    return Padding(
      padding: EdgeInsets.only(top: context.m),
      child: SizedBox(
        height: size,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          itemCount: memories.length,
          separatorBuilder: (_, _) => SizedBox(width: context.w * 0.025),
          itemBuilder: (_, i) => _MemoryThumb(
            memory: memories[i],
            size: size,
            onTap: () => _openViewer(context, memories, i),
          ),
        ),
      ),
    );
  }

  void _openViewer(
    BuildContext context,
    List<WineMemoryEntity> memories,
    int initialIndex,
  ) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withValues(alpha: 0.95),
        pageBuilder: (_, _, _) =>
            _MemoryViewer(memories: memories, initialIndex: initialIndex),
      ),
    );
  }
}

class _MemoryThumb extends StatelessWidget {
  final WineMemoryEntity memory;
  final double size;
  final VoidCallback onTap;

  const _MemoryThumb({
    required this.memory,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: _memoryImage(memory, cs),
      ),
    );
  }

  Widget _memoryImage(WineMemoryEntity m, ColorScheme cs) {
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
    return Icon(PhosphorIconsRegular.image, color: cs.outline);
  }
}

class _MemoryViewer extends StatefulWidget {
  final List<WineMemoryEntity> memories;
  final int initialIndex;

  const _MemoryViewer({required this.memories, required this.initialIndex});

  @override
  State<_MemoryViewer> createState() => _MemoryViewerState();
}

class _MemoryViewerState extends State<_MemoryViewer> {
  late final PageController _controller = PageController(
    initialPage: widget.initialIndex,
  );
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.memories.length,
              onPageChanged: (i) => setState(() => _index = i),
              itemBuilder: (_, i) {
                final m = widget.memories[i];
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(child: _viewerImage(m)),
                );
              },
            ),
            Positioned(
              top: context.m,
              right: context.m,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(context.s),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIconsRegular.x,
                    color: Colors.white,
                    size: context.w * 0.06,
                  ),
                ),
              ),
            ),
            if (widget.memories.length > 1)
              Positioned(
                bottom: context.l,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.m,
                      vertical: context.xs * 1.4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(context.w * 0.05),
                    ),
                    child: Text(
                      '${_index + 1} / ${widget.memories.length}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: context.captionFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _viewerImage(WineMemoryEntity m) {
    if (m.localImagePath != null) {
      return Image.file(File(m.localImagePath!), fit: BoxFit.contain);
    }
    if (m.imageUrl != null) {
      return Image.network(
        m.imageUrl!,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => const Icon(
          PhosphorIconsRegular.image,
          color: Colors.white,
          size: 80,
        ),
      );
    }
    return const Icon(
      PhosphorIconsRegular.image,
      color: Colors.white,
      size: 80,
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
              location ?? 'No place set',
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

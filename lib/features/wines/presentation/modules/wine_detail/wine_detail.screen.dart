import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../groups/presentation/widgets/share_wine_sheet.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';

class WineDetailScreen extends ConsumerWidget {
  final String wineId;

  const WineDetailScreen({super.key, required this.wineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineDetailProvider(wineId));

    return Scaffold(
      body: wineAsync.when(
        data: (wine) {
          if (wine == null) {
            return const Center(child: Text('Wine not found'));
          }
          return WineDetailBody(
            wine: wine,
            onDelete: () async {
              await ref
                  .read(wineControllerProvider.notifier)
                  .deleteWine(wineId);
              if (context.mounted) Navigator.pop(context);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class WineDetailBody extends ConsumerStatefulWidget {
  final WineEntity wine;
  final VoidCallback onDelete;

  const WineDetailBody({
    super.key,
    required this.wine,
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
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: context.xl * 1.5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _NameTitle(name: widget.wine.name)),
                  Padding(
                    padding: EdgeInsets.only(right: context.paddingH * 0.7),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _IconCircleButton(
                          icon: Icons.edit_outlined,
                          onTap: () => context.push(
                            AppRoutes.wineEditPath(widget.wine.id),
                          ),
                        ),
                        SizedBox(width: context.w * 0.02),
                        _IconCircleButton(
                          icon: Icons.ios_share,
                          onTap: () => showShareWineSheet(
                            context: context,
                            ref: ref,
                            wineId: widget.wine.id,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.s),
              _TypeSubtitle(type: widget.wine.type),
              SizedBox(height: context.l),
              Expanded(
                flex: 5,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingH),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: _WineImage(wine: widget.wine)),
                      Expanded(
                          flex: 4,
                          child: _StatsColumn(wine: widget.wine)),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: _PlaceSection(
                  location: widget.wine.location,
                  latitude: widget.wine.latitude,
                  longitude: widget.wine.longitude,
                  hasCoords: hasCoords,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: context.m,
                  top: context.s,
                ),
                child: TextButton(
                  onPressed: () => _confirmDelete(context),
                  child: Text(
                    'Delete wine',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
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
              child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Delete',
                style:
                    TextStyle(color: Theme.of(ctx).colorScheme.error)),
          ),
        ],
      ),
    );
    if (confirmed == true) widget.onDelete();
  }
}

class _IconCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconCircleButton({required this.icon, required this.onTap});

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
        child: Icon(icon, size: context.w * 0.045, color: cs.onSurface),
      ),
    );
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
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
      ),
    );
  }
}

class _NameTitle extends StatelessWidget {
  final String name;
  const _NameTitle({required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.paddingH * 1.3,
        right: context.paddingH * 1.3,
      ),
      child: Text(
        name.toUpperCase(),
        textAlign: TextAlign.left,
        style: GoogleFonts.playfairDisplay(
          fontSize: context.titleFont * 1.3,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          height: 1.05,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _WineImage extends StatelessWidget {
  final WineEntity wine;
  const _WineImage({required this.wine});

  @override
  Widget build(BuildContext context) {
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFF8B2252),
      WineType.white => const Color(0xFFB8A04A),
      WineType.rose => const Color(0xFFB5658A),
    };

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              width: context.w * 0.35,
              height: context.w * 0.35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: typeColor.withValues(alpha: 0.3),
                    blurRadius: 60,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        wine.imageUrl != null
            ? Image.network(wine.imageUrl!, fit: BoxFit.contain)
            : Icon(
                Icons.wine_bar,
                size: context.w * 0.25,
                color: typeColor.withValues(alpha: 0.6),
              ),
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
          if (wine.country != null)
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
        Text(label,
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w500,
              color: cs.primary,
              letterSpacing: 0.3,
            )),
        SizedBox(height: context.xs * 0.3),
        if (isText)
          Text(value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.bodyFont * 1.1,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis)
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value,
                  style: TextStyle(
                    fontSize: context.headingFont * 1.4,
                    fontWeight: FontWeight.bold,
                  )),
              if (unit != null) ...[
                SizedBox(width: context.w * 0.01),
                Text(unit!,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      color: cs.onSurfaceVariant,
                    )),
              ],
            ],
          ),
      ],
    );
  }
}

class _TypeSubtitle extends StatelessWidget {
  final WineType type;
  const _TypeSubtitle({required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.paddingH * 1.3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: _WineTypeChip(type: type),
      ),
    );
  }
}

class _WineTypeChip extends StatelessWidget {
  final WineType type;
  const _WineTypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    final label = switch (type) {
      WineType.red => 'Red Wine',
      WineType.white => 'White Wine',
      WineType.rose => 'Rosé',
    };
    final color = switch (type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
    };
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.xs + 1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(context.w * 0.05),
      ),
      child: Text(label,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 0.2,
          )),
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
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.sippd.sippd',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: point,
                    width: context.w * 0.1,
                    height: context.w * 0.1,
                    child: Icon(
                      Icons.place,
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
            Icon(Icons.map_outlined,
                size: context.w * 0.12, color: cs.outline),
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

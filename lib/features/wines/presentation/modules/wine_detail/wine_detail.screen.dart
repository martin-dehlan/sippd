import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../common/utils/responsive.dart';
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
    );
  }
}

class WineDetailBody extends StatefulWidget {
  final WineEntity wine;
  final VoidCallback onDelete;

  const WineDetailBody({
    super.key,
    required this.wine,
    required this.onDelete,
  });

  @override
  State<WineDetailBody> createState() => _WineDetailBodyState();
}

class _WineDetailBodyState extends State<WineDetailBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Top bar
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.03, vertical: context.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircleButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.pop(context),
                ),
                _CircleButton(
                  icon: Icons.delete_outline,
                  onTap: widget.onDelete,
                  isDestructive: true,
                ),
              ],
            ),
          ),

          // Hero: Image left + Stats right
          Expanded(
            flex: 5,
            child: FadeTransition(
              opacity: _fadeIn,
              child: SlideTransition(
                position: _slideUp,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingH),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: WineImageWithGlow(wine: widget.wine)),
                      Expanded(
                          flex: 4,
                          child: WineStatsColumn(wine: widget.wine)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom info
          Expanded(
            flex: 4,
            child: WineBottomSheet(wine: widget.wine),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.w * 0.1,
        height: context.w * 0.1,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          shape: BoxShape.circle,
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Icon(
          icon,
          size: context.w * 0.045,
          color: isDestructive ? cs.error : cs.onSurface,
        ),
      ),
    );
  }
}

class WineImageWithGlow extends StatelessWidget {
  final WineEntity wine;
  const WineImageWithGlow({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFF8B2252),
      WineType.white => const Color(0xFFB8A04A),
      WineType.rose => const Color(0xFFB5658A),
    };

    return Container(
      margin: EdgeInsets.only(right: context.w * 0.02),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow effect behind wine
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
          // Wine image or icon
          wine.imageUrl != null
              ? Image.network(wine.imageUrl!, fit: BoxFit.contain)
              : Icon(
                  Icons.wine_bar,
                  size: context.w * 0.25,
                  color: typeColor.withValues(alpha: 0.4),
                ),
        ],
      ),
    );
  }
}

class WineStatsColumn extends StatelessWidget {
  final WineEntity wine;
  const WineStatsColumn({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.w * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Wine name
          Text(
            wine.name,
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.s),
          WineDetailTypeBadge(type: wine.type),
          SizedBox(height: context.xl),

          // Rating
          _StatItem(
            label: 'Rating',
            value: wine.rating.toStringAsFixed(1),
            unit: '/ 10',
          ),
          SizedBox(height: context.l),

          // Price
          if (wine.price != null) ...[
            _StatItem(
              label: 'Price',
              value: wine.price!.toStringAsFixed(2),
              unit: wine.currency,
            ),
            SizedBox(height: context.l),
          ],

          // Place
          if (wine.location != null)
            _StatItem(label: 'Place', value: wine.location!, isText: true)
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
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w500,
            color: cs.primary,
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: context.xs * 0.3),
        if (isText)
          Text(
            value,
            style: TextStyle(
                fontSize: context.bodyFont, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right,
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

class WineBottomSheet extends StatelessWidget {
  final WineEntity wine;
  const WineBottomSheet({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasDetails = wine.grape != null ||
        wine.vintage != null ||
        wine.country != null ||
        wine.notes != null;

    if (!hasDetails) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(context.w * 0.06)),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: context.paddingH, vertical: context.l),
        children: [
          // Drag handle
          Center(
            child: Container(
              width: context.w * 0.1,
              height: 3,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: context.m),

          // Detail chips
          Wrap(
            spacing: context.w * 0.02,
            runSpacing: context.s,
            children: [
              if (wine.grape != null)
                _DetailChip(icon: Icons.grass, label: wine.grape!),
              if (wine.vintage != null)
                _DetailChip(
                    icon: Icons.calendar_today,
                    label: wine.vintage.toString()),
              if (wine.country != null)
                _DetailChip(icon: Icons.flag_outlined, label: wine.country!),
              if (wine.location != null && wine.country != null)
                _DetailChip(
                    icon: Icons.location_on_outlined,
                    label: wine.location!),
            ],
          ),

          if (wine.notes != null) ...[
            SizedBox(height: context.m),
            Text('Tasting Notes',
                style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                    letterSpacing: 0.3)),
            SizedBox(height: context.s),
            Text(
              wine.notes!,
              style: TextStyle(
                fontSize: context.bodyFont,
                height: 1.6,
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DetailChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w * 0.03,
        vertical: context.xs,
      ),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.w * 0.02),
        border: Border.all(color: cs.outlineVariant, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.w * 0.04, color: cs.primary),
          SizedBox(width: context.w * 0.015),
          Text(label,
              style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class WineDetailTypeBadge extends StatelessWidget {
  final WineType type;
  const WineDetailTypeBadge({super.key, required this.type});

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
          horizontal: context.w * 0.025, vertical: context.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(context.w * 0.015),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w600,
              color: color)),
    );
  }
}

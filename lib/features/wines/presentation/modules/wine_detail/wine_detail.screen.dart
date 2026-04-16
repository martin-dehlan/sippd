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
      backgroundColor: Theme.of(context).colorScheme.surface,
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

class WineDetailBody extends StatelessWidget {
  final WineEntity wine;
  final VoidCallback onDelete;

  const WineDetailBody({
    super.key,
    required this.wine,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: Column(
        children: [
          // Top bar
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.w * 0.02, vertical: context.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new),
                  style: IconButton.styleFrom(
                    backgroundColor: cs.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete_outline, color: cs.error),
                  style: IconButton.styleFrom(
                    backgroundColor: cs.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Hero: Image left, Stats right
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.paddingH),
              child: Row(
                children: [
                  // Left: Wine image
                  Expanded(
                    flex: 5,
                    child: WineImageArea(wine: wine),
                  ),
                  // Right: Stats
                  Expanded(
                    flex: 4,
                    child: WineStatsColumn(wine: wine),
                  ),
                ],
              ),
            ),
          ),

          // Bottom: Additional info
          Expanded(
            flex: 4,
            child: WineBottomInfo(wine: wine),
          ),
        ],
      ),
    );
  }
}

class WineImageArea extends StatelessWidget {
  final WineEntity wine;
  const WineImageArea({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(right: context.w * 0.02),
      child: wine.imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(context.w * 0.04),
              child: Image.network(wine.imageUrl!, fit: BoxFit.contain),
            )
          : Center(
              child: Icon(
                Icons.wine_bar,
                size: context.w * 0.3,
                color: cs.outline.withValues(alpha: 0.15),
              ),
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
          // Wine name + type
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

          // Stat: Rating
          StatItem(
            label: 'Rating',
            value: wine.rating.toStringAsFixed(1),
            unit: '/ 10',
          ),
          SizedBox(height: context.l),

          // Stat: Price
          if (wine.price != null) ...[
            StatItem(
              label: 'Price',
              value: wine.price!.toStringAsFixed(2),
              unit: wine.currency,
            ),
            SizedBox(height: context.l),
          ],

          // Stat: Place
          if (wine.location != null)
            StatItem(
              label: 'Place',
              value: wine.location!,
              isText: true,
            )
          else if (wine.country != null)
            StatItem(
              label: 'Country',
              value: wine.country!,
              isText: true,
            ),
        ],
      ),
    );
  }
}

class StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final bool isText;

  const StatItem({
    super.key,
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
          ),
        ),
        SizedBox(height: context.xs * 0.5),
        if (isText)
          Text(
            value,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
            ),
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
                  fontSize: context.headingFont * 1.3,
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

class WineBottomInfo extends StatelessWidget {
  final WineEntity wine;
  const WineBottomInfo({super.key, required this.wine});

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
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.w * 0.06)),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.l,
        ),
        children: [
          // Detail chips row
          Wrap(
            spacing: context.w * 0.02,
            runSpacing: context.s,
            children: [
              if (wine.grape != null)
                DetailChip(icon: Icons.grass, label: wine.grape!),
              if (wine.vintage != null)
                DetailChip(
                    icon: Icons.calendar_today,
                    label: wine.vintage.toString()),
              if (wine.country != null)
                DetailChip(icon: Icons.flag_outlined, label: wine.country!),
              if (wine.location != null && wine.country != null)
                DetailChip(
                    icon: Icons.location_on_outlined, label: wine.location!),
            ],
          ),

          // Tasting notes
          if (wine.notes != null) ...[
            SizedBox(height: context.m),
            Text('Tasting Notes',
                style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurfaceVariant)),
            SizedBox(height: context.s),
            Text(
              wine.notes!,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurface,
                height: 1.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const DetailChip({super.key, required this.icon, required this.label});

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
    final cs = Theme.of(context).colorScheme;
    final label = switch (type) {
      WineType.red => 'Red Wine',
      WineType.white => 'White Wine',
      WineType.rose => 'Rosé',
    };
    final color = switch (type) {
      WineType.red => cs.error,
      WineType.white => const Color(0xFFD4A017),
      WineType.rose => cs.primary,
    };

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.025, vertical: context.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
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

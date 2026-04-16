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

    return CustomScrollView(
      slivers: [
        // Hero image area
        SliverAppBar(
          expandedHeight: context.h * 0.35,
          pinned: true,
          backgroundColor: cs.surface,
          foregroundColor: cs.onSurface,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: WineHeroSection(wine: wine),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.m),

                // Name + type badge
                Text(
                  wine.name,
                  style: TextStyle(
                    fontSize: context.titleFont,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: context.s),
                WineDetailTypeBadge(type: wine.type),
                SizedBox(height: context.l),

                // Stats row
                WineStatsRow(wine: wine),
                SizedBox(height: context.l),

                // Details
                if (wine.grape != null || wine.vintage != null)
                  WineInfoSection(
                    title: 'Details',
                    children: [
                      if (wine.grape != null)
                        WineInfoTile(
                            icon: Icons.grass,
                            label: 'Grape',
                            value: wine.grape!),
                      if (wine.vintage != null)
                        WineInfoTile(
                            icon: Icons.calendar_today,
                            label: 'Vintage',
                            value: wine.vintage.toString()),
                    ],
                  ),

                if (wine.country != null || wine.location != null)
                  WineInfoSection(
                    title: 'Origin',
                    children: [
                      if (wine.country != null)
                        WineInfoTile(
                            icon: Icons.flag_outlined,
                            label: 'Country',
                            value: wine.country!),
                      if (wine.location != null)
                        WineInfoTile(
                            icon: Icons.location_on_outlined,
                            label: 'Tasted at',
                            value: wine.location!),
                    ],
                  ),

                // Tasting notes
                if (wine.notes != null) ...[
                  Text('Tasting Notes',
                      style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: context.s),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(context.w * 0.04),
                    decoration: BoxDecoration(
                      color: cs.surfaceContainer,
                      borderRadius:
                          BorderRadius.circular(context.w * 0.03),
                    ),
                    child: Text(
                      wine.notes!,
                      style: TextStyle(
                        fontSize: context.bodyFont,
                        color: cs.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: context.l),
                ],

                SizedBox(height: context.xl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class WineHeroSection extends StatelessWidget {
  final WineEntity wine;
  const WineHeroSection({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      color: cs.surfaceContainer,
      child: wine.imageUrl != null
          ? Image.network(wine.imageUrl!, fit: BoxFit.cover)
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.wine_bar,
                      size: context.w * 0.2,
                      color: cs.outline.withValues(alpha: 0.3)),
                  SizedBox(height: context.s),
                  Text('No photo',
                      style: TextStyle(
                          fontSize: context.captionFont,
                          color: cs.outline)),
                ],
              ),
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
      WineType.white => cs.tertiary,
      WineType.rose => cs.primary,
    };

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03, vertical: context.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(context.w * 0.015),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w600,
              color: color)),
    );
  }
}

class WineStatsRow extends StatelessWidget {
  final WineEntity wine;
  const WineStatsRow({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: WineStatCard(
            label: 'Rating',
            value: wine.rating.toStringAsFixed(1),
            unit: '/ 10',
            isPrimary: true,
          ),
        ),
        SizedBox(width: context.w * 0.03),
        if (wine.price != null)
          Expanded(
            child: WineStatCard(
              label: 'Price',
              value: wine.price!.toStringAsFixed(2),
              unit: wine.currency,
            ),
          ),
      ],
    );
  }
}

class WineStatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final bool isPrimary;

  const WineStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(context.w * 0.04),
      decoration: BoxDecoration(
        color: isPrimary ? cs.primaryContainer : cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w500,
                color: isPrimary ? cs.onPrimaryContainer : cs.onSurfaceVariant,
              )),
          SizedBox(height: context.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value,
                  style: TextStyle(
                    fontSize: context.headingFont * 1.2,
                    fontWeight: FontWeight.bold,
                    color: isPrimary ? cs.onPrimaryContainer : cs.onSurface,
                  )),
              SizedBox(width: context.w * 0.01),
              Text(unit,
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color:
                        isPrimary ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class WineInfoSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const WineInfoSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: context.bodyFont, fontWeight: FontWeight.w700)),
        SizedBox(height: context.s),
        ...children,
        SizedBox(height: context.l),
      ],
    );
  }
}

class WineInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WineInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: context.s),
      child: Row(
        children: [
          Icon(icon, size: context.w * 0.05, color: cs.primary),
          SizedBox(width: context.w * 0.03),
          Text(label,
              style: TextStyle(
                  fontSize: context.bodyFont, color: cs.onSurfaceVariant)),
          const Spacer(),
          Text(value,
              style: TextStyle(
                  fontSize: context.bodyFont, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

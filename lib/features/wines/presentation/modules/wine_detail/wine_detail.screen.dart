import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/wine_card.widget.dart';

class WineDetailScreen extends ConsumerWidget {
  final String wineId;

  const WineDetailScreen({super.key, required this.wineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineDetailProvider(wineId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wine Details',
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              await ref
                  .read(wineControllerProvider.notifier)
                  .deleteWine(wineId);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: wineAsync.when(
        data: (wine) {
          if (wine == null) {
            return const Center(child: Text('Wine not found'));
          }
          return WineDetailBody(wine: wine);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class WineDetailBody extends StatelessWidget {
  final WineEntity wine;
  const WineDetailBody({super.key, required this.wine});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: context.paddingH,
        vertical: context.paddingV,
      ),
      children: [
        // Hero section
        Center(
          child: Column(
            children: [
              WineRatingDisplay(rating: wine.rating),
              SizedBox(height: context.s),
              Text(
                wine.name,
                style: TextStyle(
                  fontSize: context.titleFont,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.xs),
              WineTypeBadge(type: wine.type),
            ],
          ),
        ),
        SizedBox(height: context.l),

        // Details
        if (wine.price != null)
          WineDetailRow(
            icon: Icons.euro,
            label: 'Price',
            value: '${wine.price!.toStringAsFixed(2)} ${wine.currency}',
          ),
        if (wine.country != null)
          WineDetailRow(
            icon: Icons.flag,
            label: 'Country',
            value: wine.country!,
          ),
        if (wine.location != null)
          WineDetailRow(
            icon: Icons.location_on,
            label: 'Location',
            value: wine.location!,
          ),
        if (wine.grape != null)
          WineDetailRow(
            icon: Icons.grass,
            label: 'Grape',
            value: wine.grape!,
          ),
        if (wine.vintage != null)
          WineDetailRow(
            icon: Icons.calendar_today,
            label: 'Vintage',
            value: wine.vintage.toString(),
          ),
        if (wine.notes != null) ...[
          SizedBox(height: context.m),
          Text(
            'Tasting Notes',
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.s),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(context.w * 0.04),
            decoration: BoxDecoration(
              color: cs.surfaceContainer,
              borderRadius: BorderRadius.circular(context.w * 0.03),
            ),
            child: Text(
              wine.notes!,
              style: TextStyle(
                fontSize: context.bodyFont,
                color: cs.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class WineDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WineDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: context.m),
      child: Row(
        children: [
          Icon(icon, size: context.w * 0.05, color: cs.onSurfaceVariant),
          SizedBox(width: context.w * 0.03),
          Text(
            label,
            style: TextStyle(
              fontSize: context.bodyFont,
              color: cs.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/responsive.dart';
import '../../controller/wine.provider.dart';
import '../../domain/entities/wine.entity.dart';

class WineTypeFilterBar extends ConsumerWidget {
  const WineTypeFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(wineTypeFilterProvider);

    return SizedBox(
      height: context.h * 0.045,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          WineFilterChip(
            label: 'All',
            isSelected: selected == null,
            onTap: () =>
                ref.read(wineTypeFilterProvider.notifier).setFilter(null),
          ),
          SizedBox(width: context.w * 0.02),
          WineFilterChip(
            label: 'Red',
            isSelected: selected == WineType.red,
            onTap: () => ref
                .read(wineTypeFilterProvider.notifier)
                .setFilter(WineType.red),
          ),
          SizedBox(width: context.w * 0.02),
          WineFilterChip(
            label: 'White',
            isSelected: selected == WineType.white,
            onTap: () => ref
                .read(wineTypeFilterProvider.notifier)
                .setFilter(WineType.white),
          ),
          SizedBox(width: context.w * 0.02),
          WineFilterChip(
            label: 'Rosé',
            isSelected: selected == WineType.rose,
            onTap: () => ref
                .read(wineTypeFilterProvider.notifier)
                .setFilter(WineType.rose),
          ),
        ],
      ),
    );
  }
}

class WineFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const WineFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary : cs.surface,
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(context.w * 0.05),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w500,
            color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

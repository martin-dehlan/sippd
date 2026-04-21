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
          _FilterChip(
            label: 'All',
            isSelected: selected == null,
            onTap: () =>
                ref.read(wineTypeFilterProvider.notifier).setFilter(null),
          ),
          SizedBox(width: context.w * 0.02),
          _FilterChip(
            label: 'Red',
            isSelected: selected == WineType.red,
            dotColor: const Color(0xFFA84343),
            onTap: () => ref
                .read(wineTypeFilterProvider.notifier)
                .setFilter(WineType.red),
          ),
          SizedBox(width: context.w * 0.02),
          _FilterChip(
            label: 'White',
            isSelected: selected == WineType.white,
            dotColor: const Color(0xFFD4C49A),
            onTap: () => ref
                .read(wineTypeFilterProvider.notifier)
                .setFilter(WineType.white),
          ),
          SizedBox(width: context.w * 0.02),
          _FilterChip(
            label: 'Rosé',
            isSelected: selected == WineType.rose,
            dotColor: const Color(0xFFD6889A),
            onTap: () => ref
                .read(wineTypeFilterProvider.notifier)
                .setFilter(WineType.rose),
          ),
          SizedBox(width: context.w * 0.02),
          _FilterChip(
            label: 'Sparkling',
            isSelected: selected == WineType.sparkling,
            dotColor: const Color(0xFFD4A84B),
            onTap: () => ref
                .read(wineTypeFilterProvider.notifier)
                .setFilter(WineType.sparkling),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? dotColor;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    this.dotColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.04,
          vertical: context.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? cs.primary.withValues(alpha: 0.15)
              : cs.surfaceContainer,
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
            width: isSelected ? 1.0 : 0.5,
          ),
          borderRadius: BorderRadius.circular(context.w * 0.05),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dotColor != null) ...[
              Container(
                width: context.w * 0.018,
                height: context.w * 0.018,
                decoration:
                    BoxDecoration(color: dotColor, shape: BoxShape.circle),
              ),
              SizedBox(width: context.w * 0.015),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? cs.primary : cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

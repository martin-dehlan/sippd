import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/data/wine_regions.dart';
import '../../../../common/utils/responsive.dart';

void showWineRegionPicker({
  required BuildContext context,
  required String country,
  required String? selected,
  required ValueChanged<String?> onChanged,
}) {
  final regions = regionsFor(country);
  if (regions.isEmpty) return;

  final cs = Theme.of(context).colorScheme;
  final searchController = TextEditingController();
  var filter = '';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: cs.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setModalState) {
        final filtered = regions
            .where((r) => r.toLowerCase().contains(filter.toLowerCase()))
            .toList();

        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          expand: false,
          builder: (_, scrollController) => Column(
            children: [
              SizedBox(height: context.m),
              Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.paddingH),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country,
                      style: TextStyle(
                        fontSize: context.captionFont,
                        fontWeight: FontWeight.w700,
                        color: cs.primary,
                      ),
                    ),
                    SizedBox(height: context.s),
                    TextField(
                      controller: searchController,
                      autofocus: true,
                      style: TextStyle(fontSize: context.bodyFont),
                      decoration: InputDecoration(
                        hintText: 'Search region...',
                        prefixIcon: Icon(
                          PhosphorIconsRegular.magnifyingGlass,
                          color: cs.primary,
                        ),
                        isDense: true,
                      ),
                      onChanged: (v) => setModalState(() => filter = v),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    if (selected != null)
                      _RegionTile(
                        region: 'No region',
                        isSelected: false,
                        onTap: () {
                          onChanged(null);
                          Navigator.pop(ctx);
                        },
                      ),
                    ...filtered.map((r) => _RegionTile(
                          region: r,
                          isSelected: r == selected,
                          onTap: () {
                            onChanged(r);
                            Navigator.pop(ctx);
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

class _RegionTile extends StatelessWidget {
  final String region;
  final bool isSelected;
  final VoidCallback onTap;

  const _RegionTile({
    required this.region,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      dense: true,
      title: Text(
        region,
        style: TextStyle(
          fontSize: context.bodyFont,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          color: isSelected ? cs.primary : cs.onSurface,
        ),
      ),
      trailing: isSelected
          ? Icon(
              PhosphorIconsRegular.checkCircle,
              color: cs.primary,
              size: context.w * 0.05,
            )
          : null,
      onTap: onTap,
    );
  }
}

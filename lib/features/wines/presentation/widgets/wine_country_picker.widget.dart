import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../common/utils/responsive.dart';

const _topWineCountries = [
    'France',
    'Italy',
    'Spain',
    'Germany',
    'Portugal',
    'Argentina',
    'Chile',
    'Australia',
    'South Africa',
    'Austria',
    'USA',
    'New Zealand',
    'Greece',
    'Georgia',
    'Hungary',
  ];

const _otherCountries = [
    'Albania',
    'Algeria',
    'Armenia',
    'Belgium',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Brazil',
    'Bulgaria',
    'Canada',
    'China',
    'Croatia',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Egypt',
    'England',
    'Ethiopia',
    'India',
    'Iran',
    'Ireland',
    'Israel',
    'Japan',
    'Jordan',
    'Kosovo',
    'Lebanon',
    'Luxembourg',
    'Mexico',
    'Moldova',
    'Montenegro',
    'Morocco',
    'Netherlands',
    'North Macedonia',
    'Norway',
    'Peru',
    'Poland',
    'Romania',
    'Russia',
    'Serbia',
    'Slovakia',
    'Slovenia',
    'Sweden',
    'Switzerland',
    'Tunisia',
    'Turkey',
    'Ukraine',
    'United Kingdom',
    'Uruguay',
];

void showWineCountryPicker({
  required BuildContext context,
  required String? selected,
  required ValueChanged<String?> onChanged,
}) {
  final cs = Theme.of(context).colorScheme;
  final searchController = TextEditingController();
  var filter = '';

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(context.w * 0.05)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          final filteredTop = _topWineCountries
              .where((c) => c.toLowerCase().contains(filter.toLowerCase()))
              .toList();
          final filteredOther = _otherCountries
              .where((c) => c.toLowerCase().contains(filter.toLowerCase()))
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
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    style: TextStyle(fontSize: context.bodyFont),
                    decoration: InputDecoration(
                      hintText: 'Search country...',
                      prefixIcon: Icon(PhosphorIconsRegular.magnifyingGlass, color: cs.primary),
                      isDense: true,
                    ),
                    onChanged: (v) => setModalState(() => filter = v),
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    children: [
                      if (filteredTop.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.paddingH,
                              vertical: context.xs),
                          child: Text('Top Wine Countries',
                              style: TextStyle(
                                  fontSize: context.captionFont,
                                  fontWeight: FontWeight.w700,
                                  color: cs.primary)),
                        ),
                        ...filteredTop.map((c) => _CountryTile(
                              country: c,
                              isSelected: c == selected,
                              onTap: () {
                                onChanged(c);
                                Navigator.pop(ctx);
                              },
                            )),
                      ],
                      if (filteredOther.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.paddingH,
                              vertical: context.xs),
                          child: Text('Other Countries',
                              style: TextStyle(
                                  fontSize: context.captionFont,
                                  fontWeight: FontWeight.w700,
                                  color: cs.onSurfaceVariant)),
                        ),
                        ...filteredOther.map((c) => _CountryTile(
                              country: c,
                              isSelected: c == selected,
                              onTap: () {
                                onChanged(c);
                                Navigator.pop(ctx);
                              },
                            )),
                      ],
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

class _CountryTile extends StatelessWidget {
  final String country;
  final bool isSelected;
  final VoidCallback onTap;

  const _CountryTile({
    required this.country,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      dense: true,
      title: Text(country,
          style: TextStyle(
            fontSize: context.bodyFont,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            color: isSelected ? cs.primary : cs.onSurface,
          )),
      trailing: isSelected
          ? Icon(PhosphorIconsRegular.checkCircle, color: cs.primary, size: context.w * 0.05)
          : null,
      onTap: onTap,
    );
  }
}

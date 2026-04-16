import 'package:flutter/material.dart';
import '../../../../common/utils/responsive.dart';

class WineCountryPicker extends StatefulWidget {
  final String? selectedCountry;
  final ValueChanged<String?> onChanged;

  const WineCountryPicker({
    super.key,
    this.selectedCountry,
    required this.onChanged,
  });

  @override
  State<WineCountryPicker> createState() => _WineCountryPickerState();
}

class _WineCountryPickerState extends State<WineCountryPicker> {
  final _searchController = TextEditingController();
  String _filter = '';

  static const _topWineCountries = [
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

  static const _otherCountries = [
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => _showPicker(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Country',
          prefixIcon: Icon(Icons.flag_outlined,
              color: cs.primary, size: context.w * 0.05),
          suffixIcon: widget.selectedCountry != null
              ? IconButton(
                  icon: Icon(Icons.clear,
                      size: context.w * 0.045, color: cs.onSurfaceVariant),
                  onPressed: () => widget.onChanged(null),
                )
              : Icon(Icons.arrow_drop_down,
                  color: cs.onSurfaceVariant, size: context.w * 0.06),
        ),
        child: Text(
          widget.selectedCountry ?? 'Select country',
          style: TextStyle(
            fontSize: context.bodyFont,
            color: widget.selectedCountry != null
                ? cs.onSurface
                : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
              .where((c) => c.toLowerCase().contains(_filter.toLowerCase()))
              .toList();
          final filteredOther = _otherCountries
              .where((c) => c.toLowerCase().contains(_filter.toLowerCase()))
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
                    controller: _searchController,
                    autofocus: true,
                    style: TextStyle(fontSize: context.bodyFont),
                    decoration: InputDecoration(
                      hintText: 'Search country...',
                      prefixIcon: Icon(Icons.search, color: cs.primary),
                      isDense: true,
                    ),
                    onChanged: (v) => setModalState(() => _filter = v),
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
                              isSelected: c == widget.selectedCountry,
                              onTap: () {
                                widget.onChanged(c);
                                _searchController.clear();
                                _filter = '';
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
                              isSelected: c == widget.selectedCountry,
                              onTap: () {
                                widget.onChanged(c);
                                _searchController.clear();
                                _filter = '';
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
          ? Icon(Icons.check_circle, color: cs.primary, size: context.w * 0.05)
          : null,
      onTap: onTap,
    );
  }
}

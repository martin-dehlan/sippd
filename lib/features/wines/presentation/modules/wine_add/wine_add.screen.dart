import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/text_input_sheet.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../locations/presentation/widgets/location_search_sheet.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';
import '../../widgets/wine_country_picker.widget.dart';
import '../../widgets/wine_photo_picker.widget.dart';

class WineAddScreen extends ConsumerStatefulWidget {
  const WineAddScreen({super.key});

  @override
  ConsumerState<WineAddScreen> createState() => _WineAddScreenState();
}

class _WineAddScreenState extends ConsumerState<WineAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  double _rating = 5.0;
  WineType _type = WineType.red;

  double? _price;
  int? _vintage;
  String? _grape;
  String? _country;
  LocationEntity? _location;
  String? _notes;

  String? _imageUrl;
  String? _localImagePath;
  String? _memoryImageUrl;
  String? _memoryLocalImagePath;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final wine = WineEntity(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      rating: _rating,
      type: _type,
      price: _price,
      country: _country,
      location: _location?.shortDisplay,
      latitude: _location?.lat,
      longitude: _location?.lng,
      notes: _notes,
      grape: _grape,
      vintage: _vintage,
      imageUrl: _imageUrl,
      localImagePath: _localImagePath,
      memoryImageUrl: _memoryImageUrl,
      memoryLocalImagePath: _memoryLocalImagePath,
      userId: 'local_user',
      createdAt: DateTime.now(),
    );

    await ref.read(wineControllerProvider.notifier).addWine(wine);
    if (mounted) context.pop();
  }

  Future<void> _editPrice() async {
    final result = await showTextInputSheet(
      context: context,
      title: 'Price',
      initial: _price?.toStringAsFixed(2),
      prefix: '€ ',
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
    if (result == null) return;
    setState(() => _price = result.isEmpty ? null : double.tryParse(result));
  }

  Future<void> _editVintage() async {
    final result = await showTextInputSheet(
      context: context,
      title: 'Year',
      initial: _vintage?.toString(),
      hint: 'e.g. 2020',
      keyboardType: TextInputType.number,
    );
    if (result == null) return;
    setState(() => _vintage = result.isEmpty ? null : int.tryParse(result));
  }

  Future<void> _editGrape() async {
    final result = await showTextInputSheet(
      context: context,
      title: 'Grape variety',
      initial: _grape,
      hint: 'e.g. Merlot',
    );
    if (result == null) return;
    setState(() => _grape = result.isEmpty ? null : result);
  }

  Future<void> _editNotes() async {
    final result = await showTextInputSheet(
      context: context,
      title: 'Tasting notes',
      initial: _notes,
      hint: 'Aromas, body, finish…',
      maxLines: 5,
    );
    if (result == null) return;
    setState(() => _notes = result.isEmpty ? null : result);
  }

  Future<void> _editPlace() async {
    final result = await showLocationSearchSheet(
      context: context,
      initial: _location,
    );
    if (result == null) return;
    setState(() => _location = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: context.xl),
              _NameField(controller: _nameController),
              SizedBox(height: context.l),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.paddingH),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        height: context.h * 0.28,
                        child: WinePhotoPicker(
                          label: 'Photo',
                          placeholderIcon: Icons.wine_bar_outlined,
                          imageUrl: _imageUrl,
                          localPath: _localImagePath,
                          onChanged: (v) => setState(() {
                            _imageUrl = v.imageUrl;
                            _localImagePath = v.localPath;
                          }),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(left: context.w * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _RatingStat(
                              rating: _rating,
                              onChanged: (v) => setState(() => _rating = v),
                            ),
                            SizedBox(height: context.l),
                            _PriceStat(
                              price: _price,
                              onTap: _editPrice,
                            ),
                            SizedBox(height: context.l),
                            _TypeBadge(
                              type: _type,
                              onChanged: (t) => setState(() => _type = t),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.l),
              _ChipsRow(
                grape: _grape,
                vintage: _vintage,
                country: _country,
                notes: _notes,
                onGrapeTap: _editGrape,
                onVintageTap: _editVintage,
                onCountryTap: () => showWineCountryPicker(
                  context: context,
                  selected: _country,
                  onChanged: (c) => setState(() => _country = c),
                ),
                onNotesTap: _editNotes,
              ),
              SizedBox(height: context.l),
              _MemoryTile(
                imageUrl: _memoryImageUrl,
                localPath: _memoryLocalImagePath,
                onChanged: (v) => setState(() {
                  _memoryImageUrl = v.imageUrl;
                  _memoryLocalImagePath = v.localPath;
                }),
              ),
              SizedBox(height: context.l),
              SizedBox(
                height: context.h * 0.24,
                child: _PlaceMap(
                  location: _location,
                  onTap: _editPlace,
                ),
              ),
              SizedBox(height: context.m),
              Center(
                child: TextButton(
                  onPressed: _submit,
                  child: Text(
                    'Save wine',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.xl),
            ],
          ),
        ),
      ),
      floatingActionButton: const _FloatingBackButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
        heroTag: 'wine-add-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => context.pop(),
        child: Icon(Icons.arrow_back_ios_new, size: context.w * 0.06),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  final TextEditingController controller;
  const _NameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: context.titleFont * 1.1,
          fontWeight: FontWeight.bold,
          letterSpacing: -1,
          height: 1.1,
        ),
        decoration: InputDecoration(
          hintText: 'Wine name',
          hintStyle: TextStyle(color: cs.outline),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
        validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}

class _StatLabel extends StatelessWidget {
  final String text;
  const _StatLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(text,
        style: TextStyle(
          fontSize: context.captionFont,
          fontWeight: FontWeight.w500,
          color: cs.primary,
          letterSpacing: 0.3,
        ));
  }
}

class _RatingStat extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;
  const _RatingStat({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const _StatLabel(text: 'Rating'),
        SizedBox(height: context.xs * 0.3),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(rating.toStringAsFixed(1),
                style: TextStyle(
                    fontSize: context.headingFont * 1.4,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: context.w * 0.01),
            Text('/ 10',
                style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant)),
          ],
        ),
        SizedBox(
          width: context.w * 0.35,
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: cs.primary,
              inactiveTrackColor: cs.outlineVariant,
              thumbColor: cs.primary,
              overlayColor: cs.primary.withValues(alpha: 0.12),
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
            ),
            child: Slider(
              value: rating,
              min: 0,
              max: 10,
              divisions: 20,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class _PriceStat extends StatelessWidget {
  final double? price;
  final VoidCallback onTap;
  const _PriceStat({required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const _StatLabel(text: 'Price'),
          SizedBox(height: context.xs * 0.3),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                price != null ? price!.toStringAsFixed(2) : '—',
                style: TextStyle(
                  fontSize: context.headingFont * 1.4,
                  fontWeight: FontWeight.bold,
                  color: price != null ? cs.onSurface : cs.outline,
                ),
              ),
              if (price != null) ...[
                SizedBox(width: context.w * 0.01),
                Text('EUR',
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant)),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final WineType type;
  final ValueChanged<WineType> onChanged;
  const _TypeBadge({required this.type, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _cycle(),
      child: _TypeChipDisplay(type: type),
    );
  }

  void _cycle() {
    final next = switch (type) {
      WineType.red => WineType.white,
      WineType.white => WineType.rose,
      WineType.rose => WineType.red,
    };
    onChanged(next);
  }
}

class _TypeChipDisplay extends StatelessWidget {
  final WineType type;
  const _TypeChipDisplay({required this.type});

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
          horizontal: context.w * 0.03, vertical: context.xs),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(context.w * 0.02),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w600,
              color: color)),
    );
  }
}

class _ChipsRow extends StatelessWidget {
  final String? grape;
  final int? vintage;
  final String? country;
  final String? notes;
  final VoidCallback onGrapeTap;
  final VoidCallback onVintageTap;
  final VoidCallback onCountryTap;
  final VoidCallback onNotesTap;

  const _ChipsRow({
    required this.grape,
    required this.vintage,
    required this.country,
    required this.notes,
    required this.onGrapeTap,
    required this.onVintageTap,
    required this.onCountryTap,
    required this.onNotesTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: Wrap(
        spacing: context.w * 0.02,
        runSpacing: context.s,
        children: [
          _FieldChip(
            icon: Icons.grass_outlined,
            label: grape ?? 'Grape',
            isEmpty: grape == null,
            onTap: onGrapeTap,
          ),
          _FieldChip(
            icon: Icons.calendar_today_outlined,
            label: vintage?.toString() ?? 'Year',
            isEmpty: vintage == null,
            onTap: onVintageTap,
          ),
          _FieldChip(
            icon: Icons.public,
            label: country ?? 'Country',
            isEmpty: country == null,
            onTap: onCountryTap,
          ),
          _FieldChip(
            icon: Icons.notes_outlined,
            label: notes != null && notes!.isNotEmpty ? 'Notes ✓' : 'Notes',
            isEmpty: notes == null || notes!.isEmpty,
            onTap: onNotesTap,
          ),
        ],
      ),
    );
  }
}

class _FieldChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEmpty;
  final VoidCallback onTap;

  const _FieldChip({
    required this.icon,
    required this.label,
    required this.isEmpty,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.035,
          vertical: context.xs + 2,
        ),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(context.w * 0.02),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: context.w * 0.04,
                color: isEmpty ? cs.outline : cs.primary),
            SizedBox(width: context.w * 0.015),
            Text(label,
                style: TextStyle(
                    fontSize: context.captionFont,
                    fontWeight: FontWeight.w500,
                    color: isEmpty ? cs.outline : cs.onSurface)),
          ],
        ),
      ),
    );
  }
}

class _MemoryTile extends StatelessWidget {
  final String? imageUrl;
  final String? localPath;
  final ValueChanged<({String? imageUrl, String? localPath})> onChanged;

  const _MemoryTile({
    required this.imageUrl,
    required this.localPath,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: SizedBox(
        height: context.h * 0.18,
        child: WinePhotoPicker(
          label: 'Memory photo',
          placeholderIcon: Icons.photo_camera_front_outlined,
          imageUrl: imageUrl,
          localPath: localPath,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _PlaceMap extends StatelessWidget {
  final LocationEntity? location;
  final VoidCallback onTap;

  const _PlaceMap({required this.location, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final hasCoords = location?.lat != null && location?.lng != null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: cs.surfaceContainer,
            borderRadius: BorderRadius.circular(context.w * 0.04),
          ),
          child: hasCoords
              ? _MapContent(
                  point: LatLng(location!.lat!, location!.lng!),
                  label: location!.shortDisplay,
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_location_alt_outlined,
                          size: context.w * 0.12, color: cs.outline),
                      SizedBox(height: context.s),
                      Text('Tap to add place',
                          style: TextStyle(
                            fontSize: context.bodyFont,
                            color: cs.onSurfaceVariant,
                          )),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class _MapContent extends StatelessWidget {
  final LatLng point;
  final String label;
  const _MapContent({required this.point, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      children: [
        IgnorePointer(
          child: FlutterMap(
            options: MapOptions(
              initialCenter: point,
              initialZoom: 14,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.sippd.sippd',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: point,
                    width: context.w * 0.1,
                    height: context.w * 0.1,
                    child: Icon(Icons.place,
                        size: context.w * 0.1, color: cs.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
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
                    label,
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
    );
  }
}

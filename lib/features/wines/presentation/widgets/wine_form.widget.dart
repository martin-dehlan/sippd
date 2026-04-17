import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/text_input_sheet.dart';
import '../../../../common/widgets/year_picker_sheet.dart';
import '../../../locations/domain/entities/location.entity.dart';
import '../../../locations/presentation/widgets/location_search_sheet.dart';
import '../../domain/entities/wine.entity.dart';
import 'rating_sheet.dart';
import 'wine_country_picker.widget.dart';
import 'wine_photo_picker.widget.dart';

class WineFormData {
  final String name;
  final double rating;
  final WineType type;
  final double? price;
  final int? vintage;
  final String? grape;
  final String? country;
  final LocationEntity? location;
  final String? notes;
  final String? imageUrl;
  final String? localImagePath;
  final String? memoryImageUrl;
  final String? memoryLocalImagePath;

  const WineFormData({
    required this.name,
    required this.rating,
    required this.type,
    this.price,
    this.vintage,
    this.grape,
    this.country,
    this.location,
    this.notes,
    this.imageUrl,
    this.localImagePath,
    this.memoryImageUrl,
    this.memoryLocalImagePath,
  });
}

class WineForm extends StatefulWidget {
  final WineFormData? initial;
  final String submitLabel;
  final Future<void> Function(WineFormData data) onSubmit;
  final bool autoSave;

  const WineForm({
    super.key,
    this.initial,
    this.submitLabel = 'Save wine',
    required this.onSubmit,
    this.autoSave = false,
  });

  @override
  State<WineForm> createState() => _WineFormState();
}

class _WineFormState extends State<WineForm>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _nameFocus = FocusNode();
  final _nameFieldKey = GlobalKey();
  late final AnimationController _shake;

  bool _nameError = false;

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

  Timer? _autoSaveDebounce;

  @override
  void initState() {
    super.initState();
    _shake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _nameController.addListener(() {
      if (_nameError && _nameController.text.trim().isNotEmpty) {
        setState(() => _nameError = false);
      }
      _scheduleAutoSave();
    });

    final init = widget.initial;
    if (init != null) {
      _nameController.text = init.name;
      _rating = init.rating;
      _type = init.type;
      _price = init.price;
      _vintage = init.vintage;
      _grape = init.grape;
      _country = init.country;
      _location = init.location;
      _notes = init.notes;
      _imageUrl = init.imageUrl;
      _localImagePath = init.localImagePath;
      _memoryImageUrl = init.memoryImageUrl;
      _memoryLocalImagePath = init.memoryLocalImagePath;
    }
  }

  @override
  void dispose() {
    _autoSaveDebounce?.cancel();
    _nameController.dispose();
    _nameFocus.dispose();
    _shake.dispose();
    super.dispose();
  }

  void _scheduleAutoSave() {
    if (!widget.autoSave) return;
    if (_nameController.text.trim().isEmpty) return;
    _autoSaveDebounce?.cancel();
    _autoSaveDebounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSubmit(_collect());
    });
  }

  WineFormData _collect() => WineFormData(
        name: _nameController.text.trim(),
        rating: _rating,
        type: _type,
        price: _price,
        vintage: _vintage,
        grape: _grape,
        country: _country,
        location: _location,
        notes: _notes,
        imageUrl: _imageUrl,
        localImagePath: _localImagePath,
        memoryImageUrl: _memoryImageUrl,
        memoryLocalImagePath: _memoryLocalImagePath,
      );

  Future<void> _submit() async {
    if (_nameController.text.trim().isEmpty) {
      setState(() => _nameError = true);
      final ctx = _nameFieldKey.currentContext;
      if (ctx != null) {
        await Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: 0.2,
        );
      }
      _nameFocus.requestFocus();
      _shake.forward(from: 0);
      return;
    }

    await widget.onSubmit(_collect());
  }

  Future<void> _editRating() async {
    final result = await showRatingSheet(context: context, initial: _rating);
    if (result == null) return;
    setState(() => _rating = result);
    _scheduleAutoSave();
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
    _scheduleAutoSave();
  }

  Future<void> _editVintage() async {
    final result = await showYearPickerSheet(
      context: context,
      initial: _vintage,
    );
    if (result == null) return;
    setState(() => _vintage = result.year);
    _scheduleAutoSave();
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
    _scheduleAutoSave();
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
    _scheduleAutoSave();
  }

  Future<void> _editPlace() async {
    final result = await showLocationSearchSheet(
      context: context,
      initial: _location,
    );
    if (result == null) return;
    setState(() => _location = result);
    _scheduleAutoSave();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: context.xl * 1.5),
        WineFormNameField(
          key: _nameFieldKey,
          controller: _nameController,
          focusNode: _nameFocus,
          hasError: _nameError,
          shake: _shake,
        ),
        SizedBox(height: context.s),
        WineFormTypeChipRow(
          selected: _type,
          onChanged: (t) {
            setState(() => _type = t);
            _scheduleAutoSave();
          },
        ),
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
                    onChanged: (v) {
                      setState(() {
                        _imageUrl = v.imageUrl;
                        _localImagePath = v.localPath;
                      });
                      _scheduleAutoSave();
                    },
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
                      WineFormRatingStat(
                        rating: _rating,
                        onTap: _editRating,
                      ),
                      SizedBox(height: context.l),
                      WineFormPriceStat(
                        price: _price,
                        onTap: _editPrice,
                      ),
                      SizedBox(height: context.l),
                      WineFormCountryStat(
                        country: _country,
                        onTap: () => showWineCountryPicker(
                          context: context,
                          selected: _country,
                          onChanged: (c) {
                            setState(() => _country = c);
                            _scheduleAutoSave();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.l),
        WineFormChipsRow(
          grape: _grape,
          vintage: _vintage,
          notes: _notes,
          onGrapeTap: _editGrape,
          onVintageTap: _editVintage,
          onNotesTap: _editNotes,
        ),
        SizedBox(height: context.l),
        WineFormMemoryTile(
          imageUrl: _memoryImageUrl,
          localPath: _memoryLocalImagePath,
          onChanged: (v) {
            setState(() {
              _memoryImageUrl = v.imageUrl;
              _memoryLocalImagePath = v.localPath;
            });
            _scheduleAutoSave();
          },
        ),
        SizedBox(height: context.l),
        SizedBox(
          height: context.h * 0.24,
          child: WineFormPlaceMap(
            location: _location,
            onTap: _editPlace,
          ),
        ),
        if (!widget.autoSave) ...[
          SizedBox(height: context.l),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            child: SizedBox(
              width: double.infinity,
              height: context.h * 0.065,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: Text(
                  widget.submitLabel,
                  style: TextStyle(
                    fontSize: context.bodyFont * 1.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: FilledButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.04),
                  ),
                ),
              ),
            ),
          ),
        ],
        SizedBox(height: context.xl),
      ],
    );
  }
}

class WineFormNameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool hasError;
  final AnimationController shake;
  const WineFormNameField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hasError,
    required this.shake,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final titleStyle = GoogleFonts.playfairDisplay(
      fontSize: context.titleFont * 1.3,
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      height: 1.05,
      color: cs.onSurface,
    );
    final hintColor = hasError ? cs.error : cs.outline;
    return AnimatedBuilder(
      animation: shake,
      builder: (_, child) {
        final dx = shake.isAnimating ? sin(shake.value * pi * 4) * 10 : 0.0;
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: context.paddingH * 1.3,
          right: context.paddingH * 1.3,
        ),
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: cs.primary,
          cursorWidth: 1.5,
          textCapitalization: TextCapitalization.characters,
          style: titleStyle,
          decoration: InputDecoration(
            hintText: 'WINE NAME',
            hintStyle: titleStyle.copyWith(color: hintColor),
            filled: false,
            fillColor: Colors.transparent,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }
}

class WineFormStatLabel extends StatelessWidget {
  final String text;
  const WineFormStatLabel({super.key, required this.text});

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

class WineFormRatingStat extends StatelessWidget {
  final double rating;
  final VoidCallback onTap;
  const WineFormRatingStat({
    super.key,
    required this.rating,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const WineFormStatLabel(text: 'Rating'),
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
        ],
      ),
    );
  }
}

class WineFormPriceStat extends StatelessWidget {
  final double? price;
  final VoidCallback onTap;
  const WineFormPriceStat({
    super.key,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const WineFormStatLabel(text: 'Price'),
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

class WineFormTypeChipRow extends StatelessWidget {
  final WineType selected;
  final ValueChanged<WineType> onChanged;
  const WineFormTypeChipRow({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.paddingH * 1.3),
      child: Wrap(
        spacing: context.w * 0.02,
        runSpacing: context.s,
        children: [
          WineFormTypeChoice(
            type: WineType.red,
            label: 'Red Wine',
            isSelected: selected == WineType.red,
            onTap: () => onChanged(WineType.red),
          ),
          WineFormTypeChoice(
            type: WineType.white,
            label: 'White Wine',
            isSelected: selected == WineType.white,
            onTap: () => onChanged(WineType.white),
          ),
          WineFormTypeChoice(
            type: WineType.rose,
            label: 'Rosé',
            isSelected: selected == WineType.rose,
            onTap: () => onChanged(WineType.rose),
          ),
        ],
      ),
    );
  }
}

class WineFormTypeChoice extends StatelessWidget {
  final WineType type;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const WineFormTypeChoice({
    super.key,
    required this.type,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = switch (type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
    };
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03,
          vertical: context.xs + 1,
        ),
        decoration: BoxDecoration(
          color:
              isSelected ? color.withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(
            color: isSelected ? color : cs.outlineVariant,
            width: isSelected ? 1 : 0.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w600,
            color: isSelected ? color : cs.onSurfaceVariant,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}

class WineFormCountryStat extends StatelessWidget {
  final String? country;
  final VoidCallback onTap;
  const WineFormCountryStat({
    super.key,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const WineFormStatLabel(text: 'Country'),
          SizedBox(height: context.xs * 0.3),
          Text(
            country ?? '—',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.bold,
              color: country != null ? cs.onSurface : cs.outline,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class WineFormChipsRow extends StatelessWidget {
  final String? grape;
  final int? vintage;
  final String? notes;
  final VoidCallback onGrapeTap;
  final VoidCallback onVintageTap;
  final VoidCallback onNotesTap;

  const WineFormChipsRow({
    super.key,
    required this.grape,
    required this.vintage,
    required this.notes,
    required this.onGrapeTap,
    required this.onVintageTap,
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
          WineFormFieldChip(
            icon: Icons.grass_outlined,
            label: grape ?? 'Grape',
            isEmpty: grape == null,
            onTap: onGrapeTap,
          ),
          WineFormFieldChip(
            icon: Icons.calendar_today_outlined,
            label: vintage?.toString() ?? 'Year',
            isEmpty: vintage == null,
            onTap: onVintageTap,
          ),
          WineFormFieldChip(
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

class WineFormFieldChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEmpty;
  final VoidCallback onTap;

  const WineFormFieldChip({
    super.key,
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

class WineFormMemoryTile extends StatelessWidget {
  final String? imageUrl;
  final String? localPath;
  final ValueChanged<({String? imageUrl, String? localPath})> onChanged;

  const WineFormMemoryTile({
    super.key,
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

class WineFormPlaceMap extends StatelessWidget {
  final LocationEntity? location;
  final VoidCallback onTap;

  const WineFormPlaceMap({
    super.key,
    required this.location,
    required this.onTap,
  });

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
              ? WineFormMapContent(
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

class WineFormMapContent extends StatelessWidget {
  final LatLng point;
  final String label;
  const WineFormMapContent({
    super.key,
    required this.point,
    required this.label,
  });

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

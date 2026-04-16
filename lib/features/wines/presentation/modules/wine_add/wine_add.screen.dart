import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../locations/presentation/widgets/location_search.widget.dart';
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
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();
  final _grapeController = TextEditingController();
  final _vintageController = TextEditingController();

  double _rating = 5.0;
  WineType _type = WineType.red;
  String? _country;
  LocationEntity? _location;
  String? _imageUrl;
  String? _localImagePath;
  String? _memoryImageUrl;
  String? _memoryLocalImagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    _grapeController.dispose();
    _vintageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final wine = WineEntity(
      id: const Uuid().v4(),
      name: _nameController.text.trim(),
      rating: _rating,
      type: _type,
      price: _priceController.text.isNotEmpty
          ? double.tryParse(_priceController.text)
          : null,
      country: _country,
      location: _location?.shortDisplay,
      notes:
          _notesController.text.isNotEmpty ? _notesController.text.trim() : null,
      grape:
          _grapeController.text.isNotEmpty ? _grapeController.text.trim() : null,
      vintage: _vintageController.text.isNotEmpty
          ? int.tryParse(_vintageController.text)
          : null,
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _TopBar(onSave: _submit),
              Expanded(
                child: ListView(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.paddingH),
                  children: [
                    _Hero(
                      imageUrl: _imageUrl,
                      localPath: _localImagePath,
                      onPhotoChanged: (v) => setState(() {
                        _imageUrl = v.imageUrl;
                        _localImagePath = v.localPath;
                      }),
                      nameController: _nameController,
                      type: _type,
                      onTypeChanged: (t) => setState(() => _type = t),
                    ),
                    SizedBox(height: context.l),
                    _RatingRow(
                      rating: _rating,
                      onChanged: (v) => setState(() => _rating = v),
                    ),
                    SizedBox(height: context.l),
                    _DividerLine(),
                    _FieldRow(
                      icon: Icons.euro,
                      label: 'Price',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      hint: '—',
                    ),
                    _DividerLine(),
                    _FieldRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Year',
                      controller: _vintageController,
                      keyboardType: TextInputType.number,
                      hint: '—',
                    ),
                    _DividerLine(),
                    _FieldRow(
                      icon: Icons.grass_outlined,
                      label: 'Grape',
                      controller: _grapeController,
                      hint: '—',
                    ),
                    _DividerLine(),
                    _CountryRow(
                      country: _country,
                      onChanged: (c) => setState(() => _country = c),
                    ),
                    _DividerLine(),
                    _LocationRow(
                      location: _location,
                      onLocationSelected: (loc) =>
                          setState(() => _location = loc),
                      onClear: () => setState(() => _location = null),
                    ),
                    _DividerLine(),
                    SizedBox(height: context.l),
                    _SectionHeader(text: 'Memory photo'),
                    SizedBox(height: context.s),
                    SizedBox(
                      height: context.h * 0.16,
                      child: WinePhotoPicker(
                        label: 'Add a selfie or place',
                        placeholderIcon: Icons.photo_camera_front_outlined,
                        imageUrl: _memoryImageUrl,
                        localPath: _memoryLocalImagePath,
                        onChanged: (v) => setState(() {
                          _memoryImageUrl = v.imageUrl;
                          _memoryLocalImagePath = v.localPath;
                        }),
                      ),
                    ),
                    SizedBox(height: context.l),
                    _SectionHeader(text: 'Notes'),
                    SizedBox(height: context.s),
                    TextFormField(
                      controller: _notesController,
                      maxLines: 4,
                      style: TextStyle(
                          fontSize: context.bodyFont, height: 1.5),
                      decoration: InputDecoration(
                        hintText: 'Aromas, body, finish…',
                        hintStyle: TextStyle(color: cs.outline),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    SizedBox(height: context.xl),
                    SizedBox(
                      width: double.infinity,
                      height: context.h * 0.06,
                      child: FilledButton(
                        onPressed: _submit,
                        style: FilledButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(context.w * 0.03),
                          ),
                        ),
                        child: Text(
                          'Save wine',
                          style: TextStyle(
                              fontSize: context.bodyFont,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(height: context.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onSave;
  const _TopBar({required this.onSave});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.02, vertical: context.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => context.pop(),
          ),
          TextButton(
            onPressed: onSave,
            child: Text('Save',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                  color: cs.primary,
                )),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  final String? imageUrl;
  final String? localPath;
  final ValueChanged<({String? imageUrl, String? localPath})> onPhotoChanged;
  final TextEditingController nameController;
  final WineType type;
  final ValueChanged<WineType> onTypeChanged;

  const _Hero({
    required this.imageUrl,
    required this.localPath,
    required this.onPhotoChanged,
    required this.nameController,
    required this.type,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final photoSize = context.w * 0.32;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: photoSize,
          height: photoSize * 1.2,
          child: WinePhotoPicker(
            label: 'Photo',
            placeholderIcon: Icons.wine_bar_outlined,
            imageUrl: imageUrl,
            localPath: localPath,
            onChanged: onPhotoChanged,
          ),
        ),
        SizedBox(width: context.w * 0.04),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                style: TextStyle(
                  fontSize: context.headingFont,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
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
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: context.s),
              _TypeSelector(selected: type, onChanged: onTypeChanged),
            ],
          ),
        ),
      ],
    );
  }
}

class _TypeSelector extends StatelessWidget {
  final WineType selected;
  final ValueChanged<WineType> onChanged;
  const _TypeSelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _TypePill(
            label: 'Red',
            selected: selected == WineType.red,
            onTap: () => onChanged(WineType.red)),
        SizedBox(width: context.w * 0.015),
        _TypePill(
            label: 'White',
            selected: selected == WineType.white,
            onTap: () => onChanged(WineType.white)),
        SizedBox(width: context.w * 0.015),
        _TypePill(
            label: 'Rosé',
            selected: selected == WineType.rose,
            onTap: () => onChanged(WineType.rose)),
      ],
    );
  }
}

class _TypePill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TypePill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03,
          vertical: context.xs,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont,
            fontWeight: FontWeight.w600,
            color: selected ? cs.onPrimary : cs.onSurface,
          ),
        ),
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;
  const _RatingRow({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(Icons.star_rounded, color: cs.primary, size: context.w * 0.055),
        SizedBox(width: context.w * 0.02),
        Text('Rating',
            style: TextStyle(
                fontSize: context.bodyFont, fontWeight: FontWeight.w600)),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: cs.primary,
              inactiveTrackColor: cs.outlineVariant,
              thumbColor: cs.primary,
              overlayColor: cs.primary.withValues(alpha: 0.12),
              trackHeight: 2,
              thumbShape:
                  const RoundSliderThumbShape(enabledThumbRadius: 7),
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
        SizedBox(
          width: context.w * 0.1,
          child: Text(
            rating.toStringAsFixed(1),
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w700,
              color: cs.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Divider(color: cs.outlineVariant, height: 1, thickness: 0.5);
  }
}

class _FieldRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? keyboardType;

  const _FieldRow({
    required this.icon,
    required this.label,
    required this.controller,
    this.hint,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s),
      child: Row(
        children: [
          Icon(icon, size: context.w * 0.05, color: cs.onSurfaceVariant),
          SizedBox(width: context.w * 0.04),
          SizedBox(
            width: context.w * 0.22,
            child: Text(label,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  color: cs.onSurface,
                )),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    color: cs.outline, fontWeight: FontWeight.w400),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CountryRow extends StatelessWidget {
  final String? country;
  final ValueChanged<String?> onChanged;
  const _CountryRow({required this.country, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showWineCountryPicker(
        context: context,
        selected: country,
        onChanged: onChanged,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.m),
        child: Row(
          children: [
            Icon(Icons.public,
                size: context.w * 0.05, color: cs.onSurfaceVariant),
            SizedBox(width: context.w * 0.04),
            SizedBox(
              width: context.w * 0.22,
              child: Text('Country',
                  style: TextStyle(
                      fontSize: context.bodyFont, color: cs.onSurface)),
            ),
            Expanded(
              child: Text(
                country ?? '—',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w500,
                  color: country != null ? cs.onSurface : cs.outline,
                ),
              ),
            ),
            SizedBox(width: context.w * 0.02),
            Icon(Icons.chevron_right,
                size: context.w * 0.05, color: cs.outline),
          ],
        ),
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final LocationEntity? location;
  final ValueChanged<LocationEntity> onLocationSelected;
  final VoidCallback onClear;

  const _LocationRow({
    required this.location,
    required this.onLocationSelected,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.location_on_outlined,
              size: context.w * 0.05, color: cs.onSurfaceVariant),
          SizedBox(width: context.w * 0.04),
          SizedBox(
            width: context.w * 0.22,
            child: Text('Place',
                style: TextStyle(
                    fontSize: context.bodyFont, color: cs.onSurface)),
          ),
          Expanded(
            child: location != null
                ? _SelectedLocationChip(
                    location: location!,
                    onClear: onClear,
                  )
                : LocationSearchWidget(
                    onLocationSelected: onLocationSelected,
                    initialValue: null,
                  ),
          ),
        ],
      ),
    );
  }
}

class _SelectedLocationChip extends StatelessWidget {
  final LocationEntity location;
  final VoidCallback onClear;
  const _SelectedLocationChip({
    required this.location,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: Text(
            location.shortDisplay,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: context.w * 0.02),
        GestureDetector(
          onTap: onClear,
          child: Icon(Icons.close,
              size: context.w * 0.04, color: cs.outline),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        fontSize: context.captionFont,
        fontWeight: FontWeight.w600,
        color: cs.onSurfaceVariant,
        letterSpacing: 0.3,
      ),
    );
  }
}

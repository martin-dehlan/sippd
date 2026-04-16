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
import '../../widgets/wine_rating_input.widget.dart';

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
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            children: [
              SizedBox(height: context.s),

              // Top bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleIconButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () => context.pop(),
                  ),
                  TextButton(
                    onPressed: _submit,
                    child: Text('Save',
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700,
                          color: cs.primary,
                        )),
                  ),
                ],
              ),
              SizedBox(height: context.m),

              // Hero: photo left + name/type right
              SizedBox(
                height: context.h * 0.22,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
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
                    SizedBox(width: context.w * 0.04),
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            style: TextStyle(
                              fontSize: context.bodyFont * 1.1,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Wine name',
                              hintStyle: TextStyle(
                                color: cs.outline,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Required'
                                : null,
                          ),
                          SizedBox(height: context.s),
                          _TypeSelector(
                            selected: _type,
                            onChanged: (t) => setState(() => _type = t),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.l),

              WineRatingInput(
                rating: _rating,
                onChanged: (v) => setState(() => _rating = v),
              ),
              SizedBox(height: context.l),

              // Price + Year
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _CompactField(
                      controller: _priceController,
                      label: 'Price',
                      icon: Icons.euro,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: context.w * 0.03),
                  Expanded(
                    child: _CompactField(
                      controller: _vintageController,
                      label: 'Year',
                      icon: Icons.calendar_today,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.m),

              _CompactField(
                controller: _grapeController,
                label: 'Grape',
                icon: Icons.grass,
              ),
              SizedBox(height: context.m),

              WineCountryPicker(
                selectedCountry: _country,
                onChanged: (c) => setState(() => _country = c),
              ),
              SizedBox(height: context.m),

              LocationSearchWidget(
                onLocationSelected: (loc) => setState(() => _location = loc),
                initialValue: _location?.shortDisplay,
              ),
              if (_location != null) ...[
                SizedBox(height: context.s),
                _SelectedLocationChip(
                  location: _location!,
                  onClear: () => setState(() => _location = null),
                ),
              ],
              SizedBox(height: context.l),

              // Memory photo
              WinePhotoPicker(
                label: 'Memory Photo',
                placeholderIcon: Icons.photo_camera_front_outlined,
                imageUrl: _memoryImageUrl,
                localPath: _memoryLocalImagePath,
                onChanged: (v) => setState(() {
                  _memoryImageUrl = v.imageUrl;
                  _memoryLocalImagePath = v.localPath;
                }),
              ),
              SizedBox(height: context.l),

              TextFormField(
                controller: _notesController,
                maxLines: 4,
                style: TextStyle(fontSize: context.bodyFont, height: 1.5),
                decoration: InputDecoration(
                  hintText: 'Tasting notes — aromas, body, finish…',
                  hintStyle: TextStyle(color: cs.outline),
                  filled: true,
                  fillColor: cs.surfaceContainer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: context.xl),

              SizedBox(
                width: double.infinity,
                height: context.h * 0.06,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('Add Wine',
                      style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: context.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.w * 0.1,
        height: context.w * 0.1,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          shape: BoxShape.circle,
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Icon(icon, size: context.w * 0.045, color: cs.onSurface),
      ),
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
      children: [
        _TypeChip(
          label: 'Red',
          isSelected: selected == WineType.red,
          onTap: () => onChanged(WineType.red),
        ),
        SizedBox(width: context.w * 0.015),
        _TypeChip(
          label: 'White',
          isSelected: selected == WineType.white,
          onTap: () => onChanged(WineType.white),
        ),
        SizedBox(width: context.w * 0.015),
        _TypeChip(
          label: 'Rosé',
          isSelected: selected == WineType.rose,
          onTap: () => onChanged(WineType.rose),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TypeChip({
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
          horizontal: context.w * 0.025,
          vertical: context.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary : cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.015),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont * 0.9,
            fontWeight: FontWeight.w600,
            color: isSelected ? cs.onPrimary : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _CompactField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;

  const _CompactField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: context.bodyFont),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: cs.primary, size: context.w * 0.05),
        filled: true,
        fillColor: cs.surfaceContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.w * 0.03),
          borderSide: BorderSide.none,
        ),
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
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.03, vertical: context.xs),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(context.w * 0.02),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.place,
              size: context.w * 0.04, color: cs.onPrimaryContainer),
          SizedBox(width: context.w * 0.01),
          Flexible(
            child: Text(
              location.shortDisplay,
              style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: context.w * 0.01),
          GestureDetector(
            onTap: onClear,
            child: Icon(Icons.close,
                size: context.w * 0.04, color: cs.onPrimaryContainer),
          ),
        ],
      ),
    );
  }
}

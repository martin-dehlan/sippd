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
      appBar: AppBar(
        title: Text('Add Wine',
            style: TextStyle(
                fontSize: context.headingFont, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: _submit,
            child: Text('Save',
                style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w700,
                    color: cs.primary)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          children: [
            SizedBox(height: context.m),

            // Photo placeholder
            WinePhotoPlaceholder(onTap: () {
              // TODO: image_picker
            }),
            SizedBox(height: context.l),

            // Name
            TextFormField(
              controller: _nameController,
              style: TextStyle(
                  fontSize: context.bodyFont, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                labelText: 'Wine Name',
                prefixIcon: Icon(Icons.wine_bar,
                    color: cs.primary, size: context.w * 0.05),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Name required' : null,
            ),
            SizedBox(height: context.m),

            // Type
            WineTypeSelector(
              selected: _type,
              onChanged: (t) => setState(() => _type = t),
            ),
            SizedBox(height: context.l),

            // Rating
            WineRatingInput(
              rating: _rating,
              onChanged: (v) => setState(() => _rating = v),
            ),
            SizedBox(height: context.l),

            // Section: Details
            SectionLabel(label: 'Details'),
            SizedBox(height: context.m),

            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      prefixIcon: Icon(Icons.euro,
                          color: cs.primary, size: context.w * 0.05),
                    ),
                  ),
                ),
                SizedBox(width: context.w * 0.03),
                Expanded(
                  child: TextFormField(
                    controller: _vintageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Year'),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.m),

            TextFormField(
              controller: _grapeController,
              decoration: InputDecoration(
                labelText: 'Grape variety',
                prefixIcon: Icon(Icons.grass,
                    color: cs.primary, size: context.w * 0.05),
              ),
            ),
            SizedBox(height: context.l),

            // Section: Origin
            SectionLabel(label: 'Origin'),
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
              SelectedLocationChip(
                location: _location!,
                onClear: () => setState(() => _location = null),
              ),
            ],
            SizedBox(height: context.l),

            // Section: Notes
            SectionLabel(label: 'Tasting Notes'),
            SizedBox(height: context.m),

            TextFormField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'How did it taste? Aromas, body, finish...',
                hintStyle: TextStyle(color: cs.outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(context.w * 0.03),
                ),
              ),
            ),
            SizedBox(height: context.xl),

            // Submit button
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
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────

class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(label,
        style: TextStyle(
          fontSize: context.captionFont,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: cs.onSurfaceVariant,
        ));
  }
}

class WinePhotoPlaceholder extends StatelessWidget {
  final VoidCallback onTap;
  const WinePhotoPlaceholder({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.h * 0.2,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.04),
          border: Border.all(
              color: cs.outlineVariant, style: BorderStyle.solid, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_outlined,
                size: context.w * 0.1, color: cs.outline),
            SizedBox(height: context.s),
            Text('Add Photo',
                style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.outline,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class WineTypeSelector extends StatelessWidget {
  final WineType selected;
  final ValueChanged<WineType> onChanged;

  const WineTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<WineType>(
      segments: const [
        ButtonSegment(value: WineType.red, label: Text('Red')),
        ButtonSegment(value: WineType.white, label: Text('White')),
        ButtonSegment(value: WineType.rose, label: Text('Rosé')),
      ],
      selected: {selected},
      onSelectionChanged: (v) => onChanged(v.first),
    );
  }
}

class SelectedLocationChip extends StatelessWidget {
  final LocationEntity location;
  final VoidCallback onClear;

  const SelectedLocationChip({
    super.key,
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
          Icon(Icons.place, size: context.w * 0.04, color: cs.onPrimaryContainer),
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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _TopBar(onSave: _submit),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: context.paddingH),
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
                      rating: _rating,
                      onRatingChanged: (v) => setState(() => _rating = v),
                      price: _price,
                      location: _location?.shortDisplay,
                      country: _country,
                      onPriceTap: _editPrice,
                      onPlaceTap: _editPlace,
                    ),
                    SizedBox(height: context.l),
                    _DetailsWrap(
                      grape: _grape,
                      vintage: _vintage,
                      country: _country,
                      onGrapeTap: _editGrape,
                      onVintageTap: _editVintage,
                      onCountryTap: () => showWineCountryPicker(
                        context: context,
                        selected: _country,
                        onChanged: (c) => setState(() => _country = c),
                      ),
                    ),
                    SizedBox(height: context.l),
                    _SectionLabel(text: 'Memory'),
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
                    _SectionLabel(text: 'Tasting notes'),
                    SizedBox(height: context.s),
                    _NotesTile(notes: _notes, onTap: _editNotes),
                    SizedBox(height: context.xl),
                    _SaveButton(onTap: _submit),
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
                    color: cs.primary)),
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
  final double rating;
  final ValueChanged<double> onRatingChanged;
  final double? price;
  final String? location;
  final String? country;
  final VoidCallback onPriceTap;
  final VoidCallback onPlaceTap;

  const _Hero({
    required this.imageUrl,
    required this.localPath,
    required this.onPhotoChanged,
    required this.nameController,
    required this.type,
    required this.onTypeChanged,
    required this.rating,
    required this.onRatingChanged,
    required this.price,
    required this.location,
    required this.country,
    required this.onPriceTap,
    required this.onPlaceTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final photoSize = context.w * 0.38;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: photoSize,
          height: photoSize * 1.4,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: nameController,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.headingFont,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
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
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: context.s),
              _TypeBadge(type: type, onChanged: onTypeChanged),
              SizedBox(height: context.l),
              _StatBlock(
                label: 'Rating',
                child: _RatingControl(
                    rating: rating, onChanged: onRatingChanged),
              ),
              SizedBox(height: context.m),
              _StatBlock(
                label: 'Price',
                onTap: onPriceTap,
                child: Text(
                  price != null ? '€${price!.toStringAsFixed(2)}' : '—',
                  style: TextStyle(
                    fontSize: context.headingFont * 1.1,
                    fontWeight: FontWeight.bold,
                    color: price != null ? cs.onSurface : cs.outline,
                  ),
                ),
              ),
              SizedBox(height: context.m),
              _StatBlock(
                label: 'Place',
                onTap: onPlaceTap,
                child: Text(
                  location ?? country ?? 'Tap to add',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: (location != null || country != null)
                        ? cs.onSurface
                        : cs.outline,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String label;
  final Widget child;
  final VoidCallback? onTap;
  const _StatBlock({required this.label, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final inner = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: context.captionFont,
              fontWeight: FontWeight.w500,
              color: cs.primary,
              letterSpacing: 0.3,
            )),
        SizedBox(height: context.xs * 0.5),
        child,
      ],
    );
    if (onTap == null) return inner;
    return GestureDetector(
        behavior: HitTestBehavior.opaque, onTap: onTap, child: inner);
  }
}

class _RatingControl extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onChanged;
  const _RatingControl({required this.rating, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
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
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: cs.primary,
            inactiveTrackColor: cs.outlineVariant,
            thumbColor: cs.primary,
            overlayColor: cs.primary.withValues(alpha: 0.12),
            trackHeight: 2,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
          ),
          child: Slider(
            value: rating,
            min: 0,
            max: 10,
            divisions: 20,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  final WineType type;
  final ValueChanged<WineType> onChanged;
  const _TypeBadge({required this.type, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TypePill(
            label: 'Red',
            selected: type == WineType.red,
            onTap: () => onChanged(WineType.red)),
        SizedBox(width: context.w * 0.015),
        _TypePill(
            label: 'White',
            selected: type == WineType.white,
            onTap: () => onChanged(WineType.white)),
        SizedBox(width: context.w * 0.015),
        _TypePill(
            label: 'Rosé',
            selected: type == WineType.rose,
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
          horizontal: context.w * 0.025,
          vertical: context.xs,
        ),
        decoration: BoxDecoration(
          color: selected ? cs.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(context.w * 0.05),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.captionFont * 0.9,
            fontWeight: FontWeight.w600,
            color: selected ? cs.onPrimary : cs.onSurface,
          ),
        ),
      ),
    );
  }
}

class _DetailsWrap extends StatelessWidget {
  final String? grape;
  final int? vintage;
  final String? country;
  final VoidCallback onGrapeTap;
  final VoidCallback onVintageTap;
  final VoidCallback onCountryTap;

  const _DetailsWrap({
    required this.grape,
    required this.vintage,
    required this.country,
    required this.onGrapeTap,
    required this.onVintageTap,
    required this.onCountryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: context.w * 0.02,
      runSpacing: context.s,
      children: [
        _DetailChip(
          icon: Icons.grass_outlined,
          label: grape ?? 'Add grape',
          isEmpty: grape == null,
          onTap: onGrapeTap,
        ),
        _DetailChip(
          icon: Icons.calendar_today_outlined,
          label: vintage?.toString() ?? 'Add year',
          isEmpty: vintage == null,
          onTap: onVintageTap,
        ),
        _DetailChip(
          icon: Icons.public,
          label: country ?? 'Add country',
          isEmpty: country == null,
          onTap: onCountryTap,
        ),
      ],
    );
  }
}

class _DetailChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEmpty;
  final VoidCallback onTap;

  const _DetailChip({
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

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Text(text,
        style: TextStyle(
          fontSize: context.captionFont,
          fontWeight: FontWeight.w700,
          color: cs.primary,
          letterSpacing: 0.3,
        ));
  }
}

class _NotesTile extends StatelessWidget {
  final String? notes;
  final VoidCallback onTap;
  const _NotesTile({required this.notes, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(context.m),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Text(
          notes ?? 'Aromas, body, finish…',
          style: TextStyle(
            fontSize: context.bodyFont,
            height: 1.5,
            color: notes != null ? cs.onSurface : cs.outline,
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SaveButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.h * 0.06,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.w * 0.03),
          ),
        ),
        child: Text('Save wine',
            style: TextStyle(
                fontSize: context.bodyFont, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

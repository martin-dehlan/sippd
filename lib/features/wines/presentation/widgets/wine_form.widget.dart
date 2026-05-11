import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

import '../../../../common/data/wine_regions.dart';
import '../../../../common/utils/price_format.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/price_input_sheet.dart';
import '../../../../common/widgets/text_input_sheet.dart';
import '../../../../common/widgets/year_picker_sheet.dart';
import '../../../locations/domain/entities/location.entity.dart';
import '../../../locations/presentation/widgets/location_search_sheet.dart';
import '../../controller/wine.provider.dart';
import '../../domain/entities/expert_tasting.entity.dart';
import '../../domain/entities/wine.entity.dart';
import 'grape_picker_sheet.dart';
import 'wine_rating_sheet.dart';
import 'wine_country_picker.widget.dart';
import 'wine_memories_editor.widget.dart';
import 'wine_photo_picker.widget.dart';
import 'wine_region_picker.widget.dart';

class WineFormData {
  final String name;
  final double rating;
  final WineType type;
  final double? price;
  final int? vintage;

  /// Display string for the legacy `grape` column. Always set to the
  /// canonical name (when [canonicalGrapeId] is set) or to the user's
  /// free-text entry — kept around so older readers still render
  /// something while the canonical id rolls out.
  final String? grape;
  final String? canonicalGrapeId;
  final String? grapeFreetext;

  final String? winery;
  final String? country;
  final String? region;
  final LocationEntity? location;
  final String? notes;
  final String? imageUrl;
  final String? localImagePath;
  final List<MemoryDraft> memories;

  /// Pro expert tasting dimensions the user typed inside the rating
  /// sheet during *initial* wine creation. Null for edits and for
  /// add-flows where the user never opened the tasting-notes panel.
  /// Persisted to `wine_ratings_extended` by the host screen after the
  /// wine row lands and a canonical id has been resolved.
  final ExpertTastingEntity? pendingExpertTasting;

  const WineFormData({
    required this.name,
    required this.rating,
    required this.type,
    this.price,
    this.vintage,
    this.grape,
    this.canonicalGrapeId,
    this.grapeFreetext,
    this.winery,
    this.country,
    this.region,
    this.location,
    this.notes,
    this.imageUrl,
    this.localImagePath,
    this.memories = const [],
    this.pendingExpertTasting,
  });
}

class WineForm extends ConsumerStatefulWidget {
  final WineFormData? initial;
  final String submitLabel;
  final Future<void> Function(WineFormData data) onSubmit;
  final ValueChanged<WineFormData>? onChanged;
  final bool autoSave;
  final WineEntity? wine;

  /// When false, the form omits its inline submit button. Host screens
  /// drive submission through a [GlobalKey] and call [WineFormState.submit].
  final bool showInlineSubmit;

  const WineForm({
    super.key,
    this.initial,
    this.submitLabel = 'Save wine',
    required this.onSubmit,
    this.onChanged,
    this.autoSave = false,
    this.showInlineSubmit = true,
    this.wine,
  });

  @override
  ConsumerState<WineForm> createState() => WineFormState();
}

class WineFormState extends ConsumerState<WineForm>
    with SingleTickerProviderStateMixin {
  /// Public submit hook for parents that host the action button outside
  /// the form (e.g. floating action button).
  Future<void> submit() => _submit();

  final _nameController = TextEditingController();
  final _nameFocus = FocusNode();
  final _nameFieldKey = GlobalKey();
  late final AnimationController _shake;

  bool _nameError = false;

  double _rating = 5.0;
  WineType _type = WineType.red;

  double? _price;
  int? _vintage;
  String? _grapeDisplay;
  String? _canonicalGrapeId;
  String? _grapeFreetext;
  String? _winery;
  String? _country;
  String? _region;
  LocationEntity? _location;
  String? _notes;

  String? _imageUrl;
  String? _localImagePath;
  List<MemoryDraft> _memories = const [];
  // Expert tasting typed during initial wine creation, persisted by the
  // host screen after canonical id resolves. Survives sheet re-opens.
  ExpertTastingEntity? _pendingExpertTasting;

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
      _canonicalGrapeId = init.canonicalGrapeId;
      _grapeFreetext = init.grapeFreetext;
      _grapeDisplay = init.grape;
      _winery = init.winery;
      _country = init.country;
      _region = init.region;
      _location = init.location;
      _notes = init.notes;
      _imageUrl = init.imageUrl;
      _localImagePath = init.localImagePath;
      _memories = init.memories;
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
    widget.onChanged?.call(_collect());
    if (!widget.autoSave) return;
    // Cancel any in-flight debounce *before* the empty-name guard, not
    // after — otherwise clearing the name field still lets a previously
    // queued save fire 500ms later, which then writes the now-empty
    // name into the wine row. (Repro: edit a wine, type a new name,
    // immediately clear it before the debounce fires → wine ends up
    // nameless.) Also re-check at fire time for the same reason.
    _autoSaveDebounce?.cancel();
    if (_nameController.text.trim().isEmpty) return;
    _autoSaveDebounce = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      if (_nameController.text.trim().isEmpty) return;
      widget.onSubmit(_collect());
    });
  }

  WineFormData _collect() => WineFormData(
    name: _nameController.text.trim(),
    rating: _rating,
    type: _type,
    price: _price,
    vintage: _vintage,
    grape: _grapeDisplay,
    canonicalGrapeId: _canonicalGrapeId,
    grapeFreetext: _grapeFreetext,
    winery: _winery,
    country: _country,
    region: _region,
    location: _location,
    notes: _notes,
    imageUrl: _imageUrl,
    localImagePath: _localImagePath,
    memories: _memories,
    pendingExpertTasting: _pendingExpertTasting,
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
    FocusScope.of(context).unfocus();
    final result = await showWineRatingSheet(
      context: context,
      initial: _rating,
      ratingContext: 'personal',
      wine: widget.wine,
      // Pre-save the wine entity doesn't exist yet, so the rating sheet
      // can't read wine.type for the expert panel. Pass the form's
      // current type explicitly so the panel can render before save.
      wineType: _type,
      // Re-seed any expert dimensions the user typed in a previous open
      // of the sheet during this same add-wine flow, so re-opening
      // shows what was typed instead of starting empty.
      initialExpert: _pendingExpertTasting,
    );
    if (!mounted) return;
    if (result == null) return;
    setState(() {
      _rating = result.rating;
      // Only overwrite when the sheet handed us pending dims (initial
      // wine creation path). For an existing wine the sheet wrote them
      // inline and `pendingExpert` is null — don't clobber prior state.
      if (result.pendingExpert != null) {
        _pendingExpertTasting = result.pendingExpert;
      }
    });
    _scheduleAutoSave();
  }

  Future<void> _editPrice() async {
    FocusScope.of(context).unfocus();
    final result = await showPriceInputSheet(context: context, initial: _price);
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (result == null) return;
    setState(
      () => _price = result.isEmpty
          ? null
          : double.tryParse(result.replaceAll(',', '.')),
    );
    _scheduleAutoSave();
  }

  Future<void> _editVintage() async {
    FocusScope.of(context).unfocus();
    final result = await showYearPickerSheet(
      context: context,
      initial: _vintage,
    );
    if (!mounted) return;
    if (result == null) return;
    setState(() => _vintage = result.year);
    _scheduleAutoSave();
  }

  /// Display label for the grape chip — resolves canonical_grape_id via
  /// the cached catalog. Falls back to the user's free-text entry, then
  /// the legacy grape string carried in from the wine row.
  String? _resolvedGrapeLabel() {
    final id = _canonicalGrapeId;
    if (id != null) {
      final asyncGrape = ref.watch(canonicalGrapeProvider(id));
      return asyncGrape.valueOrNull?.name ?? _grapeDisplay;
    }
    return _grapeFreetext ?? _grapeDisplay;
  }

  Future<void> _editGrape() async {
    FocusScope.of(context).unfocus();
    final result = await showGrapePickerSheet(
      context: context,
      initialCanonicalId: _canonicalGrapeId,
      initialFreetext:
          _grapeFreetext ?? (_canonicalGrapeId == null ? _grapeDisplay : null),
    );
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (result == null) return;
    setState(() {
      if (result.isCanonical) {
        _canonicalGrapeId = result.id;
        _grapeFreetext = null;
        _grapeDisplay = result.name;
      } else {
        _canonicalGrapeId = null;
        _grapeFreetext = result.freetext;
        _grapeDisplay = result.freetext;
      }
    });
    _scheduleAutoSave();
  }

  Future<void> _editWinery() async {
    FocusScope.of(context).unfocus();
    final result = await showTextInputSheet(
      context: context,
      title: 'Winery',
      initial: _winery,
      hint: 'e.g. Château Margaux',
      maxLength: 100,
    );
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (result == null) return;
    setState(() => _winery = result.isEmpty ? null : result);
    _scheduleAutoSave();
  }

  Future<void> _editNotes() async {
    FocusScope.of(context).unfocus();
    final result = await showTextInputSheet(
      context: context,
      title: 'Tasting notes',
      initial: _notes,
      hint: 'Aromas, body, finish…',
      maxLines: 5,
      maxLength: 2000,
    );
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
    if (result == null) return;
    setState(() => _notes = result.isEmpty ? null : result);
    _scheduleAutoSave();
  }

  void _editOrigin() {
    FocusScope.of(context).unfocus();
    showWineCountryPicker(
      context: context,
      selected: _country,
      onChanged: (c) {
        final countryChanged = c != _country;
        setState(() {
          _country = c;
          if (countryChanged) _region = null;
        });
        _scheduleAutoSave();
        if (c != null && hasRegionsFor(c)) {
          // Defer to let the country sheet finish dismissing.
          Future.microtask(() {
            if (!mounted) return;
            showWineRegionPicker(
              context: context,
              country: c,
              selected: _region,
              onChanged: (r) {
                setState(() => _region = r);
                _scheduleAutoSave();
              },
            );
          });
        }
      },
    );
  }

  Future<void> _editPlace() async {
    FocusScope.of(context).unfocus();
    final result = await showLocationSearchSheet(
      context: context,
      initial: _location,
    );
    if (!mounted) return;
    FocusManager.instance.primaryFocus?.unfocus();
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
                    placeholderIcon: PhosphorIconsRegular.wine,
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
                      WineFormRatingStat(rating: _rating, onTap: _editRating),
                      SizedBox(height: context.l),
                      WineFormPriceStat(price: _price, onTap: _editPrice),
                      SizedBox(height: context.l),
                      WineFormCountryStat(
                        country: _country,
                        region: _region,
                        onTap: _editOrigin,
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
          grape: _resolvedGrapeLabel(),
          vintage: _vintage,
          notes: _notes,
          winery: _winery,
          onGrapeTap: _editGrape,
          onVintageTap: _editVintage,
          onNotesTap: _editNotes,
          onWineryTap: _editWinery,
        ),
        SizedBox(height: context.l),
        WineMemoriesEditor(
          memories: _memories,
          onChanged: (next) {
            setState(() => _memories = next);
            _scheduleAutoSave();
          },
        ),
        SizedBox(height: context.l),
        SizedBox(
          height: context.h * 0.24,
          child: WineFormPlaceMap(location: _location, onTap: _editPlace),
        ),
        if (!widget.autoSave && widget.showInlineSubmit) ...[
          SizedBox(height: context.l),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH),
            child: SizedBox(
              width: double.infinity,
              height: context.h * 0.065,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(PhosphorIconsRegular.check),
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
        // Bottom scroll padding — keeps the last form field clear of the
        // floating Save / Back buttons hosted by the parent screen.
        SizedBox(height: context.xl * 3),
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
          textCapitalization: TextCapitalization.words,
          style: titleStyle,
          maxLength: 60,
          maxLines: 2,
          minLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(60)],
          decoration: InputDecoration(
            hintText: 'Wine name',
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
    return Text(
      text,
      style: TextStyle(
        fontSize: context.captionFont,
        fontWeight: FontWeight.w500,
        color: cs.primary,
        letterSpacing: 0.3,
      ),
    );
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
              Text(
                rating.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: context.headingFont * 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: context.w * 0.01),
              Text(
                '/ 10',
                style: TextStyle(
                  fontSize: context.captionFont,
                  color: cs.onSurfaceVariant,
                ),
              ),
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
                price != null ? formatPrice(price!) : '—',
                style: TextStyle(
                  fontSize: context.headingFont * 1.4,
                  fontWeight: FontWeight.bold,
                  color: price != null ? cs.onSurface : cs.outline,
                ),
              ),
              if (price != null) ...[
                SizedBox(width: context.w * 0.01),
                Text(
                  'EUR',
                  style: TextStyle(
                    fontSize: context.captionFont,
                    color: cs.onSurfaceVariant,
                  ),
                ),
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
            label: 'Red',
            isSelected: selected == WineType.red,
            onTap: () => onChanged(WineType.red),
          ),
          WineFormTypeChoice(
            type: WineType.white,
            label: 'White',
            isSelected: selected == WineType.white,
            onTap: () => onChanged(WineType.white),
          ),
          WineFormTypeChoice(
            type: WineType.rose,
            label: 'Rosé',
            isSelected: selected == WineType.rose,
            onTap: () => onChanged(WineType.rose),
          ),
          WineFormTypeChoice(
            type: WineType.sparkling,
            label: 'Sparkling',
            isSelected: selected == WineType.sparkling,
            onTap: () => onChanged(WineType.sparkling),
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
      WineType.sparkling => const Color(0xFFD4A84B),
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
          color: isSelected
              ? color.withValues(alpha: 0.18)
              : Colors.transparent,
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
  final String? region;
  final VoidCallback onTap;
  const WineFormCountryStat({
    super.key,
    required this.country,
    required this.region,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // Region replaces country when set — single field, no extra row.
    final headline = region ?? country;
    final hasValue = headline != null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          WineFormStatLabel(text: region != null ? 'Region' : 'Country'),
          SizedBox(height: context.xs * 0.3),
          Text(
            headline ?? '—',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: context.bodyFont * 1.1,
              fontWeight: FontWeight.bold,
              color: hasValue ? cs.onSurface : cs.outline,
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
  final String? winery;
  final VoidCallback onGrapeTap;
  final VoidCallback onVintageTap;
  final VoidCallback onNotesTap;
  final VoidCallback onWineryTap;

  const WineFormChipsRow({
    super.key,
    required this.grape,
    required this.vintage,
    required this.notes,
    required this.winery,
    required this.onGrapeTap,
    required this.onVintageTap,
    required this.onNotesTap,
    required this.onWineryTap,
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
            icon: PhosphorIconsRegular.factory,
            label: winery ?? 'Winery',
            isEmpty: winery == null,
            onTap: onWineryTap,
          ),
          WineFormFieldChip(
            icon: PhosphorIconsRegular.plant,
            label: grape ?? 'Grape',
            isEmpty: grape == null,
            onTap: onGrapeTap,
          ),
          WineFormFieldChip(
            icon: PhosphorIconsRegular.calendarBlank,
            label: vintage?.toString() ?? 'Year',
            isEmpty: vintage == null,
            onTap: onVintageTap,
          ),
          WineFormFieldChip(
            icon: PhosphorIconsRegular.notePencil,
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
            Icon(
              icon,
              size: context.w * 0.04,
              color: isEmpty ? cs.outline : cs.primary,
            ),
            SizedBox(width: context.w * 0.015),
            Text(
              label,
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w500,
                color: isEmpty ? cs.outline : cs.onSurface,
              ),
            ),
          ],
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
                      Icon(
                        PhosphorIconsRegular.mapPinPlus,
                        size: context.w * 0.12,
                        color: cs.outline,
                      ),
                      SizedBox(height: context.s),
                      Text(
                        'Tap to add place',
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
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
                userAgentPackageName: 'xyz.sippd.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: point,
                    width: context.w * 0.1,
                    height: context.w * 0.1,
                    child: Icon(
                      PhosphorIconsFill.mapPin,
                      size: context.w * 0.1,
                      color: cs.primary,
                    ),
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
              horizontal: context.m,
              vertical: context.s,
            ),
            decoration: BoxDecoration(
              color: cs.surface.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(context.w * 0.02),
            ),
            child: Row(
              children: [
                Icon(
                  PhosphorIconsRegular.mapPin,
                  size: context.w * 0.045,
                  color: cs.primary,
                ),
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

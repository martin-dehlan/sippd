import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../controller/wine.provider.dart';
import '../../../domain/entities/wine.entity.dart';

class WineAddScreen extends ConsumerStatefulWidget {
  const WineAddScreen({super.key});

  @override
  ConsumerState<WineAddScreen> createState() => _WineAddScreenState();
}

class _WineAddScreenState extends ConsumerState<WineAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _countryController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  final _grapeController = TextEditingController();
  final _vintageController = TextEditingController();

  double _rating = 5.0;
  WineType _type = WineType.red;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _countryController.dispose();
    _locationController.dispose();
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
      country: _countryController.text.isNotEmpty
          ? _countryController.text.trim()
          : null,
      location: _locationController.text.isNotEmpty
          ? _locationController.text.trim()
          : null,
      notes: _notesController.text.isNotEmpty
          ? _notesController.text.trim()
          : null,
      grape: _grapeController.text.isNotEmpty
          ? _grapeController.text.trim()
          : null,
      vintage: _vintageController.text.isNotEmpty
          ? int.tryParse(_vintageController.text)
          : null,
      userId: 'local_user', // TODO: Replace with Supabase auth user
      createdAt: DateTime.now(),
    );

    await ref.read(wineControllerProvider.notifier).addWine(wine);

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Wine',
          style: TextStyle(
            fontSize: context.headingFont,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: context.paddingH,
              vertical: context.paddingV,
            ),
            children: [
              // Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Wine Name'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Name required' : null,
              ),
              SizedBox(height: context.m),

              // Rating slider
              Text(
                'Rating: ${_rating.toStringAsFixed(1)} / 10',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Slider(
                value: _rating,
                min: 0,
                max: 10,
                divisions: 20,
                label: _rating.toStringAsFixed(1),
                onChanged: (v) => setState(() => _rating = v),
              ),
              SizedBox(height: context.m),

              // Wine type
              Text(
                'Type',
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: context.s),
              SegmentedButton<WineType>(
                segments: const [
                  ButtonSegment(value: WineType.red, label: Text('Red')),
                  ButtonSegment(value: WineType.white, label: Text('White')),
                  ButtonSegment(value: WineType.rose, label: Text('Rosé')),
                ],
                selected: {_type},
                onSelectionChanged: (v) => setState(() => _type = v.first),
              ),
              SizedBox(height: context.m),

              // Price
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price (optional)',
                  prefixText: '€ ',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: context.m),

              // Country
              TextFormField(
                controller: _countryController,
                decoration:
                    const InputDecoration(labelText: 'Country (optional)'),
              ),
              SizedBox(height: context.m),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                    labelText: 'Where did you drink it? (optional)'),
              ),
              SizedBox(height: context.m),

              // Grape
              TextFormField(
                controller: _grapeController,
                decoration: const InputDecoration(
                    labelText: 'Grape variety (optional)'),
              ),
              SizedBox(height: context.m),

              // Vintage
              TextFormField(
                controller: _vintageController,
                decoration:
                    const InputDecoration(labelText: 'Vintage (optional)'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: context.m),

              // Notes
              TextFormField(
                controller: _notesController,
                decoration:
                    const InputDecoration(labelText: 'Tasting notes (optional)'),
                maxLines: 3,
              ),
              SizedBox(height: context.xl),

              // Submit
              SizedBox(
                width: double.infinity,
                height: context.h * 0.06,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(
                    'Add Wine',
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.l),
            ],
          ),
        ),
      ),
    );
  }
}

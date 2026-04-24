import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/text_input_sheet.dart';
import '../../../../../core/routes/app.routes.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../locations/presentation/widgets/location_search_sheet.dart';
import '../../../controller/tastings.provider.dart';

class TastingCreateScreen extends ConsumerStatefulWidget {
  final String groupId;
  const TastingCreateScreen({super.key, required this.groupId});

  @override
  ConsumerState<TastingCreateScreen> createState() =>
      _TastingCreateScreenState();
}

class _TastingCreateScreenState extends ConsumerState<TastingCreateScreen> {
  String _title = '';
  String? _description;
  LocationEntity? _location;
  DateTime _date = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _time = const TimeOfDay(hour: 19, minute: 0);
  bool _saving = false;

  DateTime get _scheduledAt => DateTime(
      _date.year, _date.month, _date.day, _time.hour, _time.minute);

  Future<void> _editTitle() async {
    final r = await showTextInputSheet(
      context: context,
      title: 'Tasting title',
      initial: _title,
      hint: 'e.g. Barolo night',
    );
    if (r == null) return;
    setState(() => _title = r);
  }

  Future<void> _editDescription() async {
    final r = await showTextInputSheet(
      context: context,
      title: 'Description',
      initial: _description,
      hint: 'What is this about?',
      maxLines: 4,
    );
    if (r == null) return;
    setState(() => _description = r.isEmpty ? null : r);
  }

  Future<void> _editDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _editTime() async {
    final picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null) setState(() => _time = picked);
  }

  Future<void> _editPlace() async {
    final r = await showLocationSearchSheet(
      context: context,
      initial: _location,
    );
    if (r == null) return;
    setState(() => _location = r);
  }

  Future<void> _submit() async {
    if (_title.trim().isEmpty) return;
    setState(() => _saving = true);
    final tasting =
        await ref.read(tastingsControllerProvider.notifier).create(
              groupId: widget.groupId,
              title: _title.trim(),
              description: _description,
              location: _location?.shortDisplay,
              latitude: _location?.lat,
              longitude: _location?.lng,
              scheduledAt: _scheduledAt,
            );
    if (!mounted) return;
    setState(() => _saving = false);
    if (tasting != null) {
      context.pushReplacement(AppRoutes.tastingDetailPath(tasting.id));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not create tasting')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final canSave = _title.trim().isNotEmpty && !_saving;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: context.xl * 1.5),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
              child: Text('NEW TASTING',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: context.titleFont * 1.1,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.05,
                  )),
            ),
            SizedBox(height: context.l),
            _Row(
              label: 'Title',
              value: _title.isEmpty ? 'Tap to add' : _title,
              isEmpty: _title.isEmpty,
              onTap: _editTitle,
            ),
            _Divider(),
            _Row(
              label: 'Date',
              value: DateFormat.yMMMMEEEEd().format(_date),
              isEmpty: false,
              onTap: _editDate,
            ),
            _Divider(),
            _Row(
              label: 'Time',
              value: _time.format(context),
              isEmpty: false,
              onTap: _editTime,
            ),
            _Divider(),
            _Row(
              label: 'Place',
              value: _location?.shortDisplay ?? 'Tap to add',
              isEmpty: _location == null,
              onTap: _editPlace,
            ),
            _Divider(),
            _Row(
              label: 'Description',
              value: _description ?? 'Tap to add',
              isEmpty: _description == null,
              onTap: _editDescription,
            ),
            _Divider(),
            SizedBox(height: context.xl),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
              child: SizedBox(
                width: double.infinity,
                height: context.h * 0.06,
                child: FilledButton(
                  onPressed: canSave ? _submit : null,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                  child: _saving
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: cs.onPrimary),
                        )
                      : Text('Create tasting',
                          style: TextStyle(
                              fontSize: context.bodyFont,
                              fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            SizedBox(height: context.xl * 3),
          ],
        ),
      ),
      floatingActionButton: const _BackFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _BackFab extends StatelessWidget {
  const _BackFab();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = context.w * 0.16;
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        heroTag: 'tasting-create-back',
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

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmpty;
  final VoidCallback onTap;

  const _Row({
    required this.label,
    required this.value,
    required this.isEmpty,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.paddingH * 1.3, vertical: context.m),
        child: Row(
          children: [
            SizedBox(
              width: context.w * 0.28,
              child: Text(label,
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      color: cs.onSurface)),
            ),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w500,
                  color: isEmpty ? cs.outline : cs.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: context.w * 0.02),
            Icon(Icons.chevron_right,
                size: context.w * 0.045, color: cs.outline),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
      child: Divider(color: cs.outlineVariant, height: 1, thickness: 0.5),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../common/utils/responsive.dart';
import '../../../../../common/widgets/text_input_sheet.dart';
import '../../../../locations/domain/entities/location.entity.dart';
import '../../../../locations/presentation/widgets/location_search_sheet.dart';
import '../../../controller/tastings.provider.dart';
import '../../../domain/entities/tasting.entity.dart';

class TastingEditScreen extends ConsumerWidget {
  final String tastingId;
  const TastingEditScreen({super.key, required this.tastingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(tastingDetailProvider(tastingId));
    return Scaffold(
      body: async.when(
        data: (t) {
          if (t == null) {
            return const Center(child: Text('Tasting not found'));
          }
          return _EditForm(tasting: t);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: const _BackFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

class _EditForm extends ConsumerStatefulWidget {
  final TastingEntity tasting;
  const _EditForm({required this.tasting});

  @override
  ConsumerState<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<_EditForm> {
  late String _title;
  late String? _description;
  late LocationEntity? _location;
  late DateTime _date;
  late TimeOfDay _time;
  late bool _openLineup;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final t = widget.tasting;
    _title = t.title;
    _description = t.description;
    _location = (t.location != null || t.latitude != null)
        ? LocationEntity(
            lat: t.latitude,
            lng: t.longitude,
            locationName: t.location ?? '',
          )
        : null;
    final local = t.scheduledAt.toLocal();
    _date = DateTime(local.year, local.month, local.day);
    _time = TimeOfDay(hour: local.hour, minute: local.minute);
    _openLineup = t.lineupMode == TastingLineupMode.open;
  }

  DateTime get _scheduledAt =>
      DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);

  Future<void> _editTitle() async {
    final r = await showTextInputSheet(
      context: context,
      title: 'Tasting title',
      initial: _title,
      hint: 'e.g. Barolo night',
      maxLength: 80,
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
      maxLength: 1000,
    );
    if (r == null) return;
    setState(() => _description = r.isEmpty ? null : r);
  }

  Future<void> _editDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _editTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
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
    final updated = await ref
        .read(tastingsControllerProvider.notifier)
        .updateTasting(
          tastingId: widget.tasting.id,
          groupId: widget.tasting.groupId,
          title: _title.trim(),
          description: _description,
          location: _location?.shortDisplay,
          latitude: _location?.lat,
          longitude: _location?.lng,
          scheduledAt: _scheduledAt,
          lineupMode: _openLineup
              ? TastingLineupMode.open
              : TastingLineupMode.planned,
        );
    if (!mounted) return;
    setState(() => _saving = false);
    if (updated != null) {
      context.pop();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not update tasting')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final canSave = _title.trim().isNotEmpty && !_saving;

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(height: context.xl * 1.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: Text(
              'EDIT TASTING',
              style: GoogleFonts.playfairDisplay(
                fontSize: context.titleFont * 1.1,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                height: 1.05,
              ),
            ),
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
            value: _location?.shortDisplay.isNotEmpty == true
                ? _location!.shortDisplay
                : 'Tap to add',
            isEmpty: _location == null || _location!.shortDisplay.isEmpty,
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
          _ToggleRow(
            label: 'Open lineup',
            hint: 'Add wines as they arrive',
            value: _openLineup,
            onChanged: (v) => setState(() => _openLineup = v),
          ),
          _Divider(),
          SizedBox(height: context.xl),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.paddingH * 1.3),
            child: SizedBox(
              width: double.infinity,
              height: context.h * 0.06,
              child: FilledButton(
                onPressed: canSave ? _submit : null,
                style: FilledButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.w * 0.03),
                  ),
                ),
                child: _saving
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onPrimary,
                        ),
                      )
                    : Text(
                        'Save changes',
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: context.xl * 2),
        ],
      ),
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
        heroTag: 'tasting-edit-back',
        backgroundColor: cs.surfaceContainer,
        foregroundColor: cs.onSurface,
        elevation: 2,
        shape: const CircleBorder(),
        onPressed: () => context.pop(),
        child: Icon(PhosphorIconsRegular.arrowLeft, size: context.w * 0.06),
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
          horizontal: context.paddingH * 1.3,
          vertical: context.m,
        ),
        child: Row(
          children: [
            SizedBox(
              width: context.w * 0.28,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  color: cs.onSurface,
                ),
              ),
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
            Icon(
              PhosphorIconsRegular.caretRight,
              size: context.w * 0.045,
              color: cs.outline,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String label;
  final String hint;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH * 1.3,
          vertical: context.m,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      color: cs.onSurface,
                    ),
                  ),
                  SizedBox(height: context.xs * 0.6),
                  Text(
                    hint,
                    style: TextStyle(
                      fontSize: context.captionFont * 0.95,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Switch(value: value, onChanged: onChanged),
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

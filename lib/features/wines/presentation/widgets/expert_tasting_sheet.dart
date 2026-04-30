import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/responsive.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../data/data_sources/expert_tasting.api.dart';
import '../../domain/entities/expert_tasting.entity.dart';
import '../../domain/entities/wine.entity.dart';

/// Pro-grade tasting sheet — five 1..5 sliders + finish pill + aroma
/// chip picker. Saves into wine_ratings_extended which feeds the
/// canonical_wine_attributes aggregation that powers Style DNA.
Future<void> showExpertTastingSheet({
  required BuildContext context,
  required WineEntity wine,
}) {
  if (wine.canonicalWineId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Wine identity not yet resolved — try again in a moment.",
        ),
      ),
    );
    return Future.value();
  }
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (_) => _ExpertSheet(wine: wine),
  );
}

const _aromaTags = [
  'cherry', 'raspberry', 'strawberry', 'plum',
  'blackcurrant', 'blackberry', 'blueberry',
  'lemon', 'lime', 'grapefruit',
  'pineapple', 'mango', 'passion fruit',
  'peach', 'apricot',
  'rose', 'violet', 'honeysuckle',
  'bell pepper', 'mint', 'eucalyptus',
  'leather', 'tobacco', 'mushroom',
  'black pepper', 'vanilla', 'clove',
  'toast', 'smoke', 'cedar',
  'honey', 'butter', 'mineral',
];

class _ExpertSheet extends ConsumerStatefulWidget {
  const _ExpertSheet({required this.wine});

  final WineEntity wine;

  @override
  ConsumerState<_ExpertSheet> createState() => _ExpertSheetState();
}

class _ExpertSheetState extends ConsumerState<_ExpertSheet> {
  ExpertTastingEntity _draft = const ExpertTastingEntity();
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    final api = ExpertTastingApi(ref.read(supabaseClientProvider));
    final existing =
        await api.getMine(canonicalWineId: widget.wine.canonicalWineId!);
    if (!mounted) return;
    setState(() {
      _draft = existing ?? const ExpertTastingEntity();
      _loading = false;
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    HapticFeedback.lightImpact();
    final api = ExpertTastingApi(ref.read(supabaseClientProvider));
    try {
      await api.upsert(
        canonicalWineId: widget.wine.canonicalWineId!,
        tasting: _draft,
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  bool get _isRed => widget.wine.type == WineType.red;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        left: context.paddingH,
        right: context.paddingH,
        top: context.s,
        bottom: MediaQuery.of(context).viewInsets.bottom + context.l,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: context.m),
            Text(
              'Tasting notes',
              style: TextStyle(
                fontSize: context.headingFont * 0.95,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.xs * 0.5),
            Text(
              'WSET-style perceptions. Helps refine your Style DNA and '
              'feeds into the global wine catalog.',
              style: TextStyle(
                fontSize: context.captionFont,
                color: cs.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            SizedBox(height: context.m),
            if (_loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(child: CircularProgressIndicator()),
              )
            else ...[
              _LikertRow(
                label: 'Body',
                lowLabel: 'light',
                highLabel: 'full',
                value: _draft.body,
                onChanged: (v) => setState(() => _draft = _draft.copyWith(body: v)),
              ),
              if (_isRed)
                _LikertRow(
                  label: 'Tannin',
                  lowLabel: 'soft',
                  highLabel: 'gripping',
                  value: _draft.tannin,
                  onChanged: (v) =>
                      setState(() => _draft = _draft.copyWith(tannin: v)),
                ),
              _LikertRow(
                label: 'Acidity',
                lowLabel: 'soft',
                highLabel: 'crisp',
                value: _draft.acidity,
                onChanged: (v) =>
                    setState(() => _draft = _draft.copyWith(acidity: v)),
              ),
              _LikertRow(
                label: 'Sweetness',
                lowLabel: 'dry',
                highLabel: 'sweet',
                value: _draft.sweetness,
                onChanged: (v) =>
                    setState(() => _draft = _draft.copyWith(sweetness: v)),
              ),
              _LikertRow(
                label: 'Oak',
                lowLabel: 'unoaked',
                highLabel: 'heavy',
                value: _draft.oak,
                onChanged: (v) =>
                    setState(() => _draft = _draft.copyWith(oak: v)),
              ),
              SizedBox(height: context.s),
              _FinishPicker(
                value: _draft.finish,
                onChanged: (v) =>
                    setState(() => _draft = _draft.copyWith(finish: v)),
              ),
              SizedBox(height: context.m),
              _AromaPicker(
                selected: _draft.aromaTags,
                onToggle: (tag) {
                  final next = [..._draft.aromaTags];
                  if (next.contains(tag)) {
                    next.remove(tag);
                  } else {
                    next.add(tag);
                  }
                  setState(() => _draft = _draft.copyWith(aromaTags: next));
                },
              ),
              SizedBox(height: context.l),
              SizedBox(
                height: context.h * 0.06,
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.04),
                    ),
                  ),
                  child: _saving
                      ? SizedBox(
                          width: context.w * 0.05,
                          height: context.w * 0.05,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: cs.onPrimary,
                          ),
                        )
                      : Text(
                          _draft.isEmpty
                              ? 'Save (or skip)'
                              : 'Save tasting notes',
                          style: TextStyle(
                            fontSize: context.bodyFont,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LikertRow extends StatelessWidget {
  const _LikertRow({
    required this.label,
    required this.lowLabel,
    required this.highLabel,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final String lowLabel;
  final String highLabel;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ),
              if (value != null)
                GestureDetector(
                  onTap: () => onChanged(null),
                  child: Text(
                    'clear',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.85,
                      color: cs.outline,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: context.xs * 0.7),
          Row(
            children: [
              for (var i = 1; i <= 5; i++)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onChanged(i);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      height: context.h * 0.04,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: i == value
                            ? cs.primary
                            : cs.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: i == value ? cs.onPrimary : cs.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: context.captionFont,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Text(
                  lowLabel,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.78,
                    color: cs.outline,
                  ),
                ),
                const Spacer(),
                Text(
                  highLabel,
                  style: TextStyle(
                    fontSize: context.captionFont * 0.78,
                    color: cs.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FinishPicker extends StatelessWidget {
  const _FinishPicker({required this.value, required this.onChanged});

  final int? value;
  final ValueChanged<int?> onChanged;

  static const _labels = ['Short', 'Medium', 'Long'];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Finish',
                  style: TextStyle(
                    fontSize: context.bodyFont * 0.95,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
              ),
              if (value != null)
                GestureDetector(
                  onTap: () => onChanged(null),
                  child: Text(
                    'clear',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.85,
                      color: cs.outline,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: context.xs * 0.7),
          Row(
            children: [
              for (var i = 1; i <= 3; i++)
                Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(i),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      height: context.h * 0.05,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: i == value
                            ? cs.primary.withValues(alpha: 0.18)
                            : cs.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: i == value
                              ? cs.primary
                              : Colors.transparent,
                          width: 1.4,
                        ),
                      ),
                      child: Text(
                        _labels[i - 1],
                        style: TextStyle(
                          color: i == value ? cs.primary : cs.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: context.captionFont,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AromaPicker extends StatelessWidget {
  const _AromaPicker({required this.selected, required this.onToggle});

  final List<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aromas',
          style: TextStyle(
            fontSize: context.bodyFont * 0.95,
            fontWeight: FontWeight.w700,
            color: cs.onSurface,
          ),
        ),
        SizedBox(height: context.xs),
        Wrap(
          spacing: context.xs * 1.2,
          runSpacing: context.xs * 1.2,
          children: [
            for (final tag in _aromaTags)
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onToggle(tag);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w * 0.025,
                    vertical: context.h * 0.006,
                  ),
                  decoration: BoxDecoration(
                    color: selected.contains(tag)
                        ? cs.primary.withValues(alpha: 0.18)
                        : cs.surfaceContainer,
                    borderRadius: BorderRadius.circular(context.w * 0.04),
                    border: Border.all(
                      color: selected.contains(tag)
                          ? cs.primary
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      fontSize: context.captionFont * 0.95,
                      color: selected.contains(tag)
                          ? cs.primary
                          : cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../../auth/controller/auth.provider.dart';
import '../../data/data_sources/expert_tasting.api.dart';
import '../../domain/entities/expert_tasting.entity.dart';
import '../../domain/entities/wine.entity.dart';

/// Pro tasting sheet — five 1..5 perception rows, finish pill, optional
/// aroma chip picker. Reads / saves wine_ratings_extended which feeds
/// the canonical_wine_attributes aggregation that powers Style DNA.
Future<void> showExpertTastingSheet({
  required BuildContext context,
  required WineEntity wine,
}) {
  if (wine.canonicalWineId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Save the wine first — tasting notes attach to the canonical id.',
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
  bool _aromasExpanded = false;

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
      _aromasExpanded = (existing?.aromaTags ?? const []).isNotEmpty;
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
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.paddingH,
            vertical: context.s,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SheetHeader(
                onClose: () => Navigator.pop(context),
                aromaCount: _draft.aromaTags.length,
              ),
              SizedBox(height: context.s),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(child: CircularProgressIndicator()),
                )
              else ...[
                Flexible(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TastingCompactRow(
                          label: 'Body',
                          lowLabel: 'light',
                          highLabel: 'full',
                          value: _draft.body,
                          onChanged: (v) =>
                              setState(() => _draft = _draft.copyWith(body: v)),
                        ),
                        if (_isRed)
                          TastingCompactRow(
                            label: 'Tannin',
                            lowLabel: 'soft',
                            highLabel: 'gripping',
                            value: _draft.tannin,
                            onChanged: (v) => setState(
                                () => _draft = _draft.copyWith(tannin: v)),
                          ),
                        TastingCompactRow(
                          label: 'Acidity',
                          lowLabel: 'soft',
                          highLabel: 'crisp',
                          value: _draft.acidity,
                          onChanged: (v) => setState(
                              () => _draft = _draft.copyWith(acidity: v)),
                        ),
                        TastingCompactRow(
                          label: 'Sweetness',
                          lowLabel: 'dry',
                          highLabel: 'sweet',
                          value: _draft.sweetness,
                          onChanged: (v) => setState(
                              () => _draft = _draft.copyWith(sweetness: v)),
                        ),
                        TastingCompactRow(
                          label: 'Oak',
                          lowLabel: 'unoaked',
                          highLabel: 'heavy',
                          value: _draft.oak,
                          onChanged: (v) =>
                              setState(() => _draft = _draft.copyWith(oak: v)),
                        ),
                        SizedBox(height: context.xs),
                        TastingFinishRow(
                          value: _draft.finish,
                          onChanged: (v) => setState(
                              () => _draft = _draft.copyWith(finish: v)),
                        ),
                        SizedBox(height: context.s),
                        TastingAromaSection(
                          expanded: _aromasExpanded,
                          selected: _draft.aromaTags,
                          onToggleExpand: () => setState(
                              () => _aromasExpanded = !_aromasExpanded),
                          onToggleTag: (tag) {
                            final next = [..._draft.aromaTags];
                            if (next.contains(tag)) {
                              next.remove(tag);
                            } else {
                              next.add(tag);
                            }
                            setState(
                                () => _draft = _draft.copyWith(aromaTags: next));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.m),
                SizedBox(
                  width: double.infinity,
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
                            'Save',
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
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.onClose, required this.aromaCount});

  final VoidCallback onClose;
  final int aromaCount;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: context.xs),
            width: context.w * 0.1,
            height: 4,
            decoration: BoxDecoration(
              color: cs.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: context.s * 1.4),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tasting notes',
                      style: TextStyle(
                        fontSize: context.bodyFont * 1.05,
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                    ),
                    Text(
                      'WSET-style perceptions',
                      style: TextStyle(
                        fontSize: context.captionFont * 0.85,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onClose,
                icon: Icon(PhosphorIconsRegular.x, color: cs.onSurfaceVariant),
                splashRadius: 22,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TastingCompactRow extends StatelessWidget {
  const TastingCompactRow({
    super.key,
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
      padding: EdgeInsets.symmetric(vertical: context.xs * 0.6),
      child: Row(
        children: [
          SizedBox(
            width: context.w * 0.22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: context.captionFont * 1.0,
                    fontWeight: FontWeight.w700,
                    color: cs.onSurface,
                  ),
                ),
                Text(
                  '$lowLabel · $highLabel',
                  style: TextStyle(
                    fontSize: context.captionFont * 0.7,
                    color: cs.outline,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        HapticFeedback.selectionClick();
                        onChanged(i == value ? null : i);
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: context.h * 0.034,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: i == value
                              ? cs.primary
                              : cs.surfaceContainer,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: i == value ? cs.onPrimary : cs.onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize: context.captionFont * 0.95,
                          ),
                        ),
                      ),
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

class TastingFinishRow extends StatelessWidget {
  const TastingFinishRow({required this.value, required this.onChanged});

  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.xs * 0.6),
      child: Row(
        children: [
          SizedBox(
            width: context.w * 0.22,
            child: Text(
              'Finish',
              style: TextStyle(
                fontSize: context.captionFont,
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
          ),
          for (var i = 1; i <= 3; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i == value ? null : i),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  height: context.h * 0.04,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == value
                        ? cs.primary.withValues(alpha: 0.18)
                        : cs.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: i == value ? cs.primary : Colors.transparent,
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    ['Short', 'Medium', 'Long'][i - 1],
                    style: TextStyle(
                      color: i == value ? cs.primary : cs.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: context.captionFont * 0.9,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TastingAromaSection extends StatelessWidget {
  const TastingAromaSection({
    required this.expanded,
    required this.selected,
    required this.onToggleExpand,
    required this.onToggleTag,
  });

  final bool expanded;
  final List<String> selected;
  final VoidCallback onToggleExpand;
  final ValueChanged<String> onToggleTag;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onToggleExpand,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Text(
                'Aromas',
                style: TextStyle(
                  fontSize: context.captionFont,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
              if (selected.isNotEmpty) ...[
                SizedBox(width: context.xs),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${selected.length}',
                    style: TextStyle(
                      fontSize: context.captionFont * 0.8,
                      fontWeight: FontWeight.w700,
                      color: cs.primary,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              Icon(
                expanded
                    ? PhosphorIconsRegular.caretUp
                    : PhosphorIconsRegular.caretDown,
                color: cs.outline,
                size: context.bodyFont,
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: EdgeInsets.only(top: context.xs),
            child: Wrap(
              spacing: context.xs * 1.1,
              runSpacing: context.xs * 1.1,
              children: [
                for (final tag in _aromaTags)
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onToggleTag(tag);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.w * 0.025,
                        vertical: 5,
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
                          fontSize: context.captionFont * 0.9,
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
          ),
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 220),
        ),
      ],
    );
  }
}

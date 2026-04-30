import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/utils/responsive.dart';
import '../../controller/wine.provider.dart';
import '../../domain/entities/canonical_grape.entity.dart';

/// Returned to the caller via [Navigator.pop]. Either a canonical grape
/// (id + name) or a free-text fallback the user typed.
class GrapePickerResult {
  const GrapePickerResult.canonical({required this.id, required this.name})
      : freetext = null;
  const GrapePickerResult.freetext(this.freetext)
      : id = null,
        name = null;

  final String? id;
  final String? name;
  final String? freetext;

  bool get isCanonical => id != null;
  String get display => isCanonical ? name! : freetext!;
}

Future<GrapePickerResult?> showGrapePickerSheet({
  required BuildContext context,
  String? initialCanonicalId,
  String? initialFreetext,
}) {
  return showModalBottomSheet<GrapePickerResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (ctx) => _GrapePickerSheet(
      initialCanonicalId: initialCanonicalId,
      initialFreetext: initialFreetext,
    ),
  );
}

class _GrapePickerSheet extends ConsumerStatefulWidget {
  const _GrapePickerSheet({
    this.initialCanonicalId,
    this.initialFreetext,
  });

  final String? initialCanonicalId;
  final String? initialFreetext;

  @override
  ConsumerState<_GrapePickerSheet> createState() => _GrapePickerSheetState();
}

class _GrapePickerSheetState extends ConsumerState<_GrapePickerSheet> {
  late final TextEditingController _controller;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialFreetext ?? '');
    _query = _controller.text;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectCanonical(CanonicalGrapeEntity grape) {
    Navigator.pop(
      context,
      GrapePickerResult.canonical(id: grape.id, name: grape.name),
    );
  }

  void _selectFreetext() {
    final trimmed = _controller.text.trim();
    if (trimmed.isEmpty) {
      Navigator.pop(context);
      return;
    }
    Navigator.pop(context, GrapePickerResult.freetext(trimmed));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final results = ref.watch(canonicalGrapesSearchProvider(_query));

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: context.h * 0.75),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.paddingH,
              vertical: context.m,
            ),
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
                  'Grape variety',
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: context.s),
                TextField(
                  controller: _controller,
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  onChanged: (v) => setState(() => _query = v),
                  onSubmitted: (_) => _selectFreetext(),
                  decoration: InputDecoration(
                    hintText: 'e.g. Pinot Noir',
                    prefixIcon: Icon(Icons.search, color: cs.outline),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            icon: Icon(Icons.close, color: cs.outline),
                            onPressed: () {
                              _controller.clear();
                              setState(() => _query = '');
                            },
                          ),
                    filled: true,
                    fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.03),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: context.m),
                Flexible(
                  child: results.when(
                    data: (list) => _ResultsList(
                      results: list,
                      query: _query.trim(),
                      selectedId: widget.initialCanonicalId,
                      onSelect: _selectCanonical,
                      onUseFreetext: _selectFreetext,
                    ),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (_, __) => _ErrorState(
                      onUseFreetext:
                          _query.trim().isEmpty ? null : _selectFreetext,
                    ),
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

class _ResultsList extends StatelessWidget {
  const _ResultsList({
    required this.results,
    required this.query,
    required this.selectedId,
    required this.onSelect,
    required this.onUseFreetext,
  });

  final List<CanonicalGrapeEntity> results;
  final String query;
  final String? selectedId;
  final ValueChanged<CanonicalGrapeEntity> onSelect;
  final VoidCallback onUseFreetext;

  bool get _showFreetextChip {
    if (query.isEmpty) return false;
    final q = query.toLowerCase();
    final exactMatch = results.any((g) => g.name.toLowerCase() == q);
    return !exactMatch;
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (results.isEmpty && query.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(context.l),
          child: Text(
            'No grapes available yet.',
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.outline,
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_showFreetextChip) ...[
          _FreetextChip(query: query, onTap: onUseFreetext),
          SizedBox(height: context.s),
          Divider(height: 1, color: cs.outlineVariant),
        ],
        Flexible(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (_, i) {
              final grape = results[i];
              final isSelected = grape.id == selectedId;
              return _GrapeTile(
                grape: grape,
                selected: isSelected,
                onTap: () => onSelect(grape),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FreetextChip extends StatelessWidget {
  const _FreetextChip({required this.query, required this.onTap});

  final String query;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.s,
          vertical: context.m,
        ),
        child: Row(
          children: [
            Icon(Icons.add_circle_outline, color: cs.primary),
            SizedBox(width: context.s),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    color: cs.onSurface,
                  ),
                  children: [
                    const TextSpan(text: 'Use "'),
                    TextSpan(
                      text: query,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const TextSpan(text: '" as custom'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GrapeTile extends StatelessWidget {
  const _GrapeTile({
    required this.grape,
    required this.selected,
    required this.onTap,
  });

  final CanonicalGrapeEntity grape;
  final bool selected;
  final VoidCallback onTap;

  Color _dotColor(GrapeColor color, ColorScheme cs) {
    switch (color) {
      case GrapeColor.red:
        return cs.primary;
      case GrapeColor.white:
        return cs.tertiary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.s,
          vertical: context.m,
        ),
        child: Row(
          children: [
            Container(
              width: context.w * 0.025,
              height: context.w * 0.025,
              decoration: BoxDecoration(
                color: _dotColor(grape.color, cs),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: context.s * 1.5),
            Expanded(
              child: Text(
                grape.name,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: cs.onSurface,
                ),
              ),
            ),
            if (selected)
              Icon(Icons.check, color: cs.primary, size: context.bodyFont * 1.2),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({this.onUseFreetext});

  final VoidCallback? onUseFreetext;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(context.l),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Couldn't load grape catalog.",
            style: TextStyle(
              fontSize: context.captionFont,
              color: cs.outline,
            ),
          ),
          if (onUseFreetext != null) ...[
            SizedBox(height: context.s),
            TextButton(
              onPressed: onUseFreetext,
              child: const Text('Use what I typed'),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/responsive.dart';
import '../../../wines/controller/wine.provider.dart';
import '../../../wines/domain/entities/wine.entity.dart';

Future<List<String>?> showWinePickerSheet({
  required BuildContext context,
  required Set<String> alreadyInLineup,
}) {
  return showModalBottomSheet<List<String>>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (ctx) => _Sheet(alreadyInLineup: alreadyInLineup),
  );
}

class _Sheet extends ConsumerStatefulWidget {
  final Set<String> alreadyInLineup;
  const _Sheet({required this.alreadyInLineup});

  @override
  ConsumerState<_Sheet> createState() => _SheetState();
}

class _SheetState extends ConsumerState<_Sheet> {
  final Set<String> _selected = {};

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final winesAsync = ref.watch(wineControllerProvider);
    final sheetHeight = MediaQuery.of(context).size.height * 0.7;

    return SafeArea(
      child: SizedBox(
        height: sheetHeight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: context.m),
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
              Text('Add wines to lineup',
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant)),
              SizedBox(height: context.m),
              Expanded(
                child: winesAsync.when(
                  data: (wines) {
                    final pickable = wines
                        .where((w) => !widget.alreadyInLineup.contains(w.id))
                        .toList();
                    if (pickable.isEmpty) {
                      return Center(
                        child: Text(
                          'All your wines are already in the lineup.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.onSurfaceVariant),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: pickable.length,
                      separatorBuilder: (_, __) => SizedBox(height: context.s),
                      itemBuilder: (_, i) => _WineRow(
                        wine: pickable[i],
                        selected: _selected.contains(pickable[i].id),
                        onToggle: () {
                          setState(() {
                            final id = pickable[i].id;
                            if (_selected.contains(id)) {
                              _selected.remove(id);
                            } else {
                              _selected.add(id);
                            }
                          });
                        },
                      ),
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text('Error: $e',
                        style: TextStyle(
                            fontSize: context.captionFont,
                            color: cs.error)),
                  ),
                ),
              ),
              SizedBox(height: context.s),
              SizedBox(
                width: double.infinity,
                height: context.h * 0.055,
                child: FilledButton(
                  onPressed: _selected.isEmpty
                      ? null
                      : () => Navigator.pop(context, _selected.toList()),
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                  child: Text(
                    _selected.isEmpty
                        ? 'Add wines'
                        : 'Add ${_selected.length} wine${_selected.length == 1 ? '' : 's'}',
                    style: TextStyle(
                        fontSize: context.bodyFont,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: context.s),
            ],
          ),
        ),
      ),
    );
  }
}

class _WineRow extends StatelessWidget {
  final WineEntity wine;
  final bool selected;
  final VoidCallback onToggle;

  const _WineRow({
    required this.wine,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final typeColor = switch (wine.type) {
      WineType.red => const Color(0xFFA84343),
      WineType.white => const Color(0xFFD4C49A),
      WineType.rose => const Color(0xFFD6889A),
    };
    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: EdgeInsets.all(context.w * 0.04),
        decoration: BoxDecoration(
          color: selected
              ? cs.primary.withValues(alpha: 0.12)
              : cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
          border: Border.all(
            color: selected ? cs.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: context.w * 0.025,
              height: context.w * 0.1,
              decoration: BoxDecoration(
                color: typeColor,
                borderRadius: BorderRadius.circular(context.w * 0.01),
              ),
            ),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wine.name.toUpperCase(),
                      style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: context.xs * 0.4),
                  Text(
                    [
                      if (wine.vintage != null) wine.vintage.toString(),
                      if (wine.country != null) wine.country,
                    ].join(' · '),
                    style: TextStyle(
                        fontSize: context.captionFont,
                        color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? cs.primary : cs.outline,
              size: context.w * 0.06,
            ),
          ],
        ),
      ),
    );
  }
}

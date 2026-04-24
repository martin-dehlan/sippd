import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/utils/responsive.dart';
import '../../../wines/controller/wine.provider.dart';
import '../../../wines/domain/entities/wine.entity.dart';
import '../../../wines/presentation/widgets/wine_card.widget.dart';

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
          padding: EdgeInsets.symmetric(
            horizontal: context.paddingH,
            vertical: context.m,
          ),
          child: Column(
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
                'Add wines to lineup',
                style: TextStyle(
                  fontSize: context.bodyFont * 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: context.s),
              Expanded(
                child: winesAsync.when(
                  data: (wines) {
                    if (wines.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: context.l),
                        child: Text(
                          'You have no wines yet.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.onSurfaceVariant),
                        ),
                      );
                    }
                    final sorted = List<WineEntity>.from(wines)
                      ..sort((a, b) {
                        final aIn =
                            widget.alreadyInLineup.contains(a.id) ? 1 : 0;
                        final bIn =
                            widget.alreadyInLineup.contains(b.id) ? 1 : 0;
                        if (aIn != bIn) return aIn - bIn;
                        return b.rating.compareTo(a.rating);
                      });
                    return ListView.separated(
                      itemCount: sorted.length,
                      separatorBuilder: (_, _) =>
                          SizedBox(height: context.xs),
                      itemBuilder: (_, i) {
                        final wine = sorted[i];
                        final inLineup =
                            widget.alreadyInLineup.contains(wine.id);
                        return _WinePickerRow(
                          wine: wine,
                          inLineup: inLineup,
                          selected: _selected.contains(wine.id),
                          onTap: inLineup
                              ? null
                              : () {
                                  setState(() {
                                    if (_selected.contains(wine.id)) {
                                      _selected.remove(wine.id);
                                    } else {
                                      _selected.add(wine.id);
                                    }
                                  });
                                },
                        );
                      },
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

class _WinePickerRow extends StatelessWidget {
  final WineEntity wine;
  final bool inLineup;
  final bool selected;
  final VoidCallback? onTap;

  const _WinePickerRow({
    required this.wine,
    required this.inLineup,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Opacity(
      opacity: inLineup ? 0.5 : 1,
      child: Material(
        color: selected
            ? cs.primary.withValues(alpha: 0.12)
            : cs.surfaceContainer,
        borderRadius: BorderRadius.circular(context.w * 0.03),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(context.w * 0.03),
              border: Border.all(
                color: selected ? cs.primary : Colors.transparent,
                width: 1,
              ),
            ),
            padding: EdgeInsets.only(right: context.w * 0.035),
            child: Row(
              children: [
                WineCardImage(wine: wine, compact: true),
                SizedBox(width: context.w * 0.01),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(wine.name,
                          style: TextStyle(
                              fontSize: context.bodyFont,
                              fontWeight: FontWeight.w700,
                              height: 1.2),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: context.xs * 0.5),
                      Row(
                        children: [
                          WineTypeDot(type: wine.type),
                          SizedBox(width: context.w * 0.015),
                          Flexible(
                            child: Text(
                              [
                                if (wine.vintage != null)
                                  wine.vintage.toString(),
                                if (wine.country != null) wine.country,
                              ].join(' · '),
                              style: TextStyle(
                                  fontSize: context.captionFont,
                                  color: cs.onSurfaceVariant),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.w * 0.02),
                if (inLineup)
                  _AddedChip()
                else
                  Icon(
                    selected ? Icons.check_circle : Icons.circle_outlined,
                    color: selected ? cs.primary : cs.outline,
                    size: context.w * 0.06,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddedChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.w * 0.025, vertical: context.xs),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.w * 0.02),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_rounded,
              size: context.w * 0.035, color: cs.onSurfaceVariant),
          SizedBox(width: context.xs),
          Text(
            'Added',
            style: TextStyle(
              fontSize: context.captionFont * 0.9,
              fontWeight: FontWeight.w600,
              color: cs.onSurfaceVariant,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

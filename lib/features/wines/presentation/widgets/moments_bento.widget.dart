import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../domain/entities/wine_memory.entity.dart';
import '../modules/moment_viewer/moment_viewer.screen.dart';

/// Content-driven moment mosaic. The pattern is picked from the moment
/// count (clamped 1..12), not from the wine id — so the layout
/// genuinely changes as the user adds moments. Each pattern fills the
/// container completely with that exact tile count: no placeholders,
/// no empty cells.
///
/// Pass an empty [memories] list to render a pure placeholder mosaic
/// (5 ghost tiles, the first one carrying the `+` CTA). Used by
/// wine_detail's empty state AND wine_add as the "add moment" hook.
///
/// When the user has more than 9 moments, the 9-tile pattern is used
/// and its last tile becomes a "+N" inline expand toggle that reveals
/// the rest in a grid below. Tap the trailing caret-up in the grid to
/// collapse.
class MomentsBento extends ConsumerStatefulWidget {
  // Capped at P9 (9 slots) so the section's aspect never exceeds 4:3
  // — keeps the wine-detail screen from being elbowed by memory tiles.
  static const _kMaxBentoSlots = 9;

  final List<WineMemoryEntity> memories;
  final String wineId;
  final VoidCallback onAdd;

  /// When true, real-tile taps open the moment viewer. Disabled in
  /// wine_add where there's no real wineId yet — callers that still
  /// want a per-tile action there pass [onMemoryTap] instead (e.g.
  /// "re-edit draft").
  final bool viewerEnabled;

  /// Optional per-tile tap handler. Takes priority over [viewerEnabled]
  /// — when set, a tile tap invokes `onMemoryTap(index)` instead of
  /// the viewer. Used by wine_add to re-open the draft in
  /// moment_capture for editing.
  final ValueChanged<int>? onMemoryTap;

  const MomentsBento({
    super.key,
    required this.memories,
    required this.wineId,
    required this.onAdd,
    this.viewerEnabled = true,
    this.onMemoryTap,
  });

  @override
  ConsumerState<MomentsBento> createState() => _MomentsBentoState();
}

class _MomentsBentoState extends ConsumerState<MomentsBento> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final memories = widget.memories;
    final wineId = widget.wineId;
    final gap = context.w * 0.015;

    final count = memories.length;
    final hasOverflow = count > MomentsBento._kMaxBentoSlots;
    // Slot count snaps to the smallest tier (5, 9, 12) that holds the
    // moments plus a small placeholder buffer, so the section always
    // reads as a clean mosaic without dangling empty cells.
    final layoutCount = hasOverflow
        ? MomentsBento._kMaxBentoSlots
        : _slotCountForCount(count);
    final realInBento = hasOverflow
        ? (_expanded
              ? MomentsBento._kMaxBentoSlots
              : MomentsBento._kMaxBentoSlots - 1)
        : count;
    final overflowStart = realInBento;
    final overflowCount = count - overflowStart;

    Widget tile(int index) => _BentoTile(
      memory: memories[index],
      onTap: widget.onMemoryTap != null
          ? () => widget.onMemoryTap!(index)
          : widget.viewerEnabled
          ? () => pushMomentViewer(
              context,
              wineId: wineId,
              moments: memories,
              initialIndex: index,
            )
          : widget.onAdd,
    );

    Widget slot(int index) {
      if (index < realInBento) return tile(index);
      // Overflow toggle on the very last slot when collapsed.
      if (hasOverflow &&
          !_expanded &&
          index == MomentsBento._kMaxBentoSlots - 1) {
        return _BentoOverflowTile(
          count: overflowCount,
          expanded: false,
          onTap: () => setState(() => _expanded = true),
        );
      }
      // Only the FIRST empty slot shows the "+" CTA — every other
      // placeholder renders as a silent ghost tile so the mosaic
      // doesn't nag the user with repeated plus icons. Tap-to-add
      // still works on every empty slot.
      final isFirstEmpty = index == realInBento;
      return _BentoPlaceholder(onTap: widget.onAdd, showPlus: isFirstEmpty);
    }

    final bento = _renderCountPattern(layoutCount, slot, gap, wineId);

    return Column(
      children: [
        bento,
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          alignment: Alignment.topCenter,
          child: (hasOverflow && _expanded)
              ? Padding(
                  padding: EdgeInsets.only(top: gap),
                  child: _ExpandedOverflowGrid(
                    memories: memories,
                    startIndex: overflowStart,
                    onTapMoment: widget.onMemoryTap != null
                        ? (index) => widget.onMemoryTap!(index)
                        : widget.viewerEnabled
                        ? (index) => pushMomentViewer(
                            context,
                            wineId: wineId,
                            moments: memories,
                            initialIndex: index,
                          )
                        : (_) => widget.onAdd(),
                    onCollapse: () => setState(() => _expanded = false),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}

/// Mosaic tile spec — explicit (row, col, rowSpan, colSpan) placement
/// on a grid. Used to compose chaos patterns out of mixed shapes
/// (hero 2×2 / 3×2, wide 2×1, tall 1×2, square 1×1) instead of a
/// uniform hero-plus-smalls layout. The first tile in a pattern is
/// always the hero (largest tile).
class _MTile {
  final int row;
  final int col;
  final int rowSpan;
  final int colSpan;
  const _MTile(this.row, this.col, this.rowSpan, this.colSpan);
}

/// Chaos mosaic — variable grid dimensions and tile shapes per
/// pattern. Cells stay roughly square because container aspect =
/// cols/rows; accent tiles (2×1 wide, 1×2 tall) deliberately break
/// the cell-by-cell rhythm of a plain grid. Hero is tile 0.
class _Mosaic {
  final int cols;
  final int rows;
  final List<_MTile> tiles;
  const _Mosaic({required this.cols, required this.rows, required this.tiles});
  int get slotCount => tiles.length;
}

// Twelve chaos variants. Mixed grids (3×3, 4×2, 5×2, 4×3) and tile
// shapes break the symmetrical hero-plus-ring look. Hero never sits
// dead centre. Wide and tall accents introduce two non-square
// rhythms so the pattern never reads as a tidy spreadsheet. The
// wine-id hash picks the variant so neighbouring wines look
// visibly different.

// --- 3-tile tier (exact-fill for count = 3) ---
const _kP3a = _Mosaic(
  cols: 4,
  rows: 3,
  tiles: [_MTile(0, 2, 3, 2), _MTile(0, 0, 2, 2), _MTile(2, 0, 1, 2)],
);
const _kP3b = _Mosaic(
  cols: 4,
  rows: 3,
  tiles: [_MTile(0, 2, 3, 2), _MTile(0, 0, 1, 2), _MTile(1, 0, 2, 2)],
);
const _kP3 = [_kP3a, _kP3b];

// --- 4-tile tier (exact-fill for count = 4) ---
const _kP4a = _Mosaic(
  cols: 4,
  rows: 3,
  tiles: [
    _MTile(0, 2, 3, 2),
    _MTile(0, 0, 2, 2),
    _MTile(2, 0, 1, 1),
    _MTile(2, 1, 1, 1),
  ],
);
const _kP4b = _Mosaic(
  cols: 4,
  rows: 3,
  tiles: [
    _MTile(0, 2, 3, 2),
    _MTile(0, 0, 1, 1),
    _MTile(0, 1, 1, 1),
    _MTile(1, 0, 2, 2),
  ],
);
const _kP4 = [_kP4a, _kP4b];

// --- 5-slot tier (0..2 moments + placeholders, or 5 exact) ---
const _kP5a = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(0, 2, 2, 3),
    _MTile(1, 0, 2, 2),
    _MTile(0, 0, 1, 2),
    _MTile(2, 2, 1, 2),
    _MTile(2, 4, 1, 1),
  ],
);
const _kP5b = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(1, 2, 2, 3),
    _MTile(0, 0, 2, 2),
    _MTile(0, 2, 1, 2),
    _MTile(0, 4, 1, 1),
    _MTile(2, 0, 1, 2),
  ],
);
const _kP5c = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(0, 2, 2, 3),
    _MTile(0, 0, 2, 2),
    _MTile(2, 0, 1, 2),
    _MTile(2, 2, 1, 1),
    _MTile(2, 3, 1, 2),
  ],
);
const _kP5d = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(1, 2, 2, 3),
    _MTile(1, 0, 2, 2),
    _MTile(0, 0, 1, 2),
    _MTile(0, 2, 1, 1),
    _MTile(0, 3, 1, 2),
  ],
);
const _kP5 = [_kP5a, _kP5b, _kP5c, _kP5d];

// --- 6-tile tier (exact-fill for count = 6) ---
const _kP6a = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(0, 2, 2, 3),
    _MTile(0, 0, 2, 2),
    _MTile(2, 0, 1, 2),
    _MTile(2, 2, 1, 1),
    _MTile(2, 3, 1, 1),
    _MTile(2, 4, 1, 1),
  ],
);
const _kP6b = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(1, 2, 2, 3),
    _MTile(1, 0, 2, 2),
    _MTile(0, 0, 1, 2),
    _MTile(0, 2, 1, 1),
    _MTile(0, 3, 1, 1),
    _MTile(0, 4, 1, 1),
  ],
);
const _kP6 = [_kP6a, _kP6b];

// --- 7-tile tier (exact-fill for count = 7) ---
const _kP7a = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(0, 2, 2, 3),
    _MTile(0, 0, 1, 2),
    _MTile(1, 0, 1, 1),
    _MTile(1, 1, 1, 1),
    _MTile(2, 0, 1, 2),
    _MTile(2, 2, 1, 2),
    _MTile(2, 4, 1, 1),
  ],
);
const _kP7 = [_kP7a];

// --- 8-tile tier (exact-fill for count = 8) ---
const _kP8a = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(0, 2, 2, 3),
    _MTile(0, 0, 1, 2),
    _MTile(1, 0, 1, 1),
    _MTile(1, 1, 1, 1),
    _MTile(2, 0, 1, 2),
    _MTile(2, 2, 1, 1),
    _MTile(2, 3, 1, 1),
    _MTile(2, 4, 1, 1),
  ],
);
const _kP8 = [_kP8a];

// --- 9-slot tier (5..8 real + +overflow) ---
const _kP9a = _Mosaic(
  cols: 4,
  rows: 3,
  tiles: [
    _MTile(0, 2, 2, 2),
    _MTile(0, 0, 1, 1),
    _MTile(0, 1, 1, 1),
    _MTile(1, 0, 1, 1),
    _MTile(1, 1, 1, 1),
    _MTile(2, 0, 1, 1),
    _MTile(2, 1, 1, 1),
    _MTile(2, 2, 1, 1),
    _MTile(2, 3, 1, 1),
  ],
);
const _kP9b = _Mosaic(
  cols: 4,
  rows: 3,
  tiles: [
    _MTile(1, 2, 2, 2),
    _MTile(0, 0, 1, 1),
    _MTile(0, 1, 1, 1),
    _MTile(0, 2, 1, 1),
    _MTile(0, 3, 1, 1),
    _MTile(1, 0, 1, 1),
    _MTile(1, 1, 1, 1),
    _MTile(2, 0, 1, 1),
    _MTile(2, 1, 1, 1),
  ],
);
const _kP9c = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(0, 2, 2, 3),
    _MTile(2, 0, 1, 2),
    _MTile(0, 0, 1, 1),
    _MTile(0, 1, 1, 1),
    _MTile(1, 0, 1, 1),
    _MTile(1, 1, 1, 1),
    _MTile(2, 2, 1, 1),
    _MTile(2, 3, 1, 1),
    _MTile(2, 4, 1, 1),
  ],
);
const _kP9d = _Mosaic(
  cols: 5,
  rows: 3,
  tiles: [
    _MTile(1, 2, 2, 3),
    _MTile(0, 0, 1, 2),
    _MTile(0, 2, 1, 1),
    _MTile(0, 3, 1, 1),
    _MTile(0, 4, 1, 1),
    _MTile(1, 0, 1, 1),
    _MTile(1, 1, 1, 1),
    _MTile(2, 0, 1, 1),
    _MTile(2, 1, 1, 1),
  ],
);
const _kP9 = [_kP9a, _kP9b, _kP9c, _kP9d];

_Mosaic _pickMosaic(int slotCount, String wineId) {
  final variants = switch (slotCount) {
    3 => _kP3,
    4 => _kP4,
    5 => _kP5,
    6 => _kP6,
    7 => _kP7,
    8 => _kP8,
    9 => _kP9,
    _ => _kP5,
  };
  if (variants.length == 1) return variants.first;
  // Hash the wine id to pick a stable variant so the same wine always
  // gets the same mosaic, but neighbours look different.
  final h = wineId.codeUnits.fold<int>(
    0,
    (acc, c) => (acc * 31 + c) & 0x7fffffff,
  );
  return variants[h % variants.length];
}

/// Maps real-moment counts to mosaic slot tiers:
/// 0..2 → 5 slots (placeholders fill the collage).
/// 3..8 → exact fill (no placeholders).
/// 9+ → 9 slots with overflow tile.
int _slotCountForCount(int count) {
  if (count <= 2) return 5;
  if (count <= 8) return count;
  return 9;
}

Widget _renderCountPattern(
  int count,
  Widget Function(int) slot,
  double gap,
  String wineId,
) {
  if (count <= 0) return const SizedBox.shrink();
  final pattern = _pickMosaic(count, wineId);

  return AspectRatio(
    aspectRatio: pattern.cols / pattern.rows,
    child: LayoutBuilder(
      builder: (_, c) {
        final cellW = c.maxWidth / pattern.cols;
        final cellH = c.maxHeight / pattern.rows;
        final half = gap / 2;
        final children = <Widget>[
          for (var i = 0; i < pattern.tiles.length; i++)
            Positioned(
              left: pattern.tiles[i].col * cellW + half,
              top: pattern.tiles[i].row * cellH + half,
              width: pattern.tiles[i].colSpan * cellW - gap,
              height: pattern.tiles[i].rowSpan * cellH - gap,
              child: slot(i),
            ),
        ];
        return Stack(children: children);
      },
    ),
  );
}

class _ExpandedOverflowGrid extends StatelessWidget {
  final List<WineMemoryEntity> memories;
  final int startIndex;
  final ValueChanged<int> onTapMoment;
  final VoidCallback onCollapse;

  const _ExpandedOverflowGrid({
    required this.memories,
    required this.startIndex,
    required this.onTapMoment,
    required this.onCollapse,
  });

  @override
  Widget build(BuildContext context) {
    final overflow = memories.sublist(startIndex);
    final gap = context.w * 0.015;
    final cs = Theme.of(context).colorScheme;
    final chunks = <List<WineMemoryEntity>>[];
    for (var i = 0; i < overflow.length; i += 8) {
      final end = (i + 8) > overflow.length ? overflow.length : i + 8;
      chunks.add(overflow.sublist(i, end));
    }

    Widget renderChunk(int chunkIdx) {
      final chunk = chunks[chunkIdx];
      if (chunk.length < 3) {
        return Row(
          children: [
            for (var c = 0; c < chunk.length; c++) ...[
              if (c != 0) SizedBox(width: gap),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _BentoTile(
                    memory: chunk[c],
                    onTap: () => onTapMoment(startIndex + chunkIdx * 8 + c),
                  ),
                ),
              ),
              if (chunk.length == 1)
                Expanded(flex: 3, child: const SizedBox.shrink()),
            ],
          ],
        );
      }
      return _renderCountPattern(
        chunk.length,
        (slotIndex) => _BentoTile(
          memory: chunk[slotIndex],
          onTap: () => onTapMoment(startIndex + chunkIdx * 8 + slotIndex),
        ),
        gap,
        '${memories.first.id}-$chunkIdx',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < chunks.length; i++) ...[
          if (i != 0) SizedBox(height: gap),
          renderChunk(i),
        ],
        SizedBox(height: gap),
        AspectRatio(
          aspectRatio: 6,
          child: GestureDetector(
            onTap: onCollapse,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: cs.surfaceContainer,
                borderRadius: BorderRadius.circular(context.w * 0.025),
                border: Border.all(color: cs.outlineVariant, width: 0.5),
              ),
              child: Center(
                child: Icon(
                  PhosphorIconsRegular.caretUp,
                  color: cs.onSurface.withValues(alpha: 0.85),
                  size: context.w * 0.05,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BentoTile extends StatelessWidget {
  final WineMemoryEntity memory;
  final VoidCallback onTap;
  const _BentoTile({required this.memory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.025),
        ),
        child: _thumb(memory, cs),
      ),
    );
  }

  Widget _thumb(WineMemoryEntity m, ColorScheme cs) {
    if (m.localImagePath != null) {
      return Image.file(File(m.localImagePath!), fit: BoxFit.cover);
    }
    if (m.imageUrl != null) {
      return Image.network(
        m.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            Icon(PhosphorIconsRegular.image, color: cs.outline),
      );
    }
    return Container(
      color: cs.surfaceContainer,
      alignment: Alignment.center,
      child: Icon(PhosphorIconsRegular.image, color: cs.outline),
    );
  }
}

class _BentoPlaceholder extends StatelessWidget {
  final VoidCallback onTap;
  final bool showPlus;
  const _BentoPlaceholder({required this.onTap, this.showPlus = true});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fill = showPlus ? cs.surfaceContainerHigh : cs.surfaceContainer;
    final borderAlpha = showPlus ? 0.9 : 0.55;
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: fill,
          borderRadius: BorderRadius.circular(context.w * 0.025),
          border: Border.all(
            color: cs.outlineVariant.withValues(alpha: borderAlpha),
            width: 0.8,
          ),
        ),
        child: showPlus
            ? Center(
                child: Icon(
                  PhosphorIconsRegular.plus,
                  color: cs.onSurface.withValues(alpha: 0.65),
                  size: context.w * 0.05,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class _BentoOverflowTile extends StatelessWidget {
  final int count;
  final bool expanded;
  final VoidCallback onTap;
  const _BentoOverflowTile({
    required this.count,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.025),
          border: Border.all(color: cs.outlineVariant, width: 0.5),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: expanded
                ? Icon(
                    PhosphorIconsRegular.caretUp,
                    key: const ValueKey('collapse'),
                    color: cs.onSurface.withValues(alpha: 0.85),
                    size: context.w * 0.06,
                  )
                : Text(
                    '+$count',
                    key: const ValueKey('overflow'),
                    style: TextStyle(
                      color: cs.onSurface.withValues(alpha: 0.85),
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

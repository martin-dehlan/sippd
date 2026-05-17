import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/utils/responsive.dart';
import '../../controller/wine.provider.dart';

class WineSearchBar extends ConsumerStatefulWidget {
  const WineSearchBar({super.key});

  @override
  ConsumerState<WineSearchBar> createState() => _WineSearchBarState();
}

class _WineSearchBarState extends ConsumerState<WineSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: ref.read(wineSearchQueryProvider));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.clear();
    ref.read(wineSearchQueryProvider.notifier).clear();
    ref.read(wineSearchBarVisibleProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surfaceContainer,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: TextField(
        controller: _controller,
        autofocus: true,
        cursorColor: cs.onSurface,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: context.bodyFont, color: cs.onSurface),
        onChanged: (q) =>
            ref.read(wineSearchQueryProvider.notifier).set(q),
        decoration: InputDecoration(
          hintText: 'Search your wines…',
          hintStyle: TextStyle(
            fontSize: context.bodyFont,
            color: cs.onSurfaceVariant,
          ),
          prefixIcon: Icon(
            PhosphorIconsRegular.magnifyingGlass,
            color: cs.onSurfaceVariant,
            size: context.w * 0.05,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              PhosphorIconsRegular.x,
              color: cs.onSurfaceVariant,
              size: context.w * 0.05,
            ),
            onPressed: _close,
            tooltip: 'Close search',
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.w * 0.03,
            vertical: context.s,
          ),
        ),
      ),
    );
  }
}

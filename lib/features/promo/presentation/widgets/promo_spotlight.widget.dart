import 'package:flutter/material.dart';

import '../../../../common/utils/responsive.dart';

/// An app-like screen whose individual widgets can "pop out" into focus.
///
/// Tapping a slot lifts a copy of that widget from its in-layout position,
/// scales it up to screen-centre with the rest of the screen dimmed, holds,
/// then glides it back into place. The whole effect lives inside this
/// widget's own [Stack] (no global Overlay), so it sits within the promo
/// recorder / screenshot boundary and exports cleanly.
class PromoScene extends StatefulWidget {
  const PromoScene({
    super.key,
    required this.title,
    required this.slots,
    this.focusScale = 1.4,
    this.hold = const Duration(milliseconds: 1400),
  });

  final String title;

  /// Each builder is rendered both inline and (when popped) as the
  /// focused copy, so keep them cheap and side-effect free.
  final List<WidgetBuilder> slots;

  /// Upper bound on how much a slot grows in focus; clamped down so it
  /// always fits the screen width.
  final double focusScale;

  /// How long the widget stays in focus before returning.
  final Duration hold;

  @override
  State<PromoScene> createState() => _PromoSceneState();
}

class _PromoSceneState extends State<PromoScene>
    with SingleTickerProviderStateMixin {
  final GlobalKey _stackKey = GlobalKey();
  late final List<GlobalKey> _slotKeys = List.generate(
    widget.slots.length,
    (_) => GlobalKey(),
  );

  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 520),
  );

  int? _active;
  Rect? _origin;
  Rect? _focus;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _pop(int index) async {
    if (_active != null) return;
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    final slotBox =
        _slotKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null || slotBox == null || !slotBox.hasSize) return;

    final topLeft = slotBox.localToGlobal(Offset.zero, ancestor: stackBox);
    final origin = topLeft & slotBox.size;
    final stackSize = stackBox.size;

    final maxWidth = stackSize.width * 0.92;
    final scale = (maxWidth / origin.width).clamp(1.0, widget.focusScale);
    final focusSize = Size(origin.width * scale, origin.height * scale);
    final focus = Rect.fromCenter(
      center: Offset(stackSize.width / 2, stackSize.height / 2),
      width: focusSize.width,
      height: focusSize.height,
    );

    setState(() {
      _active = index;
      _origin = origin;
      _focus = focus;
    });

    await _ctrl.forward(from: 0);
    await Future<void>.delayed(widget.hold);
    if (!mounted) return;
    await _ctrl.reverse();
    if (!mounted) return;
    setState(() {
      _active = null;
      _origin = null;
      _focus = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _stackKey,
      children: [
        Positioned.fill(child: _content(context)),
        if (_active != null)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (context, _) {
                final t = _ctrl.value;
                final dim = Curves.easeOut.transform(t.clamp(0.0, 1.0));
                final rect = Rect.lerp(
                  _origin,
                  _focus,
                  Curves.easeOutBack.transform(t),
                )!;
                return Stack(
                  children: [
                    Positioned.fill(
                      child: IgnorePointer(
                        child: ColoredBox(
                          color: Colors.black.withValues(alpha: 0.6 * dim),
                        ),
                      ),
                    ),
                    Positioned.fromRect(
                      rect: rect,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: SizedBox.fromSize(
                          size: _origin!.size,
                          child: Builder(builder: widget.slots[_active!]),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          context.w * 0.05,
          context.l,
          context.w * 0.05,
          context.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: context.titleFont,
                fontWeight: FontWeight.w800,
                color: cs.onSurface,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: context.l),
            for (var i = 0; i < widget.slots.length; i++) ...[
              if (i > 0) SizedBox(height: context.l),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _pop(i),
                child: KeyedSubtree(
                  key: _slotKeys[i],
                  child: Opacity(
                    opacity: _active == i ? 0 : 1,
                    child: Builder(builder: widget.slots[i]),
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

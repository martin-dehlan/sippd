import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/generated/app_localizations.dart';
import '../utils/price_format.dart';
import '../utils/responsive.dart';

/// Returns:
/// - `null`  → user dismissed without saving
/// - empty   → user cleared the price
/// - string  → parsed amount as "12.50"
Future<String?> showPriceInputSheet({
  required BuildContext context,
  double? initial,
  String currencySymbol = '€',
  String currencyCode = 'EUR',
  bool demoAutoFill = false,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) => _PriceInputSheet(
      initial: initial,
      currencySymbol: currencySymbol,
      currencyCode: currencyCode,
      demoAutoFill: demoAutoFill,
    ),
  );
}

class _PriceInputSheet extends StatefulWidget {
  final double? initial;
  final String currencySymbol;
  final String currencyCode;
  final bool demoAutoFill;
  const _PriceInputSheet({
    required this.initial,
    required this.currencySymbol,
    required this.currencyCode,
    this.demoAutoFill = false,
  });

  @override
  State<_PriceInputSheet> createState() => _PriceInputSheetState();
}

class _PriceInputSheetState extends State<_PriceInputSheet> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  static const List<int> _presets = [5, 10, 15, 20, 30, 50];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initial != null ? formatPrice(widget.initial!) : '',
    );
    // Collapse the cursor at end of text so iOS autofocus doesn't
    // paint a "select-all" rectangle behind the hint placeholder.
    _controller.selection = TextSelection.collapsed(
      offset: _controller.text.length,
    );
    _focusNode = FocusNode();
    _controller.addListener(_onChanged);
    if (widget.demoAutoFill) _runDemoFill();
  }

  /// Demo only: tap through a few preset chips so the price reads as being
  /// chosen, not typed (each pick highlights its chip). Not persisted — the
  /// tour closes without saving.
  Future<void> _runDemoFill() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    const picks = [15, 30, 50];
    for (final p in picks) {
      if (!mounted) return;
      _applyPreset(p);
      await Future<void>.delayed(const Duration(milliseconds: 900));
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged() => setState(() {});

  double? get _parsed {
    final raw = _controller.text.trim().replaceAll(',', '.');
    if (raw.isEmpty) return null;
    return double.tryParse(raw);
  }

  bool get _hasValue => _controller.text.trim().isNotEmpty;

  void _applyPreset(int value) {
    _controller.text = value.toString();
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  void _save() {
    FocusManager.instance.primaryFocus?.unfocus();
    final v = _parsed;
    Navigator.pop(context, v == null ? '' : v.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final canSave = _parsed != null || !_hasValue;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        top: false,
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
              SizedBox(height: context.l),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.commonPriceSheetTitle,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: context.w * 0.015),
                  Text(
                    widget.currencyCode,
                    style: TextStyle(
                      fontSize: context.captionFont,
                      fontWeight: FontWeight.w500,
                      color: cs.outline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.l),
              _AmountDisplay(
                controller: _controller,
                focusNode: _focusNode,
                symbol: widget.currencySymbol,
                hasValue: _hasValue,
              ),
              SizedBox(height: context.l),
              Wrap(
                spacing: context.w * 0.02,
                runSpacing: context.s,
                alignment: WrapAlignment.center,
                children: [
                  for (final p in _presets)
                    _PresetChip(
                      label: '${widget.currencySymbol}$p',
                      selected: _parsed != null && _parsed == p.toDouble(),
                      onTap: () => _applyPreset(p),
                    ),
                ],
              ),
              SizedBox(height: context.xl),
              SizedBox(
                width: double.infinity,
                height: context.h * 0.06,
                child: FilledButton(
                  onPressed: canSave ? _save : null,
                  style: FilledButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.w * 0.03),
                    ),
                  ),
                  child: Text(
                    l10n.commonSave,
                    style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w600,
                    ),
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

class _AmountDisplay extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String symbol;
  final bool hasValue;

  const _AmountDisplay({
    required this.controller,
    required this.focusNode,
    required this.symbol,
    required this.hasValue,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final amountSize = context.displayFont;

    // Selection rendering disabled — keeps an autofocused empty field
    // from painting iOS's grey "select-all" rectangle behind the hint.
    // Cursor still shows because it's separately controlled.
    final textField = TextSelectionTheme(
      data: const TextSelectionThemeData(
        selectionColor: Colors.transparent,
        selectionHandleColor: Colors.transparent,
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        textAlign: TextAlign.left,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        cursorColor: cs.primary,
        cursorWidth: 1.5,
        cursorRadius: const Radius.circular(1),
        enableInteractiveSelection: false,
        inputFormatters: [
          LengthLimitingTextInputFormatter(8),
          _DecimalInputFormatter(),
        ],
        style: TextStyle(
          fontSize: amountSize,
          fontWeight: FontWeight.bold,
          height: 1,
          letterSpacing: -1,
          color: cs.onSurface,
          fontFeatures: tabularFigures,
        ),
        decoration: InputDecoration(
          isCollapsed: true,
          hintText: '0',
          hintStyle: TextStyle(
            fontSize: amountSize,
            fontWeight: FontWeight.bold,
            height: 1,
            letterSpacing: -1,
            color: cs.outline.withValues(alpha: 0.45),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );

    return GestureDetector(
      onTap: () => focusNode.requestFocus(),
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            symbol,
            style: TextStyle(
              fontSize: amountSize * 0.5,
              fontWeight: FontWeight.w500,
              color: hasValue ? cs.onSurfaceVariant : cs.outline,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(width: context.w * 0.02),
          IntrinsicWidth(child: textField),
        ],
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PresetChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: selected
          ? cs.primary.withValues(alpha: 0.12)
          : cs.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.w * 0.06),
        side: BorderSide(
          color: selected ? cs.primary : cs.outlineVariant,
          width: selected ? 1.4 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.w * 0.06),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.045,
            vertical: context.s * 1.2,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: context.bodyFont,
              fontWeight: FontWeight.w600,
              color: selected ? cs.primary : cs.onSurface,
              letterSpacing: -0.2,
            ),
          ),
        ),
      ),
    );
  }
}

/// Allows digits + single `.` or `,` separator, max 2 decimals.
class _DecimalInputFormatter extends TextInputFormatter {
  static final _regex = RegExp(r'^\d*([.,]\d{0,2})?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    if (!_regex.hasMatch(text)) return oldValue;
    return newValue;
  }
}

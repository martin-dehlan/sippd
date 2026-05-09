import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/responsive.dart';

Future<String?> showTextInputSheet({
  required BuildContext context,
  required String title,
  String? initial,
  String? hint,
  String? prefix,
  TextInputType keyboardType = TextInputType.text,
  int maxLines = 1,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
}) async {
  final controller = TextEditingController(text: initial);
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
      return Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ctx.paddingH,
              vertical: ctx.m,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: ctx.w * 0.1,
                    height: 4,
                    decoration: BoxDecoration(
                      color: cs.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: ctx.m),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: ctx.s),
                TextField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  maxLength: maxLength,
                  inputFormatters: [
                    if (maxLength != null)
                      LengthLimitingTextInputFormatter(maxLength),
                    if (inputFormatters != null) ...inputFormatters,
                  ],
                  cursorColor: cs.primary,
                  cursorWidth: 1.5,
                  style: TextStyle(
                    fontSize: maxLines > 1 ? ctx.bodyFont : ctx.titleFont * 1.1,
                    fontWeight: maxLines > 1
                        ? FontWeight.w500
                        : FontWeight.bold,
                    height: maxLines > 1 ? 1.5 : 1.1,
                    color: cs.onSurface,
                    letterSpacing: maxLines > 1 ? 0 : -0.5,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: cs.outline,
                      fontSize: maxLines > 1
                          ? ctx.bodyFont
                          : ctx.titleFont * 1.1,
                      fontWeight: maxLines > 1
                          ? FontWeight.w400
                          : FontWeight.bold,
                      letterSpacing: maxLines > 1 ? 0 : -0.5,
                    ),
                    counterText: maxLines > 1 ? null : '',
                    prefixText: prefix,
                    prefixStyle: TextStyle(
                      fontSize: ctx.titleFont * 1.1,
                      fontWeight: FontWeight.bold,
                      color: cs.onSurfaceVariant,
                      letterSpacing: -0.5,
                    ),
                    filled: false,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onSubmitted: (v) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Navigator.pop(ctx, v.trim());
                  },
                ),
                SizedBox(height: ctx.s),
                Container(height: 1, color: cs.outlineVariant),
                SizedBox(height: ctx.l),
                SizedBox(
                  width: double.infinity,
                  height: ctx.h * 0.055,
                  child: FilledButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(ctx, controller.text.trim());
                    },
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ctx.w * 0.03),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: ctx.bodyFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ctx.s),
              ],
            ),
          ),
        ),
      );
    },
  );
}

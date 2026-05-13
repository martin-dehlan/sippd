import 'package:flutter/material.dart';
import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/location.entity.dart';
import 'location_search.widget.dart';

Future<LocationEntity?> showLocationSearchSheet({
  required BuildContext context,
  LocationEntity? initial,
}) {
  return showModalBottomSheet<LocationEntity>(
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
                  AppLocalizations.of(ctx).locSheetTitle,
                  style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: ctx.s),
                LocationSearchWidget(
                  initialValue: initial?.shortDisplay,
                  onLocationSelected: (loc) => Navigator.pop(ctx, loc),
                ),
                SizedBox(height: ctx.l),
              ],
            ),
          ),
        ),
      );
    },
  );
}

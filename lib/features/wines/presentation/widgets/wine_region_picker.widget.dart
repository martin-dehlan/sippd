import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/data/wine_regions.dart';
import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/utils/responsive.dart';
import '../../../../common/widgets/text_input_sheet.dart';

void showWineRegionPicker({
  required BuildContext context,
  required String country,
  required String? selected,
  required ValueChanged<String?> onChanged,
}) {
  final regions = regionsFor(country);
  final cs = Theme.of(context).colorScheme;
  final l10n = AppLocalizations.of(context);
  final searchController = TextEditingController();
  var filter = '';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: cs.surface,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.w * 0.05),
      ),
    ),
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setModalState) {
        final filtered = regions
            .where((r) => r.toLowerCase().contains(filter.toLowerCase()))
            .toList();

        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          maxChildSize: 0.95,
          minChildSize: 0.4,
          expand: false,
          builder: (_, scrollController) => Column(
            children: [
              SizedBox(height: context.m),
              Container(
                width: context.w * 0.1,
                height: 4,
                decoration: BoxDecoration(
                  color: cs.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.paddingH,
                  context.m,
                  context.paddingH,
                  context.s,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.winesRegionSheetTitle,
                            style: TextStyle(
                              fontSize: context.headingFont,
                              fontWeight: FontWeight.w800,
                              color: cs.onSurface,
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: context.xs),
                          Text(
                            l10n.winesRegionSheetSubtitle(country),
                            style: TextStyle(
                              fontSize: context.captionFont,
                              color: cs.onSurfaceVariant,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: context.s),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: TextButton.styleFrom(
                        foregroundColor: cs.onSurfaceVariant,
                        padding: EdgeInsets.symmetric(
                          horizontal: context.s,
                          vertical: context.xs,
                        ),
                      ),
                      child: Text(
                        l10n.winesRegionSheetSkip,
                        style: TextStyle(
                          fontSize: context.bodyFont,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (regions.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    context.paddingH,
                    0,
                    context.paddingH,
                    context.s,
                  ),
                  child: TextField(
                    controller: searchController,
                    autofocus: false,
                    maxLength: 100,
                    inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    style: TextStyle(fontSize: context.bodyFont),
                    decoration: InputDecoration(
                      hintText: l10n.winesRegionSheetSearchHint,
                      counterText: '',
                      prefixIcon: Icon(
                        PhosphorIconsRegular.magnifyingGlass,
                        color: cs.primary,
                      ),
                      isDense: true,
                    ),
                    onChanged: (v) => setModalState(() => filter = v),
                  ),
                ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    if (selected != null)
                      _RegionTile(
                        region: l10n.winesRegionSheetClear,
                        leading: PhosphorIconsRegular.x,
                        muted: true,
                        isSelected: false,
                        onTap: () {
                          onChanged(null);
                          Navigator.pop(ctx);
                        },
                      ),
                    ...filtered.map(
                      (r) => _RegionTile(
                        region: r,
                        isSelected: r == selected,
                        onTap: () {
                          onChanged(r);
                          Navigator.pop(ctx);
                        },
                      ),
                    ),
                    if (regions.isNotEmpty) ...[
                      SizedBox(height: context.s),
                      const Divider(height: 1),
                    ],
                    _RegionTile(
                      region: l10n.winesRegionSheetOther,
                      leading: PhosphorIconsRegular.pencilSimple,
                      muted: true,
                      isSelected: false,
                      onTap: () async {
                        final result = await showTextInputSheet(
                          context: ctx,
                          title: l10n.winesRegionSheetOtherTitle,
                          initial: selected,
                          hint: l10n.winesRegionSheetOtherHint,
                          maxLength: 80,
                        );
                        if (result == null) return;
                        final trimmed = result.trim();
                        onChanged(trimmed.isEmpty ? null : trimmed);
                        if (ctx.mounted) Navigator.pop(ctx);
                      },
                    ),
                    SizedBox(height: context.l),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

class _RegionTile extends StatelessWidget {
  final String region;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? leading;
  final bool muted;

  const _RegionTile({
    required this.region,
    required this.isSelected,
    required this.onTap,
    this.leading,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = muted
        ? cs.onSurfaceVariant
        : (isSelected ? cs.primary : cs.onSurface);

    return ListTile(
      dense: true,
      leading: leading != null
          ? Icon(leading, color: color, size: context.w * 0.05)
          : null,
      title: Text(
        region,
        style: TextStyle(
          fontSize: context.bodyFont,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          color: color,
        ),
      ),
      trailing: isSelected
          ? Icon(
              PhosphorIconsRegular.checkCircle,
              color: cs.primary,
              size: context.w * 0.05,
            )
          : null,
      onTap: onTap,
    );
  }
}

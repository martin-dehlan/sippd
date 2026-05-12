import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/l10n/generated/app_localizations.dart';
import '../../../../common/services/locale/locale.provider.dart';
import '../../../../common/utils/responsive.dart';

const _nativeLanguageNames = <String, String>{
  'en': 'English',
  'de': 'Deutsch',
  'es': 'Español',
  'it': 'Italiano',
  'fr': 'Français',
};

Future<void> showLanguagePickerSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (_) => const _LanguagePickerSheet(),
  );
}

class _LanguagePickerSheet extends ConsumerWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final selected = ref.watch(appLocaleControllerProvider);
    final controller = ref.read(appLocaleControllerProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.paddingH,
          vertical: context.m,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.languageSheetTitle,
              style: TextStyle(
                fontSize: context.bodyFont,
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: context.m),
            _OptionTile(
              label: l10n.languageOptionSystem,
              isSelected: selected == null,
              onTap: () async {
                await controller.setLocale(null);
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
            for (final locale in supportedAppLocales)
              _OptionTile(
                label:
                    _nativeLanguageNames[locale.languageCode] ??
                    locale.languageCode,
                isSelected: selected?.languageCode == locale.languageCode,
                onTap: () async {
                  await controller.setLocale(locale);
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: context.m,
          horizontal: context.w * 0.04,
        ),
        margin: EdgeInsets.only(bottom: context.xs),
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(context.w * 0.03),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: context.bodyFont,
                  fontWeight: FontWeight.w500,
                  color: cs.onSurface,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                PhosphorIconsRegular.check,
                size: context.w * 0.05,
                color: cs.primary,
              ),
          ],
        ),
      ),
    );
  }
}

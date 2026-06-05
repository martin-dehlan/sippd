import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/routes/app.routes.dart';

Future<void> startCompareFlow(
  BuildContext context, {
  required String sourceWineId,
}) async {
  final picked = await context.push<String?>(
    AppRoutes.wineComparePickerPath(sourceWineId),
  );
  if (picked == null || picked.isEmpty) return;
  if (!context.mounted) return;
  context.push(AppRoutes.wineComparePath(sourceWineId, picked));
}

/// Two-step compare entry used by the wine-list header icon: pick the first
/// wine (no exclusion), then hand off to [startCompareFlow] to pick the second.
Future<void> startCompareSelection(BuildContext context) async {
  final first = await context.push<String?>(
    '${AppRoutes.wineComparePicker}?first=1',
  );
  if (first == null || first.isEmpty) return;
  if (!context.mounted) return;
  await startCompareFlow(context, sourceWineId: first);
}

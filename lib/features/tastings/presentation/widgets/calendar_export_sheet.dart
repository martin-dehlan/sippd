import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/utils/responsive.dart';
import '../../domain/entities/tasting.entity.dart';

Future<void> showCalendarExportSheet({
  required BuildContext context,
  required TastingEntity tasting,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(context.w * 0.05)),
    ),
    builder: (ctx) => _Sheet(tasting: tasting),
  );
}

class _Sheet extends StatelessWidget {
  final TastingEntity tasting;
  const _Sheet({required this.tasting});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.paddingH, vertical: context.m),
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
            SizedBox(height: context.m),
            Text('Add to calendar',
                style: TextStyle(
                    fontSize: context.bodyFont,
                    fontWeight: FontWeight.w600,
                    color: cs.onSurfaceVariant)),
            SizedBox(height: context.m),
            _Option(
              icon: Icons.event,
              label: 'Google Calendar',
              onTap: () => _openGoogleCalendar(context, tasting),
            ),
            _Option(
              icon: Icons.file_download_outlined,
              label: 'iCal / Apple Calendar',
              onTap: () => _shareIcs(context, tasting),
            ),
            SizedBox(height: context.s),
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _Option({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.w * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.w * 0.02, vertical: context.m),
        child: Row(
          children: [
            Icon(icon, color: cs.primary, size: context.w * 0.05),
            SizedBox(width: context.w * 0.04),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                      fontSize: context.bodyFont,
                      fontWeight: FontWeight.w500)),
            ),
            Icon(Icons.arrow_forward_ios,
                size: context.w * 0.035, color: cs.outline),
          ],
        ),
      ),
    );
  }
}

Future<void> _openGoogleCalendar(
    BuildContext context, TastingEntity t) async {
  final start = _formatGcalDate(t.scheduledAt);
  final end = _formatGcalDate(t.scheduledAt.add(const Duration(hours: 2)));
  final uri = Uri.https('calendar.google.com', '/calendar/render', {
    'action': 'TEMPLATE',
    'text': t.title,
    'dates': '$start/$end',
    if (t.description != null && t.description!.isNotEmpty)
      'details': t.description!,
    if (t.location != null && t.location!.isNotEmpty)
      'location': t.location!,
  });
  if (context.mounted) Navigator.pop(context);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> _shareIcs(BuildContext context, TastingEntity t) async {
  final ics = _buildIcs(t);
  final dir = await getTemporaryDirectory();
  final safeTitle =
      t.title.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');
  final file = File('${dir.path}/$safeTitle.ics');
  await file.writeAsString(ics);
  if (context.mounted) Navigator.pop(context);
  await Share.shareXFiles(
    [XFile(file.path, mimeType: 'text/calendar')],
    subject: t.title,
  );
}

String _formatGcalDate(DateTime dt) {
  final u = dt.toUtc();
  String pad(int n) => n.toString().padLeft(2, '0');
  return '${u.year}${pad(u.month)}${pad(u.day)}'
      'T${pad(u.hour)}${pad(u.minute)}${pad(u.second)}Z';
}

String _buildIcs(TastingEntity t) {
  final end = t.scheduledAt.add(const Duration(hours: 2));
  final dtStamp = _formatGcalDate(DateTime.now());
  final dtStart = _formatGcalDate(t.scheduledAt);
  final dtEnd = _formatGcalDate(end);

  String escape(String s) => s
      .replaceAll('\\', '\\\\')
      .replaceAll(',', '\\,')
      .replaceAll(';', '\\;')
      .replaceAll('\n', '\\n');

  final lines = [
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//Sippd//Tasting//EN',
    'BEGIN:VEVENT',
    'UID:${t.id}@sippd.app',
    'DTSTAMP:$dtStamp',
    'DTSTART:$dtStart',
    'DTEND:$dtEnd',
    'SUMMARY:${escape(t.title)}',
    if (t.description != null && t.description!.isNotEmpty)
      'DESCRIPTION:${escape(t.description!)}',
    if (t.location != null && t.location!.isNotEmpty)
      'LOCATION:${escape(t.location!)}',
    if (t.latitude != null && t.longitude != null)
      'GEO:${t.latitude};${t.longitude}',
    'END:VEVENT',
    'END:VCALENDAR',
  ];
  return lines.join('\r\n');
}

import 'package:add_2_calendar/add_2_calendar.dart' as a2c;
import 'package:flutter/material.dart';
import '../../domain/entities/tasting.entity.dart';

Future<void> addTastingToCalendar({
  required BuildContext context,
  required TastingEntity tasting,
}) async {
  final event = a2c.Event(
    title: tasting.title,
    description: tasting.description ?? '',
    location: tasting.location ?? '',
    startDate: tasting.scheduledAt,
    endDate: tasting.scheduledAt.add(const Duration(hours: 2)),
  );
  final ok = await a2c.Add2Calendar.addEvent2Cal(event);
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not open calendar')),
    );
  }
}

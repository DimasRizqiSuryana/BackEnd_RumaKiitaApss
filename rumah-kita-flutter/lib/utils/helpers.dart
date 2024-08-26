import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Assets
class Assets {
  static String image([String asset = '']) {
    return 'assets/images/$asset';
  }
}

/// showDateAndTimePicker
///
/// Composite of showDatePicker and showTimePicker
Future<DateTime?> showDateAndTimePicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  DateTime? datetime;
  TimeOfDay? time;

  datetime = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate ?? DateTime(initialDate.year),
    lastDate: lastDate ??
        DateTime(
          initialDate.add(const Duration(days: 365 * 5)).year,
        ),
  );

  if (datetime != null && context.mounted) {
    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
  }

  if (datetime != null && time != null) {
    return DateTime(
      datetime.year,
      datetime.month,
      datetime.day,
      time.hour,
      time.minute,
    );
  }

  return null;
}

String formatedDateTime(DateTime date) {
  return "${DateFormat.EEEE().format(date)}, ${DateFormat.yMd().format(date)} ${DateFormat.Hm().format(date)}";
}

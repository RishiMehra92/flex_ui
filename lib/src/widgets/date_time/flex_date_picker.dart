import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// Shows a date picker styled with Flex UI theme colors.
Future<DateTime?> showFlexDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
}) {
  final theme = FlexUITheme.of(context);
  final colors = theme.colors;

  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? DateTime(2100),
    initialDatePickerMode: initialDatePickerMode,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme(
            brightness: theme.brightness,
            primary: colors.primary,
            onPrimary: Colors.white,
            secondary: colors.secondary,
            onSecondary: Colors.white,
            error: colors.error,
            onError: Colors.white,
            surface: colors.surface,
            onSurface: colors.textPrimary,
          ),
        ),
        child: child!,
      );
    },
  );
}

/// An inline calendar date picker widget.
class FlexDatePicker extends StatelessWidget {
  const FlexDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
    this.firstDate,
    this.lastDate,
  });

  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
      onDateChanged: onDateChanged,
    );
  }
}

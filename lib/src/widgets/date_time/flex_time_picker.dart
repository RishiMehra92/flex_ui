import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../inputs/flex_input_field.dart';

/// Shows a time picker styled with Flex UI theme colors.
Future<TimeOfDay?> showFlexTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) {
  final theme = FlexUITheme.of(context);
  final colors = theme.colors;

  return showTimePicker(
    context: context,
    initialTime: initialTime,
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

/// A time selection input field that triggers a time picker dialog on tap.
class FlexTimePickerField extends StatefulWidget {
  const FlexTimePickerField({
    super.key,
    this.selectedTime,
    this.onTimeSelected,
    this.label = 'Time',
    this.hintText = 'Select time',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.validator,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.semanticLabel,
  });

  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay>? onTimeSelected;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool isRequired;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final String? semanticLabel;

  @override
  State<FlexTimePickerField> createState() => _FlexTimePickerFieldState();
}

class _FlexTimePickerFieldState extends State<FlexTimePickerField> {
  late TextEditingController _controller;
  TimeOfDay? _time;

  @override
  void initState() {
    super.initState();
    _time = widget.selectedTime;
    _controller = TextEditingController(text: _formatTime(_time));
  }

  @override
  void didUpdateWidget(FlexTimePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedTime != oldWidget.selectedTime) {
      _time = widget.selectedTime;
      _controller.text = _formatTime(_time);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Future<void> _pickTime() async {
    if (!widget.enabled) return;

    final picked = await showFlexTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _time = picked;
        _controller.text = _formatTime(picked);
      });
      widget.onTimeSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlexInputField(
      controller: _controller,
      label: widget.label,
      hintText: widget.hintText,
      helperText: widget.helperText,
      errorText: widget.errorText,
      isRequired: widget.isRequired,
      enabled: widget.enabled,
      readOnly: true,
      onTap: _pickTime,
      prefixIcon: Icons.access_time_outlined,
      suffixIcon: Icons.arrow_drop_down_rounded,
      fillColor: widget.fillColor,
      borderColor: widget.borderColor,
      borderRadius: widget.borderRadius,
      width: widget.width,
      semanticLabel: widget.semanticLabel,
      validator: (val) {
        if (widget.isRequired && (val == null || val.isEmpty)) {
          return 'Please select a time';
        }
        return widget.validator?.call(val);
      },
    );
  }
}

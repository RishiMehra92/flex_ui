import 'package:flutter/material.dart';
import 'flex_input_field.dart';

/// A date selection input field that triggers a date picker on tap.
class FlexDateField extends StatefulWidget {
  const FlexDateField({
    super.key,
    this.selectedDate,
    this.onDateSelected,
    this.label = 'Date',
    this.hintText = 'Select date',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.firstDate,
    this.lastDate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.validator,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.semanticLabel,
    this.gradient,
    this.gradientBorder,
    this.borderGradient,
    this.focusedGradientBorder,
    this.errorGradientBorder,
    this.borderWidth,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool isRequired;
  final bool enabled;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DatePickerMode initialDatePickerMode;
  final FormFieldValidator<String>? validator;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final String? semanticLabel;
  final Gradient? gradient;
  final Gradient? gradientBorder;
  final Gradient? borderGradient;
  final Gradient? focusedGradientBorder;
  final Gradient? errorGradientBorder;
  final double? borderWidth;

  @override
  State<FlexDateField> createState() => _FlexDateFieldState();
}

class _FlexDateFieldState extends State<FlexDateField> {
  late TextEditingController _controller;
  DateTime? _date;

  @override
  void initState() {
    super.initState();
    _date = widget.selectedDate;
    _controller = TextEditingController(
      text: _formatDate(_date),
    );
  }

  @override
  void didUpdateWidget(FlexDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _date = widget.selectedDate;
      _controller.text = _formatDate(_date);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '';
    final year = dt.year.toString().padLeft(4, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final day = dt.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<void> _pickDate() async {
    if (!widget.enabled) return;

    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      initialDatePickerMode: widget.initialDatePickerMode,
    );

    if (picked != null) {
      setState(() {
        _date = picked;
        _controller.text = _formatDate(picked);
      });
      widget.onDateSelected?.call(picked);
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
      onTap: _pickDate,
      prefixIcon: Icons.calendar_today_outlined,
      suffixIcon: Icons.arrow_drop_down_rounded,
      fillColor: widget.fillColor,
      borderColor: widget.borderColor,
      borderRadius: widget.borderRadius,
      borderWidth: widget.borderWidth,
      gradient: widget.gradient,
      gradientBorder: widget.gradientBorder ?? widget.borderGradient,
      focusedGradientBorder: widget.focusedGradientBorder,
      errorGradientBorder: widget.errorGradientBorder,
      width: widget.width,
      semanticLabel: widget.semanticLabel,
      validator: (val) {
        if (widget.isRequired && (val == null || val.isEmpty)) {
          return 'Please select a date';
        }
        return widget.validator?.call(val);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/validators.dart';
import 'flex_input_field.dart';

/// A numeric input field preconfigured with number keyboard,
/// numeric validation, and integer/decimal formatters.
class FlexNumberField extends StatelessWidget {
  const FlexNumberField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.label,
    this.hintText = '0',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.allowDecimals = true,
    this.allowNegative = false,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.semanticLabel,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool isRequired;
  final bool enabled;
  final bool readOnly;
  final bool allowDecimals;
  final bool allowNegative;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return FlexInputField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      label: label,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      isRequired: isRequired,
      enabled: enabled,
      readOnly: readOnly,
      prefixIcon: prefixIcon,
      prefixWidget: prefixWidget,
      suffixWidget: suffixWidget,
      keyboardType: TextInputType.numberWithOptions(
        decimal: allowDecimals,
        signed: allowNegative,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(allowDecimals
              ? (allowNegative ? r'^-?[0-9]*\.?[0-9]*' : r'^[0-9]*\.?[0-9]*')
              : (allowNegative ? r'^-?[0-9]*' : r'^[0-9]*')),
        ),
      ],
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      width: width,
      semanticLabel: semanticLabel,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Please enter a number';
        }
        if (value != null && value.trim().isNotEmpty) {
          final numErr = FlexValidators.number()(value);
          if (numErr != null) return numErr;
        }
        return validator?.call(value);
      },
    );
  }
}

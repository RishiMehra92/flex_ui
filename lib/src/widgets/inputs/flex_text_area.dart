import 'package:flutter/material.dart';
import 'flex_input_field.dart';

/// A multi-line text area input field with line constraints and character counts.
class FlexTextArea extends StatelessWidget {
  const FlexTextArea({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.label,
    this.hintText = 'Enter details...',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.minLines = 4,
    this.maxLines = 8,
    this.maxLength,
    this.validator,
    this.onChanged,
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
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
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
      minLines: minLines,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      gradient: gradient,
      gradientBorder: gradientBorder ?? borderGradient,
      focusedGradientBorder: focusedGradientBorder,
      errorGradientBorder: errorGradientBorder,
      width: width,
      semanticLabel: semanticLabel,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

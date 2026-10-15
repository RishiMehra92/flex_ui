import 'package:flutter/material.dart';
import '../../utils/validators.dart';
import 'flex_input_field.dart';

/// An email input field preconfigured with email keyboard, format validation,
/// and leading mail icon.
class FlexEmailField extends StatelessWidget {
  const FlexEmailField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.label = 'Email',
    this.hintText = 'name@example.com',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon = Icons.email_outlined,
    this.prefixWidget,
    this.suffixWidget,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.gradient,
    this.gradientBorder,
    this.focusedGradientBorder,
    this.errorGradientBorder,
    this.width,
    this.semanticLabel,
    this.autovalidateMode,
    this.onSaved,
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
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? borderWidth;
  final Gradient? gradient;
  final Gradient? gradientBorder;
  final Gradient? focusedGradientBorder;
  final Gradient? errorGradientBorder;
  final double? width;
  final String? semanticLabel;
  final AutovalidateMode? autovalidateMode;
  final FormFieldSetter<String>? onSaved;

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
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      gradient: gradient,
      gradientBorder: gradientBorder,
      focusedGradientBorder: focusedGradientBorder,
      errorGradientBorder: errorGradientBorder,
      width: width,
      semanticLabel: semanticLabel,
      autovalidateMode: autovalidateMode,
      onSaved: onSaved,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Please enter your email';
        }
        if (value != null && value.trim().isNotEmpty) {
          final emailErr = FlexValidators.email()(value);
          if (emailErr != null) return emailErr;
        }
        return validator?.call(value);
      },
    );
  }
}

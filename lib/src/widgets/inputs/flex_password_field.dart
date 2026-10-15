import 'package:flutter/material.dart';
import 'flex_input_field.dart';

/// A password input field preconfigured with text obscuring, visibility toggle,
/// leading lock icon, and password security defaults.
class FlexPasswordField extends StatelessWidget {
  const FlexPasswordField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.label = 'Password',
    this.hintText = 'Enter your password',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon = Icons.lock_outline_rounded,
    this.prefixWidget,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
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
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
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
      obscureText: true,
      showPasswordToggle: true,
      keyboardType: TextInputType.visiblePassword,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      enableSuggestions: false,
      fillColor: fillColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      width: width,
      semanticLabel: semanticLabel,
      autovalidateMode: autovalidateMode,
      onSaved: onSaved,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
    );
  }
}

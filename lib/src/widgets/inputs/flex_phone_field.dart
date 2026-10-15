import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/validators.dart';
import 'flex_input_field.dart';

/// A phone number input field preconfigured with phone keyboard,
/// phone formatting and validation, and leading phone icon or country code.
class FlexPhoneField extends StatelessWidget {
  const FlexPhoneField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.label = 'Phone Number',
    this.hintText = '+1 (555) 000-0000',
    this.countryCodePrefix = '+1',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon = Icons.phone_outlined,
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
  final String? countryCodePrefix;
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
    Widget? leading = prefixWidget;
    if (leading == null && countryCodePrefix != null) {
      leading = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null) ...[
            const SizedBox(width: 12),
            Icon(prefixIcon, size: 20, color: Colors.grey),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              countryCodePrefix!,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 8),
        ],
      );
    }

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
      prefixWidget: leading,
      suffixWidget: suffixWidget,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-()+]')),
      ],
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
      onSubmitted: onSubmitted,
      validator: (value) {
        if (isRequired && (value == null || value.trim().isEmpty)) {
          return 'Please enter a phone number';
        }
        if (value != null && value.trim().isNotEmpty) {
          final phoneErr = FlexValidators.phone()(value);
          if (phoneErr != null) return phoneErr;
        }
        return validator?.call(value);
      },
    );
  }
}

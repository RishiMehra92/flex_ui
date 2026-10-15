import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// An item in a [FlexDropdownField].
class FlexDropdownItem<T> {
  const FlexDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final IconData? icon;
  final bool enabled;
}

/// A form-compatible dropdown input field styled consistently with [FlexInputField].
class FlexDropdownField<T> extends StatelessWidget {
  const FlexDropdownField({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.label,
    this.hintText = 'Select an option',
    this.helperText,
    this.errorText,
    this.isRequired = false,
    this.enabled = true,
    this.prefixIcon,
    this.prefixWidget,
    this.validator,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.fillColor,
    this.width,
  });

  final List<FlexDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final bool isRequired;
  final bool enabled;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final FormFieldValidator<T>? validator;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? fillColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final inTheme = theme.inputTheme;

    final effectiveRadius = borderRadius ?? inTheme.borderRadius;
    final effectiveFillColor = fillColor ??
        inTheme.fillColor ??
        (enabled ? colors.surface : colors.surfaceVariant);
    final effectiveBorderColor =
        borderColor ?? inTheme.borderColor ?? colors.border;
    final effectiveBorderWidth = borderWidth ?? inTheme.borderWidth;

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: inTheme.focusedBorderColor ?? colors.borderFocused,
        width: inTheme.focusedBorderWidth,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: inTheme.errorBorderColor ?? colors.error,
        width: effectiveBorderWidth,
      ),
    );

    Widget? leading = prefixWidget;
    if (leading == null && prefixIcon != null) {
      leading = Icon(
        prefixIcon,
        color: enabled ? colors.hint : colors.disabledText,
        size: 20,
      );
    }

    final bool isActuallyRequired =
        isRequired || (label != null && label!.trim().endsWith('*'));

    Widget? labelWidget;
    if (label != null) {
      String cleanLabel = label!;
      if (cleanLabel.trim().endsWith('*')) {
        cleanLabel = cleanLabel.trim();
        cleanLabel = cleanLabel.substring(0, cleanLabel.length - 1).trim();
      }

      final labelStyle = theme.typography.labelLarge.copyWith(
        fontWeight: inTheme.labelFontWeight,
        fontSize: inTheme.labelFontSize,
        color: enabled ? colors.textPrimary : colors.disabledText,
      );

      if (isActuallyRequired) {
        labelWidget = Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.xs),
          child: RichText(
            text: TextSpan(
              text: cleanLabel,
              style: labelStyle,
              children: [
                TextSpan(
                  text: ' *',
                  style: labelStyle.copyWith(
                    color: colors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        labelWidget = Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.xs),
          child: Text(cleanLabel, style: labelStyle),
        );
      }
    }

    Widget dropdown = DropdownButtonFormField<T>(
      initialValue: value,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item.value,
          enabled: item.enabled,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (item.icon != null) ...[
                Icon(item.icon, size: 18, color: colors.textSecondary),
                const SizedBox(width: 8),
              ],
              Text(
                item.label,
                style: theme.typography.bodyMedium.copyWith(
                  color:
                      item.enabled ? colors.textPrimary : colors.disabledText,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
      validator: (val) {
        if (isRequired && val == null) {
          return 'Please select an option';
        }
        return validator?.call(val);
      },
      style: theme.typography.bodyMedium.copyWith(color: colors.textPrimary),
      dropdownColor: colors.surface,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: colors.hint),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: theme.typography.bodyMedium.copyWith(color: colors.hint),
        helperText: helperText,
        errorText: errorText,
        prefixIcon: leading,
        filled: true,
        fillColor: effectiveFillColor,
        isDense: true,
        contentPadding: inTheme.padding,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
      ),
    );

    Widget result = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelWidget != null) labelWidget,
        dropdown,
      ],
    );

    if (width != null) {
      result = SizedBox(width: width, child: result);
    }

    return result;
  }
}

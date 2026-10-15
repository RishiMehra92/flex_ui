import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../inputs/flex_dropdown_field.dart';

/// A standalone dropdown selector button with custom popup menu.
class FlexDropdown<T> extends StatelessWidget {
  const FlexDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    this.hintText = 'Select...',
    this.disabled = false,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    this.icon,
  });

  final List<FlexDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String hintText;
  final bool disabled;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry padding;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveRadius = borderRadius ?? theme.radius.sm;
    final effectiveBackground = backgroundColor ?? colors.surface;
    final effectiveBorder = borderColor ?? colors.border;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: disabled ? colors.disabled : effectiveBackground,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: Border.all(color: effectiveBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          hint: Text(
            hintText,
            style: theme.typography.bodyMedium.copyWith(color: colors.hint),
          ),
          isDense: true,
          dropdownColor: colors.surface,
          icon: icon ??
              Icon(Icons.keyboard_arrow_down_rounded, color: colors.hint),
          onChanged: disabled ? null : onChanged,
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
                      color: item.enabled
                          ? colors.textPrimary
                          : colors.disabledText,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import 'flex_checkbox.dart';

/// A list tile with a label, optional subtitle, and integrated [FlexCheckbox].
class FlexCheckboxListTile extends StatelessWidget {
  const FlexCheckboxListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.checkColor,
    this.gradient,
    this.borderGradient,
    this.tristate = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;
  final Color? activeColor;
  final Color? checkColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final bool tristate;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final isEnabled = onChanged != null;

    return InkWell(
      onTap: isEnabled
          ? () {
              if (tristate) {
                if (value == null) {
                  onChanged!(true);
                } else if (value == true) {
                  onChanged!(false);
                } else {
                  onChanged!(null);
                }
              } else {
                onChanged!(value != true);
              }
            }
          : null,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            FlexCheckbox(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
              checkColor: checkColor,
              gradient: gradient,
              borderGradient: borderGradient,
              tristate: tristate,
            ),
            SizedBox(width: theme.spacing.sm),
            if (secondary != null) ...[
              secondary!,
              SizedBox(width: theme.spacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                    style: theme.typography.bodyMedium.copyWith(
                      color: isEnabled
                          ? theme.colors.textPrimary
                          : theme.colors.disabledText,
                      fontWeight: FontWeight.w500,
                    ),
                    child: title,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    DefaultTextStyle(
                      style: theme.typography.bodySmall.copyWith(
                        color: theme.colors.textSecondary,
                      ),
                      child: subtitle!,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

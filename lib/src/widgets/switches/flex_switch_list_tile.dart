import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import 'flex_switch.dart';

/// A list tile with title, subtitle, and an interactive [FlexSwitch].
class FlexSwitchListTile extends StatelessWidget {
  const FlexSwitchListTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.secondary,
    this.activeColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget title;
  final Widget? subtitle;
  final Widget? secondary;
  final Color? activeColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final isEnabled = onChanged != null;

    return InkWell(
      onTap: isEnabled ? () => onChanged!(!value) : null,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
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
                      color:
                          isEnabled ? colors.textPrimary : colors.disabledText,
                      fontWeight: FontWeight.w500,
                    ),
                    child: title,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    DefaultTextStyle(
                      style: theme.typography.bodySmall.copyWith(
                        color: colors.textSecondary,
                      ),
                      child: subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: theme.spacing.sm),
            FlexSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: activeColor,
            ),
          ],
        ),
      ),
    );
  }
}

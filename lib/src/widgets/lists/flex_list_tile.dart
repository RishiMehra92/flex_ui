import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A theme-styled list tile supporting leading/trailing widgets, subtitle,
/// ink feedback, and trailing chevron.
class FlexListTile extends StatelessWidget {
  const FlexListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.showChevron = false,
    this.enabled = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.backgroundColor,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;
  final bool enabled;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    Widget? resolvedTrailing = trailing;
    if (resolvedTrailing == null && showChevron) {
      resolvedTrailing = Icon(
        Icons.chevron_right_rounded,
        color: colors.hint,
        size: 20,
      );
    }

    return Material(
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: theme.spacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultTextStyle(
                      style: theme.typography.bodyLarge.copyWith(
                        color:
                            enabled ? colors.textPrimary : colors.disabledText,
                        fontWeight: FontWeight.w500,
                      ),
                      child: title,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 3),
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
              if (resolvedTrailing != null) ...[
                SizedBox(width: theme.spacing.sm),
                resolvedTrailing,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

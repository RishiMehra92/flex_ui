import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../buttons/flex_button.dart';

/// An illustrative empty state presentation with icon, title, description,
/// and an optional primary action button.
class FlexEmptyState extends StatelessWidget {
  const FlexEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon = Icons.inbox_outlined,
    this.customIcon,
    this.actionLabel,
    this.onActionPressed,
    this.padding = const EdgeInsets.all(32.0),
    this.iconSize = 64.0,
    this.iconColor,
  });

  final String title;
  final String? description;
  final IconData? icon;
  final Widget? customIcon;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final Widget leading = customIcon ??
        Container(
          width: iconSize + 32,
          height: iconSize + 32,
          decoration: BoxDecoration(
            color: (iconColor ?? colors.primary).withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor ?? colors.primary,
            ),
          ),
        );

    return Center(
      child: SingleChildScrollView(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading,
            SizedBox(height: theme.spacing.lg),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.typography.headlineMedium.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            if (description != null) ...[
              SizedBox(height: theme.spacing.xs),
              Text(
                description!,
                textAlign: TextAlign.center,
                style: theme.typography.bodyMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
            if (actionLabel != null && onActionPressed != null) ...[
              SizedBox(height: theme.spacing.lg),
              FlexButton(
                label: actionLabel!,
                onPressed: onActionPressed,
                isFullWidth: false,
                size: FlexButtonSize.medium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

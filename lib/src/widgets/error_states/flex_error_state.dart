import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../buttons/flex_button.dart';

/// An error feedback view showing an error graphic/icon, title, message,
/// and a retry button.
class FlexErrorState extends StatelessWidget {
  const FlexErrorState({
    super.key,
    this.title = 'Something went wrong',
    this.message = 'An unexpected error occurred. Please try again.',
    this.icon = Icons.error_outline_rounded,
    this.customIcon,
    this.retryLabel = 'Try Again',
    this.onRetry,
    this.padding = const EdgeInsets.all(32.0),
    this.iconSize = 64.0,
    this.iconColor,
  });

  final String title;
  final String? message;
  final IconData icon;
  final Widget? customIcon;
  final String retryLabel;
  final VoidCallback? onRetry;
  final EdgeInsetsGeometry padding;
  final double iconSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final effectiveColor = iconColor ?? colors.error;

    final Widget leading = customIcon ??
        Container(
          width: iconSize + 32,
          height: iconSize + 32,
          decoration: BoxDecoration(
            color: effectiveColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: effectiveColor,
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
            if (message != null) ...[
              SizedBox(height: theme.spacing.xs),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.typography.bodyMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
            if (onRetry != null) ...[
              SizedBox(height: theme.spacing.lg),
              FlexButton(
                label: retryLabel,
                prefixIcon: Icons.refresh_rounded,
                onPressed: onRetry,
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

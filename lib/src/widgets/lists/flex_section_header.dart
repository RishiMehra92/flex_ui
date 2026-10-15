import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A section header with title and an optional trailing action button.
class FlexSectionHeader extends StatelessWidget {
  const FlexSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.typography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          if (actionLabel != null && onActionPressed != null) ...[
            GestureDetector(
              onTap: onActionPressed,
              child: Text(
                actionLabel!,
                style: theme.typography.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

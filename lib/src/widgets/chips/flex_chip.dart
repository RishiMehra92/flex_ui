import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// A theme-styled chip for tags, categories, or removable labels.
class FlexChip extends StatelessWidget {
  const FlexChip({
    super.key,
    required this.label,
    this.avatar,
    this.onDeleted,
    this.backgroundColor,
    this.gradient,
    this.borderGradient,
    this.labelColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.deleteIconColor,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  });

  final String label;
  final Widget? avatar;
  final VoidCallback? onDeleted;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Color? labelColor;
  final Color? borderColor;
  final double borderWidth;
  final Color? deleteIconColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveBg = backgroundColor ?? colors.surfaceVariant;
    final effectiveLabel = labelColor ?? colors.textPrimary;
    final effectiveBorder = borderColor ?? colors.border;

    Widget chip = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? effectiveBg : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: (borderGradient == null &&
                (borderColor != null || gradient == null))
            ? Border.all(color: effectiveBorder, width: borderWidth)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (avatar != null) ...[
            avatar!,
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              color: effectiveLabel,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (onDeleted != null) ...[
            const SizedBox(width: 6),
            GestureDetector(
              onTap: onDeleted,
              child: Icon(
                Icons.cancel,
                size: 16,
                color: deleteIconColor ?? colors.hint,
              ),
            ),
          ],
        ],
      ),
    );

    if (borderGradient != null && borderWidth > 0) {
      chip = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: borderGradient!,
          borderWidth: borderWidth,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: chip,
      );
    }

    return chip;
  }
}

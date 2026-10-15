import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// Semantic status variant for [FlexStatusBadge].
enum FlexStatusType {
  success,
  warning,
  error,
  info,
  neutral,
}

/// A pill-shaped status badge displaying semantic status indicators.
class FlexStatusBadge extends StatelessWidget {
  const FlexStatusBadge({
    super.key,
    required this.label,
    this.status = FlexStatusType.neutral,
    this.showDot = true,
    this.icon,
    this.customColor,
    this.customBackgroundColor,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.gradient,
    this.borderGradient,
    this.borderColor,
    this.borderWidth,
  });

  final String label;
  final FlexStatusType status;
  final bool showDot;
  final IconData? icon;
  final Color? customColor;
  final Color? customBackgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    Color fg;
    Color bg;

    if (customColor != null && customBackgroundColor != null) {
      fg = customColor!;
      bg = customBackgroundColor!;
    } else {
      switch (status) {
        case FlexStatusType.success:
          fg = colors.success;
          bg = colors.successContainer;
          break;
        case FlexStatusType.warning:
          fg = colors.warning;
          bg = colors.warningContainer;
          break;
        case FlexStatusType.error:
          fg = colors.error;
          bg = colors.errorContainer;
          break;
        case FlexStatusType.info:
          fg = colors.info;
          bg = colors.infoContainer;
          break;
        case FlexStatusType.neutral:
          fg = colors.textSecondary;
          bg = colors.surfaceVariant;
          break;
      }
    }

    if (gradient != null) {
      bg = Colors.transparent;
      fg = customColor ?? Colors.white;
    }

    final effectiveWidth = borderWidth ?? 1.0;

    Widget badgeContent = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? bg : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null && borderGradient == null
            ? Border.all(color: borderColor!, width: effectiveWidth)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ] else if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: fg,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: theme.typography.labelSmall.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (borderGradient != null) {
      badgeContent = FlexGradientBorderBox(
        borderGradient: borderGradient!,
        borderWidth: effectiveWidth,
        borderRadius: BorderRadius.circular(borderRadius),
        child: badgeContent,
      );
    }

    return badgeContent;
  }
}

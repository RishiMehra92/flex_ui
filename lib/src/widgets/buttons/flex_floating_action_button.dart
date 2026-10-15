import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// An elevated floating action button supporting regular and extended modes,
/// loading state, gradients, and custom colors.
class FlexFloatingActionButton extends StatelessWidget {
  const FlexFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.label,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.borderGradient,
    this.borderColor,
    this.borderWidth = 1.0,
    this.elevation = 4.0,
    this.isLoading = false,
    this.borderRadius,
    this.semanticLabel,
  });

  /// Factory for an extended FAB with an icon and text label.
  const FlexFloatingActionButton.extended({
    super.key,
    required this.onPressed,
    required String this.label,
    this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.borderGradient,
    this.borderColor,
    this.borderWidth = 1.0,
    this.elevation = 4.0,
    this.isLoading = false,
    this.borderRadius,
    this.semanticLabel,
  });

  final VoidCallback? onPressed;
  final Widget? icon;
  final String? label;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Color? borderColor;
  final double borderWidth;
  final double elevation;
  final bool isLoading;
  final double? borderRadius;
  final String? semanticLabel;

  bool get isExtended => label != null && label!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveBackground = backgroundColor ?? colors.primary;
    final effectiveForeground = foregroundColor ?? Colors.white;
    final effectiveRadius = borderRadius ?? (isExtended ? 16.0 : 28.0);

    Widget content;
    if (isLoading) {
      content = SizedBox(
        width: 24,
        height: 24,
        child: CupertinoActivityIndicator(
          radius: 12,
          color: effectiveForeground,
        ),
      );
    } else {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          if (icon != null && isExtended) SizedBox(width: theme.spacing.xs),
          if (isExtended)
            Text(
              label!,
              style: theme.typography.labelLarge.copyWith(
                color: effectiveForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      );
    }

    Widget fab = Material(
      color: Colors.transparent,
      elevation: elevation,
      shadowColor: Colors.black.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: Container(
        height: 56,
        padding: isExtended
            ? const EdgeInsets.symmetric(horizontal: 20)
            : const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: gradient == null ? effectiveBackground : null,
          gradient: gradient,
          borderRadius: BorderRadius.circular(effectiveRadius),
          border: (borderGradient == null && borderColor != null)
              ? Border.all(color: borderColor!, width: borderWidth)
              : null,
        ),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(effectiveRadius),
          child: Center(
            widthFactor: isExtended ? null : 1.0,
            child: content,
          ),
        ),
      ),
    );

    if (borderGradient != null && borderWidth > 0) {
      fab = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: borderGradient!,
          borderWidth: borderWidth,
          borderRadius: BorderRadius.circular(effectiveRadius),
        ),
        child: fab,
      );
    }

    if (tooltip != null) {
      fab = Tooltip(message: tooltip!, child: fab);
    }

    return Semantics(
      button: true,
      label: semanticLabel ?? label ?? tooltip,
      child: fab,
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// A theme-aware container widget with pre-configured borders, radii,
/// and padding presets.
class FlexContainer extends StatelessWidget {
  const FlexContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.gradient,
    this.borderGradient,
    this.gradientOverlay,
    this.gradientOverlayBlendMode = BlendMode.srcOver,
    this.borderRadius,
    this.borderColor,
    this.borderWidth = 1.0,
    this.shadowColor,
    this.elevation = 0.0,
    this.alignment,
    this.clipBehavior = Clip.none,
  });

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Gradient? gradientOverlay;
  final BlendMode gradientOverlayBlendMode;
  final double? borderRadius;
  final Color? borderColor;
  final double borderWidth;
  final Color? shadowColor;
  final double elevation;
  final AlignmentGeometry? alignment;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveRadius = borderRadius ?? theme.radius.md;
    final effectiveBackground = backgroundColor ?? colors.surface;

    Widget content = child;

    if (gradientOverlay != null) {
      content = Stack(
        fit: StackFit.passthrough,
        children: [
          content,
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: gradientOverlay,
                  backgroundBlendMode: gradientOverlayBlendMode,
                  borderRadius: BorderRadius.circular(effectiveRadius),
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget container = Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: gradient == null ? effectiveBackground : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: (borderGradient == null && borderColor != null)
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: (shadowColor ?? Colors.black).withValues(alpha: 0.08),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: content,
    );

    if (borderGradient != null && borderWidth > 0) {
      container = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: borderGradient!,
          borderWidth: borderWidth,
          borderRadius: BorderRadius.circular(effectiveRadius),
        ),
        child: container,
      );
    }

    return container;
  }
}

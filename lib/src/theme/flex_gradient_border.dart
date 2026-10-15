import 'package:flutter/material.dart';

/// A custom painter that draws a gradient border along a rounded rectangle
/// or circle with precise stroke alignment and clipping.
class FlexGradientBorderPainter extends CustomPainter {
  const FlexGradientBorderPainter({
    required this.gradient,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  /// The gradient shader source for the border.
  final Gradient gradient;

  /// The stroke thickness of the border.
  final double borderWidth;

  /// The border radius when [shape] is [BoxShape.rectangle].
  final BorderRadius? borderRadius;

  /// The box shape (rectangle or circle).
  final BoxShape shape;

  @override
  void paint(Canvas canvas, Size size) {
    if (borderWidth <= 0) return;

    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..shader = gradient.createShader(rect);

    if (shape == BoxShape.circle) {
      final radius = (size.shortestSide - borderWidth) / 2;
      canvas.drawCircle(rect.center, radius, paint);
    } else {
      final effectiveRadius = borderRadius ?? BorderRadius.zero;
      final rrect = effectiveRadius.toRRect(rect).deflate(borderWidth / 2);
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant FlexGradientBorderPainter oldDelegate) {
    return oldDelegate.gradient != gradient ||
        oldDelegate.borderWidth != borderWidth ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.shape != shape;
  }
}

/// A versatile container widget that supports independent background gradients/colors,
/// gradient borders, rounded corners, elevation shadows, and gradient overlays.
class FlexGradientBorderBox extends StatelessWidget {
  const FlexGradientBorderBox({
    super.key,
    required this.child,
    this.borderGradient,
    this.borderWidth = 1.0,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.backgroundColor,
    this.backgroundGradient,
    this.gradientOverlay,
    this.gradientOverlayBlendMode = BlendMode.srcOver,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.elevation = 0.0,
    this.shadowColor,
    this.clipBehavior = Clip.antiAlias,
  });

  /// Child widget.
  final Widget child;

  /// Gradient applied to the border stroke.
  final Gradient? borderGradient;

  /// Border stroke thickness.
  final double borderWidth;

  /// Corner radius for rectangle shapes.
  final BorderRadius? borderRadius;

  /// Box shape (rectangle or circle).
  final BoxShape shape;

  /// Solid background color.
  final Color? backgroundColor;

  /// Gradient background.
  final Gradient? backgroundGradient;

  /// Optional gradient overlay drawn on top of the background.
  final Gradient? gradientOverlay;

  /// Blend mode for the [gradientOverlay].
  final BlendMode gradientOverlayBlendMode;

  /// Inner padding.
  final EdgeInsetsGeometry? padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Width constraint.
  final double? width;

  /// Height constraint.
  final double? height;

  /// Elevation shadow depth.
  final double elevation;

  /// Shadow color.
  final Color? shadowColor;

  /// Clipping behavior for rounded borders.
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.zero;

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      child: child,
    );

    // Apply overlay if provided
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
                  shape: shape,
                  borderRadius:
                      shape == BoxShape.circle ? null : effectiveRadius,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Apply gradient border painter if borderGradient is specified
    if (borderGradient != null && borderWidth > 0) {
      content = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: borderGradient!,
          borderWidth: borderWidth,
          borderRadius: shape == BoxShape.circle ? null : effectiveRadius,
          shape: shape,
        ),
        child: content,
      );
    }

    final boxDecoration = BoxDecoration(
      color: backgroundGradient == null ? backgroundColor : null,
      gradient: backgroundGradient,
      shape: shape,
      borderRadius: shape == BoxShape.circle ? null : effectiveRadius,
      boxShadow: elevation > 0
          ? [
              BoxShadow(
                color: (shadowColor ?? Colors.black).withValues(alpha: 0.08),
                blurRadius: elevation * 2,
                offset: Offset(0, elevation),
              ),
            ]
          : null,
    );

    return Container(
      margin: margin,
      decoration: boxDecoration,
      clipBehavior: clipBehavior,
      child: content,
    );
  }
}

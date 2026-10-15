import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// Card visual variant.
enum FlexCardVariant {
  flat,
  elevated,
  outlined,
}

/// A versatile card container supporting flat, elevated, and outlined variants,
/// custom ink tap responses, borders, and paddings.
class FlexCard extends StatelessWidget {
  const FlexCard({
    super.key,
    required this.child,
    this.variant = FlexCardVariant.flat,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.gradient,
    this.borderGradient,
    this.shadowColor,
    this.gradientOverlay,
    this.gradientOverlayBlendMode = BlendMode.srcOver,
    this.elevation,
    this.width,
    this.height,
  });

  final Widget child;
  final FlexCardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Color? shadowColor;
  final Gradient? gradientOverlay;
  final BlendMode gradientOverlayBlendMode;
  final double? elevation;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final cardTheme = theme.cardTheme;

    final effectiveRadius = borderRadius ?? cardTheme.borderRadius;
    final effectivePadding = padding ?? cardTheme.padding;
    final effectiveBackground = backgroundColor ?? colors.cardBackground;
    final effectiveGradient = gradient ?? cardTheme.gradient;
    final effectiveBorderGradient = borderGradient ??
        (variant == FlexCardVariant.outlined ? cardTheme.borderGradient : null);
    final effectiveBorderWidth = borderWidth ?? cardTheme.borderWidth;
    final effectiveBorderColor = borderColor ??
        (variant == FlexCardVariant.outlined
            ? (cardTheme.borderColor ?? colors.border)
            : cardTheme.borderColor);

    Border? border;
    if (effectiveBorderGradient == null && effectiveBorderColor != null) {
      border = Border.all(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      );
    }

    final double effectiveElevation = elevation ??
        (variant == FlexCardVariant.elevated
            ? (cardTheme.elevation > 0 ? cardTheme.elevation : 3.0)
            : 0.0);

    final effectiveShadowColor =
        shadowColor ?? cardTheme.shadowColor ?? Colors.black;

    Widget cardContent = Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(effectiveRadius),
        onTap: onTap,
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );

    if (gradientOverlay != null) {
      cardContent = Stack(
        fit: StackFit.passthrough,
        children: [
          cardContent,
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

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveGradient == null ? effectiveBackground : null,
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: border,
        boxShadow: effectiveElevation > 0
            ? [
                BoxShadow(
                  color: effectiveShadowColor.withValues(alpha: 0.06),
                  blurRadius: effectiveElevation * 2,
                  offset: Offset(0, effectiveElevation),
                ),
              ]
            : null,
      ),
      child: cardContent,
    );

    if (effectiveBorderGradient != null && effectiveBorderWidth > 0) {
      card = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: effectiveBorderGradient,
          borderWidth: effectiveBorderWidth,
          borderRadius: BorderRadius.circular(effectiveRadius),
        ),
        child: card,
      );
    }

    return card;
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A frosted glass (glassmorphism) container with backdrop blur,
/// translucent tint, and subtle gradient border.
class FlexGlassContainer extends StatelessWidget {
  const FlexGlassContainer({
    super.key,
    required this.child,
    this.blur = 16.0,
    this.opacity = 0.15,
    this.tintColor,
    this.borderRadius,
    this.borderWidth = 1.0,
    this.padding,
    this.margin,
    this.width,
    this.height,
  });

  final Widget child;
  final double blur;
  final double opacity;
  final Color? tintColor;
  final double? borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final effectiveRadius = borderRadius ?? theme.radius.lg;
    final isDark = theme.isDark;

    final baseColor = tintColor ?? (isDark ? Colors.white : Colors.black);

    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(effectiveRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? EdgeInsets.all(theme.spacing.md),
            decoration: BoxDecoration(
              color: baseColor.withValues(alpha: opacity),
              borderRadius: BorderRadius.circular(effectiveRadius),
              border: Border.all(
                color: baseColor.withValues(alpha: opacity * 1.5),
                width: borderWidth,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A sleek linear progress indicator with rounded corners and custom colors.
class FlexLinearProgress extends StatelessWidget {
  const FlexLinearProgress({
    super.key,
    this.value,
    this.height = 6.0,
    this.borderRadius,
    this.color,
    this.backgroundColor,
    this.gradient,
  });

  /// The progress value between 0.0 and 1.0. If null, displays an indeterminate animation.
  final double? value;
  final double height;
  final double? borderRadius;
  final Color? color;
  final Color? backgroundColor;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveColor = color ?? colors.primary;
    final effectiveBackground = backgroundColor ?? colors.surfaceVariant;
    final effectiveRadius = borderRadius ?? height / 2;

    if (gradient != null) {
      if (value != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(effectiveRadius),
          child: Container(
            height: height,
            color: effectiveBackground,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: constraints.maxWidth * value!.clamp(0.0, 1.0),
                    height: height,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(effectiveRadius),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(effectiveRadius),
          child: SizedBox(
            height: height,
            child: ShaderMask(
              shaderCallback: (bounds) => gradient!.createShader(bounds),
              blendMode: BlendMode.srcIn,
              child: LinearProgressIndicator(
                value: null,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                backgroundColor: effectiveBackground,
              ),
            ),
          ),
        );
      }
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
          backgroundColor: effectiveBackground,
        ),
      ),
    );
  }
}

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
  });

  /// The progress value between 0.0 and 1.0. If null, displays an indeterminate animation.
  final double? value;
  final double height;
  final double? borderRadius;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveColor = color ?? colors.primary;
    final effectiveBackground = backgroundColor ?? colors.surfaceVariant;
    final effectiveRadius = borderRadius ?? height / 2;

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

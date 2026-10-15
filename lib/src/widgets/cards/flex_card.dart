import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

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

    Border? border;
    if (variant == FlexCardVariant.outlined) {
      border = Border.all(
        color: borderColor ?? colors.border,
        width: borderWidth ?? cardTheme.borderWidth,
      );
    } else if (borderColor != null) {
      border = Border.all(
        color: borderColor!,
        width: borderWidth ?? 1.0,
      );
    }

    final double effectiveElevation = elevation ??
        (variant == FlexCardVariant.elevated
            ? (cardTheme.elevation > 0 ? cardTheme.elevation : 3.0)
            : 0.0);

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackground,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: border,
        boxShadow: effectiveElevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: effectiveElevation * 2,
                  offset: Offset(0, effectiveElevation),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(effectiveRadius),
          onTap: onTap,
          child: Padding(
            padding: effectivePadding,
            child: child,
          ),
        ),
      ),
    );

    return card;
  }
}

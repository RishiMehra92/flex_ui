import 'package:flutter/material.dart';
import 'flex_card.dart';

/// An elevated card variant wrapping [FlexCard].
class FlexElevatedCard extends StatelessWidget {
  const FlexElevatedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.elevation = 4.0,
    this.width,
    this.height,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final Color? backgroundColor;
  final double elevation;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FlexCard(
      variant: FlexCardVariant.elevated,
      onTap: onTap,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      elevation: elevation,
      width: width,
      height: height,
      child: child,
    );
  }
}

import 'package:flutter/material.dart';
import 'flex_card.dart';

/// An outlined card variant wrapping [FlexCard].
class FlexOutlinedCard extends StatelessWidget {
  const FlexOutlinedCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.width,
    this.height,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return FlexCard(
      variant: FlexCardVariant.outlined,
      onTap: onTap,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      backgroundColor: backgroundColor,
      width: width,
      height: height,
      child: child,
    );
  }
}

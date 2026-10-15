import 'package:flutter/material.dart';
import 'flex_button.dart';

/// A gradient-filled button that wraps [FlexButton] with [FlexButtonVariant.gradient].
class FlexGradientButton extends StatelessWidget {
  const FlexGradientButton({
    super.key,
    this.label,
    this.onPressed,
    this.gradient,
    this.size = FlexButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = true,
    this.loadingText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.foregroundColor,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.width,
    this.height,
    this.textStyle,
    this.fontSize,
    this.enableAnimation = true,
    this.animationDuration,
    this.semanticLabel,
    this.tooltip,
    this.focusNode,
    this.autofocus = false,
  });

  final String? label;
  final VoidCallback? onPressed;
  final Gradient? gradient;
  final FlexButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final bool isFullWidth;
  final String? loadingText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Color? foregroundColor;
  final double? borderRadius;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final double? fontSize;
  final bool enableAnimation;
  final Duration? animationDuration;
  final String? semanticLabel;
  final String? tooltip;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return FlexButton(
      label: label,
      onPressed: onPressed,
      variant: FlexButtonVariant.gradient,
      gradient: gradient,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      isFullWidth: isFullWidth,
      loadingText: loadingText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      prefixWidget: prefixWidget,
      suffixWidget: suffixWidget,
      foregroundColor: foregroundColor,
      borderRadius: borderRadius,
      elevation: elevation,
      padding: padding,
      width: width,
      height: height,
      textStyle: textStyle,
      fontSize: fontSize,
      enableAnimation: enableAnimation,
      animationDuration: animationDuration,
      semanticLabel: semanticLabel,
      tooltip: tooltip,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }
}

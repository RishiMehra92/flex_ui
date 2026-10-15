import 'package:flutter/material.dart';
import 'flex_button.dart';

/// An outlined button variant that wraps [FlexButton] with [FlexButtonVariant.outlined].
class FlexOutlinedButton extends StatelessWidget {
  const FlexOutlinedButton({
    super.key,
    this.label,
    this.onPressed,
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
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.borderGradient,
    this.labelGradient,
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
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Gradient? borderGradient;
  final Gradient? labelGradient;
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
      variant: FlexButtonVariant.outlined,
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
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      borderGradient: borderGradient,
      labelGradient: labelGradient,
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

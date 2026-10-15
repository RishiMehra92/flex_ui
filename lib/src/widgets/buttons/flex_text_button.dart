import 'package:flutter/material.dart';
import 'flex_button.dart';

/// A text-only button that wraps [FlexButton] with [FlexButtonVariant.text].
class FlexTextButton extends StatelessWidget {
  const FlexTextButton({
    super.key,
    this.label,
    this.onPressed,
    this.size = FlexButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = false,
    this.loadingText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.foregroundColor,
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
      variant: FlexButtonVariant.text,
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
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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

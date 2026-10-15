import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../utils/string_helpers.dart';

/// Button visual variant.
enum FlexButtonVariant {
  /// Filled solid background.
  filled,

  /// Outlined with transparent background and border.
  outlined,

  /// Text only, no border or background.
  text,

  /// Gradient background.
  gradient,
}

/// Button size presets.
enum FlexButtonSize {
  small(height: 36.0, fontSize: 13.0, iconSize: 16.0),
  medium(height: 48.0, fontSize: 15.0, iconSize: 20.0),
  large(height: 56.0, fontSize: 16.0, iconSize: 22.0);

  const FlexButtonSize({
    required this.height,
    required this.fontSize,
    required this.iconSize,
  });

  final double height;
  final double fontSize;
  final double iconSize;
}

/// A highly customizable, accessible button supporting loading states,
/// icons, gradients, animations, and full-width mode.
class FlexButton extends StatefulWidget {
  const FlexButton({
    super.key,
    this.label,
    this.onPressed,
    this.variant = FlexButtonVariant.filled,
    this.size = FlexButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.isFullWidth = true,
    this.loadingText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.padding,
    this.width,
    this.height,
    this.textStyle,
    this.fontSize,
    this.gradient,
    this.enableAnimation = true,
    this.animationDuration,
    this.semanticLabel,
    this.tooltip,
    this.focusNode,
    this.autofocus = false,
  });

  /// The button's text label.
  final String? label;

  /// Callback when the button is tapped. Disabled if null, [isDisabled], or [isLoading].
  final VoidCallback? onPressed;

  /// Visual presentation variant.
  final FlexButtonVariant variant;

  /// Predefined size preset. Overridden by explicit [height] and [fontSize].
  final FlexButtonSize size;

  /// Whether the button is in a busy/loading state.
  final bool isLoading;

  /// Whether the button is disabled.
  final bool isDisabled;

  /// If true, width expands to [double.infinity] unless overridden by [width].
  final bool isFullWidth;

  /// Custom text shown during loading. If omitted, smartly inflected from [label].
  final String? loadingText;

  /// Optional icon placed before the label.
  final IconData? prefixIcon;

  /// Optional icon placed after the label.
  final IconData? suffixIcon;

  /// Optional custom widget placed before the label.
  final Widget? prefixWidget;

  /// Optional custom widget placed after the label.
  final Widget? suffixWidget;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom foreground/text/icon color.
  final Color? foregroundColor;

  /// Custom border color.
  final Color? borderColor;

  /// Custom border width.
  final double? borderWidth;

  /// Custom border radius.
  final double? borderRadius;

  /// Custom elevation.
  final double? elevation;

  /// Custom inner padding.
  final EdgeInsetsGeometry? padding;

  /// Custom explicit width.
  final double? width;

  /// Custom explicit height. Defaults to [size.height] or theme height.
  final double? height;

  /// Custom text style.
  final TextStyle? textStyle;

  /// Custom font size.
  final double? fontSize;

  /// Gradient background (automatically used when [variant] is [FlexButtonVariant.gradient]).
  final Gradient? gradient;

  /// Whether to enable subtle interactive press animation.
  final bool enableAnimation;

  /// Animation duration for press feedback.
  final Duration? animationDuration;

  /// Accessibility semantic label.
  final String? semanticLabel;

  /// Tooltip message shown on long press / hover.
  final String? tooltip;

  /// Focus node for keyboard accessibility.
  final FocusNode? focusNode;

  /// Whether to focus automatically.
  final bool autofocus;

  @override
  State<FlexButton> createState() => _FlexButtonState();
}

class _FlexButtonState extends State<FlexButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(FlexButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animationDuration != oldWidget.animationDuration &&
        widget.animationDuration != null) {
      _animController.duration = widget.animationDuration!;
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (_isEnabled && widget.enableAnimation) {
      setState(() => _isPressed = true);
      _animController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _animController.reverse();
    }
  }

  void _handleTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _animController.reverse();
    }
  }

  bool get _isEnabled =>
      !widget.isDisabled && !widget.isLoading && widget.onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final btnTheme = theme.buttonTheme;

    final effectiveRadius = widget.borderRadius ?? btnTheme.borderRadius;
    final effectiveHeight = widget.height ??
        (widget.size == FlexButtonSize.medium
            ? btnTheme.height
            : widget.size.height);
    final effectivePadding = widget.padding ?? btnTheme.padding;
    final effectiveElevation = widget.elevation ?? btnTheme.elevation;

    // Resolve foreground color
    Color effectiveForeground;
    if (!_isEnabled) {
      effectiveForeground = colors.disabledText;
    } else if (widget.foregroundColor != null) {
      effectiveForeground = widget.foregroundColor!;
    } else {
      switch (widget.variant) {
        case FlexButtonVariant.filled:
        case FlexButtonVariant.gradient:
          effectiveForeground = Colors.white;
          break;
        case FlexButtonVariant.outlined:
        case FlexButtonVariant.text:
          effectiveForeground = colors.primary;
          break;
      }
    }

    // Resolve background color and gradient
    Color? effectiveBackground;
    Gradient? effectiveGradient;

    if (!_isEnabled) {
      effectiveBackground = widget.variant == FlexButtonVariant.text
          ? Colors.transparent
          : colors.disabled;
      effectiveGradient = null;
    } else {
      switch (widget.variant) {
        case FlexButtonVariant.filled:
          effectiveBackground = widget.backgroundColor ?? colors.primary;
          effectiveGradient = widget.gradient;
          break;
        case FlexButtonVariant.gradient:
          effectiveGradient = widget.gradient ?? colors.primaryGradient;
          effectiveBackground = widget.backgroundColor;
          break;
        case FlexButtonVariant.outlined:
        case FlexButtonVariant.text:
          effectiveBackground = widget.backgroundColor ?? Colors.transparent;
          break;
      }
    }

    // Border
    Border? border;
    if (widget.variant == FlexButtonVariant.outlined) {
      final borderSideColor =
          !_isEnabled ? colors.border : (widget.borderColor ?? colors.primary);
      border = Border.all(
        color: borderSideColor,
        width: widget.borderWidth ?? 1.5,
      );
    } else if (widget.borderColor != null) {
      border = Border.all(
        color: widget.borderColor!,
        width: widget.borderWidth ?? 1.0,
      );
    }

    // Font and text style
    final baseTextStyle = widget.textStyle ??
        theme.typography.labelLarge.copyWith(
          fontSize: widget.fontSize ?? widget.size.fontSize,
          fontWeight: FontWeight.w600,
          color: effectiveForeground,
        );
    final effectiveTextStyle =
        baseTextStyle.copyWith(color: effectiveForeground);

    // Build children (icons + label)
    Widget content;
    if (widget.isLoading) {
      final indicatorColor = effectiveForeground;
      final loadingMessage = FlexStringHelpers.deriveLoadingText(
        widget.label,
        explicitText: widget.loadingText,
      );

      content = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: widget.size.iconSize,
            height: widget.size.iconSize,
            child: CupertinoActivityIndicator(
              radius: widget.size.iconSize / 2,
              color: indicatorColor,
            ),
          ),
          if (widget.label != null || widget.loadingText != null) ...[
            SizedBox(width: theme.spacing.sm),
            Flexible(
              child: Text(
                loadingMessage,
                style: effectiveTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ],
      );
    } else {
      final leading = widget.prefixWidget ??
          (widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: widget.size.iconSize,
                  color: effectiveForeground,
                )
              : null);

      final trailing = widget.suffixWidget ??
          (widget.suffixIcon != null
              ? Icon(
                  widget.suffixIcon,
                  size: widget.size.iconSize,
                  color: effectiveForeground,
                )
              : null);

      final hasLabel = widget.label != null && widget.label!.isNotEmpty;

      content = Row(
        mainAxisSize: (widget.isFullWidth && widget.width == null)
            ? MainAxisSize.max
            : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading,
            if (hasLabel) SizedBox(width: theme.spacing.xs),
          ],
          if (hasLabel)
            Flexible(
              child: Text(
                widget.label!,
                style: effectiveTextStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          if (trailing != null) ...[
            if (hasLabel) SizedBox(width: theme.spacing.xs),
            trailing,
          ],
        ],
      );
    }

    final double? finalWidth =
        widget.width ?? (widget.isFullWidth ? double.infinity : null);

    Widget buttonWidget = AnimatedContainer(
      duration: widget.animationDuration ?? const Duration(milliseconds: 150),
      width: finalWidth,
      height: effectiveHeight,
      constraints: BoxConstraints(
        minWidth: btnTheme.minWidth,
        minHeight: effectiveHeight,
      ),
      decoration: BoxDecoration(
        color: effectiveGradient == null ? effectiveBackground : null,
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(effectiveRadius),
        border: border,
        boxShadow: (effectiveElevation > 0 && _isEnabled)
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: effectiveElevation * 2,
                  offset: Offset(0, effectiveElevation),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusNode: widget.focusNode,
          autofocus: widget.autofocus,
          borderRadius: BorderRadius.circular(effectiveRadius),
          onTap: _isEnabled ? widget.onPressed : null,
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: Padding(
            padding: effectivePadding,
            child: Center(
              widthFactor:
                  (widget.isFullWidth && widget.width == null) ? 1.0 : null,
              child: content,
            ),
          ),
        ),
      ),
    );

    if (widget.enableAnimation) {
      buttonWidget = ScaleTransition(
        scale: _scaleAnimation,
        child: buttonWidget,
      );
    }

    if (widget.tooltip != null) {
      buttonWidget = Tooltip(
        message: widget.tooltip!,
        child: buttonWidget,
      );
    }

    return Semantics(
      button: true,
      enabled: _isEnabled,
      label: widget.semanticLabel ?? widget.label,
      child: buttonWidget,
    );
  }
}

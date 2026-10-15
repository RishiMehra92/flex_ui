import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// Shape variant for [FlexIconButton].
enum FlexIconButtonShape {
  circle,
  roundedSquare,
}

/// An accessible, customizable icon button with loading state, tooltip,
/// and badge support.
class FlexIconButton extends StatelessWidget {
  const FlexIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.size = 40.0,
    this.iconSize = 20.0,
    this.shape = FlexIconButtonShape.circle,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.gradient,
    this.borderGradient,
    this.elevation = 0.0,
    this.isLoading = false,
    this.isDisabled = false,
    this.badgeText,
    this.showBadge = false,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
  });

  /// The icon to display. Can be [IconData] or a custom [Widget].
  final dynamic icon;

  /// Callback when pressed.
  final VoidCallback? onPressed;

  /// Tooltip message.
  final String? tooltip;

  /// Diameter/size of the button container.
  final double size;

  /// Size of the icon.
  final double iconSize;

  /// Shape of the button: circle or roundedSquare.
  final FlexIconButtonShape shape;

  /// Custom border radius (for [FlexIconButtonShape.roundedSquare]).
  final double? borderRadius;

  /// Background color.
  final Color? backgroundColor;

  /// Icon and loading spinner color.
  final Color? foregroundColor;

  /// Optional border color.
  final Color? borderColor;

  /// Border width.
  final double borderWidth;

  /// Optional background gradient.
  final Gradient? gradient;

  /// Optional border gradient.
  final Gradient? borderGradient;

  /// Elevation shadow.
  final double elevation;

  /// Whether the button is loading.
  final bool isLoading;

  /// Whether the button is disabled.
  final bool isDisabled;

  /// Optional badge text overlaid on top right.
  final String? badgeText;

  /// Whether to show a badge indicator.
  final bool showBadge;

  /// Accessibility semantic label.
  final String? semanticLabel;

  /// Focus node for keyboard accessibility.
  final FocusNode? focusNode;

  /// Whether to focus automatically.
  final bool autofocus;

  bool get _isEnabled => !isDisabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveForeground = !_isEnabled
        ? colors.disabledText
        : (foregroundColor ?? colors.textPrimary);

    final effectiveBackground = backgroundColor ??
        (shape == FlexIconButtonShape.circle
            ? Colors.transparent
            : colors.surfaceVariant);

    final effectiveRadius = shape == FlexIconButtonShape.circle
        ? BorderRadius.circular(size / 2)
        : BorderRadius.circular(borderRadius ?? theme.radius.sm);

    Widget iconWidget;
    if (isLoading) {
      iconWidget = SizedBox(
        width: iconSize,
        height: iconSize,
        child: CupertinoActivityIndicator(
          radius: iconSize / 2,
          color: effectiveForeground,
        ),
      );
    } else if (icon is IconData) {
      iconWidget = Icon(
        icon as IconData,
        size: iconSize,
        color: effectiveForeground,
      );
    } else if (icon is Widget) {
      iconWidget = icon as Widget;
    } else {
      iconWidget = const SizedBox.shrink();
    }

    final effectiveGradient = _isEnabled ? gradient : null;
    final effectiveBorderGradient = _isEnabled ? borderGradient : null;

    Widget button = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: effectiveGradient == null ? effectiveBackground : null,
        gradient: effectiveGradient,
        borderRadius: effectiveRadius,
        border: (effectiveBorderGradient == null && borderColor != null)
            ? Border.all(color: borderColor!, width: borderWidth)
            : null,
        boxShadow: (elevation > 0 && _isEnabled)
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          focusNode: focusNode,
          autofocus: autofocus,
          borderRadius: effectiveRadius,
          onTap: _isEnabled ? onPressed : null,
          child: Center(child: iconWidget),
        ),
      ),
    );

    if (effectiveBorderGradient != null && borderWidth > 0) {
      button = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: effectiveBorderGradient,
          borderWidth: borderWidth,
          borderRadius: effectiveRadius,
          shape: shape == FlexIconButtonShape.circle
              ? BoxShape.circle
              : BoxShape.rectangle,
        ),
        child: button,
      );
    }

    if (showBadge || badgeText != null) {
      button = Stack(
        clipBehavior: Clip.none,
        children: [
          button,
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: colors.error,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: colors.surface, width: 1.5),
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Center(
                child: Text(
                  badgeText ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return Semantics(
      button: true,
      enabled: _isEnabled,
      label: semanticLabel ?? tooltip,
      child: button,
    );
  }
}

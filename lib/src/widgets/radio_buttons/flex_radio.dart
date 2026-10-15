import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// A theme-styled radio button supporting custom colors and sizes.
class FlexRadio<T> extends StatelessWidget {
  const FlexRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.inactiveBorderColor,
    this.gradient,
    this.borderGradient,
    this.size = 20.0,
    this.semanticLabel,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? inactiveBorderColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final double size;
  final String? semanticLabel;

  bool get _isSelected => value == groupValue;
  bool get _isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveActiveColor = activeColor ?? colors.primary;
    final effectiveInactiveBorder = inactiveBorderColor ?? colors.border;
    final effectiveBorderColor =
        _isSelected ? effectiveActiveColor : effectiveInactiveBorder;
    final effectiveGradient = (_isEnabled && _isSelected) ? gradient : null;
    final effectiveBorderGradient = _isEnabled ? borderGradient : null;
    final double borderWidth = _isSelected ? 2.0 : 1.5;

    Widget radioBox = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: effectiveBorderGradient == null
            ? Border.all(
                color: !_isEnabled ? colors.disabled : effectiveBorderColor,
                width: borderWidth,
              )
            : null,
        color: inactiveColor ?? colors.surface,
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: _isSelected ? size * 0.5 : 0,
          height: _isSelected ? size * 0.5 : 0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: !_isEnabled
                ? colors.disabledText
                : (effectiveGradient == null ? effectiveActiveColor : null),
            gradient: effectiveGradient,
          ),
        ),
      ),
    );

    if (effectiveBorderGradient != null) {
      radioBox = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: effectiveBorderGradient,
          borderWidth: borderWidth,
          shape: BoxShape.circle,
        ),
        child: radioBox,
      );
    }

    return Semantics(
      selected: _isSelected,
      enabled: _isEnabled,
      label: semanticLabel,
      child: GestureDetector(
        onTap: _isEnabled ? () => onChanged!(value) : null,
        child: radioBox,
      ),
    );
  }
}

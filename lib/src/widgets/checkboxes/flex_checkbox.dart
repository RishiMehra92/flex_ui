import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// A theme-styled checkbox supporting tri-state values and animations.
class FlexCheckbox extends StatelessWidget {
  const FlexCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.inactiveColor,
    this.inactiveBorderColor,
    this.gradient,
    this.borderGradient,
    this.borderWidth = 1.5,
    this.size = 20.0,
    this.borderRadius = 5.0,
    this.tristate = false,
    this.semanticLabel,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
  final Color? inactiveColor;
  final Color? inactiveBorderColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final double borderWidth;
  final double size;
  final double borderRadius;
  final bool tristate;
  final String? semanticLabel;

  bool get _isChecked => value == true;
  bool get _isIndeterminate => tristate && value == null;
  bool get _isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final isSelected = _isChecked || _isIndeterminate;
    final effectiveActiveColor = activeColor ?? colors.primary;
    final effectiveInactiveColor = inactiveColor ?? colors.surface;
    final effectiveCheckColor = checkColor ?? Colors.white;
    final effectiveBorderColor = isSelected
        ? effectiveActiveColor
        : (inactiveBorderColor ?? colors.border);

    final effectiveGradient = (_isEnabled && isSelected) ? gradient : null;
    final effectiveBorderGradient = _isEnabled ? borderGradient : null;

    Widget box = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: !_isEnabled
            ? colors.disabled
            : (effectiveGradient == null
                ? (isSelected ? effectiveActiveColor : effectiveInactiveColor)
                : null),
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: effectiveBorderGradient == null
            ? Border.all(
                color: !_isEnabled ? colors.disabled : effectiveBorderColor,
                width: borderWidth,
              )
            : null,
      ),
      child: Center(
        child: _isChecked
            ? Icon(
                Icons.check_rounded,
                size: size * 0.75,
                color: effectiveCheckColor,
              )
            : (_isIndeterminate
                ? Icon(
                    Icons.remove_rounded,
                    size: size * 0.75,
                    color: effectiveCheckColor,
                  )
                : null),
      ),
    );

    if (effectiveBorderGradient != null && borderWidth > 0) {
      box = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: effectiveBorderGradient,
          borderWidth: borderWidth,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: box,
      );
    }

    return Semantics(
      checked: _isChecked,
      enabled: _isEnabled,
      label: semanticLabel,
      child: GestureDetector(
        onTap: _isEnabled
            ? () {
                if (tristate) {
                  if (value == null) {
                    onChanged!(true);
                  } else if (value == true) {
                    onChanged!(false);
                  } else {
                    onChanged!(null);
                  }
                } else {
                  onChanged!(!_isChecked);
                }
              }
            : null,
        child: box,
      ),
    );
  }
}

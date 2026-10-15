import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A theme-styled checkbox supporting tri-state values and animations.
class FlexCheckbox extends StatelessWidget {
  const FlexCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.checkColor,
    this.size = 20.0,
    this.borderRadius = 5.0,
    this.tristate = false,
    this.semanticLabel,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final Color? activeColor;
  final Color? checkColor;
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

    final effectiveActiveColor = activeColor ?? colors.primary;
    final effectiveCheckColor = checkColor ?? Colors.white;

    final isSelected = _isChecked || _isIndeterminate;

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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: !_isEnabled
                ? colors.disabled
                : (isSelected ? effectiveActiveColor : colors.surface),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: !_isEnabled
                  ? colors.disabled
                  : (isSelected ? effectiveActiveColor : colors.border),
              width: 1.5,
            ),
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
        ),
      ),
    );
  }
}

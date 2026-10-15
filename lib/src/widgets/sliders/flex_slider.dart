import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A theme-aware slider with divisions, custom colors, and label formatting.
class FlexSlider extends StatelessWidget {
  const FlexSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: activeColor ?? colors.primary,
        inactiveTrackColor: inactiveColor ?? colors.surfaceVariant,
        thumbColor: thumbColor ?? colors.primary,
        overlayColor: (activeColor ?? colors.primary).withValues(alpha: 0.12),
        trackHeight: 4.0,
      ),
      child: Slider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        divisions: divisions,
        label: label,
        onChanged: onChanged,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A theme-aware range slider for selecting a range of values.
class FlexRangeSlider extends StatelessWidget {
  const FlexRangeSlider({
    super.key,
    required this.values,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.labels,
    this.activeColor,
    this.inactiveColor,
  });

  final RangeValues values;
  final ValueChanged<RangeValues>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final RangeLabels? labels;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: activeColor ?? colors.primary,
        inactiveTrackColor: inactiveColor ?? colors.surfaceVariant,
        thumbColor: activeColor ?? colors.primary,
        overlayColor: (activeColor ?? colors.primary).withValues(alpha: 0.12),
        trackHeight: 4.0,
      ),
      child: RangeSlider(
        values: values,
        min: min,
        max: max,
        divisions: divisions,
        labels: labels,
        onChanged: onChanged,
      ),
    );
  }
}

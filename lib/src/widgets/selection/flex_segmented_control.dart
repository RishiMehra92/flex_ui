import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// An option in [FlexSegmentedControl].
class FlexSegment<T> {
  const FlexSegment({
    required this.value,
    required this.label,
    this.icon,
  });

  final T value;
  final String label;
  final IconData? icon;
}

/// An animated segmented control / sliding tab selector.
class FlexSegmentedControl<T> extends StatelessWidget {
  const FlexSegmentedControl({
    super.key,
    required this.segments,
    required this.selectedValue,
    required this.onValueChanged,
    this.backgroundColor,
    this.selectedColor,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.borderRadius = 10.0,
    this.height = 42.0,
  });

  final List<FlexSegment<T>> segments;
  final T selectedValue;
  final ValueChanged<T> onValueChanged;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final double borderRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final bg = backgroundColor ?? colors.surfaceVariant;
    final selBg = selectedColor ?? colors.surface;
    final selText = selectedTextColor ?? colors.textPrimary;
    final unselText = unselectedTextColor ?? colors.textSecondary;

    return Container(
      height: height,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: segments.map((segment) {
          final isSelected = segment.value == selectedValue;

          return Expanded(
            child: GestureDetector(
              onTap: () => onValueChanged(segment.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isSelected ? selBg : Colors.transparent,
                  borderRadius: BorderRadius.circular(borderRadius - 2),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (segment.icon != null) ...[
                      Icon(
                        segment.icon,
                        size: 16,
                        color: isSelected ? selText : unselText,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      segment.label,
                      style: theme.typography.labelMedium.copyWith(
                        color: isSelected ? selText : unselText,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

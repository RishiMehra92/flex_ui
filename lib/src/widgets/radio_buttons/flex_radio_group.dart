import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import 'flex_radio.dart';

/// An item in [FlexRadioGroup].
class FlexRadioOption<T> {
  const FlexRadioOption({
    required this.value,
    required this.label,
    this.subtitle,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? subtitle;
  final bool enabled;
}

/// A structured list or column of radio button options.
class FlexRadioGroup<T> extends StatelessWidget {
  const FlexRadioGroup({
    super.key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
    this.spacing = 8.0,
  });

  final List<FlexRadioOption<T>> options;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Color? activeColor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.map((option) {
        final isEnabled = option.enabled;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: spacing / 2),
          child: InkWell(
            onTap: isEnabled ? () => onChanged(option.value) : null,
            borderRadius: BorderRadius.circular(theme.radius.sm),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: [
                  FlexRadio<T>(
                    value: option.value,
                    groupValue: groupValue,
                    onChanged: isEnabled ? onChanged : null,
                    activeColor: activeColor,
                  ),
                  SizedBox(width: theme.spacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          option.label,
                          style: theme.typography.bodyMedium.copyWith(
                            color: isEnabled
                                ? colors.textPrimary
                                : colors.disabledText,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (option.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            option.subtitle!,
                            style: theme.typography.bodySmall.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

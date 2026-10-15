import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A modern toggle switch with smooth animated thumb, custom track colors,
/// and adaptive styling.
class FlexSwitch extends StatelessWidget {
  const FlexSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.thumbColor,
    this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? thumbColor;
  final String? semanticLabel;

  bool get _isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveActiveColor = activeColor ?? colors.primary;
    final effectiveInactiveTrack = inactiveTrackColor ?? colors.border;
    final effectiveThumb = thumbColor ?? Colors.white;

    return Semantics(
      toggled: value,
      enabled: _isEnabled,
      label: semanticLabel,
      child: GestureDetector(
        onTap: _isEnabled ? () => onChanged!(!value) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: 48,
          height: 28,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: !_isEnabled
                ? colors.disabled
                : (value
                    ? (activeTrackColor ?? effectiveActiveColor)
                    : effectiveInactiveTrack),
          ),
          child: Align(
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: effectiveThumb,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

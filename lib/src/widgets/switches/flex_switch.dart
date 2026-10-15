import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

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
    this.activeTrackGradient,
    this.inactiveTrackGradient,
    this.thumbColor,
    this.thumbGradient,
    this.borderGradient,
    this.trackBorderColor,
    this.trackBorderWidth = 1.0,
    this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Gradient? activeTrackGradient;
  final Gradient? inactiveTrackGradient;
  final Color? thumbColor;
  final Gradient? thumbGradient;
  final Gradient? borderGradient;
  final Color? trackBorderColor;
  final double trackBorderWidth;
  final String? semanticLabel;

  bool get _isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveActiveColor = activeColor ?? colors.primary;
    final effectiveInactiveTrack = inactiveTrackColor ?? colors.border;
    final effectiveThumb = thumbColor ?? Colors.white;

    final effectiveTrackGradient = _isEnabled
        ? (value ? activeTrackGradient : inactiveTrackGradient)
        : null;
    final effectiveThumbGradient = _isEnabled ? thumbGradient : null;
    final effectiveBorderGradient = _isEnabled ? borderGradient : null;

    Widget track = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: 48,
      height: 28,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: !_isEnabled
            ? colors.disabled
            : (effectiveTrackGradient == null
                ? (value
                    ? (activeTrackColor ?? effectiveActiveColor)
                    : effectiveInactiveTrack)
                : null),
        gradient: effectiveTrackGradient,
        border: (effectiveBorderGradient == null && trackBorderColor != null)
            ? Border.all(color: trackBorderColor!, width: trackBorderWidth)
            : null,
      ),
      child: Align(
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: effectiveThumbGradient == null ? effectiveThumb : null,
            gradient: effectiveThumbGradient,
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
    );

    if (effectiveBorderGradient != null && trackBorderWidth > 0) {
      track = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: effectiveBorderGradient,
          borderWidth: trackBorderWidth,
          borderRadius: BorderRadius.circular(14),
        ),
        child: track,
      );
    }

    return Semantics(
      toggled: value,
      enabled: _isEnabled,
      label: semanticLabel,
      child: GestureDetector(
        onTap: _isEnabled ? () => onChanged!(!value) : null,
        child: track,
      ),
    );
  }
}

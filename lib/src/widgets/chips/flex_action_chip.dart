import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// An interactive action chip triggering a callback on tap.
class FlexActionChip extends StatelessWidget {
  const FlexActionChip({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius = 16.0,
    this.gradient,
    this.borderGradient,
    this.borderWidth = 1.0,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderRadius;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final bg =
        backgroundColor ?? (gradient != null ? null : colors.surfaceVariant);
    final fg = foregroundColor ??
        (gradient != null ? Colors.white : colors.textPrimary);
    final border = borderColor ?? colors.border;

    Widget chipContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderGradient == null
            ? Border.all(color: border, width: borderWidth)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: fg),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              color: fg,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    if (borderGradient != null) {
      chipContent = FlexGradientBorderBox(
        borderGradient: borderGradient!,
        borderWidth: borderWidth,
        borderRadius: BorderRadius.circular(borderRadius),
        child: chipContent,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: chipContent,
      ),
    );
  }
}

/// A selectable filter chip for toggling a selection state.
class FlexFilterChip extends StatelessWidget {
  const FlexFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
    this.activeColor,
    this.borderRadius = 16.0,
    this.gradient,
    this.selectedGradient,
    this.borderGradient,
    this.borderWidth,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final IconData? icon;
  final Color? activeColor;
  final double borderRadius;
  final Gradient? gradient;
  final Gradient? selectedGradient;
  final Gradient? borderGradient;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final active = activeColor ?? colors.primary;
    final effectiveWidth = borderWidth ?? (selected ? 1.5 : 1.0);
    final effectiveGradient =
        selected ? (selectedGradient ?? gradient) : gradient;

    Color? bg;
    Color fg;
    if (effectiveGradient != null && selected) {
      bg = null;
      fg = Colors.white;
    } else {
      bg = selected ? active.withValues(alpha: 0.12) : colors.surface;
      fg = selected ? active : colors.textPrimary;
    }

    Widget chipContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        gradient: effectiveGradient,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderGradient == null
            ? Border.all(
                color: selected ? active : colors.border,
                width: effectiveWidth,
              )
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selected) ...[
            Icon(Icons.check_rounded, size: 16, color: fg),
            const SizedBox(width: 6),
          ] else if (icon != null) ...[
            Icon(icon, size: 16, color: colors.textSecondary),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: theme.typography.labelMedium.copyWith(
              color: fg,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    if (borderGradient != null) {
      chipContent = FlexGradientBorderBox(
        borderGradient: borderGradient!,
        borderWidth: effectiveWidth,
        borderRadius: BorderRadius.circular(borderRadius),
        child: chipContent,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected(!selected),
        borderRadius: BorderRadius.circular(borderRadius),
        child: chipContent,
      ),
    );
  }
}

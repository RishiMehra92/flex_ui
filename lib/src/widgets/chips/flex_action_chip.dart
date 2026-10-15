import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

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
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final bg = backgroundColor ?? colors.surfaceVariant;
    final fg = foregroundColor ?? colors.textPrimary;
    final border = borderColor ?? colors.border;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: border),
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
        ),
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
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final IconData? icon;
  final Color? activeColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final active = activeColor ?? colors.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onSelected(!selected),
        borderRadius: BorderRadius.circular(borderRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? active.withValues(alpha: 0.12) : colors.surface,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: selected ? active : colors.border,
              width: selected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                Icon(Icons.check_rounded, size: 16, color: active),
                const SizedBox(width: 6),
              ] else if (icon != null) ...[
                Icon(icon, size: 16, color: colors.textSecondary),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: theme.typography.labelMedium.copyWith(
                  color: selected ? active : colors.textPrimary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A theme-aware horizontal divider, with optional centered label.
class FlexDivider extends StatelessWidget {
  const FlexDivider({
    super.key,
    this.label,
    this.color,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.spacing = 16.0,
  });

  /// Factory creating a divider with a centered label (e.g. "OR").
  const FlexDivider.withLabel({
    super.key,
    required String this.label,
    this.color,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.spacing = 16.0,
  });

  final String? label;
  final Color? color;
  final double thickness;
  final double indent;
  final double endIndent;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final dividerColor = color ?? theme.colors.divider;

    if (label != null) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: spacing / 2),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: dividerColor,
                thickness: thickness,
                indent: indent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label!,
                style: theme.typography.labelMedium.copyWith(
                  color: theme.colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: dividerColor,
                thickness: thickness,
                endIndent: endIndent,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing / 2),
      child: Divider(
        color: dividerColor,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}

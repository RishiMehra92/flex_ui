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
    this.gradient,
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
    this.gradient,
  });

  final String? label;
  final Color? color;
  final double thickness;
  final double indent;
  final double endIndent;
  final double spacing;
  final Gradient? gradient;

  Widget _buildLine(
      {required Color color, double indent = 0.0, double endIndent = 0.0}) {
    if (gradient != null) {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: indent, end: endIndent),
        child: Container(
          height: thickness,
          decoration: BoxDecoration(gradient: gradient),
        ),
      );
    }
    return Divider(
      color: color,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }

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
              child: _buildLine(
                color: dividerColor,
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
              child: _buildLine(
                color: dividerColor,
                endIndent: endIndent,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing / 2),
      child: _buildLine(
        color: dividerColor,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}

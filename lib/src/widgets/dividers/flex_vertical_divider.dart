import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A theme-aware vertical divider.
class FlexVerticalDivider extends StatelessWidget {
  const FlexVerticalDivider({
    super.key,
    this.color,
    this.thickness = 1.0,
    this.width = 16.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
  });

  final Color? color;
  final double thickness;
  final double width;
  final double indent;
  final double endIndent;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final dividerColor = color ?? theme.colors.divider;

    return VerticalDivider(
      color: dividerColor,
      thickness: thickness,
      width: width,
      indent: indent,
      endIndent: endIndent,
    );
  }
}

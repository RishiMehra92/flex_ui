import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A visual section grouping related form fields with a title and description.
class FlexFormSection extends StatelessWidget {
  const FlexFormSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
    this.spacing = 16.0,
    this.padding = EdgeInsets.zero,
  });

  final String title;
  final String? description;
  final List<Widget> children;
  final double spacing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.typography.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.textPrimary,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 4),
            Text(
              description!,
              style: theme.typography.bodySmall.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
          SizedBox(height: theme.spacing.md),
          ...children.map((child) => Padding(
                padding: EdgeInsets.only(bottom: spacing),
                child: child,
              )),
        ],
      ),
    );
  }
}

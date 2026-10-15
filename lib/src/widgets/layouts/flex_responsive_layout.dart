import 'package:flutter/material.dart';

/// Breakpoint width values.
class FlexBreakpoints {
  const FlexBreakpoints._();

  static const double compact = 600.0;
  static const double medium = 840.0;
  static const double expanded = 1200.0;
}

/// A responsive layout builder rendering appropriate views based on screen width.
class FlexResponsiveLayout extends StatelessWidget {
  const FlexResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
  });

  /// View for small/compact screens (< 600px).
  final Widget compact;

  /// View for medium/tablet screens (600px - 840px). Falls back to [compact].
  final Widget? medium;

  /// View for large/desktop screens (>= 840px). Falls back to [medium] or [compact].
  final Widget? expanded;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (width >= FlexBreakpoints.medium && expanded != null) {
          return expanded!;
        }
        if (width >= FlexBreakpoints.compact && medium != null) {
          return medium!;
        }
        return compact;
      },
    );
  }
}

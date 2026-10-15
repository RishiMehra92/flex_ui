import 'package:flutter/material.dart';

/// A [Column] that automatically inserts consistent [spacing] between children.
class FlexSpacedColumn extends StatelessWidget {
  const FlexSpacedColumn({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> children;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    if (children.length == 1) return children.first;

    final spacedChildren = <Widget>[];
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(height: spacing));
      }
    }

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: spacedChildren,
    );
  }
}

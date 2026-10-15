import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A shimmering placeholder skeleton loader for content placeholders.
class FlexSkeleton extends StatefulWidget {
  const FlexSkeleton({
    super.key,
    this.width,
    this.height = 16.0,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
  });

  /// Factory creating a circular avatar skeleton.
  const FlexSkeleton.circle({
    super.key,
    required double size,
    this.baseColor,
    this.highlightColor,
  })  : width = size,
        height = size,
        borderRadius = size / 2;

  final double? width;
  final double height;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  @override
  State<FlexSkeleton> createState() => _FlexSkeletonState();
}

class _FlexSkeletonState extends State<FlexSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final defaultBase = colors.surfaceVariant;
    final defaultHighlight = colors.border;

    final base = widget.baseColor ?? defaultBase;
    final highlight = widget.highlightColor ?? defaultHighlight;
    final radius = widget.borderRadius ?? theme.radius.sm;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Color.lerp(base, highlight, _animation.value),
            borderRadius: BorderRadius.circular(radius),
          ),
        );
      },
    );
  }
}

/// A multi-item skeleton placeholder representing a list of cards or rows.
class FlexSkeletonList extends StatelessWidget {
  const FlexSkeletonList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 72.0,
    this.spacing = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius,
  });

  final int itemCount;
  final double itemHeight;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: spacing),
      itemBuilder: (_, __) => FlexSkeleton(
        height: itemHeight,
        borderRadius: borderRadius,
      ),
    );
  }
}

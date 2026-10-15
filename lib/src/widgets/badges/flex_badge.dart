import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// A notification count badge or status indicator that can wrap a child widget.
class FlexBadge extends StatelessWidget {
  const FlexBadge({
    super.key,
    this.child,
    this.label,
    this.count,
    this.maxCount = 99,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.showBadge = true,
    this.smallDot = false,
    this.gradient,
    this.borderGradient,
  });

  final Widget? child;
  final String? label;
  final int? count;
  final int maxCount;
  final Color? backgroundColor;
  final Color textColor;
  final bool showBadge;
  final bool smallDot;
  final Gradient? gradient;
  final Gradient? borderGradient;

  @override
  Widget build(BuildContext context) {
    if (!showBadge) return child ?? const SizedBox.shrink();

    final theme = FlexUITheme.of(context);
    final bg =
        backgroundColor ?? (gradient != null ? null : theme.colors.error);

    String displayText = '';
    if (label != null) {
      displayText = label!;
    } else if (count != null) {
      displayText = count! > maxCount ? '$maxCount+' : '$count';
    }

    Widget badgeWidget;
    if (smallDot) {
      badgeWidget = Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          color: bg,
          gradient: gradient,
          shape: BoxShape.circle,
          border: borderGradient == null
              ? Border.all(color: theme.colors.surface, width: 1.5)
              : null,
        ),
      );
    } else {
      badgeWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
        decoration: BoxDecoration(
          color: bg,
          gradient: gradient,
          borderRadius: BorderRadius.circular(10),
          border: borderGradient == null
              ? Border.all(color: theme.colors.surface, width: 1.5)
              : null,
        ),
        child: Center(
          child: Text(
            displayText,
            style: TextStyle(
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
      );
    }

    if (borderGradient != null) {
      badgeWidget = CustomPaint(
        painter: FlexGradientBorderPainter(
          gradient: borderGradient!,
          borderWidth: 1.5,
          borderRadius: smallDot ? null : BorderRadius.circular(10),
          shape: smallDot ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: badgeWidget,
      );
    }

    if (child == null) return badgeWidget;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        Positioned(
          top: -4,
          right: -4,
          child: badgeWidget,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// Shows a dialog configured with Flex UI theming and animations.
Future<T?> showFlexDialog<T>({
  required BuildContext context,
  required Widget child,
  bool barrierDismissible = true,
  Color? barrierColor,
  RouteTransitionsBuilder? transitionBuilder,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
    builder: (ctx) => child,
  );
}

/// A standard dialog container with title, content, and action buttons.
class FlexDialog extends StatelessWidget {
  const FlexDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.icon,
    this.iconColor,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.maxWidth = 420.0,
  });

  final String? title;
  final Widget? content;
  final List<Widget>? actions;
  final IconData? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final dialogTheme = theme.dialogTheme;

    final effectiveRadius = borderRadius ?? dialogTheme.borderRadius;
    final effectivePadding = padding ?? dialogTheme.padding;
    final effectiveBackground = backgroundColor ?? colors.dialogBackground;

    return Dialog(
      backgroundColor: effectiveBackground,
      elevation: dialogTheme.elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: effectivePadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (icon != null) ...[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          (iconColor ?? colors.primary).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? colors.primary,
                      size: 26,
                    ),
                  ),
                ),
                SizedBox(height: theme.spacing.md),
              ],
              if (title != null) ...[
                Text(
                  title!,
                  textAlign: icon != null ? TextAlign.center : TextAlign.start,
                  style: theme.typography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: theme.spacing.sm),
              ],
              if (content != null) ...[
                DefaultTextStyle(
                  style: theme.typography.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                  child: content!,
                ),
              ],
              if (actions != null && actions!.isNotEmpty) ...[
                SizedBox(height: theme.spacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!
                      .map((action) => Padding(
                            padding: EdgeInsets.only(left: theme.spacing.xs),
                            child: action,
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

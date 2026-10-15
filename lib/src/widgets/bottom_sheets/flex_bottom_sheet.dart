import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// Shows a modal bottom sheet with Flex UI styling and rounded top corners.
Future<T?> showFlexBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
  bool enableDrag = true,
  bool isScrollControlled = true,
  Color? barrierColor,
  Color? backgroundColor,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    backgroundColor: Colors.transparent,
    barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
    builder: (ctx) => child,
  );
}

/// A standard bottom sheet container with drag handle, title, and customizable content.
class FlexBottomSheet extends StatelessWidget {
  const FlexBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.showDragHandle,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
  });

  final Widget child;
  final String? title;
  final bool? showDragHandle;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final sheetTheme = theme.bottomSheetTheme;

    final effectiveRadius = borderRadius ?? sheetTheme.borderRadius;
    final effectivePadding = padding ?? sheetTheme.padding;
    final effectiveBackground = backgroundColor ?? colors.bottomSheetBackground;
    final bool effectiveDragHandle =
        showDragHandle ?? sheetTheme.showDragHandle;

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(effectiveRadius),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (effectiveDragHandle) ...[
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(top: 10, bottom: 8),
                  decoration: BoxDecoration(
                    color: sheetTheme.dragHandleColor ?? colors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
            if (title != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                child: Text(
                  title!,
                  style: theme.typography.titleLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              Divider(height: 1, color: colors.divider),
            ],
            Padding(
              padding: effectivePadding,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

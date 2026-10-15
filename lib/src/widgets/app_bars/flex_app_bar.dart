import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// An accessible, theme-styled app bar supporting custom actions, leading widgets,
/// and tab attachments.
class FlexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FlexAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0.0,
    this.bottom,
    this.toolbarHeight = kToolbarHeight,
    this.automaticallyImplyLeading = true,
  });

  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final double toolbarHeight;
  final bool automaticallyImplyLeading;

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveBg = backgroundColor ?? colors.surface;
    final effectiveFg = foregroundColor ?? colors.textPrimary;

    Widget? resolvedTitle = titleWidget;
    if (resolvedTitle == null && title != null) {
      resolvedTitle = Text(
        title!,
        style: theme.typography.titleLarge.copyWith(
          color: effectiveFg,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    return AppBar(
      title: resolvedTitle,
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: effectiveBg,
      foregroundColor: effectiveFg,
      elevation: elevation,
      bottom: bottom,
      toolbarHeight: toolbarHeight,
      automaticallyImplyLeading: automaticallyImplyLeading,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withValues(alpha: 0.1),
    );
  }
}

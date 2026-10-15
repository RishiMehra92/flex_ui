import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// Tab style indicator.
enum FlexTabIndicatorStyle {
  pill,
  underline,
}

/// A theme-aware tab bar widget implementing [PreferredSizeWidget].
class FlexTabBar extends StatelessWidget implements PreferredSizeWidget {
  const FlexTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.indicatorStyle = FlexTabIndicatorStyle.underline,
    this.isScrollable = false,
    this.onTap,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
  });

  final List<Widget> tabs;
  final TabController? controller;
  final FlexTabIndicatorStyle indicatorStyle;
  final bool isScrollable;
  final ValueChanged<int>? onTap;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor;

  @override
  Size get preferredSize => const Size.fromHeight(48.0);

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final activeColor = labelColor ?? colors.primary;
    final inactiveColor = unselectedLabelColor ?? colors.textSecondary;
    final indColor = indicatorColor ?? colors.primary;

    Decoration decoration;
    if (indicatorStyle == FlexTabIndicatorStyle.pill) {
      decoration = BoxDecoration(
        color: indColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      );
    } else {
      decoration = UnderlineTabIndicator(
        borderSide: BorderSide(color: indColor, width: 2.5),
      );
    }

    return TabBar(
      controller: controller,
      tabs: tabs,
      isScrollable: isScrollable,
      onTap: onTap,
      labelColor: activeColor,
      unselectedLabelColor: inactiveColor,
      indicator: decoration,
      indicatorSize: indicatorStyle == FlexTabIndicatorStyle.pill
          ? TabBarIndicatorSize.tab
          : TabBarIndicatorSize.label,
      labelStyle:
          theme.typography.labelLarge.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle:
          theme.typography.labelLarge.copyWith(fontWeight: FontWeight.w500),
      dividerColor: Colors.transparent,
    );
  }
}

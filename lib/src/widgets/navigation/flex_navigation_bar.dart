import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../badges/flex_badge.dart';

/// An item in [FlexNavigationBar].
class FlexNavigationItem {
  const FlexNavigationItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.badgeCount,
    this.showBadge = false,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final int? badgeCount;
  final bool showBadge;
}

/// A modern bottom navigation bar supporting badges, smooth active item indicators,
/// and theme-consistent colors.
class FlexNavigationBar extends StatelessWidget {
  const FlexNavigationBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
  });

  final List<FlexNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final bg = backgroundColor ?? colors.surface;
    final selectedColor = selectedItemColor ?? colors.primary;
    final unselectedColor = unselectedItemColor ?? colors.hint;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        border: Border(top: BorderSide(color: colors.border)),
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: elevation,
                  offset: const Offset(0, -2),
                ),
              ]
            : null,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == currentIndex;

              Widget iconWidget = Icon(
                isSelected ? (item.activeIcon ?? item.icon) : item.icon,
                color: isSelected ? selectedColor : unselectedColor,
                size: 24,
              );

              if (item.showBadge || item.badgeCount != null) {
                iconWidget = FlexBadge(
                  count: item.badgeCount,
                  showBadge: true,
                  smallDot: item.badgeCount == null,
                  child: iconWidget,
                );
              }

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconWidget,
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: isSelected ? selectedColor : unselectedColor,
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

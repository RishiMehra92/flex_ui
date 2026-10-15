import 'package:flutter/material.dart';
import '../config/flex_ui_theme.dart';
import '../theme/flex_colors.dart';
import '../theme/flex_spacing.dart';
import '../theme/flex_radius.dart';
import '../theme/flex_typography.dart';
import '../theme/flex_theme_data.dart';

/// Extension methods on [BuildContext] for convenient access to Flex UI theme tokens.
extension FlexBuildContextExtensions on BuildContext {
  /// The active [FlexUIThemeData].
  FlexUIThemeData get flexTheme => FlexUITheme.of(this);

  /// Semantic colors from Flex UI.
  FlexColors get flexColors => flexTheme.colors;

  /// Spacing scale from Flex UI.
  FlexSpacing get flexSpacing => flexTheme.spacing;

  /// Radius scale from Flex UI.
  FlexRadius get flexRadius => flexTheme.radius;

  /// Typography scale from Flex UI.
  FlexTypography get flexTypography => flexTheme.typography;

  /// Whether the current theme is dark.
  bool get isFlexDark => flexTheme.isDark;

  /// Screen size shortcuts.
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  /// Responsive helpers.
  bool get isCompact => screenWidth < 600;
  bool get isMedium => screenWidth >= 600 && screenWidth < 840;
  bool get isExpanded => screenWidth >= 840;
}

import 'package:flutter/material.dart';
import '../theme/flex_theme_data.dart';

/// An InheritedWidget that provides [FlexUIThemeData] down the widget tree.
class FlexUITheme extends InheritedTheme {
  const FlexUITheme({
    super.key,
    required this.data,
    required super.child,
  });

  final FlexUIThemeData data;

  /// Retrieves the nearest [FlexUIThemeData] in the widget tree,
  /// falling back to [Theme.of(context).extension<FlexUIThemeData>()],
  /// or [FlexUIThemeData.light()] if none is defined.
  static FlexUIThemeData of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<FlexUITheme>();
    if (inherited != null) {
      return inherited.data;
    }

    final extensionTheme = Theme.of(context).extension<FlexUIThemeData>();
    if (extensionTheme != null) {
      return extensionTheme;
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? FlexUIThemeData.dark() : FlexUIThemeData.light();
  }

  @override
  bool updateShouldNotify(FlexUITheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlexUITheme(data: data, child: child);
  }
}

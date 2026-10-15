import 'package:flutter/material.dart';
import '../theme/flex_theme_data.dart';

/// Extension methods on [ThemeData] for seamlessly embedding Flex UI.
extension FlexThemeDataExtensions on ThemeData {
  /// Returns a new [ThemeData] with the provided [FlexUIThemeData] registered
  /// as a [ThemeExtension].
  ThemeData withFlexUI(FlexUIThemeData flexTheme) {
    return copyWith(
      extensions: [
        ...extensions.values.where((e) => e is! FlexUIThemeData),
        flexTheme,
      ],
    );
  }

  /// Retrieves the [FlexUIThemeData] registered in this [ThemeData], if any.
  FlexUIThemeData? get flexUI => extension<FlexUIThemeData>();
}

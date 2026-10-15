import 'package:flutter/material.dart';
import 'flex_colors.dart';
import 'flex_spacing.dart';
import 'flex_radius.dart';
import 'flex_typography.dart';
import 'flex_component_themes.dart';

/// Comprehensive theme data configuration for Flex UI.
///
/// Can be used as a Flutter [ThemeExtension] or via [FlexUITheme].
class FlexUIThemeData extends ThemeExtension<FlexUIThemeData> {
  const FlexUIThemeData({
    required this.brightness,
    required this.colors,
    required this.spacing,
    required this.radius,
    required this.typography,
    required this.buttonTheme,
    required this.inputTheme,
    required this.cardTheme,
    required this.dialogTheme,
    required this.bottomSheetTheme,
  });

  /// Light theme configuration.
  factory FlexUIThemeData.light({
    FlexColors? colors,
    FlexSpacing? spacing,
    FlexRadius? radius,
    FlexTypography? typography,
    FlexButtonThemeData? buttonTheme,
    FlexInputThemeData? inputTheme,
    FlexCardThemeData? cardTheme,
    FlexDialogThemeData? dialogTheme,
    FlexBottomSheetThemeData? bottomSheetTheme,
    String? fontFamily,
  }) {
    final effectiveColors = colors ?? FlexColors.light();
    final effectiveSpacing = spacing ?? const FlexSpacing();
    final effectiveRadius = radius ?? const FlexRadius();
    final effectiveTypography = typography ??
        FlexTypography.fromColors(
          primaryText: effectiveColors.textPrimary,
          secondaryText: effectiveColors.textSecondary,
          fontFamily: fontFamily,
        );

    return FlexUIThemeData(
      brightness: Brightness.light,
      colors: effectiveColors,
      spacing: effectiveSpacing,
      radius: effectiveRadius,
      typography: effectiveTypography,
      buttonTheme: buttonTheme ?? const FlexButtonThemeData(),
      inputTheme: inputTheme ?? const FlexInputThemeData(),
      cardTheme: cardTheme ?? const FlexCardThemeData(),
      dialogTheme: dialogTheme ?? const FlexDialogThemeData(),
      bottomSheetTheme: bottomSheetTheme ?? const FlexBottomSheetThemeData(),
    );
  }

  /// Dark theme configuration.
  factory FlexUIThemeData.dark({
    FlexColors? colors,
    FlexSpacing? spacing,
    FlexRadius? radius,
    FlexTypography? typography,
    FlexButtonThemeData? buttonTheme,
    FlexInputThemeData? inputTheme,
    FlexCardThemeData? cardTheme,
    FlexDialogThemeData? dialogTheme,
    FlexBottomSheetThemeData? bottomSheetTheme,
    String? fontFamily,
  }) {
    final effectiveColors = colors ?? FlexColors.dark();
    final effectiveSpacing = spacing ?? const FlexSpacing();
    final effectiveRadius = radius ?? const FlexRadius();
    final effectiveTypography = typography ??
        FlexTypography.fromColors(
          primaryText: effectiveColors.textPrimary,
          secondaryText: effectiveColors.textSecondary,
          fontFamily: fontFamily,
        );

    return FlexUIThemeData(
      brightness: Brightness.dark,
      colors: effectiveColors,
      spacing: effectiveSpacing,
      radius: effectiveRadius,
      typography: effectiveTypography,
      buttonTheme: buttonTheme ?? const FlexButtonThemeData(),
      inputTheme: inputTheme ?? const FlexInputThemeData(),
      cardTheme: cardTheme ?? const FlexCardThemeData(),
      dialogTheme: dialogTheme ?? const FlexDialogThemeData(),
      bottomSheetTheme: bottomSheetTheme ?? const FlexBottomSheetThemeData(),
    );
  }

  final Brightness brightness;
  final FlexColors colors;
  final FlexSpacing spacing;
  final FlexRadius radius;
  final FlexTypography typography;
  final FlexButtonThemeData buttonTheme;
  final FlexInputThemeData inputTheme;
  final FlexCardThemeData cardTheme;
  final FlexDialogThemeData dialogTheme;
  final FlexBottomSheetThemeData bottomSheetTheme;

  bool get isDark => brightness == Brightness.dark;

  @override
  FlexUIThemeData copyWith({
    Brightness? brightness,
    FlexColors? colors,
    FlexSpacing? spacing,
    FlexRadius? radius,
    FlexTypography? typography,
    FlexButtonThemeData? buttonTheme,
    FlexInputThemeData? inputTheme,
    FlexCardThemeData? cardTheme,
    FlexDialogThemeData? dialogTheme,
    FlexBottomSheetThemeData? bottomSheetTheme,
  }) {
    return FlexUIThemeData(
      brightness: brightness ?? this.brightness,
      colors: colors ?? this.colors,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      typography: typography ?? this.typography,
      buttonTheme: buttonTheme ?? this.buttonTheme,
      inputTheme: inputTheme ?? this.inputTheme,
      cardTheme: cardTheme ?? this.cardTheme,
      dialogTheme: dialogTheme ?? this.dialogTheme,
      bottomSheetTheme: bottomSheetTheme ?? this.bottomSheetTheme,
    );
  }

  @override
  FlexUIThemeData lerp(
    covariant ThemeExtension<FlexUIThemeData>? other,
    double t,
  ) {
    if (other is! FlexUIThemeData) {
      return this;
    }

    return FlexUIThemeData(
      brightness: t < 0.5 ? brightness : other.brightness,
      colors: FlexColors.lerp(colors, other.colors, t),
      spacing: FlexSpacing.lerp(spacing, other.spacing, t),
      radius: FlexRadius.lerp(radius, other.radius, t),
      typography: FlexTypography.lerp(typography, other.typography, t),
      buttonTheme: FlexButtonThemeData.lerp(buttonTheme, other.buttonTheme, t),
      inputTheme: FlexInputThemeData.lerp(inputTheme, other.inputTheme, t),
      cardTheme: FlexCardThemeData.lerp(cardTheme, other.cardTheme, t),
      dialogTheme: FlexDialogThemeData.lerp(dialogTheme, other.dialogTheme, t),
      bottomSheetTheme: FlexBottomSheetThemeData.lerp(
          bottomSheetTheme, other.bottomSheetTheme, t),
    );
  }
}

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
    Gradient? primaryGradient,
    Gradient? secondaryGradient,
    Gradient? accentGradient,
    double? borderRadius,
    double? borderWidth,
  }) {
    var effectiveColors = colors ?? FlexColors.light();
    if (primaryGradient != null ||
        secondaryGradient != null ||
        accentGradient != null) {
      effectiveColors = effectiveColors.copyWith(
        primaryGradient: primaryGradient,
        secondaryGradient: secondaryGradient,
        accentGradient: accentGradient,
      );
    }

    var effectiveRadius = radius ?? const FlexRadius();
    if (borderRadius != null) {
      effectiveRadius = effectiveRadius.copyWith(md: borderRadius);
    }

    final effectiveTypography = typography ??
        FlexTypography.fromColors(
          primaryText: effectiveColors.textPrimary,
          secondaryText: effectiveColors.textSecondary,
          fontFamily: fontFamily,
        );

    var effectiveButtonTheme = buttonTheme ?? const FlexButtonThemeData();
    if (borderRadius != null) {
      effectiveButtonTheme =
          effectiveButtonTheme.copyWith(borderRadius: borderRadius);
    }
    if (borderWidth != null) {
      effectiveButtonTheme =
          effectiveButtonTheme.copyWith(borderWidth: borderWidth);
    }

    var effectiveInputTheme = inputTheme ?? const FlexInputThemeData();
    if (borderRadius != null) {
      effectiveInputTheme =
          effectiveInputTheme.copyWith(borderRadius: borderRadius);
    }
    if (borderWidth != null) {
      effectiveInputTheme =
          effectiveInputTheme.copyWith(borderWidth: borderWidth);
    }

    var effectiveCardTheme = cardTheme ?? const FlexCardThemeData();
    if (borderRadius != null) {
      effectiveCardTheme =
          effectiveCardTheme.copyWith(borderRadius: borderRadius);
    }
    if (borderWidth != null) {
      effectiveCardTheme =
          effectiveCardTheme.copyWith(borderWidth: borderWidth);
    }

    return FlexUIThemeData(
      brightness: Brightness.light,
      colors: effectiveColors,
      spacing: spacing ?? const FlexSpacing(),
      radius: effectiveRadius,
      typography: effectiveTypography,
      buttonTheme: effectiveButtonTheme,
      inputTheme: effectiveInputTheme,
      cardTheme: effectiveCardTheme,
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
    Gradient? primaryGradient,
    Gradient? secondaryGradient,
    Gradient? accentGradient,
    double? borderRadius,
    double? borderWidth,
  }) {
    var effectiveColors = colors ?? FlexColors.dark();
    if (primaryGradient != null ||
        secondaryGradient != null ||
        accentGradient != null) {
      effectiveColors = effectiveColors.copyWith(
        primaryGradient: primaryGradient,
        secondaryGradient: secondaryGradient,
        accentGradient: accentGradient,
      );
    }

    var effectiveRadius = radius ?? const FlexRadius();
    if (borderRadius != null) {
      effectiveRadius = effectiveRadius.copyWith(md: borderRadius);
    }

    final effectiveTypography = typography ??
        FlexTypography.fromColors(
          primaryText: effectiveColors.textPrimary,
          secondaryText: effectiveColors.textSecondary,
          fontFamily: fontFamily,
        );

    var effectiveButtonTheme = buttonTheme ?? const FlexButtonThemeData();
    if (borderRadius != null) {
      effectiveButtonTheme =
          effectiveButtonTheme.copyWith(borderRadius: borderRadius);
    }
    if (borderWidth != null) {
      effectiveButtonTheme =
          effectiveButtonTheme.copyWith(borderWidth: borderWidth);
    }

    var effectiveInputTheme = inputTheme ?? const FlexInputThemeData();
    if (borderRadius != null) {
      effectiveInputTheme =
          effectiveInputTheme.copyWith(borderRadius: borderRadius);
    }
    if (borderWidth != null) {
      effectiveInputTheme =
          effectiveInputTheme.copyWith(borderWidth: borderWidth);
    }

    var effectiveCardTheme = cardTheme ?? const FlexCardThemeData();
    if (borderRadius != null) {
      effectiveCardTheme =
          effectiveCardTheme.copyWith(borderRadius: borderRadius);
    }
    if (borderWidth != null) {
      effectiveCardTheme =
          effectiveCardTheme.copyWith(borderWidth: borderWidth);
    }

    return FlexUIThemeData(
      brightness: Brightness.dark,
      colors: effectiveColors,
      spacing: spacing ?? const FlexSpacing(),
      radius: effectiveRadius,
      typography: effectiveTypography,
      buttonTheme: effectiveButtonTheme,
      inputTheme: effectiveInputTheme,
      cardTheme: effectiveCardTheme,
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

  /// Primary gradient defined in the current color scheme.
  Gradient? get primaryGradient => colors.primaryGradient;

  /// Secondary gradient defined in the current color scheme.
  Gradient? get secondaryGradient => colors.secondaryGradient;

  /// Accent gradient defined in the current color scheme.
  Gradient? get accentGradient => colors.accentGradient;

  /// Default border radius value from [radius.md].
  double get defaultBorderRadius => radius.md;

  /// Default border width value from [inputTheme.borderWidth].
  double get defaultBorderWidth => inputTheme.borderWidth;

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

import 'package:flutter/material.dart';

/// Typography definitions for Flex UI components.
///
/// Designed to work seamlessly with system fonts, custom fonts, or Google Fonts.
class FlexTypography {
  const FlexTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    this.fontFamily,
  });

  /// Factory creating default typography for light or dark mode.
  factory FlexTypography.fromColors({
    required Color primaryText,
    required Color secondaryText,
    String? fontFamily,
  }) {
    TextStyle base(double size, FontWeight weight, Color color,
        {double? height, double? letterSpacing}) {
      return TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
      );
    }

    return FlexTypography(
      fontFamily: fontFamily,
      displayLarge: base(40, FontWeight.w800, primaryText,
          height: 1.2, letterSpacing: -0.5),
      displayMedium: base(32, FontWeight.w700, primaryText,
          height: 1.25, letterSpacing: -0.5),
      displaySmall: base(28, FontWeight.w700, primaryText, height: 1.3),
      headlineLarge: base(24, FontWeight.w700, primaryText, height: 1.3),
      headlineMedium: base(20, FontWeight.w600, primaryText, height: 1.35),
      headlineSmall: base(18, FontWeight.w600, primaryText, height: 1.4),
      titleLarge: base(18, FontWeight.w600, primaryText, height: 1.4),
      titleMedium: base(16, FontWeight.w600, primaryText, height: 1.45),
      titleSmall: base(14, FontWeight.w600, primaryText, height: 1.45),
      bodyLarge: base(16, FontWeight.w400, primaryText, height: 1.5),
      bodyMedium: base(14, FontWeight.w400, primaryText, height: 1.5),
      bodySmall: base(12, FontWeight.w400, secondaryText, height: 1.5),
      labelLarge: base(14, FontWeight.w600, primaryText, letterSpacing: 0.1),
      labelMedium: base(12, FontWeight.w500, secondaryText, letterSpacing: 0.2),
      labelSmall: base(10, FontWeight.w500, secondaryText, letterSpacing: 0.3),
    );
  }

  final String? fontFamily;
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  FlexTypography copyWith({
    String? fontFamily,
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) {
    return FlexTypography(
      fontFamily: fontFamily ?? this.fontFamily,
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  static FlexTypography lerp(FlexTypography a, FlexTypography b, double t) {
    return FlexTypography(
      fontFamily: t < 0.5 ? a.fontFamily : b.fontFamily,
      displayLarge:
          TextStyle.lerp(a.displayLarge, b.displayLarge, t) ?? a.displayLarge,
      displayMedium: TextStyle.lerp(a.displayMedium, b.displayMedium, t) ??
          a.displayMedium,
      displaySmall:
          TextStyle.lerp(a.displaySmall, b.displaySmall, t) ?? a.displaySmall,
      headlineLarge: TextStyle.lerp(a.headlineLarge, b.headlineLarge, t) ??
          a.headlineLarge,
      headlineMedium: TextStyle.lerp(a.headlineMedium, b.headlineMedium, t) ??
          a.headlineMedium,
      headlineSmall: TextStyle.lerp(a.headlineSmall, b.headlineSmall, t) ??
          a.headlineSmall,
      titleLarge: TextStyle.lerp(a.titleLarge, b.titleLarge, t) ?? a.titleLarge,
      titleMedium:
          TextStyle.lerp(a.titleMedium, b.titleMedium, t) ?? a.titleMedium,
      titleSmall: TextStyle.lerp(a.titleSmall, b.titleSmall, t) ?? a.titleSmall,
      bodyLarge: TextStyle.lerp(a.bodyLarge, b.bodyLarge, t) ?? a.bodyLarge,
      bodyMedium: TextStyle.lerp(a.bodyMedium, b.bodyMedium, t) ?? a.bodyMedium,
      bodySmall: TextStyle.lerp(a.bodySmall, b.bodySmall, t) ?? a.bodySmall,
      labelLarge: TextStyle.lerp(a.labelLarge, b.labelLarge, t) ?? a.labelLarge,
      labelMedium:
          TextStyle.lerp(a.labelMedium, b.labelMedium, t) ?? a.labelMedium,
      labelSmall: TextStyle.lerp(a.labelSmall, b.labelSmall, t) ?? a.labelSmall,
    );
  }
}

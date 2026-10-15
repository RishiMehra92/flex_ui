import 'package:flutter/material.dart';

/// Semantic color palette for Flex UI components.
///
/// Supports both light and dark mode variants, custom customization,
/// and smooth theme transitions via [lerp].
class FlexColors {
  const FlexColors({
    required this.primary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryContainer,
    required this.accent,
    required this.surface,
    required this.surfaceVariant,
    required this.background,
    required this.border,
    required this.borderFocused,
    required this.divider,
    required this.textPrimary,
    required this.textSecondary,
    required this.hint,
    required this.disabled,
    required this.disabledText,
    required this.error,
    required this.errorContainer,
    required this.success,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.info,
    required this.infoContainer,
    required this.cardBackground,
    required this.dialogBackground,
    required this.bottomSheetBackground,
    this.primaryGradient,
    this.secondaryGradient,
    this.accentGradient,
    this.backgroundGradient,
    this.surfaceGradient,
  });

  /// Default light color scheme.
  factory FlexColors.light() {
    return const FlexColors(
      primary: Color(0xFF2563EB), // Blue 600
      primaryContainer: Color(0xFFDBEAFE),
      secondary: Color(0xFF4F46E5), // Indigo 600
      secondaryContainer: Color(0xFFE0E7FF),
      accent: Color(0xFF06B6D4), // Cyan 500
      surface: Color(0xFFFFFFFF),
      surfaceVariant: Color(0xFFF3F4F6), // Gray 100
      background: Color(0xFFF9FAFB), // Gray 50
      border: Color(0xFFE5E7EB), // Gray 200
      borderFocused: Color(0xFF2563EB),
      divider: Color(0xFFE5E7EB),
      textPrimary: Color(0xFF111827), // Gray 900
      textSecondary: Color(0xFF4B5563), // Gray 600
      hint: Color(0xFF9CA3AF), // Gray 400
      disabled: Color(0xFFE5E7EB),
      disabledText: Color(0xFF9CA3AF),
      error: Color(0xFFDC2626), // Red 600
      errorContainer: Color(0xFFFEE2E2),
      success: Color(0xFF16A34A), // Green 600
      successContainer: Color(0xFFDCFCE7),
      warning: Color(0xFFD97706), // Amber 600
      warningContainer: Color(0xFFFEF3C7),
      info: Color(0xFF0284C7), // Sky 600
      infoContainer: Color(0xFFE0F2FE),
      cardBackground: Color(0xFFFFFFFF),
      dialogBackground: Color(0xFFFFFFFF),
      bottomSheetBackground: Color(0xFFFFFFFF),
      primaryGradient: LinearGradient(
        colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondaryGradient: LinearGradient(
        colors: [Color(0xFF4F46E5), Color(0xFF4338CA)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentGradient: LinearGradient(
        colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  /// Default dark color scheme.
  factory FlexColors.dark() {
    return const FlexColors(
      primary: Color(0xFF3B82F6), // Blue 500
      primaryContainer: Color(0xFF1E3A8A),
      secondary: Color(0xFF6366F1), // Indigo 500
      secondaryContainer: Color(0xFF312E81),
      accent: Color(0xFF22D3EE), // Cyan 400
      surface: Color(0xFF1F2937), // Gray 800
      surfaceVariant: Color(0xFF374151), // Gray 700
      background: Color(0xFF111827), // Gray 900
      border: Color(0xFF374151), // Gray 700
      borderFocused: Color(0xFF3B82F6),
      divider: Color(0xFF374151),
      textPrimary: Color(0xFFF9FAFB), // Gray 50
      textSecondary: Color(0xFF9CA3AF), // Gray 400
      hint: Color(0xFF6B7280), // Gray 500
      disabled: Color(0xFF374151),
      disabledText: Color(0xFF6B7280),
      error: Color(0xFFEF4444), // Red 500
      errorContainer: Color(0xFF7F1D1D),
      success: Color(0xFF22C55E), // Green 500
      successContainer: Color(0xFF14532D),
      warning: Color(0xFFF59E0B), // Amber 500
      warningContainer: Color(0xFF78350F),
      info: Color(0xFF38BDF8), // Sky 400
      infoContainer: Color(0xFF0C4A6E),
      cardBackground: Color(0xFF1F2937),
      dialogBackground: Color(0xFF1F2937),
      bottomSheetBackground: Color(0xFF1F2937),
      primaryGradient: LinearGradient(
        colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      secondaryGradient: LinearGradient(
        colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentGradient: LinearGradient(
        colors: [Color(0xFF22D3EE), Color(0xFF06B6D4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  final Color primary;
  final Color primaryContainer;
  final Color secondary;
  final Color secondaryContainer;
  final Color accent;
  final Color surface;
  final Color surfaceVariant;
  final Color background;
  final Color border;
  final Color borderFocused;
  final Color divider;
  final Color textPrimary;
  final Color textSecondary;
  final Color hint;
  final Color disabled;
  final Color disabledText;
  final Color error;
  final Color errorContainer;
  final Color success;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color info;
  final Color infoContainer;
  final Color cardBackground;
  final Color dialogBackground;
  final Color bottomSheetBackground;
  final Gradient? primaryGradient;
  final Gradient? secondaryGradient;
  final Gradient? accentGradient;
  final Gradient? backgroundGradient;
  final Gradient? surfaceGradient;

  FlexColors copyWith({
    Color? primary,
    Color? primaryContainer,
    Color? secondary,
    Color? secondaryContainer,
    Color? accent,
    Color? surface,
    Color? surfaceVariant,
    Color? background,
    Color? border,
    Color? borderFocused,
    Color? divider,
    Color? textPrimary,
    Color? textSecondary,
    Color? hint,
    Color? disabled,
    Color? disabledText,
    Color? error,
    Color? errorContainer,
    Color? success,
    Color? successContainer,
    Color? warning,
    Color? warningContainer,
    Color? info,
    Color? infoContainer,
    Color? cardBackground,
    Color? dialogBackground,
    Color? bottomSheetBackground,
    Gradient? primaryGradient,
    Gradient? secondaryGradient,
    Gradient? accentGradient,
    Gradient? backgroundGradient,
    Gradient? surfaceGradient,
  }) {
    return FlexColors(
      primary: primary ?? this.primary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      secondary: secondary ?? this.secondary,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      accent: accent ?? this.accent,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      background: background ?? this.background,
      border: border ?? this.border,
      borderFocused: borderFocused ?? this.borderFocused,
      divider: divider ?? this.divider,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      hint: hint ?? this.hint,
      disabled: disabled ?? this.disabled,
      disabledText: disabledText ?? this.disabledText,
      error: error ?? this.error,
      errorContainer: errorContainer ?? this.errorContainer,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      warning: warning ?? this.warning,
      warningContainer: warningContainer ?? this.warningContainer,
      info: info ?? this.info,
      infoContainer: infoContainer ?? this.infoContainer,
      cardBackground: cardBackground ?? this.cardBackground,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      bottomSheetBackground:
          bottomSheetBackground ?? this.bottomSheetBackground,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      secondaryGradient: secondaryGradient ?? this.secondaryGradient,
      accentGradient: accentGradient ?? this.accentGradient,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      surfaceGradient: surfaceGradient ?? this.surfaceGradient,
    );
  }

  static FlexColors lerp(FlexColors a, FlexColors b, double t) {
    return FlexColors(
      primary: Color.lerp(a.primary, b.primary, t) ?? a.primary,
      primaryContainer: Color.lerp(a.primaryContainer, b.primaryContainer, t) ??
          a.primaryContainer,
      secondary: Color.lerp(a.secondary, b.secondary, t) ?? a.secondary,
      secondaryContainer:
          Color.lerp(a.secondaryContainer, b.secondaryContainer, t) ??
              a.secondaryContainer,
      accent: Color.lerp(a.accent, b.accent, t) ?? a.accent,
      surface: Color.lerp(a.surface, b.surface, t) ?? a.surface,
      surfaceVariant:
          Color.lerp(a.surfaceVariant, b.surfaceVariant, t) ?? a.surfaceVariant,
      background: Color.lerp(a.background, b.background, t) ?? a.background,
      border: Color.lerp(a.border, b.border, t) ?? a.border,
      borderFocused:
          Color.lerp(a.borderFocused, b.borderFocused, t) ?? a.borderFocused,
      divider: Color.lerp(a.divider, b.divider, t) ?? a.divider,
      textPrimary: Color.lerp(a.textPrimary, b.textPrimary, t) ?? a.textPrimary,
      textSecondary:
          Color.lerp(a.textSecondary, b.textSecondary, t) ?? a.textSecondary,
      hint: Color.lerp(a.hint, b.hint, t) ?? a.hint,
      disabled: Color.lerp(a.disabled, b.disabled, t) ?? a.disabled,
      disabledText:
          Color.lerp(a.disabledText, b.disabledText, t) ?? a.disabledText,
      error: Color.lerp(a.error, b.error, t) ?? a.error,
      errorContainer:
          Color.lerp(a.errorContainer, b.errorContainer, t) ?? a.errorContainer,
      success: Color.lerp(a.success, b.success, t) ?? a.success,
      successContainer: Color.lerp(a.successContainer, b.successContainer, t) ??
          a.successContainer,
      warning: Color.lerp(a.warning, b.warning, t) ?? a.warning,
      warningContainer: Color.lerp(a.warningContainer, b.warningContainer, t) ??
          a.warningContainer,
      info: Color.lerp(a.info, b.info, t) ?? a.info,
      infoContainer:
          Color.lerp(a.infoContainer, b.infoContainer, t) ?? a.infoContainer,
      cardBackground:
          Color.lerp(a.cardBackground, b.cardBackground, t) ?? a.cardBackground,
      dialogBackground: Color.lerp(a.dialogBackground, b.dialogBackground, t) ??
          a.dialogBackground,
      bottomSheetBackground:
          Color.lerp(a.bottomSheetBackground, b.bottomSheetBackground, t) ??
              a.bottomSheetBackground,
      primaryGradient: Gradient.lerp(a.primaryGradient, b.primaryGradient, t) ??
          a.primaryGradient,
      secondaryGradient:
          Gradient.lerp(a.secondaryGradient, b.secondaryGradient, t) ??
              a.secondaryGradient,
      accentGradient: Gradient.lerp(a.accentGradient, b.accentGradient, t) ??
          a.accentGradient,
      backgroundGradient:
          Gradient.lerp(a.backgroundGradient, b.backgroundGradient, t) ??
              a.backgroundGradient,
      surfaceGradient: Gradient.lerp(a.surfaceGradient, b.surfaceGradient, t) ??
          a.surfaceGradient,
    );
  }
}

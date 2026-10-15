import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// Semantic text variants for [FlexText].
enum FlexTextStyleVariant {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

/// A typography widget that integrates with [FlexUITheme], providing
/// semantic hierarchy variants and granular visual overrides.
class FlexText extends StatelessWidget {
  const FlexText(
    this.text, {
    super.key,
    this.variant = FlexTextStyleVariant.bodyMedium,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.letterSpacing,
    this.height,
    this.fontStyle,
    this.decoration,
    this.softWrap,
    this.fontFamily,
  });

  final String text;
  final FlexTextStyleVariant variant;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? height;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final bool? softWrap;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final typo = theme.typography;
    final colors = theme.colors;

    TextStyle base;
    switch (variant) {
      case FlexTextStyleVariant.displayLarge:
        base = typo.displayLarge;
        break;
      case FlexTextStyleVariant.displayMedium:
        base = typo.displayMedium;
        break;
      case FlexTextStyleVariant.displaySmall:
        base = typo.displaySmall;
        break;
      case FlexTextStyleVariant.headlineLarge:
        base = typo.headlineLarge;
        break;
      case FlexTextStyleVariant.headlineMedium:
        base = typo.headlineMedium;
        break;
      case FlexTextStyleVariant.headlineSmall:
        base = typo.headlineSmall;
        break;
      case FlexTextStyleVariant.titleLarge:
        base = typo.titleLarge;
        break;
      case FlexTextStyleVariant.titleMedium:
        base = typo.titleMedium;
        break;
      case FlexTextStyleVariant.titleSmall:
        base = typo.titleSmall;
        break;
      case FlexTextStyleVariant.bodyLarge:
        base = typo.bodyLarge;
        break;
      case FlexTextStyleVariant.bodyMedium:
        base = typo.bodyMedium;
        break;
      case FlexTextStyleVariant.bodySmall:
        base = typo.bodySmall;
        break;
      case FlexTextStyleVariant.labelLarge:
        base = typo.labelLarge;
        break;
      case FlexTextStyleVariant.labelMedium:
        base = typo.labelMedium;
        break;
      case FlexTextStyleVariant.labelSmall:
        base = typo.labelSmall;
        break;
    }

    if (style != null) {
      base = base.merge(style);
    }

    final effectiveColor = color ?? base.color ?? colors.textPrimary;

    final resolvedStyle = base.copyWith(
      color: effectiveColor,
      fontSize: fontSize ?? base.fontSize,
      fontWeight: fontWeight ?? base.fontWeight,
      letterSpacing: letterSpacing ?? base.letterSpacing,
      height: height ?? base.height,
      fontStyle: fontStyle ?? base.fontStyle,
      decoration: decoration ?? base.decoration,
      fontFamily: fontFamily ?? base.fontFamily,
    );

    return Text(
      text,
      style: resolvedStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

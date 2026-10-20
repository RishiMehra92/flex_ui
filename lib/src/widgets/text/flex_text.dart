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
/// semantic hierarchy variants and granular visual overrides directly without
/// having to wrap properties inside a [TextStyle].
///
/// Example:
/// ```dart
/// FlexText(
///   text: 'Sample Title',
///   fontSize: 16,
///   fontWeight: FontWeight.bold,
///   color: Colors.blue,
/// );
/// ```
class FlexText extends StatelessWidget {
  /// Creates a [FlexText] widget with optional named [text] and comprehensive
  /// typography styling options directly accessible without [TextStyle].
  const FlexText({
    super.key,
    this.text,
    this.variant = FlexTextStyleVariant.bodyMedium,
    this.style,
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.leadingDistribution,
    this.locale,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.fontFamily,
    this.fontFamilyFallback,
    this.package,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.strutStyle,
    this.gradient,
  });

  /// Alternative constructor accepting text data positionally.
  const FlexText.data(
    this.text, {
    super.key,
    this.variant = FlexTextStyleVariant.bodyMedium,
    this.style,
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.leadingDistribution,
    this.locale,
    this.foreground,
    this.background,
    this.shadows,
    this.fontFeatures,
    this.fontVariations,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.debugLabel,
    this.fontFamily,
    this.fontFamilyFallback,
    this.package,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.strutStyle,
    this.gradient,
  });

  /// The text string to display.
  final String? text;

  /// Semantic typography variant determining the base [TextStyle] from [FlexUITheme].
  final FlexTextStyleVariant variant;

  /// Optional base [TextStyle] to merge. Granular properties take precedence.
  final TextStyle? style;

  /// Text color.
  final Color? color;

  /// Background color behind the text.
  final Color? backgroundColor;

  /// Font size in logical pixels.
  final double? fontSize;

  /// Font weight (e.g., [FontWeight.w600], [FontWeight.bold]).
  final FontWeight? fontWeight;

  /// Font style (normal or italic).
  final FontStyle? fontStyle;

  /// Spacing between individual glyphs.
  final double? letterSpacing;

  /// Spacing between words.
  final double? wordSpacing;

  /// Common baseline metric for aligning text.
  final TextBaseline? textBaseline;

  /// Line height multiplier.
  final double? height;

  /// How leading should be distributed vertically.
  final TextLeadingDistribution? leadingDistribution;

  /// Locale used to select region-specific glyphs.
  final Locale? locale;

  /// Paint used to draw the text foreground instead of [color].
  final Paint? foreground;

  /// Paint used to draw the text background instead of [backgroundColor].
  final Paint? background;

  /// Drop shadows cast behind the text glyphs.
  final List<Shadow>? shadows;

  /// OpenType font features.
  final List<FontFeature>? fontFeatures;

  /// Variable font axis settings.
  final List<FontVariation>? fontVariations;

  /// Text decoration (e.g. underline, lineThrough).
  final TextDecoration? decoration;

  /// Color of the text decoration.
  final Color? decorationColor;

  /// Style of the text decoration (e.g. solid, double, dashed).
  final TextDecorationStyle? decorationStyle;

  /// Thickness of the text decoration line.
  final double? decorationThickness;

  /// Debug label identifying this style in tooling.
  final String? debugLabel;

  /// Primary font family name.
  final String? fontFamily;

  /// Fallback list of font families.
  final List<String>? fontFamilyFallback;

  /// Package name where font assets reside.
  final String? package;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Horizontal text alignment.
  final TextAlign? textAlign;

  /// Reading direction (LTR or RTL).
  final TextDirection? textDirection;

  /// Whether text should break across soft line breaks.
  final bool? softWrap;

  /// Custom text scaling policy.
  final TextScaler? textScaler;

  /// Maximum lines of text before clipping or overflowing.
  final int? maxLines;

  /// Alternative semantics label for screen readers.
  final String? semanticsLabel;

  /// How text width is calculated.
  final TextWidthBasis? textWidthBasis;

  /// Defines how the first line's ascent and last line's descent are handled.
  final TextHeightBehavior? textHeightBehavior;

  /// Color of text selection highlight.
  final Color? selectionColor;

  /// Strut style for consistent vertical font metrics.
  final StrutStyle? strutStyle;

  /// Optional gradient applied to the text glyphs using a [ShaderMask].
  final Gradient? gradient;

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

    final effectiveColor = color ??
        (foreground == null ? (base.color ?? colors.textPrimary) : null);

    final resolvedStyle = base.copyWith(
      inherit: true,
      color: effectiveColor,
      backgroundColor: backgroundColor ?? base.backgroundColor,
      fontSize: fontSize ?? base.fontSize,
      fontWeight: fontWeight ?? base.fontWeight,
      fontStyle: fontStyle ?? base.fontStyle,
      letterSpacing: letterSpacing ?? base.letterSpacing,
      wordSpacing: wordSpacing ?? base.wordSpacing,
      textBaseline: textBaseline ?? base.textBaseline,
      height: height ?? base.height,
      leadingDistribution: leadingDistribution ?? base.leadingDistribution,
      locale: locale ?? base.locale,
      foreground: foreground ?? base.foreground,
      background: background ?? base.background,
      shadows: shadows ?? base.shadows,
      fontFeatures: fontFeatures ?? base.fontFeatures,
      fontVariations: fontVariations ?? base.fontVariations,
      decoration: decoration ?? base.decoration,
      decorationColor: decorationColor ?? base.decorationColor,
      decorationStyle: decorationStyle ?? base.decorationStyle,
      decorationThickness: decorationThickness ?? base.decorationThickness,
      debugLabel: debugLabel ?? base.debugLabel,
      fontFamily: fontFamily ?? base.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? base.fontFamilyFallback,
      package: package,
      overflow: overflow ?? base.overflow,
    );

    final content = text ?? '';

    final textWidget = Text(
      content,
      style: gradient != null
          ? resolvedStyle.copyWith(color: Colors.white)
          : resolvedStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaler: textScaler,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      selectionColor: selectionColor,
    );

    if (gradient != null) {
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient!.createShader(bounds),
        child: textWidget,
      );
    }

    return textWidget;
  }
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import 'flex_text.dart';

/// Level of heading (H1 to H6).
enum FlexHeadingLevel { h1, h2, h3, h4, h5, h6 }

/// A structured heading widget with title, optional subtitle, and customizable hierarchy.
class FlexHeading extends StatelessWidget {
  const FlexHeading(
    this.title, {
    super.key,
    this.subtitle,
    this.level = FlexHeadingLevel.h2,
    this.titleColor,
    this.subtitleColor,
    this.gradient,
    this.textAlign = TextAlign.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = 4.0,
  });

  final String title;
  final String? subtitle;
  final FlexHeadingLevel level;
  final Color? titleColor;
  final Color? subtitleColor;
  final Gradient? gradient;
  final TextAlign textAlign;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    FlexTextStyleVariant titleVariant;
    switch (level) {
      case FlexHeadingLevel.h1:
        titleVariant = FlexTextStyleVariant.displaySmall;
        break;
      case FlexHeadingLevel.h2:
        titleVariant = FlexTextStyleVariant.headlineLarge;
        break;
      case FlexHeadingLevel.h3:
        titleVariant = FlexTextStyleVariant.headlineMedium;
        break;
      case FlexHeadingLevel.h4:
        titleVariant = FlexTextStyleVariant.headlineSmall;
        break;
      case FlexHeadingLevel.h5:
        titleVariant = FlexTextStyleVariant.titleLarge;
        break;
      case FlexHeadingLevel.h6:
        titleVariant = FlexTextStyleVariant.titleMedium;
        break;
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        FlexText(
          title,
          variant: titleVariant,
          color: titleColor ?? colors.textPrimary,
          gradient: gradient,
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          SizedBox(height: spacing),
          FlexText(
            subtitle!,
            variant: FlexTextStyleVariant.bodyMedium,
            color: subtitleColor ?? colors.textSecondary,
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }
}

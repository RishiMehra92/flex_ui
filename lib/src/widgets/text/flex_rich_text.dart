import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// A rich text widget integrated with Flex UI typography.
class FlexRichText extends StatelessWidget {
  const FlexRichText({
    super.key,
    required this.spans,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.softWrap = true,
  });

  final List<InlineSpan> spans;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final defaultStyle = theme.typography.bodyMedium.copyWith(
      color: theme.colors.textPrimary,
    );

    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      text: TextSpan(
        style: defaultStyle,
        children: spans,
      ),
    );
  }
}

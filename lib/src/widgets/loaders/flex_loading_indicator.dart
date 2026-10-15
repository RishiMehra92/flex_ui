import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import 'flex_spinner.dart';

/// A full-content or inline loading indicator block with an optional message.
class FlexLoadingIndicator extends StatelessWidget {
  const FlexLoadingIndicator({
    super.key,
    this.message,
    this.spinnerSize = 32.0,
    this.spinnerColor,
    this.textStyle,
    this.padding = const EdgeInsets.all(24.0),
  });

  final String? message;
  final double spinnerSize;
  final Color? spinnerColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FlexSpinner(
              size: spinnerSize,
              color: spinnerColor,
            ),
            if (message != null) ...[
              SizedBox(height: theme.spacing.md),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: textStyle ??
                    theme.typography.bodyMedium.copyWith(
                      color: colors.textSecondary,
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

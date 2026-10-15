import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// Spinner style.
enum FlexSpinnerStyle {
  cupertino,
  material,
  adaptive,
}

/// A versatile loading spinner supporting adaptive, Cupertino, and Material styles.
class FlexSpinner extends StatelessWidget {
  const FlexSpinner({
    super.key,
    this.size = 24.0,
    this.strokeWidth = 2.5,
    this.color,
    this.style = FlexSpinnerStyle.adaptive,
  });

  final double size;
  final double strokeWidth;
  final Color? color;
  final FlexSpinnerStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final effectiveColor = color ?? theme.colors.primary;

    final isCupertino = style == FlexSpinnerStyle.cupertino ||
        (style == FlexSpinnerStyle.adaptive &&
            Theme.of(context).platform == TargetPlatform.iOS);

    if (isCupertino) {
      return SizedBox(
        width: size,
        height: size,
        child: CupertinoActivityIndicator(
          radius: size / 2,
          color: effectiveColor,
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
      ),
    );
  }
}

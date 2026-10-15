import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../loaders/flex_skeleton.dart';

/// A robust image widget supporting network/asset images, placeholder loaders,
/// error fallbacks, and rounded corners.
class FlexImage extends StatelessWidget {
  const FlexImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.semanticLabel,
  });

  final String url;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BoxFit fit;
  final double? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final radius = borderRadius ?? theme.radius.sm;

    Widget image = Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            FlexSkeleton(
              width: width,
              height: height ?? 120,
              borderRadius: radius,
            );
      },
      errorBuilder: (context, error, stackTrace) {
        return errorWidget ??
            Container(
              width: width,
              height: height,
              color: colors.surfaceVariant,
              child: Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: colors.hint,
                  size: 28,
                ),
              ),
            );
      },
    );

    if (aspectRatio != null) {
      image = AspectRatio(aspectRatio: aspectRatio!, child: image);
    }

    if (radius > 0) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: image,
      );
    }

    return image;
  }
}

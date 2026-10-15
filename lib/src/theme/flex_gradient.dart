import 'dart:math' as math;
import 'package:flutter/material.dart';

/// The type of gradient to render.
enum FlexGradientType {
  /// A gradient that transitions colors along a linear line.
  linear,

  /// A gradient that transitions colors radiating from a central point.
  radial,

  /// A gradient that transitions colors sweeping around a central point.
  sweep,
}

/// A versatile, production-ready gradient model extending Flutter's native [Gradient].
///
/// Supports linear, radial, and sweep gradients, color stops, opacity,
/// angle/rotation transforms, solid color adaptation, and lerping.
///
/// Because [FlexGradient] extends [Gradient], it can be passed directly anywhere
/// a Flutter [Gradient], [LinearGradient], [RadialGradient], or [SweepGradient] is accepted.
///
/// Example:
/// ```dart
/// const gradient = FlexGradient(
///   colors: [Color(0xFF6750A4), Color(0xFF9C27B0)],
///   begin: Alignment.centerLeft,
///   end: Alignment.centerRight,
/// );
/// ```
class FlexGradient extends Gradient {
  /// Creates a [FlexGradient], defaulting to a linear gradient.
  const FlexGradient({
    required super.colors,
    super.stops,
    super.transform,
    this.type = FlexGradientType.linear,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.center = Alignment.center,
    this.radius = 0.5,
    this.startAngle = 0.0,
    this.endAngle = math.pi * 2,
    this.tileMode = TileMode.clamp,
    this.opacity = 1.0,
  });

  /// Creates a linear [FlexGradient].
  const FlexGradient.linear({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
    double opacity = 1.0,
  }) : this(
          colors: colors,
          stops: stops,
          type: FlexGradientType.linear,
          begin: begin,
          end: end,
          tileMode: tileMode,
          transform: transform,
          opacity: opacity,
        );

  /// Creates a radial [FlexGradient].
  const FlexGradient.radial({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
    double opacity = 1.0,
  }) : this(
          colors: colors,
          stops: stops,
          type: FlexGradientType.radial,
          center: center,
          radius: radius,
          tileMode: tileMode,
          transform: transform,
          opacity: opacity,
        );

  /// Creates a sweep [FlexGradient].
  const FlexGradient.sweep({
    required List<Color> colors,
    List<double>? stops,
    AlignmentGeometry center = Alignment.center,
    double startAngle = 0.0,
    double endAngle = math.pi * 2,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
    double opacity = 1.0,
  }) : this(
          colors: colors,
          stops: stops,
          type: FlexGradientType.sweep,
          center: center,
          startAngle: startAngle,
          endAngle: endAngle,
          tileMode: tileMode,
          transform: transform,
          opacity: opacity,
        );

  /// Creates a [FlexGradient] representing a uniform solid color.
  ///
  /// Useful for APIs where both gradients and solid colors can be handled uniformly.
  FlexGradient.solid(
    Color color, {
    double opacity = 1.0,
  }) : this(
          colors: [color, color],
          type: FlexGradientType.linear,
          opacity: opacity,
        );

  /// Creates a [FlexGradient] from any existing Flutter [Gradient].
  factory FlexGradient.from(Gradient gradient) {
    if (gradient is FlexGradient) {
      return gradient;
    }
    if (gradient is LinearGradient) {
      return FlexGradient.linear(
        colors: gradient.colors,
        stops: gradient.stops,
        begin: gradient.begin,
        end: gradient.end,
        tileMode: gradient.tileMode,
        transform: gradient.transform,
      );
    }
    if (gradient is RadialGradient) {
      return FlexGradient.radial(
        colors: gradient.colors,
        stops: gradient.stops,
        center: gradient.center,
        radius: gradient.radius,
        tileMode: gradient.tileMode,
        transform: gradient.transform,
      );
    }
    if (gradient is SweepGradient) {
      return FlexGradient.sweep(
        colors: gradient.colors,
        stops: gradient.stops,
        center: gradient.center,
        startAngle: gradient.startAngle,
        endAngle: gradient.endAngle,
        tileMode: gradient.tileMode,
        transform: gradient.transform,
      );
    }
    return FlexGradient(
      colors: gradient.colors,
      stops: gradient.stops,
      transform: gradient.transform,
    );
  }

  /// The gradient variety (linear, radial, or sweep).
  final FlexGradientType type;

  /// Start alignment for linear gradients.
  final AlignmentGeometry begin;

  /// End alignment for linear gradients.
  final AlignmentGeometry end;

  /// Center point for radial and sweep gradients.
  final AlignmentGeometry center;

  /// Radius for radial gradients.
  final double radius;

  /// Start angle in radians for sweep gradients.
  final double startAngle;

  /// End angle in radians for sweep gradients.
  final double endAngle;

  /// How the gradient should tile.
  final TileMode tileMode;

  /// Global opacity multiplier applied to all colors in this gradient.
  final double opacity;

  /// List of colors with [opacity] applied.
  List<Color> get effectiveColors {
    if (opacity >= 1.0) return colors;
    final clampedOpacity = opacity.clamp(0.0, 1.0);
    return colors
        .map((c) => c.withValues(alpha: c.a * clampedOpacity))
        .toList();
  }

  @override
  Shader createShader(Rect rect, {TextDirection? textDirection}) {
    switch (type) {
      case FlexGradientType.linear:
        return LinearGradient(
          begin: begin,
          end: end,
          colors: effectiveColors,
          stops: stops,
          tileMode: tileMode,
          transform: transform,
        ).createShader(rect, textDirection: textDirection);
      case FlexGradientType.radial:
        return RadialGradient(
          center: center,
          radius: radius,
          colors: effectiveColors,
          stops: stops,
          tileMode: tileMode,
          transform: transform,
        ).createShader(rect, textDirection: textDirection);
      case FlexGradientType.sweep:
        return SweepGradient(
          center: center,
          startAngle: startAngle,
          endAngle: endAngle,
          colors: effectiveColors,
          stops: stops,
          tileMode: tileMode,
          transform: transform,
        ).createShader(rect, textDirection: textDirection);
    }
  }

  @override
  Gradient scale(double factor) {
    return copyWith(
      colors: colors.map((c) => Color.lerp(null, c, factor)!).toList(),
    );
  }

  @override
  FlexGradient withOpacity(double opacity) {
    return copyWith(opacity: opacity);
  }

  /// Returns a copy of this [FlexGradient] with a rotation applied in radians.
  FlexGradient withRotation(double radians) {
    return copyWith(transform: GradientRotation(radians));
  }

  /// Converts this gradient to a Flutter [LinearGradient].
  LinearGradient toLinearGradient() {
    return LinearGradient(
      begin: begin,
      end: end,
      colors: effectiveColors,
      stops: stops,
      tileMode: tileMode,
      transform: transform,
    );
  }

  /// Converts this gradient to a Flutter [RadialGradient].
  RadialGradient toRadialGradient() {
    return RadialGradient(
      center: center,
      radius: radius,
      colors: effectiveColors,
      stops: stops,
      tileMode: tileMode,
      transform: transform,
    );
  }

  /// Converts this gradient to a Flutter [SweepGradient].
  SweepGradient toSweepGradient() {
    return SweepGradient(
      center: center,
      startAngle: startAngle,
      endAngle: endAngle,
      colors: effectiveColors,
      stops: stops,
      tileMode: tileMode,
      transform: transform,
    );
  }

  /// Creates a copy of this gradient with the given fields replaced.
  FlexGradient copyWith({
    List<Color>? colors,
    List<double>? stops,
    FlexGradientType? type,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    AlignmentGeometry? center,
    double? radius,
    double? startAngle,
    double? endAngle,
    TileMode? tileMode,
    GradientTransform? transform,
    double? opacity,
  }) {
    return FlexGradient(
      colors: colors ?? this.colors,
      stops: stops ?? this.stops,
      type: type ?? this.type,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      center: center ?? this.center,
      radius: radius ?? this.radius,
      startAngle: startAngle ?? this.startAngle,
      endAngle: endAngle ?? this.endAngle,
      tileMode: tileMode ?? this.tileMode,
      transform: transform ?? this.transform,
      opacity: opacity ?? this.opacity,
    );
  }

  /// Linearly interpolate between two [FlexGradient]s.
  static FlexGradient? lerp(FlexGradient? a, FlexGradient? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b?.scale(t) as FlexGradient?;
    if (b == null) return a.scale(1.0 - t) as FlexGradient?;

    // Determine colors lerp
    final aColors = a.effectiveColors;
    final bColors = b.effectiveColors;
    final count = math.max(aColors.length, bColors.length);
    final interpolatedColors = <Color>[];

    for (var i = 0; i < count; i++) {
      final aColor = aColors[math.min(i, aColors.length - 1)];
      final bColor = bColors[math.min(i, bColors.length - 1)];
      interpolatedColors.add(Color.lerp(aColor, bColor, t) ?? aColor);
    }

    return FlexGradient(
      type: t < 0.5 ? a.type : b.type,
      colors: interpolatedColors,
      begin: AlignmentGeometry.lerp(a.begin, b.begin, t) ?? a.begin,
      end: AlignmentGeometry.lerp(a.end, b.end, t) ?? a.end,
      center: AlignmentGeometry.lerp(a.center, b.center, t) ?? a.center,
      radius: (a.radius + (b.radius - a.radius) * t),
      startAngle: (a.startAngle + (b.startAngle - a.startAngle) * t),
      endAngle: (a.endAngle + (b.endAngle - a.endAngle) * t),
      tileMode: t < 0.5 ? a.tileMode : b.tileMode,
      transform: t < 0.5 ? a.transform : b.transform,
      opacity: (a.opacity + (b.opacity - a.opacity) * t),
    );
  }

  // ---------------------------------------------------------------------------
  // Pre-configured designer palettes
  // ---------------------------------------------------------------------------

  /// Modern primary blue gradient.
  static const FlexGradient primary = FlexGradient(
    colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Vibrant indigo to purple gradient.
  static const FlexGradient secondary = FlexGradient(
    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Cyan to teal accent gradient.
  static const FlexGradient accent = FlexGradient(
    colors: [Color(0xFF06B6D4), Color(0xFF0D9488)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Sunset gradient (orange into hot pink and purple).
  static const FlexGradient sunset = FlexGradient(
    colors: [Color(0xFFFF7E5F), Color(0xFFFEB47B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Ocean gradient (cyan into deep royal blue).
  static const FlexGradient ocean = FlexGradient(
    colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Purple into neon magenta/pink.
  static const FlexGradient purplePink = FlexGradient(
    colors: [Color(0xFF8A2387), Color(0xFFE94057), Color(0xFFF27121)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Emerald green into teal gradient.
  static const FlexGradient emerald = FlexGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Fire gradient (red into fiery orange/amber).
  static const FlexGradient fire = FlexGradient(
    colors: [Color(0xFFEF4444), Color(0xFFF59E0B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Sleek dark slate gradient.
  static const FlexGradient dark = FlexGradient(
    colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Semi-transparent glassmorphic frosted gradient.
  static const FlexGradient glass = FlexGradient(
    colors: [Color(0x33FFFFFF), Color(0x0DFFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FlexGradient) return false;
    if (type != other.type ||
        tileMode != other.tileMode ||
        opacity != other.opacity ||
        begin != other.begin ||
        end != other.end ||
        center != other.center ||
        radius != other.radius ||
        startAngle != other.startAngle ||
        endAngle != other.endAngle) {
      return false;
    }
    if (colors.length != other.colors.length) return false;
    for (var i = 0; i < colors.length; i++) {
      if (colors[i] != other.colors[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(
        type,
        tileMode,
        opacity,
        begin,
        end,
        center,
        radius,
        startAngle,
        endAngle,
        Object.hashAll(colors),
      );

  @override
  String toString() {
    return 'FlexGradient($type, colors: $colors, opacity: $opacity)';
  }
}

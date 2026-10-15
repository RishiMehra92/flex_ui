import 'package:flutter/material.dart';

/// Corner radius scale used across all Flex UI components.
class FlexRadius {
  const FlexRadius({
    this.none = 0.0,
    this.xs = 4.0,
    this.sm = 8.0,
    this.md = 12.0,
    this.lg = 16.0,
    this.xl = 24.0,
    this.full = 999.0,
  });

  final double none;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double full;

  BorderRadius get noneBorder => BorderRadius.circular(none);
  BorderRadius get xsBorder => BorderRadius.circular(xs);
  BorderRadius get smBorder => BorderRadius.circular(sm);
  BorderRadius get mdBorder => BorderRadius.circular(md);
  BorderRadius get lgBorder => BorderRadius.circular(lg);
  BorderRadius get xlBorder => BorderRadius.circular(xl);
  BorderRadius get fullBorder => BorderRadius.circular(full);

  BorderRadius circular(double radius) => BorderRadius.circular(radius);

  FlexRadius copyWith({
    double? none,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) {
    return FlexRadius(
      none: none ?? this.none,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      full: full ?? this.full,
    );
  }

  static FlexRadius lerp(FlexRadius a, FlexRadius b, double t) {
    double lerpD(double x, double y) => x + (y - x) * t;
    return FlexRadius(
      none: lerpD(a.none, b.none),
      xs: lerpD(a.xs, b.xs),
      sm: lerpD(a.sm, b.sm),
      md: lerpD(a.md, b.md),
      lg: lerpD(a.lg, b.lg),
      xl: lerpD(a.xl, b.xl),
      full: lerpD(a.full, b.full),
    );
  }
}

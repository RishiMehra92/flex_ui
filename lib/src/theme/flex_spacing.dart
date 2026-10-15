/// Spacing scale used across all Flex UI components.
class FlexSpacing {
  const FlexSpacing({
    this.none = 0.0,
    this.xxxs = 2.0,
    this.xxs = 4.0,
    this.xs = 8.0,
    this.sm = 12.0,
    this.md = 16.0,
    this.lg = 24.0,
    this.xl = 32.0,
    this.xxl = 40.0,
    this.xxxl = 48.0,
  });

  final double none;
  final double xxxs;
  final double xxs;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;

  FlexSpacing copyWith({
    double? none,
    double? xxxs,
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) {
    return FlexSpacing(
      none: none ?? this.none,
      xxxs: xxxs ?? this.xxxs,
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
    );
  }

  static FlexSpacing lerp(FlexSpacing a, FlexSpacing b, double t) {
    double lerpD(double x, double y) => x + (y - x) * t;
    return FlexSpacing(
      none: lerpD(a.none, b.none),
      xxxs: lerpD(a.xxxs, b.xxxs),
      xxs: lerpD(a.xxs, b.xxs),
      xs: lerpD(a.xs, b.xs),
      sm: lerpD(a.sm, b.sm),
      md: lerpD(a.md, b.md),
      lg: lerpD(a.lg, b.lg),
      xl: lerpD(a.xl, b.xl),
      xxl: lerpD(a.xxl, b.xxl),
      xxxl: lerpD(a.xxxl, b.xxxl),
    );
  }
}

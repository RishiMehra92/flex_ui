import 'package:flutter/material.dart';

/// Global configuration options for Flex UI.
class FlexUIConfig {
  const FlexUIConfig({
    this.defaultAnimationDuration = const Duration(milliseconds: 200),
    this.defaultAnimationCurve = Curves.easeOutCubic,
    this.defaultButtonHeight = 48.0,
    this.defaultInputHeight = 48.0,
    this.defaultBorderRadius = 10.0,
    this.enableHapticFeedback = true,
  });

  /// The active default configuration.
  static FlexUIConfig current = const FlexUIConfig();

  final Duration defaultAnimationDuration;
  final Curve defaultAnimationCurve;
  final double defaultButtonHeight;
  final double defaultInputHeight;
  final double defaultBorderRadius;
  final bool enableHapticFeedback;

  FlexUIConfig copyWith({
    Duration? defaultAnimationDuration,
    Curve? defaultAnimationCurve,
    double? defaultButtonHeight,
    double? defaultInputHeight,
    double? defaultBorderRadius,
    bool? enableHapticFeedback,
  }) {
    return FlexUIConfig(
      defaultAnimationDuration:
          defaultAnimationDuration ?? this.defaultAnimationDuration,
      defaultAnimationCurve:
          defaultAnimationCurve ?? this.defaultAnimationCurve,
      defaultButtonHeight: defaultButtonHeight ?? this.defaultButtonHeight,
      defaultInputHeight: defaultInputHeight ?? this.defaultInputHeight,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
    );
  }
}

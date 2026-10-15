import 'package:flutter/material.dart';

/// Theme configuration for Flex UI buttons.
class FlexButtonThemeData {
  const FlexButtonThemeData({
    this.height = 48.0,
    this.minWidth = 88.0,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.elevation = 0.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableAnimation = true,
    this.textStyle,
    this.gradient,
    this.borderGradient,
    this.labelGradient,
    this.borderWidth,
    this.borderColor,
  });

  final double height;
  final double minWidth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double elevation;
  final Duration animationDuration;
  final bool enableAnimation;
  final TextStyle? textStyle;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Gradient? labelGradient;
  final double? borderWidth;
  final Color? borderColor;

  FlexButtonThemeData copyWith({
    double? height,
    double? minWidth,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    double? elevation,
    Duration? animationDuration,
    bool? enableAnimation,
    TextStyle? textStyle,
    Gradient? gradient,
    Gradient? borderGradient,
    Gradient? labelGradient,
    double? borderWidth,
    Color? borderColor,
  }) {
    return FlexButtonThemeData(
      height: height ?? this.height,
      minWidth: minWidth ?? this.minWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      elevation: elevation ?? this.elevation,
      animationDuration: animationDuration ?? this.animationDuration,
      enableAnimation: enableAnimation ?? this.enableAnimation,
      textStyle: textStyle ?? this.textStyle,
      gradient: gradient ?? this.gradient,
      borderGradient: borderGradient ?? this.borderGradient,
      labelGradient: labelGradient ?? this.labelGradient,
      borderWidth: borderWidth ?? this.borderWidth,
      borderColor: borderColor ?? this.borderColor,
    );
  }

  static FlexButtonThemeData lerp(
      FlexButtonThemeData a, FlexButtonThemeData b, double t) {
    return FlexButtonThemeData(
      height: (a.height + (b.height - a.height) * t),
      minWidth: (a.minWidth + (b.minWidth - a.minWidth) * t),
      borderRadius: (a.borderRadius + (b.borderRadius - a.borderRadius) * t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
      elevation: (a.elevation + (b.elevation - a.elevation) * t),
      animationDuration: t < 0.5 ? a.animationDuration : b.animationDuration,
      enableAnimation: t < 0.5 ? a.enableAnimation : b.enableAnimation,
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t) ?? a.textStyle,
      gradient: Gradient.lerp(a.gradient, b.gradient, t) ?? a.gradient,
      borderGradient: Gradient.lerp(a.borderGradient, b.borderGradient, t) ??
          a.borderGradient,
      labelGradient:
          Gradient.lerp(a.labelGradient, b.labelGradient, t) ?? a.labelGradient,
      borderWidth: a.borderWidth != null && b.borderWidth != null
          ? (a.borderWidth! + (b.borderWidth! - a.borderWidth!) * t)
          : (t < 0.5 ? a.borderWidth : b.borderWidth),
      borderColor: Color.lerp(a.borderColor, b.borderColor, t),
    );
  }
}

/// Theme configuration for Flex UI input fields.
class FlexInputThemeData {
  const FlexInputThemeData({
    this.borderRadius = 10.0,
    this.borderWidth = 1.0,
    this.focusedBorderWidth = 1.5,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.labelFontSize = 14.0,
    this.labelFontWeight = FontWeight.w600,
    this.inputFontSize = 14.0,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.gradient,
    this.borderGradient,
    this.focusedBorderGradient,
    this.errorBorderGradient,
    this.disabledGradientBorder,
    this.successGradientBorder,
  });

  final double borderRadius;
  final double borderWidth;
  final double focusedBorderWidth;
  final EdgeInsetsGeometry padding;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final double inputFontSize;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Gradient? focusedBorderGradient;
  final Gradient? errorBorderGradient;
  final Gradient? disabledGradientBorder;
  final Gradient? successGradientBorder;

  FlexInputThemeData copyWith({
    double? borderRadius,
    double? borderWidth,
    double? focusedBorderWidth,
    EdgeInsetsGeometry? padding,
    double? labelFontSize,
    FontWeight? labelFontWeight,
    double? inputFontSize,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Gradient? gradient,
    Gradient? borderGradient,
    Gradient? focusedBorderGradient,
    Gradient? errorBorderGradient,
    Gradient? disabledGradientBorder,
    Gradient? successGradientBorder,
  }) {
    return FlexInputThemeData(
      borderRadius: borderRadius ?? this.borderRadius,
      borderWidth: borderWidth ?? this.borderWidth,
      focusedBorderWidth: focusedBorderWidth ?? this.focusedBorderWidth,
      padding: padding ?? this.padding,
      labelFontSize: labelFontSize ?? this.labelFontSize,
      labelFontWeight: labelFontWeight ?? this.labelFontWeight,
      inputFontSize: inputFontSize ?? this.inputFontSize,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      errorBorderColor: errorBorderColor ?? this.errorBorderColor,
      gradient: gradient ?? this.gradient,
      borderGradient: borderGradient ?? this.borderGradient,
      focusedBorderGradient:
          focusedBorderGradient ?? this.focusedBorderGradient,
      errorBorderGradient: errorBorderGradient ?? this.errorBorderGradient,
      disabledGradientBorder:
          disabledGradientBorder ?? this.disabledGradientBorder,
      successGradientBorder:
          successGradientBorder ?? this.successGradientBorder,
    );
  }

  static FlexInputThemeData lerp(
      FlexInputThemeData a, FlexInputThemeData b, double t) {
    return FlexInputThemeData(
      borderRadius: (a.borderRadius + (b.borderRadius - a.borderRadius) * t),
      borderWidth: (a.borderWidth + (b.borderWidth - a.borderWidth) * t),
      focusedBorderWidth: (a.focusedBorderWidth +
          (b.focusedBorderWidth - a.focusedBorderWidth) * t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
      labelFontSize:
          (a.labelFontSize + (b.labelFontSize - a.labelFontSize) * t),
      labelFontWeight: t < 0.5 ? a.labelFontWeight : b.labelFontWeight,
      inputFontSize:
          (a.inputFontSize + (b.inputFontSize - a.inputFontSize) * t),
      fillColor: Color.lerp(a.fillColor, b.fillColor, t),
      borderColor: Color.lerp(a.borderColor, b.borderColor, t),
      focusedBorderColor:
          Color.lerp(a.focusedBorderColor, b.focusedBorderColor, t),
      errorBorderColor: Color.lerp(a.errorBorderColor, b.errorBorderColor, t),
      gradient: Gradient.lerp(a.gradient, b.gradient, t) ?? a.gradient,
      borderGradient: Gradient.lerp(a.borderGradient, b.borderGradient, t) ??
          a.borderGradient,
      focusedBorderGradient:
          Gradient.lerp(a.focusedBorderGradient, b.focusedBorderGradient, t) ??
              a.focusedBorderGradient,
      errorBorderGradient:
          Gradient.lerp(a.errorBorderGradient, b.errorBorderGradient, t) ??
              a.errorBorderGradient,
      disabledGradientBorder: Gradient.lerp(
              a.disabledGradientBorder, b.disabledGradientBorder, t) ??
          a.disabledGradientBorder,
      successGradientBorder:
          Gradient.lerp(a.successGradientBorder, b.successGradientBorder, t) ??
              a.successGradientBorder,
    );
  }
}

/// Theme configuration for Flex UI cards.
class FlexCardThemeData {
  const FlexCardThemeData({
    this.borderRadius = 14.0,
    this.elevation = 0.0,
    this.padding = const EdgeInsets.all(16.0),
    this.borderWidth = 1.0,
    this.gradient,
    this.borderGradient,
    this.borderColor,
    this.shadowColor,
  });

  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final double borderWidth;
  final Gradient? gradient;
  final Gradient? borderGradient;
  final Color? borderColor;
  final Color? shadowColor;

  FlexCardThemeData copyWith({
    double? borderRadius,
    double? elevation,
    EdgeInsetsGeometry? padding,
    double? borderWidth,
    Gradient? gradient,
    Gradient? borderGradient,
    Color? borderColor,
    Color? shadowColor,
  }) {
    return FlexCardThemeData(
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
      borderWidth: borderWidth ?? this.borderWidth,
      gradient: gradient ?? this.gradient,
      borderGradient: borderGradient ?? this.borderGradient,
      borderColor: borderColor ?? this.borderColor,
      shadowColor: shadowColor ?? this.shadowColor,
    );
  }

  static FlexCardThemeData lerp(
      FlexCardThemeData a, FlexCardThemeData b, double t) {
    return FlexCardThemeData(
      borderRadius: (a.borderRadius + (b.borderRadius - a.borderRadius) * t),
      elevation: (a.elevation + (b.elevation - a.elevation) * t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
      borderWidth: (a.borderWidth + (b.borderWidth - a.borderWidth) * t),
      gradient: Gradient.lerp(a.gradient, b.gradient, t) ?? a.gradient,
      borderGradient: Gradient.lerp(a.borderGradient, b.borderGradient, t) ??
          a.borderGradient,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t),
      shadowColor: Color.lerp(a.shadowColor, b.shadowColor, t),
    );
  }
}

/// Theme configuration for Flex UI dialogs.
class FlexDialogThemeData {
  const FlexDialogThemeData({
    this.borderRadius = 16.0,
    this.elevation = 4.0,
    this.padding = const EdgeInsets.all(24.0),
  });

  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;

  FlexDialogThemeData copyWith({
    double? borderRadius,
    double? elevation,
    EdgeInsetsGeometry? padding,
  }) {
    return FlexDialogThemeData(
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      padding: padding ?? this.padding,
    );
  }

  static FlexDialogThemeData lerp(
      FlexDialogThemeData a, FlexDialogThemeData b, double t) {
    return FlexDialogThemeData(
      borderRadius: (a.borderRadius + (b.borderRadius - a.borderRadius) * t),
      elevation: (a.elevation + (b.elevation - a.elevation) * t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
    );
  }
}

/// Theme configuration for Flex UI bottom sheets.
class FlexBottomSheetThemeData {
  const FlexBottomSheetThemeData({
    this.borderRadius = 20.0,
    this.showDragHandle = true,
    this.dragHandleColor,
    this.padding = const EdgeInsets.all(20.0),
  });

  final double borderRadius;
  final bool showDragHandle;
  final Color? dragHandleColor;
  final EdgeInsetsGeometry padding;

  FlexBottomSheetThemeData copyWith({
    double? borderRadius,
    bool? showDragHandle,
    Color? dragHandleColor,
    EdgeInsetsGeometry? padding,
  }) {
    return FlexBottomSheetThemeData(
      borderRadius: borderRadius ?? this.borderRadius,
      showDragHandle: showDragHandle ?? this.showDragHandle,
      dragHandleColor: dragHandleColor ?? this.dragHandleColor,
      padding: padding ?? this.padding,
    );
  }

  static FlexBottomSheetThemeData lerp(
      FlexBottomSheetThemeData a, FlexBottomSheetThemeData b, double t) {
    return FlexBottomSheetThemeData(
      borderRadius: (a.borderRadius + (b.borderRadius - a.borderRadius) * t),
      showDragHandle: t < 0.5 ? a.showDragHandle : b.showDragHandle,
      dragHandleColor: Color.lerp(a.dragHandleColor, b.dragHandleColor, t),
      padding: EdgeInsetsGeometry.lerp(a.padding, b.padding, t) ?? a.padding,
    );
  }
}

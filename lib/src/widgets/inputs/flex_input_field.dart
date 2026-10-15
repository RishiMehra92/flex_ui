import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_gradient_border.dart';

/// A versatile, highly customizable input field that integrates with Flutter's
/// [Form] system, supporting labels, helpers, prefixes, suffixes, validation,
/// obscure text toggling, and required field indicators.
class FlexInputField extends StatefulWidget {
  const FlexInputField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.prefixWidget,
    this.suffixIcon,
    this.suffixWidget,
    this.obscureText = false,
    this.showPasswordToggle = false,
    this.readOnly = false,
    this.enabled = true,
    this.isRequired = false,
    this.requiredIndicatorText = ' *',
    this.requiredIndicatorColor,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.borderWidth,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.disabledBorderColor,
    this.focusedBorderWidth,
    this.gradient,
    this.gradientBorder,
    this.borderGradient,
    this.focusedGradientBorder,
    this.errorGradientBorder,
    this.disabledGradientBorder,
    this.successGradientBorder,
    this.prefixIconColor,
    this.suffixIconColor,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.helperStyle,
    this.errorStyle,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.semanticLabel,
    this.autovalidateMode,
    this.onSaved,
  });

  /// The text editing controller.
  final TextEditingController? controller;

  /// Initial text value if no [controller] is provided.
  final String? initialValue;

  /// The focus node.
  final FocusNode? focusNode;

  /// Label text displayed above the input.
  final String? label;

  /// Placeholder text displayed inside the field when empty.
  final String? hintText;

  /// Informational helper text displayed below the field.
  final String? helperText;

  /// Static error message overriding validator errors.
  final String? errorText;

  /// Leading icon.
  final IconData? prefixIcon;

  /// Leading custom widget.
  final Widget? prefixWidget;

  /// Trailing icon.
  final IconData? suffixIcon;

  /// Trailing custom widget.
  final Widget? suffixWidget;

  /// Whether to obscure the input text (e.g. for passwords).
  final bool obscureText;

  /// If true, renders a password visibility toggle button in the suffix area.
  final bool showPasswordToggle;

  /// If true, the field is non-editable.
  final bool readOnly;

  /// Whether the field is enabled.
  final bool enabled;

  /// Whether this field is required. If true or if [label] ends with '*',
  /// displays an asterisk.
  final bool isRequired;

  /// Asterisk or custom symbol for required fields.
  final String requiredIndicatorText;

  /// Color of the required asterisk. Defaults to error color.
  final Color? requiredIndicatorColor;

  /// The keyboard type to display.
  final TextInputType? keyboardType;

  /// Text capitalization rules.
  final TextCapitalization? textCapitalization;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// Input formatters (filters, formatters).
  final List<TextInputFormatter>? inputFormatters;

  /// Validation function returning an error string if invalid.
  final FormFieldValidator<String>? validator;

  /// Callback when text changes.
  final ValueChanged<String>? onChanged;

  /// Callback when keyboard submit action is tapped.
  final ValueChanged<String>? onSubmitted;

  /// Callback when the input field is tapped.
  final VoidCallback? onTap;

  /// Callback when editing is completed.
  final VoidCallback? onEditingComplete;

  /// Maximum line count.
  final int? maxLines;

  /// Minimum line count.
  final int? minLines;

  /// Maximum character count.
  final int? maxLength;

  /// Explicit custom width.
  final double? width;

  /// Explicit custom height of the field.
  final double? height;

  /// Content padding inside the field.
  final EdgeInsetsGeometry? padding;

  /// Custom corner radius.
  final double? borderRadius;

  /// Custom border width.
  final double? borderWidth;

  /// Custom fill color.
  final Color? fillColor;

  /// Custom border color when unfocused.
  final Color? borderColor;

  /// Custom border color when focused.
  final Color? focusedBorderColor;

  /// Custom border color when invalid.
  final Color? errorBorderColor;

  /// Custom border color when disabled.
  final Color? disabledBorderColor;

  /// Custom focused border width.
  final double? focusedBorderWidth;

  /// Optional background gradient for the input field.
  final Gradient? gradient;

  /// Optional default gradient border for the input field.
  final Gradient? gradientBorder;

  /// Alias for [gradientBorder].
  final Gradient? borderGradient;

  /// Optional gradient border when the field is focused.
  final Gradient? focusedGradientBorder;

  /// Optional gradient border when the field has an error.
  final Gradient? errorGradientBorder;

  /// Optional gradient border when the field is disabled.
  final Gradient? disabledGradientBorder;

  /// Optional gradient border when the field is valid/success.
  final Gradient? successGradientBorder;

  /// Custom prefix icon color.
  final Color? prefixIconColor;

  /// Custom suffix icon color.
  final Color? suffixIconColor;

  /// Custom style for the input text.
  final TextStyle? textStyle;

  /// Custom style for the hint text.
  final TextStyle? hintStyle;

  /// Custom style for the label text.
  final TextStyle? labelStyle;

  /// Custom style for helper text.
  final TextStyle? helperStyle;

  /// Custom style for error text.
  final TextStyle? errorStyle;

  /// Text alignment.
  final TextAlign textAlign;

  /// Whether to focus automatically.
  final bool autofocus;

  /// Whether to enable autocorrect.
  final bool autocorrect;

  /// Whether to enable suggestions.
  final bool enableSuggestions;

  /// Accessibility semantic label.
  final String? semanticLabel;

  /// Used to configure auto validation.
  final AutovalidateMode? autovalidateMode;

  /// An optional method to call with the final value when the form is saved.
  final FormFieldSetter<String>? onSaved;

  @override
  State<FlexInputField> createState() => _FlexInputFieldState();
}

class _FlexInputFieldState extends State<FlexInputField> {
  late bool _obscureText;
  FocusNode? _internalFocusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  bool _isFocused = false;
  String? _validatorError;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _effectiveFocusNode.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(FlexInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
    }
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)
          ?.removeListener(_handleFocusChanged);
      _effectiveFocusNode.addListener(_handleFocusChanged);
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChanged);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleFocusChanged() {
    if (_isFocused != _effectiveFocusNode.hasFocus) {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus;
      });
    }
  }

  void _toggleObscure() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;
    final inTheme = theme.inputTheme;

    final effectiveRadius = widget.borderRadius ?? inTheme.borderRadius;
    final effectiveFillColor = widget.fillColor ??
        inTheme.fillColor ??
        (widget.enabled ? colors.surface : colors.surfaceVariant);

    final effectiveBorderColor =
        widget.borderColor ?? inTheme.borderColor ?? colors.border;
    final effectiveFocusedBorderColor = widget.focusedBorderColor ??
        inTheme.focusedBorderColor ??
        colors.borderFocused;
    final effectiveErrorBorderColor =
        widget.errorBorderColor ?? inTheme.errorBorderColor ?? colors.error;
    final effectiveDisabledBorderColor =
        widget.disabledBorderColor ?? colors.border.withValues(alpha: 0.5);

    final effectiveBorderWidth = widget.borderWidth ?? inTheme.borderWidth;
    final effectiveFocusedBorderWidth = widget.focusedBorderWidth ??
        (widget.borderWidth != null
            ? widget.borderWidth! * 1.5
            : inTheme.focusedBorderWidth);

    // Smart capitalization fallback
    final effectiveCapitalization = widget.textCapitalization ??
        ((widget.keyboardType == TextInputType.emailAddress ||
                widget.keyboardType == TextInputType.number ||
                widget.keyboardType == TextInputType.phone ||
                _obscureText)
            ? TextCapitalization.none
            : TextCapitalization.sentences);

    // Prefix and Suffix colors
    final effectivePrefixColor = widget.prefixIconColor ??
        (widget.enabled ? colors.hint : colors.disabledText);
    final effectiveSuffixColor = widget.suffixIconColor ??
        (widget.enabled ? colors.hint : colors.disabledText);

    // Prefix
    Widget? prefix;
    if (widget.prefixWidget != null) {
      prefix = widget.prefixWidget;
    } else if (widget.prefixIcon != null) {
      prefix = Icon(
        widget.prefixIcon,
        color: effectivePrefixColor,
        size: 20,
      );
    }

    // Suffix
    Widget? suffix;
    if (widget.showPasswordToggle) {
      suffix = IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: widget.suffixIconColor ?? colors.hint,
          size: 20,
        ),
        onPressed: _toggleObscure,
        splashRadius: 20,
        tooltip: _obscureText ? 'Show password' : 'Hide password',
      );
    } else if (widget.suffixWidget != null) {
      suffix = widget.suffixWidget;
    } else if (widget.suffixIcon != null) {
      suffix = Icon(
        widget.suffixIcon,
        color: effectiveSuffixColor,
        size: 20,
      );
    }

    // Gradient styling resolution
    final effectiveBackgroundGradient = widget.gradient ?? inTheme.gradient;
    final effectiveGradientBorder = widget.gradientBorder ??
        widget.borderGradient ??
        inTheme.borderGradient;
    final effectiveFocusedGradientBorder = widget.focusedGradientBorder ??
        inTheme.focusedBorderGradient ??
        effectiveGradientBorder;
    final effectiveErrorGradientBorder = widget.errorGradientBorder ??
        inTheme.errorBorderGradient ??
        effectiveGradientBorder;
    final effectiveDisabledGradientBorder =
        widget.disabledGradientBorder ?? inTheme.disabledGradientBorder;

    final hasGradientBorder = effectiveGradientBorder != null ||
        effectiveFocusedGradientBorder != null ||
        effectiveErrorGradientBorder != null ||
        effectiveDisabledGradientBorder != null;

    final bool hasError =
        (widget.errorText != null && widget.errorText!.isNotEmpty) ||
            (_validatorError != null && _validatorError!.isNotEmpty);
    final String? activeErrorText = widget.errorText ?? _validatorError;

    Gradient? activeGradientBorder;
    if (hasGradientBorder) {
      if (!widget.enabled) {
        activeGradientBorder = effectiveDisabledGradientBorder;
      } else if (hasError) {
        activeGradientBorder = effectiveErrorGradientBorder;
      } else if (_isFocused) {
        activeGradientBorder = effectiveFocusedGradientBorder;
      } else {
        activeGradientBorder = effectiveGradientBorder;
      }
    }

    final double activeBorderWidth =
        _isFocused ? effectiveFocusedBorderWidth : effectiveBorderWidth;

    InputBorder outlineBorder;
    InputBorder focusedBorder;
    InputBorder errorBorder;
    InputBorder disabledBorder;

    if (hasGradientBorder) {
      final transparentBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
        borderSide: BorderSide.none,
      );
      outlineBorder = transparentBorder;
      focusedBorder = transparentBorder;
      errorBorder = transparentBorder;
      disabledBorder = transparentBorder;
    } else {
      outlineBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
        borderSide: BorderSide(
          color: effectiveBorderColor,
          width: effectiveBorderWidth,
        ),
      );

      focusedBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
        borderSide: BorderSide(
          color: effectiveFocusedBorderColor,
          width: effectiveFocusedBorderWidth,
        ),
      );

      errorBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
        borderSide: BorderSide(
          color: effectiveErrorBorderColor,
          width: effectiveBorderWidth,
        ),
      );

      disabledBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(effectiveRadius),
        borderSide: BorderSide(
          color: effectiveDisabledBorderColor,
          width: effectiveBorderWidth,
        ),
      );
    }

    final effectiveTextStyle = widget.textStyle ??
        theme.typography.bodyMedium.copyWith(
          color: widget.enabled ? colors.textPrimary : colors.disabledText,
          fontSize: inTheme.inputFontSize,
        );

    final effectiveHintStyle = widget.hintStyle ??
        theme.typography.bodyMedium.copyWith(
          color: colors.hint,
          fontSize: inTheme.inputFontSize,
        );

    // Label handling with required asterisk
    final bool isActuallyRequired = widget.isRequired ||
        (widget.label != null && widget.label!.trim().endsWith('*'));

    Widget? labelWidget;
    if (widget.label != null) {
      String cleanLabel = widget.label!;
      if (cleanLabel.trim().endsWith('*')) {
        cleanLabel = cleanLabel.trim();
        cleanLabel = cleanLabel.substring(0, cleanLabel.length - 1).trim();
      }

      final labelStyle = widget.labelStyle ??
          theme.typography.labelLarge.copyWith(
            fontWeight: inTheme.labelFontWeight,
            fontSize: inTheme.labelFontSize,
            color: widget.enabled ? colors.textPrimary : colors.disabledText,
          );

      if (isActuallyRequired) {
        labelWidget = Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.xs),
          child: RichText(
            text: TextSpan(
              text: cleanLabel,
              style: labelStyle,
              children: [
                TextSpan(
                  text: widget.requiredIndicatorText,
                  style: labelStyle.copyWith(
                    color: widget.requiredIndicatorColor ?? colors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        labelWidget = Padding(
          padding: EdgeInsets.only(bottom: theme.spacing.xs),
          child: Text(cleanLabel, style: labelStyle),
        );
      }
    }

    Widget formField = TextFormField(
      controller: widget.controller,
      initialValue: widget.controller == null ? widget.initialValue : null,
      focusNode: _effectiveFocusNode,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textCapitalization: effectiveCapitalization,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      validator: (value) {
        final result = widget.validator?.call(value);
        if (_validatorError != result) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _validatorError = result);
          });
        }
        return result;
      },
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      maxLines: _obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      autovalidateMode: widget.autovalidateMode,
      onSaved: widget.onSaved,
      style: effectiveTextStyle,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: effectiveHintStyle,
        helperText: hasGradientBorder ? null : widget.helperText,
        helperStyle: widget.helperStyle ??
            theme.typography.bodySmall.copyWith(color: colors.textSecondary),
        errorText: hasGradientBorder ? null : widget.errorText,
        errorStyle: widget.errorStyle ??
            theme.typography.bodySmall.copyWith(color: colors.error),
        prefixIcon: prefix,
        suffixIcon: suffix,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        filled: true,
        fillColor: effectiveBackgroundGradient != null
            ? Colors.transparent
            : effectiveFillColor,
        isDense: true,
        contentPadding: widget.padding ?? inTheme.padding,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: hasGradientBorder
            ? outlineBorder
            : errorBorder.copyWith(
                borderSide: BorderSide(
                  color: effectiveErrorBorderColor,
                  width: effectiveFocusedBorderWidth,
                ),
              ),
        disabledBorder: disabledBorder,
      ),
    );

    if (effectiveBackgroundGradient != null) {
      formField = Container(
        decoration: BoxDecoration(
          gradient: effectiveBackgroundGradient,
          borderRadius: BorderRadius.circular(effectiveRadius),
        ),
        child: formField,
      );
    }

    if (hasGradientBorder &&
        activeGradientBorder != null &&
        activeBorderWidth > 0) {
      formField = CustomPaint(
        foregroundPainter: FlexGradientBorderPainter(
          gradient: activeGradientBorder,
          borderWidth: activeBorderWidth,
          borderRadius: BorderRadius.circular(effectiveRadius),
        ),
        child: formField,
      );
    }

    if (widget.height != null) {
      formField = SizedBox(height: widget.height, child: formField);
    }

    final effectiveErrorStyle = widget.errorStyle ??
        theme.typography.bodySmall.copyWith(color: colors.error);
    final effectiveHelperStyle = widget.helperStyle ??
        theme.typography.bodySmall.copyWith(color: colors.textSecondary);

    Widget completeWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelWidget != null) labelWidget,
        formField,
        if (hasGradientBorder && hasError && activeErrorText != null)
          Padding(
            padding: EdgeInsets.only(
              top: theme.spacing.xs,
              left: theme.spacing.xs,
            ),
            child: Text(activeErrorText, style: effectiveErrorStyle),
          )
        else if (hasGradientBorder && widget.helperText != null)
          Padding(
            padding: EdgeInsets.only(
              top: theme.spacing.xs,
              left: theme.spacing.xs,
            ),
            child: Text(widget.helperText!, style: effectiveHelperStyle),
          ),
      ],
    );

    if (widget.width != null) {
      completeWidget = SizedBox(width: widget.width, child: completeWidget);
    }

    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      child: completeWidget,
    );
  }
}

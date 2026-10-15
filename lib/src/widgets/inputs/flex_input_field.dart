import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../config/flex_ui_theme.dart';

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

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(FlexInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
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

    final effectiveBorderWidth = widget.borderWidth ?? inTheme.borderWidth;
    final effectiveFocusedBorderWidth = widget.borderWidth != null
        ? widget.borderWidth! * 1.5
        : inTheme.focusedBorderWidth;

    // Smart capitalization fallback
    final effectiveCapitalization = widget.textCapitalization ??
        ((widget.keyboardType == TextInputType.emailAddress ||
                widget.keyboardType == TextInputType.number ||
                widget.keyboardType == TextInputType.phone ||
                _obscureText)
            ? TextCapitalization.none
            : TextCapitalization.sentences);

    // Prefix
    Widget? prefix;
    if (widget.prefixWidget != null) {
      prefix = widget.prefixWidget;
    } else if (widget.prefixIcon != null) {
      prefix = Icon(
        widget.prefixIcon,
        color: widget.enabled ? colors.hint : colors.disabledText,
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
          color: colors.hint,
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
        color: widget.enabled ? colors.hint : colors.disabledText,
        size: 20,
      );
    }

    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: effectiveFocusedBorderColor,
        width: effectiveFocusedBorderWidth,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: effectiveErrorBorderColor,
        width: effectiveBorderWidth,
      ),
    );

    final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(effectiveRadius),
      borderSide: BorderSide(
        color: colors.border.withValues(alpha: 0.5),
        width: effectiveBorderWidth,
      ),
    );

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
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      textCapitalization: effectiveCapitalization,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
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
        helperText: widget.helperText,
        helperStyle: widget.helperStyle ??
            theme.typography.bodySmall.copyWith(color: colors.textSecondary),
        errorText: widget.errorText,
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
        fillColor: effectiveFillColor,
        isDense: true,
        contentPadding: widget.padding ?? inTheme.padding,
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder.copyWith(
          borderSide: BorderSide(
            color: effectiveErrorBorderColor,
            width: effectiveFocusedBorderWidth,
          ),
        ),
        disabledBorder: disabledBorder,
      ),
    );

    if (widget.height != null) {
      formField = SizedBox(height: widget.height, child: formField);
    }

    Widget completeWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelWidget != null) labelWidget,
        formField,
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

import 'package:flutter/material.dart';
import 'flex_input_field.dart';

/// A search input field with search icon, clear button, and real-time query support.
class FlexSearchField extends StatefulWidget {
  const FlexSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 24.0,
    this.width,
    this.height,
    this.autofocus = false,
    this.semanticLabel = 'Search',
    this.gradient,
    this.gradientBorder,
    this.borderGradient,
    this.focusedGradientBorder,
    this.borderWidth,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final double? width;
  final double? height;
  final bool autofocus;
  final String semanticLabel;
  final Gradient? gradient;
  final Gradient? gradientBorder;
  final Gradient? borderGradient;
  final Gradient? focusedGradientBorder;
  final double? borderWidth;

  @override
  State<FlexSearchField> createState() => _FlexSearchFieldState();
}

class _FlexSearchFieldState extends State<FlexSearchField> {
  late TextEditingController _effectiveController;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _effectiveController = widget.controller ?? TextEditingController();
    _hasText = _effectiveController.text.isNotEmpty;
    _effectiveController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final has = _effectiveController.text.isNotEmpty;
    if (has != _hasText) {
      setState(() => _hasText = has);
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _effectiveController.dispose();
    } else {
      _effectiveController.removeListener(_onTextChanged);
    }
    super.dispose();
  }

  void _handleClear() {
    _effectiveController.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return FlexInputField(
      controller: _effectiveController,
      focusNode: widget.focusNode,
      hintText: widget.hintText,
      prefixIcon: Icons.search_rounded,
      suffixWidget: _hasText
          ? IconButton(
              icon: const Icon(Icons.close_rounded, size: 18),
              onPressed: _handleClear,
              splashRadius: 18,
              tooltip: 'Clear search',
            )
          : null,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      fillColor: widget.fillColor,
      borderColor: widget.borderColor,
      borderRadius: widget.borderRadius,
      borderWidth: widget.borderWidth,
      gradient: widget.gradient,
      gradientBorder: widget.gradientBorder ?? widget.borderGradient,
      focusedGradientBorder: widget.focusedGradientBorder,
      width: widget.width,
      height: widget.height,
      autofocus: widget.autofocus,
      semanticLabel: widget.semanticLabel,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
    );
  }
}

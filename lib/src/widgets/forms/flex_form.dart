import 'package:flutter/material.dart';

/// A wrapper around Flutter's [Form] with integrated key access and validation helpers.
class FlexForm extends StatelessWidget {
  const FlexForm({
    super.key,
    required this.child,
    this.formKey,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onChanged,
  });

  final Widget child;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      child: child,
    );
  }
}

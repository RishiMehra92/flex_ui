import 'package:flutter/services.dart';

/// Common input formatters for Flex UI input fields.
class FlexInputFormatters {
  const FlexInputFormatters._();

  /// Formatter allowing only digits.
  static TextInputFormatter get digitsOnly =>
      FilteringTextInputFormatter.digitsOnly;

  /// Formatter allowing single-line text (no newlines).
  static TextInputFormatter get singleLine =>
      FilteringTextInputFormatter.singleLineFormatter;

  /// Formatter converting characters to uppercase.
  static TextInputFormatter get upperCase => _UpperCaseTextFormatter();

  /// Formatter converting characters to lowercase.
  static TextInputFormatter get lowerCase => _LowerCaseTextFormatter();
}

class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

import 'package:flutter/widgets.dart';
import 'flex_validation_messages.dart';
import 'flex_validation_rules.dart';

/// Function signature for Flutter form field validators.
typedef FlexValidator = String? Function(String? value);

/// An extensible, universal validation library for Flutter form fields.
class FlexValidators {
  const FlexValidators._();

  static FlexValidationMessages get _messages =>
      FlexValidationMessages.defaultMessages;

  /// Validates that a string is non-null and not empty/whitespace.
  static FlexValidator required({
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message ?? _messages.required(fieldName);
      }
      return null;
    };
  }

  /// Validates an email address.
  ///
  /// Ignores empty or null values (combine with [required] if necessary).
  static FlexValidator email({
    String? message,
    String? fieldName,
    RegExp? customRegex,
  }) {
    final regex = customRegex ??
        RegExp(
          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)+$',
        );

    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      if (!regex.hasMatch(value.trim())) {
        return message ?? _messages.email(fieldName);
      }
      return null;
    };
  }

  /// Validates human names using configurable [FlexNameRules].
  static FlexValidator name({
    FlexNameRules rules = const FlexNameRules(),
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final trimmed = value.trim();

      if (trimmed.length < rules.minLength ||
          trimmed.length > rules.maxLength) {
        return message ??
            _messages.rangeLength(
                rules.minLength, rules.maxLength, fieldName ?? 'Name');
      }

      if (rules.customPattern != null) {
        if (!rules.customPattern!.hasMatch(trimmed)) {
          return message ?? _messages.name(fieldName ?? 'name');
        }
        return null;
      }

      // Check character restrictions
      for (int i = 0; i < trimmed.length; i++) {
        final char = trimmed[i];
        final code = char.codeUnitAt(0);

        final isLetter = (code >= 65 && code <= 90) ||
            (code >= 97 && code <= 122) ||
            code > 127; // Unicode / international letters
        final isDigit = code >= 48 && code <= 57;
        final isSpace = char == ' ';
        final isHyphen = char == '-';
        final isApostrophe = char == "'" || char == '’';

        if (isLetter) continue;
        if (isDigit && rules.allowNumbers) continue;
        if (isSpace && rules.allowSpaces) continue;
        if (isHyphen && rules.allowHyphens) continue;
        if (isApostrophe && rules.allowApostrophes) continue;

        return message ?? _messages.name(fieldName ?? 'name');
      }

      return null;
    };
  }

  /// Validates usernames/handles with configurable [FlexUsernameRules].
  static FlexValidator username({
    FlexUsernameRules rules = const FlexUsernameRules(),
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final trimmed = value.trim();

      if (trimmed.length < rules.minLength ||
          trimmed.length > rules.maxLength) {
        return message ??
            _messages.rangeLength(
              rules.minLength,
              rules.maxLength,
              fieldName ?? 'Username',
            );
      }

      if (rules.customPattern != null) {
        if (!rules.customPattern!.hasMatch(trimmed)) {
          return message ?? _messages.username(fieldName ?? 'username');
        }
        return null;
      }

      if (rules.requireStartWithLetter && trimmed.isNotEmpty) {
        final firstCode = trimmed.codeUnitAt(0);
        final isLetter = (firstCode >= 65 && firstCode <= 90) ||
            (firstCode >= 97 && firstCode <= 122);
        if (!isLetter) {
          return message ??
              '${fieldName ?? 'Username'} must begin with a letter';
        }
      }

      final buffer = StringBuffer(r'^[a-zA-Z0-9');
      if (rules.allowUnderscore) buffer.write('_');
      if (rules.allowDots) buffer.write(r'\.');
      if (rules.allowHyphens) buffer.write(r'\-');
      buffer.write(r']+$');

      final reg = RegExp(buffer.toString());
      if (!reg.hasMatch(trimmed)) {
        return message ?? _messages.username(fieldName ?? 'username');
      }

      return null;
    };
  }

  /// Validates passwords using configurable [FlexPasswordRules].
  static FlexValidator password({
    FlexPasswordRules rules = const FlexPasswordRules(),
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;

      if (value.length < rules.minLength) {
        return message ??
            _messages.minLength(rules.minLength, fieldName ?? 'Password');
      }

      if (rules.maxLength != null && value.length > rules.maxLength!) {
        return message ??
            _messages.maxLength(rules.maxLength!, fieldName ?? 'Password');
      }

      if (rules.customPattern != null) {
        if (!rules.customPattern!.hasMatch(value)) {
          return message ?? _messages.password(fieldName ?? 'Password');
        }
        return null;
      }

      if (rules.requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
        return message ??
            '${fieldName ?? 'Password'} must contain at least one uppercase letter';
      }

      if (rules.requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
        return message ??
            '${fieldName ?? 'Password'} must contain at least one lowercase letter';
      }

      if (rules.requireNumber && !RegExp(r'[0-9]').hasMatch(value)) {
        return message ??
            '${fieldName ?? 'Password'} must contain at least one number';
      }

      if (rules.requireSpecialCharacter) {
        final hasSpecial = value
            .split('')
            .any((char) => rules.allowedSpecialCharacters.contains(char));
        if (!hasSpecial) {
          return message ??
              '${fieldName ?? 'Password'} must contain at least one special character';
        }
      }

      return null;
    };
  }

  /// Validates strong passwords with upper, lower, number, and special character rules.
  static FlexValidator strongPassword({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecialCharacter = true,
    String? message,
    String? fieldName,
  }) {
    return password(
      rules: FlexPasswordRules(
        minLength: minLength,
        requireUppercase: requireUppercase,
        requireLowercase: requireLowercase,
        requireNumber: requireNumber,
        requireSpecialCharacter: requireSpecialCharacter,
      ),
      message: message ??
          _messages.strongPassword(
            minLength: minLength,
            requireUppercase: requireUppercase,
            requireLowercase: requireLowercase,
            requireNumber: requireNumber,
            requireSpecial: requireSpecialCharacter,
          ),
      fieldName: fieldName,
    );
  }

  /// Cross-field matching validator (e.g. Confirm Password).
  ///
  /// [target] can be:
  /// - A direct `String`
  /// - A callback `String? Function()` returning the target value
  /// - A `TextEditingController` of the target field
  static FlexValidator match(
    dynamic target, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;

      String? targetValue;
      if (target is String) {
        targetValue = target;
      } else if (target is String? Function()) {
        targetValue = target();
      } else if (target is TextEditingController) {
        targetValue = target.text;
      }

      if (value != targetValue) {
        return message ?? _messages.match(fieldName);
      }
      return null;
    };
  }

  /// Validates phone numbers with configurable [FlexPhoneRules].
  static FlexValidator phone({
    FlexPhoneRules rules = const FlexPhoneRules(),
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final trimmed = value.trim();

      if (rules.customPattern != null) {
        if (!rules.customPattern!.hasMatch(trimmed)) {
          return message ?? _messages.phone(fieldName);
        }
        return null;
      }

      // Check digits count
      final digitsOnly = trimmed.replaceAll(RegExp(r'\D'), '');
      if (digitsOnly.length < rules.minLength ||
          digitsOnly.length > rules.maxLength) {
        return message ?? _messages.phone(fieldName);
      }

      final buffer = StringBuffer(r'^');
      if (rules.allowPlus) buffer.write(r'\+?');
      buffer.write(r'[\d');
      if (rules.allowSpaces) buffer.write(r'\s');
      if (rules.allowDashes) buffer.write(r'\-');
      if (rules.allowParentheses) buffer.write(r'()');
      buffer.write(r']+$');

      final reg = RegExp(buffer.toString());
      if (!reg.hasMatch(trimmed)) {
        return message ?? _messages.phone(fieldName);
      }

      return null;
    };
  }

  /// Validates numeric inputs with configurable [FlexNumberRules].
  static FlexValidator number({
    FlexNumberRules rules = const FlexNumberRules(),
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final trimmed = value.trim();

      if (rules.customPattern != null) {
        if (!rules.customPattern!.hasMatch(trimmed)) {
          return message ?? _messages.number(fieldName);
        }
        return null;
      }

      final parsed = num.tryParse(trimmed);
      if (parsed == null) {
        return message ?? _messages.number(fieldName);
      }

      if (!rules.allowDecimals && trimmed.contains('.')) {
        return message ?? '${fieldName ?? 'Value'} must be an integer';
      }

      if (!rules.allowNegative && parsed < 0) {
        return message ?? '${fieldName ?? 'Value'} cannot be negative';
      }

      if (rules.minValue != null && parsed < rules.minValue!) {
        return message ?? _messages.minValue(rules.minValue!, fieldName);
      }

      if (rules.maxValue != null && parsed > rules.maxValue!) {
        return message ?? _messages.maxValue(rules.maxValue!, fieldName);
      }

      return null;
    };
  }

  /// Validates minimum string character length.
  static FlexValidator minLength(
    int length, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (value.length < length) {
        return message ?? _messages.minLength(length, fieldName);
      }
      return null;
    };
  }

  /// Validates maximum string character length.
  static FlexValidator maxLength(
    int length, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (value.length > length) {
        return message ?? _messages.maxLength(length, fieldName);
      }
      return null;
    };
  }

  /// Validates that string length falls within [[min], [max]].
  static FlexValidator rangeLength(
    int min,
    int max, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (value.length < min || value.length > max) {
        return message ?? _messages.rangeLength(min, max, fieldName);
      }
      return null;
    };
  }

  /// Validates that numeric value is at least [min].
  static FlexValidator minValue(
    num min, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final parsed = num.tryParse(value.trim());
      if (parsed == null) return _messages.number(fieldName);
      if (parsed < min) {
        return message ?? _messages.minValue(min, fieldName);
      }
      return null;
    };
  }

  /// Validates that numeric value is at most [max].
  static FlexValidator maxValue(
    num max, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final parsed = num.tryParse(value.trim());
      if (parsed == null) return _messages.number(fieldName);
      if (parsed > max) {
        return message ?? _messages.maxValue(max, fieldName);
      }
      return null;
    };
  }

  /// Validates that numeric value falls within [[min], [max]].
  static FlexValidator rangeValue(
    num min,
    num max, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final parsed = num.tryParse(value.trim());
      if (parsed == null) return _messages.number(fieldName);
      if (parsed < min || parsed > max) {
        return message ?? _messages.rangeValue(min, max, fieldName);
      }
      return null;
    };
  }

  /// Validates that input contains letters only.
  static FlexValidator lettersOnly({
    bool allowSpaces = false,
    String? message,
    String? fieldName,
  }) {
    final pattern = allowSpaces ? r'^[a-zA-Z\s]+$' : r'^[a-zA-Z]+$';
    final reg = RegExp(pattern);
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!reg.hasMatch(value)) {
        return message ?? _messages.lettersOnly(fieldName);
      }
      return null;
    };
  }

  /// Validates that input contains digits only.
  static FlexValidator digitsOnly({
    String? message,
    String? fieldName,
  }) {
    final reg = RegExp(r'^\d+$');
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!reg.hasMatch(value)) {
        return message ?? _messages.digitsOnly(fieldName);
      }
      return null;
    };
  }

  /// Validates that input contains letters and numbers only.
  static FlexValidator alphanumeric({
    bool allowSpaces = false,
    String? message,
    String? fieldName,
  }) {
    final pattern = allowSpaces ? r'^[a-zA-Z0-9\s]+$' : r'^[a-zA-Z0-9]+$';
    final reg = RegExp(pattern);
    return (value) {
      if (value == null || value.isEmpty) return null;
      if (!reg.hasMatch(value)) {
        return message ?? _messages.alphanumeric(fieldName);
      }
      return null;
    };
  }

  /// Validates web URLs.
  static FlexValidator url({
    List<String> allowedProtocols = const ['http', 'https'],
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) return null;
      final uri = Uri.tryParse(value.trim());
      if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
        return message ?? _messages.url(fieldName);
      }
      if (!allowedProtocols.contains(uri.scheme.toLowerCase())) {
        return message ??
            '${fieldName ?? 'URL'} must use ${allowedProtocols.join(' or ')}';
      }
      return null;
    };
  }

  /// Validates input against a custom regular expression [pattern].
  static FlexValidator pattern(
    Pattern pattern, {
    String? message,
    String? fieldName,
  }) {
    return (value) {
      if (value == null || value.isEmpty) return null;
      final reg = pattern is RegExp ? pattern : RegExp(pattern.toString());
      if (!reg.hasMatch(value)) {
        return message ?? _messages.pattern(fieldName);
      }
      return null;
    };
  }

  /// Wraps a custom validator function.
  static FlexValidator custom(String? Function(String? value) validator) {
    return validator;
  }

  /// Combines multiple validators, evaluating in order and stopping at the first error.
  static FlexValidator compose(List<FlexValidator> validators) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  /// Combines multiple validators, evaluating all and joining errors with [separator].
  static FlexValidator composeAll(
    List<FlexValidator> validators, {
    String separator = '\n',
  }) {
    return (value) {
      final errors = <String>[];
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          errors.add(error);
        }
      }
      return errors.isEmpty ? null : errors.join(separator);
    };
  }

  /// Returns a fluent builder for composing multiple validation rules.
  static FlexValidatorBuilder builder() => FlexValidatorBuilder();
}

/// Fluent builder for composing multiple [FlexValidator] rules cleanly.
class FlexValidatorBuilder {
  final List<FlexValidator> _validators = [];

  /// Requires the field to be non-empty.
  FlexValidatorBuilder required({String? message, String? fieldName}) {
    _validators
        .add(FlexValidators.required(message: message, fieldName: fieldName));
    return this;
  }

  /// Validates email address format.
  FlexValidatorBuilder email(
      {String? message, String? fieldName, RegExp? customRegex}) {
    _validators.add(FlexValidators.email(
        message: message, fieldName: fieldName, customRegex: customRegex));
    return this;
  }

  /// Validates minimum character length.
  FlexValidatorBuilder minLength(int length,
      {String? message, String? fieldName}) {
    _validators.add(FlexValidators.minLength(length,
        message: message, fieldName: fieldName));
    return this;
  }

  /// Validates maximum character length.
  FlexValidatorBuilder maxLength(int length,
      {String? message, String? fieldName}) {
    _validators.add(FlexValidators.maxLength(length,
        message: message, fieldName: fieldName));
    return this;
  }

  /// Validates name input.
  FlexValidatorBuilder name(
      {FlexNameRules rules = const FlexNameRules(),
      String? message,
      String? fieldName}) {
    _validators.add(FlexValidators.name(
        rules: rules, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates username input.
  FlexValidatorBuilder username(
      {FlexUsernameRules rules = const FlexUsernameRules(),
      String? message,
      String? fieldName}) {
    _validators.add(FlexValidators.username(
        rules: rules, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates password rules.
  FlexValidatorBuilder password(
      {FlexPasswordRules rules = const FlexPasswordRules(),
      String? message,
      String? fieldName}) {
    _validators.add(FlexValidators.password(
        rules: rules, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates strong password rules.
  FlexValidatorBuilder strongPassword({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecialCharacter = true,
    String? message,
    String? fieldName,
  }) {
    _validators.add(FlexValidators.strongPassword(
      minLength: minLength,
      requireUppercase: requireUppercase,
      requireLowercase: requireLowercase,
      requireNumber: requireNumber,
      requireSpecialCharacter: requireSpecialCharacter,
      message: message,
      fieldName: fieldName,
    ));
    return this;
  }

  /// Validates that field value matches [target].
  FlexValidatorBuilder match(dynamic target,
      {String? message, String? fieldName}) {
    _validators.add(
        FlexValidators.match(target, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates phone number input.
  FlexValidatorBuilder phone(
      {FlexPhoneRules rules = const FlexPhoneRules(),
      String? message,
      String? fieldName}) {
    _validators.add(FlexValidators.phone(
        rules: rules, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates numeric input.
  FlexValidatorBuilder number(
      {FlexNumberRules rules = const FlexNumberRules(),
      String? message,
      String? fieldName}) {
    _validators.add(FlexValidators.number(
        rules: rules, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates minimum numeric value.
  FlexValidatorBuilder minValue(num min, {String? message, String? fieldName}) {
    _validators.add(
        FlexValidators.minValue(min, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates maximum numeric value.
  FlexValidatorBuilder maxValue(num max, {String? message, String? fieldName}) {
    _validators.add(
        FlexValidators.maxValue(max, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates letters only.
  FlexValidatorBuilder lettersOnly(
      {bool allowSpaces = false, String? message, String? fieldName}) {
    _validators.add(FlexValidators.lettersOnly(
        allowSpaces: allowSpaces, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates digits only.
  FlexValidatorBuilder digitsOnly({String? message, String? fieldName}) {
    _validators
        .add(FlexValidators.digitsOnly(message: message, fieldName: fieldName));
    return this;
  }

  /// Validates alphanumeric characters.
  FlexValidatorBuilder alphanumeric(
      {bool allowSpaces = false, String? message, String? fieldName}) {
    _validators.add(FlexValidators.alphanumeric(
        allowSpaces: allowSpaces, message: message, fieldName: fieldName));
    return this;
  }

  /// Validates URL.
  FlexValidatorBuilder url(
      {List<String> allowedProtocols = const ['http', 'https'],
      String? message,
      String? fieldName}) {
    _validators.add(FlexValidators.url(
        allowedProtocols: allowedProtocols,
        message: message,
        fieldName: fieldName));
    return this;
  }

  /// Validates against regular expression pattern.
  FlexValidatorBuilder pattern(Pattern pattern,
      {String? message, String? fieldName}) {
    _validators.add(FlexValidators.pattern(pattern,
        message: message, fieldName: fieldName));
    return this;
  }

  /// Appends a custom validator function.
  FlexValidatorBuilder custom(String? Function(String? value) validator) {
    _validators.add(validator);
    return this;
  }

  /// Builds a composed validator stopping at the first error.
  FlexValidator build() => FlexValidators.compose(_validators);

  /// Builds a composed validator evaluating all rules and joining errors.
  FlexValidator buildAll({String separator = '\n'}) =>
      FlexValidators.composeAll(_validators, separator: separator);
}

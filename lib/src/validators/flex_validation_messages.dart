/// Configurable and localizable error messages for Flex UI validators.
class FlexValidationMessages {
  const FlexValidationMessages();

  /// The active default messages instance used by all validators unless overridden.
  static FlexValidationMessages defaultMessages =
      const FlexValidationMessages();

  /// Message when a required field is empty.
  String required([String? fieldName]) =>
      fieldName != null ? '$fieldName is required' : 'This field is required';

  /// Message when an email address is invalid.
  String email([String? fieldName]) => 'Please enter a valid email address';

  /// Message when a value is shorter than [length] characters.
  String minLength(int length, [String? fieldName]) => fieldName != null
      ? '$fieldName must be at least $length characters'
      : 'Must be at least $length characters';

  /// Message when a value is longer than [length] characters.
  String maxLength(int length, [String? fieldName]) => fieldName != null
      ? '$fieldName must be at most $length characters'
      : 'Must be at most $length characters';

  /// Message when a string length is outside [[min], [max]].
  String rangeLength(int min, int max, [String? fieldName]) => fieldName != null
      ? '$fieldName must be between $min and $max characters'
      : 'Must be between $min and $max characters';

  /// Message when a numeric value is less than [min].
  String minValue(num min, [String? fieldName]) => fieldName != null
      ? '$fieldName must be at least $min'
      : 'Must be at least $min';

  /// Message when a numeric value is greater than [max].
  String maxValue(num max, [String? fieldName]) => fieldName != null
      ? '$fieldName must be at most $max'
      : 'Must be at most $max';

  /// Message when a numeric value is outside [[min], [max]].
  String rangeValue(num min, num max, [String? fieldName]) => fieldName != null
      ? '$fieldName must be between $min and $max'
      : 'Must be between $min and $max';

  /// Message when a value is not a valid number.
  String number([String? fieldName]) => fieldName != null
      ? '$fieldName must be a valid number'
      : 'Please enter a valid number';

  /// Message when a phone number format is invalid.
  String phone([String? fieldName]) => fieldName != null
      ? 'Please enter a valid phone number for $fieldName'
      : 'Please enter a valid phone number';

  /// Message when two fields do not match (e.g. password & confirm password).
  String match([String? fieldName]) =>
      fieldName != null ? '$fieldName does not match' : 'Values do not match';

  /// Message when a password does not meet basic criteria.
  String password([String? fieldName]) => fieldName != null
      ? '$fieldName does not meet security requirements'
      : 'Password does not meet requirements';

  /// Message when a strong password requirement is violated.
  String strongPassword({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumber = true,
    bool requireSpecial = true,
  }) {
    final requirements = <String>[];
    requirements.add('at least $minLength characters');
    if (requireUppercase) requirements.add('an uppercase letter');
    if (requireLowercase) requirements.add('a lowercase letter');
    if (requireNumber) requirements.add('a number');
    if (requireSpecial) requirements.add('a special character');

    return 'Password must contain ${requirements.join(', ')}';
  }

  /// Message when a URL is invalid.
  String url([String? fieldName]) => fieldName != null
      ? 'Please enter a valid URL for $fieldName'
      : 'Please enter a valid URL';

  /// Message when an input contains non-letter characters.
  String lettersOnly([String? fieldName]) => fieldName != null
      ? '$fieldName must contain letters only'
      : 'Only letters are allowed';

  /// Message when an input contains non-digit characters.
  String digitsOnly([String? fieldName]) => fieldName != null
      ? '$fieldName must contain digits only'
      : 'Only digits are allowed';

  /// Message when an input contains non-alphanumeric characters.
  String alphanumeric([String? fieldName]) => fieldName != null
      ? '$fieldName must contain letters and numbers only'
      : 'Only letters and numbers are allowed';

  /// Message for a generic regular expression mismatch.
  String pattern([String? fieldName]) =>
      fieldName != null ? '$fieldName format is invalid' : 'Invalid format';

  /// Message for an invalid name.
  String name([String? fieldName]) => fieldName != null
      ? 'Please enter a valid $fieldName'
      : 'Please enter a valid name';

  /// Message for an invalid username.
  String username([String? fieldName]) => fieldName != null
      ? 'Please enter a valid $fieldName'
      : 'Please enter a valid username';
}

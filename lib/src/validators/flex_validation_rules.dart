/// Configurable rule set for password validation.
class FlexPasswordRules {
  const FlexPasswordRules({
    this.minLength = 6,
    this.maxLength,
    this.requireUppercase = false,
    this.requireLowercase = false,
    this.requireNumber = false,
    this.requireSpecialCharacter = false,
    this.allowedSpecialCharacters = r'@$!%*?&#^()_-+=<>.,:;~[]{}|/',
    this.customPattern,
  });

  /// Preset for a strong enterprise password.
  const FlexPasswordRules.strong({
    this.minLength = 8,
    this.maxLength,
    this.requireUppercase = true,
    this.requireLowercase = true,
    this.requireNumber = true,
    this.requireSpecialCharacter = true,
    this.allowedSpecialCharacters = r'@$!%*?&#^()_-+=<>.,:;~[]{}|/',
    this.customPattern,
  });

  final int minLength;
  final int? maxLength;
  final bool requireUppercase;
  final bool requireLowercase;
  final bool requireNumber;
  final bool requireSpecialCharacter;
  final String allowedSpecialCharacters;
  final RegExp? customPattern;
}

/// Configurable rule set for person/display name validation.
class FlexNameRules {
  const FlexNameRules({
    this.minLength = 1,
    this.maxLength = 100,
    this.allowSpaces = true,
    this.allowNumbers = false,
    this.allowHyphens = true,
    this.allowApostrophes = true,
    this.customPattern,
  });

  final int minLength;
  final int maxLength;
  final bool allowSpaces;
  final bool allowNumbers;
  final bool allowHyphens;
  final bool allowApostrophes;
  final RegExp? customPattern;
}

/// Configurable rule set for username / handle validation.
class FlexUsernameRules {
  const FlexUsernameRules({
    this.minLength = 3,
    this.maxLength = 30,
    this.allowUnderscore = true,
    this.allowDots = true,
    this.allowHyphens = true,
    this.requireStartWithLetter = false,
    this.customPattern,
  });

  final int minLength;
  final int maxLength;
  final bool allowUnderscore;
  final bool allowDots;
  final bool allowHyphens;
  final bool requireStartWithLetter;
  final RegExp? customPattern;
}

/// Configurable rule set for phone number validation.
class FlexPhoneRules {
  const FlexPhoneRules({
    this.minLength = 7,
    this.maxLength = 17,
    this.allowPlus = true,
    this.allowDashes = true,
    this.allowSpaces = true,
    this.allowParentheses = true,
    this.customPattern,
  });

  final int minLength;
  final int maxLength;
  final bool allowPlus;
  final bool allowDashes;
  final bool allowSpaces;
  final bool allowParentheses;
  final RegExp? customPattern;
}

/// Configurable rule set for numeric input validation.
class FlexNumberRules {
  const FlexNumberRules({
    this.minValue,
    this.maxValue,
    this.allowDecimals = true,
    this.allowNegative = false,
    this.customPattern,
  });

  final num? minValue;
  final num? maxValue;
  final bool allowDecimals;
  final bool allowNegative;
  final RegExp? customPattern;
}

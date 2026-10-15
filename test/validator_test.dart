import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  group('FlexValidators.required', () {
    final validator = FlexValidators.required();

    test('returns error for null, empty, or whitespace', () {
      expect(validator(null), 'This field is required');
      expect(validator(''), 'This field is required');
      expect(validator('   '), 'This field is required');
    });

    test('returns null for non-empty text', () {
      expect(validator('hello'), isNull);
      expect(validator(' a '), isNull);
    });

    test('supports custom error message and field name', () {
      final custom = FlexValidators.required(message: 'Email cannot be blank');
      expect(custom(''), 'Email cannot be blank');

      final withField = FlexValidators.required(fieldName: 'First Name');
      expect(withField(''), 'First Name is required');
    });
  });

  group('FlexValidators.email', () {
    final validator = FlexValidators.email();

    test('passes valid emails', () {
      expect(validator('user@example.com'), isNull);
      expect(validator('first.last@domain.co.uk'), isNull);
      expect(validator('user+tag@gmail.com'), isNull);
    });

    test('fails invalid emails', () {
      expect(validator('plainaddress'), 'Please enter a valid email address');
      expect(validator('@missingusername.com'),
          'Please enter a valid email address');
      expect(validator('username@.com'), 'Please enter a valid email address');
      expect(
          validator('username@domain'), 'Please enter a valid email address');
    });

    test('ignores null or empty string (non-required by default)', () {
      expect(validator(null), isNull);
      expect(validator(''), isNull);
    });

    test('supports custom message', () {
      final custom = FlexValidators.email(message: 'Invalid email');
      expect(custom('bad'), 'Invalid email');
    });
  });

  group('FlexValidators.name', () {
    final validator = FlexValidators.name();

    test('passes typical human names', () {
      expect(validator('Jane Doe'), isNull);
      expect(validator("Mary-Jane O'Connor"), isNull);
      expect(validator('Renée Dupont'), isNull);
    });

    test('rejects digits or symbols when disallowed', () {
      expect(validator('John Doe 123'), isNotNull);
      expect(validator('Jane @Doe'), isNotNull);
    });

    test('respects configurable rules', () {
      final allowNumbersValidator = FlexValidators.name(
        rules: const FlexNameRules(allowNumbers: true),
      );
      expect(allowNumbersValidator('R2-D2'), isNull);

      final noSpacesValidator = FlexValidators.name(
        rules: const FlexNameRules(allowSpaces: false),
      );
      expect(noSpacesValidator('John Doe'), isNotNull);
    });
  });

  group('FlexValidators.username', () {
    final validator = FlexValidators.username();

    test('passes valid handles', () {
      expect(validator('john_doe'), isNull);
      expect(validator('john.doe'), isNull);
      expect(validator('john-doe'), isNull);
      expect(validator('user123'), isNull);
    });

    test('fails invalid handles', () {
      expect(validator('ab'), isNotNull); // below default minLength 3
      expect(validator('user@name'), isNotNull);
      expect(validator('user name'), isNotNull);
    });

    test('respects requireStartWithLetter', () {
      final strict = FlexValidators.username(
        rules: const FlexUsernameRules(requireStartWithLetter: true),
      );
      expect(strict('123user'), isNotNull);
      expect(strict('user123'), isNull);
    });
  });

  group('FlexValidators.password & strongPassword', () {
    test('validates basic password length', () {
      final validator = FlexValidators.password(
        rules: const FlexPasswordRules(minLength: 6),
      );
      expect(validator('12345'), isNotNull);
      expect(validator('123456'), isNull);
    });

    test('validates strong password rules', () {
      final validator = FlexValidators.strongPassword(
        minLength: 8,
        requireUppercase: true,
        requireLowercase: true,
        requireNumber: true,
        requireSpecialCharacter: true,
      );

      expect(validator('weak'), isNotNull);
      expect(validator('password123'), isNotNull); // no uppercase or special
      expect(validator('Password123'), isNotNull); // no special
      expect(validator('Password!'), isNotNull); // no number
      expect(validator('P@ssword1'), isNull); // passes all
    });
  });

  group('FlexValidators.match (Cross-Field / Confirm Password)', () {
    test('matches direct string', () {
      final validator = FlexValidators.match('Secret123');
      expect(validator('Secret123'), isNull);
      expect(validator('Different'), 'Values do not match');
    });

    test('matches callback value dynamically', () {
      String password = 'InitialPassword';
      final validator = FlexValidators.match(() => password);

      expect(validator('InitialPassword'), isNull);
      expect(validator('Mismatch'), isNotNull);

      // Mutate password
      password = 'NewPassword';
      expect(validator('NewPassword'), isNull);
      expect(validator('InitialPassword'), isNotNull);
    });

    test('matches TextEditingController dynamically', () {
      final controller = TextEditingController(text: 'pass123');
      final validator = FlexValidators.match(controller);

      expect(validator('pass123'), isNull);
      expect(validator('wrong'), isNotNull);

      controller.text = 'pass456';
      expect(validator('pass456'), isNull);
      expect(validator('pass123'), isNotNull);
    });
  });

  group('FlexValidators.phone', () {
    final validator = FlexValidators.phone();

    test('passes standard and international phones', () {
      expect(validator('+1 (555) 123-4567'), isNull);
      expect(validator('+44 20 7946 0958'), isNull);
      expect(validator('9876543210'), isNull);
    });

    test('fails invalid characters and too-short numbers', () {
      expect(validator('123'), isNotNull);
      expect(validator('phone#number'), isNotNull);
    });
  });

  group('FlexValidators.number, minValue, maxValue', () {
    test('validates numeric inputs', () {
      final validator = FlexValidators.number();
      expect(validator('42'), isNull);
      expect(validator('3.14'), isNull);
      expect(validator('not a number'), isNotNull);
    });

    test('validates minimum and maximum value ranges', () {
      final range = FlexValidators.rangeValue(10, 100);
      expect(range('5'), isNotNull);
      expect(range('10'), isNull);
      expect(range('50'), isNull);
      expect(range('100'), isNull);
      expect(range('150'), isNotNull);
    });
  });

  group('FlexValidators.lettersOnly, digitsOnly, alphanumeric', () {
    test('lettersOnly', () {
      final validator = FlexValidators.lettersOnly(allowSpaces: true);
      expect(validator('Hello World'), isNull);
      expect(validator('Hello123'), isNotNull);
    });

    test('digitsOnly', () {
      final validator = FlexValidators.digitsOnly();
      expect(validator('123456'), isNull);
      expect(validator('123a'), isNotNull);
    });

    test('alphanumeric', () {
      final validator = FlexValidators.alphanumeric();
      expect(validator('Alpha123'), isNull);
      expect(validator('Alpha 123'), isNotNull);
    });
  });

  group('FlexValidators.url', () {
    final validator = FlexValidators.url();

    test('passes valid URLs', () {
      expect(validator('https://example.com'), isNull);
      expect(validator('http://localhost:8080/path'), isNull);
    });

    test('fails invalid URLs', () {
      expect(validator('ftp://example.com'), isNotNull);
      expect(validator('not a url'), isNotNull);
    });
  });

  group('FlexValidators.compose and FlexValidatorBuilder', () {
    test('compose stops at first error', () {
      final composed = FlexValidators.compose([
        FlexValidators.required(message: 'Required'),
        FlexValidators.minLength(5, message: 'Too short'),
        FlexValidators.email(message: 'Invalid email'),
      ]);

      expect(composed(''), 'Required');
      expect(composed('abc'), 'Too short');
      expect(composed('abcdef'), 'Invalid email');
      expect(composed('user@example.com'), isNull);
    });

    test('composeAll returns all errors', () {
      final composed = FlexValidators.composeAll([
        FlexValidators.minLength(5, message: 'Error 1'),
        FlexValidators.pattern(RegExp(r'\d'), message: 'Error 2'),
      ], separator: ' | ');

      expect(composed('abc'), 'Error 1 | Error 2');
    });

    test('FlexValidatorBuilder fluent chaining', () {
      final validator = FlexValidators.builder()
          .required(message: 'Name is required')
          .minLength(3, message: 'Min 3 chars')
          .maxLength(20)
          .build();

      expect(validator(''), 'Name is required');
      expect(validator('ab'), 'Min 3 chars');
      expect(validator('Valid Name'), isNull);
    });
  });

  group('FlexValidationMessages Localization and Overrides', () {
    test('custom global messages work', () {
      final original = FlexValidationMessages.defaultMessages;

      try {
        FlexValidationMessages.defaultMessages =
            const _FrenchValidationMessages();
        final validator = FlexValidators.required();
        expect(validator(''), 'Ce champ est obligatoire');
      } finally {
        FlexValidationMessages.defaultMessages = original;
      }
    });
  });
}

class _FrenchValidationMessages extends FlexValidationMessages {
  const _FrenchValidationMessages();

  @override
  String required([String? fieldName]) => 'Ce champ est obligatoire';
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  group('FlexInputField Tests', () {
    testWidgets('renders label, hint, and handles text input', (tester) async {
      String changedText = '';
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexInputField(
              controller: controller,
              label: 'Full Name',
              hintText: 'Enter your name',
              onChanged: (val) => changedText = val,
            ),
          ),
        ),
      );

      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Enter your name'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Jane Doe');
      await tester.pumpAndSettle();

      expect(changedText, 'Jane Doe');
      expect(controller.text, 'Jane Doe');
    });

    testWidgets('renders required asterisk indicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexInputField(
              label: 'Username',
              isRequired: true,
            ),
          ),
        ),
      );

      expect(find.byType(RichText), findsWidgets);
    });

    testWidgets('validates input within Form', (tester) async {
      final formKey = GlobalKey<FormState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: FlexInputField(
                label: 'Email',
                validator: (val) =>
                    (val == null || val.isEmpty) ? 'Required field' : null,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Required field'), findsNothing);

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('Required field'), findsOneWidget);
    });
  });

  group('FlexPasswordField Tests', () {
    testWidgets('toggles password obscuring on eye icon tap', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexPasswordField(
              label: 'Password',
              initialValue: 'secret123',
            ),
          ),
        ),
      );

      // Verify eye icon is present
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);

      // Tap to toggle visibility
      await tester.tap(find.byIcon(Icons.visibility_outlined));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });

  group('FlexEmailField Tests', () {
    testWidgets('validates email format', (tester) async {
      final formKey = GlobalKey<FormState>();
      final controller = TextEditingController(text: 'invalid-email');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: FlexEmailField(
                controller: controller,
                isRequired: true,
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);

      controller.text = 'valid@example.com';
      formKey.currentState!.validate();
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsNothing);
    });
  });
}

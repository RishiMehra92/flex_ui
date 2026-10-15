import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  group('FlexButton Tests', () {
    testWidgets('renders label and handles tap callback', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexButton(
              label: 'Submit',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Submit'), findsOneWidget);
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('does not trigger onPressed when disabled', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexButton(
              label: 'Disabled Button',
              isDisabled: true,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Button'));
      await tester.pumpAndSettle();
      expect(tapped, isFalse);
    });

    testWidgets('renders loading state and derived loading text',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexButton(
              label: 'Save',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.text('Saving...'), findsOneWidget);
      expect(find.byType(FlexButton), findsOneWidget);
    });

    testWidgets('renders explicit loading text if provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexButton(
              label: 'Submit',
              loadingText: 'Please wait...',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.text('Please wait...'), findsOneWidget);
    });

    testWidgets('renders prefix and suffix icons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexButton(
              label: 'Download',
              prefixIcon: Icons.download,
              suffixIcon: Icons.arrow_forward,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.download), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.text('Download'), findsOneWidget);
    });
  });

  group('FlexButton Variants', () {
    testWidgets('FlexOutlinedButton renders properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexOutlinedButton(
              label: 'Outlined',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Outlined'), findsOneWidget);
    });

    testWidgets('FlexTextButton renders properly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexTextButton(
              label: 'Text Button',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Text Button'), findsOneWidget);
    });

    testWidgets('FlexIconButton renders icon and tooltip', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexIconButton(
              icon: Icons.favorite,
              tooltip: 'Like',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('FlexFloatingActionButton renders properly', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            floatingActionButton: FlexFloatingActionButton.extended(
              label: 'Add Item',
              icon: const Icon(Icons.add),
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Add Item'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.text('Add Item'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });
  });
}

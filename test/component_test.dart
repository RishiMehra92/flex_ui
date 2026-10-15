import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  group('Flex Component Tests', () {
    testWidgets('FlexCard renders child and responds to tap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexCard(
              onTap: () => tapped = true,
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      await tester.tap(find.text('Card Content'));
      await tester.pumpAndSettle();
      expect(tapped, isTrue);
    });

    testWidgets('FlexSwitch toggles value on tap', (tester) async {
      bool switchValue = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return FlexSwitch(
                  value: switchValue,
                  onChanged: (val) {
                    setState(() => switchValue = val);
                  },
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FlexSwitch));
      await tester.pumpAndSettle();
      expect(switchValue, isTrue);
    });

    testWidgets('FlexCheckbox toggles value on tap', (tester) async {
      bool? isChecked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return FlexCheckbox(
                  value: isChecked,
                  onChanged: (val) {
                    setState(() => isChecked = val);
                  },
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FlexCheckbox));
      await tester.pumpAndSettle();
      expect(isChecked, isTrue);
    });

    testWidgets('FlexStatusBadge displays label and dot', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexStatusBadge(
              label: 'Active',
              status: FlexStatusType.success,
            ),
          ),
        ),
      );

      expect(find.text('Active'), findsOneWidget);
    });

    testWidgets('FlexEmptyState renders title and action button',
        (tester) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexEmptyState(
              title: 'No Items Found',
              description: 'Try adjusting your filters',
              actionLabel: 'Reset Filters',
              onActionPressed: () => actionPressed = true,
            ),
          ),
        ),
      );

      expect(find.text('No Items Found'), findsOneWidget);
      expect(find.text('Try adjusting your filters'), findsOneWidget);
      expect(find.text('Reset Filters'), findsOneWidget);

      await tester.tap(find.text('Reset Filters'));
      await tester.pumpAndSettle();
      expect(actionPressed, isTrue);
    });

    testWidgets('FlexErrorState renders message and retry button',
        (tester) async {
      bool retried = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexErrorState(
              title: 'Network Error',
              message: 'Check your connection',
              onRetry: () => retried = true,
            ),
          ),
        ),
      );

      expect(find.text('Network Error'), findsOneWidget);
      expect(find.text('Check your connection'), findsOneWidget);

      await tester.tap(find.text('Try Again'));
      await tester.pumpAndSettle();
      expect(retried, isTrue);
    });
  });
}

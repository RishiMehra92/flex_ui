import 'package:flex_ui/flex_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexText Tests', () {
    testWidgets('renders using named text, fontSize, and color without style',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexText(
              text: 'Unable to load diagram image',
              fontSize: 12,
              color: Colors.amber,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

      final textFinder = find.text('Unable to load diagram image');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 12);
      expect(textWidget.style?.color, Colors.amber);
      expect(textWidget.style?.fontWeight, FontWeight.w600);
    });

    testWidgets('supports all individual typography options directly',
        (tester) async {
      const shadows = [
        Shadow(color: Colors.black26, offset: Offset(1, 1), blurRadius: 2),
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexText(
              text: 'Rich Typography',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              letterSpacing: 1.5,
              wordSpacing: 3.0,
              height: 1.4,
              backgroundColor: Colors.yellow,
              decoration: TextDecoration.underline,
              decorationColor: Colors.red,
              decorationStyle: TextDecorationStyle.wavy,
              decorationThickness: 2.0,
              fontFamily: 'Roboto',
              shadows: shadows,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              semanticsLabel: 'Accessibility Label',
            ),
          ),
        ),
      );

      final textFinder = find.text('Rich Typography');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 18);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.fontStyle, FontStyle.italic);
      expect(textWidget.style?.letterSpacing, 1.5);
      expect(textWidget.style?.wordSpacing, 3.0);
      expect(textWidget.style?.height, 1.4);
      expect(textWidget.style?.backgroundColor, Colors.yellow);
      expect(textWidget.style?.decoration, TextDecoration.underline);
      expect(textWidget.style?.decorationColor, Colors.red);
      expect(textWidget.style?.decorationStyle, TextDecorationStyle.wavy);
      expect(textWidget.style?.decorationThickness, 2.0);
      expect(textWidget.style?.fontFamily, 'Roboto');
      expect(textWidget.style?.shadows, shadows);
      expect(textWidget.textAlign, TextAlign.center);
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.softWrap, true);
      expect(textWidget.semanticsLabel, 'Accessibility Label');
    });

    testWidgets('supports FlexText.data positional constructor',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexText.data(
              'Positional Text',
              fontSize: 14,
              color: Colors.green,
            ),
          ),
        ),
      );

      final textFinder = find.text('Positional Text');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 14);
      expect(textWidget.style?.color, Colors.green);
    });

    testWidgets('supports semantic variant resolution from FlexUITheme',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light().withFlexUI(FlexUIThemeData.light()),
          home: const Scaffold(
            body: FlexText(
              text: 'Headline Large Text',
              variant: FlexTextStyleVariant.headlineLarge,
            ),
          ),
        ),
      );

      final textFinder = find.text('Headline Large Text');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 24);
    });

    testWidgets(
        'individual properties override values in optional style parameter',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexText(
              text: 'Merged Text',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.w300,
              ),
              fontSize: 16, // overrides style
              color: Colors.purple, // overrides style
            ),
          ),
        ),
      );

      final textFinder = find.text('Merged Text');
      expect(textFinder, findsOneWidget);

      final textWidget = tester.widget<Text>(textFinder);
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.color, Colors.purple);
      expect(textWidget.style?.fontWeight,
          FontWeight.w300); // preserved from style
    });

    testWidgets('renders gradient text using ShaderMask', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexText(
              text: 'Gradient Title',
              gradient: FlexGradient.sunset,
              fontSize: 22,
            ),
          ),
        ),
      );

      expect(find.text('Gradient Title'), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
    });
  });
}

import 'dart:math' as math;
import 'package:flex_ui/flex_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexGradient Core Tests', () {
    test('Linear FlexGradient creation and properties', () {
      const gradient = FlexGradient(
        colors: [Color(0xFF6750A4), Color(0xFF9C27B0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

      expect(gradient.type, FlexGradientType.linear);
      expect(gradient.colors.length, 2);
      expect(gradient.begin, Alignment.topLeft);
      expect(gradient.end, Alignment.bottomRight);
      expect(gradient.opacity, 1.0);
      expect(gradient.effectiveColors, gradient.colors);
    });

    test('Radial FlexGradient creation', () {
      const gradient = FlexGradient.radial(
        colors: [Colors.red, Colors.blue],
        center: Alignment.center,
        radius: 0.8,
      );

      expect(gradient.type, FlexGradientType.radial);
      expect(gradient.radius, 0.8);
      expect(gradient.center, Alignment.center);
    });

    test('Sweep FlexGradient creation', () {
      const gradient = FlexGradient.sweep(
        colors: [Colors.green, Colors.yellow],
        startAngle: 0.0,
        endAngle: math.pi,
      );

      expect(gradient.type, FlexGradientType.sweep);
      expect(gradient.startAngle, 0.0);
      expect(gradient.endAngle, math.pi);
    });

    test('FlexGradient.solid creates dual-stop solid gradient', () {
      final solid = FlexGradient.solid(const Color(0xFF123456));

      expect(solid.colors.length, 2);
      expect(solid.colors[0], const Color(0xFF123456));
      expect(solid.colors[1], const Color(0xFF123456));
    });

    test('FlexGradient designer presets exist and are valid', () {
      final presets = [
        FlexGradient.primary,
        FlexGradient.secondary,
        FlexGradient.accent,
        FlexGradient.sunset,
        FlexGradient.ocean,
        FlexGradient.purplePink,
        FlexGradient.emerald,
        FlexGradient.fire,
        FlexGradient.dark,
        FlexGradient.glass,
      ];

      for (final preset in presets) {
        expect(preset.colors.length, greaterThanOrEqualTo(2));
        final shader = preset.createShader(const Rect.fromLTWH(0, 0, 100, 100));
        expect(shader, isNotNull);
      }
    });

    test('withOpacity and withRotation work correctly', () {
      final base = FlexGradient.primary;
      final withOp = base.withOpacity(0.5);
      expect(withOp.opacity, 0.5);
      expect(withOp.effectiveColors.first.a, closeTo(0.5, 0.05));

      final withRot = base.withRotation(math.pi / 4);
      expect(withRot.transform, isA<GradientRotation>());
    });

    test('FlexGradient.lerp interpolates between two gradients', () {
      const g1 = FlexGradient(
        colors: [Color(0xFF000000), Color(0xFF000000)],
      );
      const g2 = FlexGradient(
        colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
      );

      final mid = FlexGradient.lerp(g1, g2, 0.5);
      expect(mid, isNotNull);
      expect(mid!.colors.first.r, closeTo(0.5, 0.1));
    });

    test(
        'toLinearGradient, toRadialGradient, and toSweepGradient convert properly',
        () {
      const g = FlexGradient(
        colors: [Colors.black, Colors.white],
      );

      expect(g.toLinearGradient(), isA<LinearGradient>());
      expect(g.toRadialGradient(), isA<RadialGradient>());
      expect(g.toSweepGradient(), isA<SweepGradient>());
    });

    test('FlexGradient equality and hashCode', () {
      const g1 = FlexGradient(
        colors: [Colors.red, Colors.blue],
        begin: Alignment.topLeft,
      );
      const g2 = FlexGradient(
        colors: [Colors.red, Colors.blue],
        begin: Alignment.topLeft,
      );
      const g3 = FlexGradient(
        colors: [Colors.red, Colors.green],
        begin: Alignment.topLeft,
      );

      expect(g1, equals(g2));
      expect(g1.hashCode, equals(g2.hashCode));
      expect(g1, isNot(equals(g3)));
    });
  });

  group('FlexGradientBorderPainter and FlexGradientBorderBox Tests', () {
    testWidgets(
        'FlexGradientBorderBox renders child with border and background gradients',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexGradientBorderBox(
              borderGradient: FlexGradient.sunset,
              borderWidth: 2.0,
              backgroundGradient: FlexGradient.ocean,
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(12),
              child: const Text('Inside Box'),
            ),
          ),
        ),
      );

      expect(find.text('Inside Box'), findsOneWidget);
      expect(find.byType(FlexGradientBorderBox), findsOneWidget);
    });

    testWidgets(
        'FlexGradientBorderPainter draws circle and rrect without error',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                CustomPaint(
                  size: const Size(100, 100),
                  painter: const FlexGradientBorderPainter(
                    gradient: FlexGradient.primary,
                    borderWidth: 2,
                    shape: BoxShape.circle,
                  ),
                ),
                CustomPaint(
                  size: const Size(200, 50),
                  painter: FlexGradientBorderPainter(
                    gradient: FlexGradient.sunset,
                    borderWidth: 2,
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(
        find.byWidgetPredicate(
          (w) => w is CustomPaint && w.painter is FlexGradientBorderPainter,
        ),
        findsNWidgets(2),
      );
    });
  });

  group('Widget Gradient Styling Tests', () {
    testWidgets(
        'FlexButton renders with gradient background, border gradient, and label gradient',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexButton(
              label: 'Gradient Button',
              gradient: FlexGradient.primary,
              borderGradient: FlexGradient.sunset,
              labelGradient: FlexGradient.ocean,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Gradient Button'), findsOneWidget);
      expect(find.byType(FlexButton), findsOneWidget);
    });

    testWidgets('FlexOutlinedButton renders with borderGradient',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexOutlinedButton(
              label: 'Outlined',
              borderGradient: FlexGradient.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Outlined'), findsOneWidget);
    });

    testWidgets('FlexText renders gradient text with ShaderMask',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexText(
              text: 'Gradient Text',
              gradient: FlexGradient.sunset,
            ),
          ),
        ),
      );

      expect(find.text('Gradient Text'), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('FlexHeading renders gradient heading with ShaderMask',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FlexHeading(
              'Gradient Heading',
              gradient: FlexGradient.emerald,
            ),
          ),
        ),
      );

      expect(find.text('Gradient Heading'), findsOneWidget);
      expect(find.byType(ShaderMask), findsOneWidget);
    });

    testWidgets('FlexContainer renders with gradient and borderGradient',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexContainer(
              gradient: FlexGradient.fire,
              borderGradient: FlexGradient.dark,
              borderRadius: 12,
              child: const Text('Container Child'),
            ),
          ),
        ),
      );

      expect(find.text('Container Child'), findsOneWidget);
      expect(find.byType(FlexContainer), findsOneWidget);
    });

    testWidgets('FlexCard renders with gradient and borderGradient',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexCard(
              gradient: FlexGradient.ocean,
              borderGradient: FlexGradient.sunset,
              child: const Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
      expect(find.byType(FlexCard), findsOneWidget);
    });

    testWidgets(
        'FlexInputField renders with gradient background and gradientBorder',
        (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlexInputField(
              controller: controller,
              label: 'Username',
              hintText: 'Enter name',
              gradient: FlexGradient.glass,
              gradientBorder: FlexGradient.primary,
              focusedGradientBorder: FlexGradient.sunset,
            ),
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
      expect(find.byType(FlexInputField), findsOneWidget);

      await tester.enterText(find.byType(FlexInputField), 'JohnDoe');
      expect(controller.text, 'JohnDoe');
    });

    testWidgets('FlexCheckbox renders with gradient and borderGradient',
        (tester) async {
      bool checked = false;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: FlexCheckbox(
                  value: checked,
                  gradient: FlexGradient.primary,
                  borderGradient: FlexGradient.accent,
                  onChanged: (val) {
                    setState(() => checked = val ?? false);
                  },
                ),
              ),
            );
          },
        ),
      );

      expect(find.byType(FlexCheckbox), findsOneWidget);
      await tester.tap(find.byType(FlexCheckbox));
      await tester.pumpAndSettle();
      expect(checked, isTrue);
    });

    testWidgets('FlexRadio renders with gradient and borderGradient',
        (tester) async {
      String? selected = 'A';

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: FlexRadio<String>(
                  value: 'B',
                  groupValue: selected,
                  gradient: FlexGradient.secondary,
                  borderGradient: FlexGradient.sunset,
                  onChanged: (val) {
                    setState(() => selected = val);
                  },
                ),
              ),
            );
          },
        ),
      );

      expect(find.byType(FlexRadio<String>), findsOneWidget);
      await tester.tap(find.byType(FlexRadio<String>));
      await tester.pumpAndSettle();
      expect(selected, 'B');
    });

    testWidgets('FlexSwitch renders with track and thumb gradients',
        (tester) async {
      bool value = false;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: FlexSwitch(
                  value: value,
                  activeTrackGradient: FlexGradient.primary,
                  thumbGradient: FlexGradient.sunset,
                  borderGradient: FlexGradient.accent,
                  onChanged: (val) {
                    setState(() => value = val);
                  },
                ),
              ),
            );
          },
        ),
      );

      expect(find.byType(FlexSwitch), findsOneWidget);
      await tester.tap(find.byType(FlexSwitch));
      await tester.pumpAndSettle();
      expect(value, isTrue);
    });

    testWidgets(
        'FlexChip, FlexBadge, FlexAvatar, and FlexDivider render with gradients',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  FlexChip(
                    label: 'Chip',
                    gradient: FlexGradient.emerald,
                    borderGradient: FlexGradient.dark,
                  ),
                  FlexBadge(
                    label: 'New',
                    gradient: FlexGradient.sunset,
                    child: const Icon(Icons.notifications),
                  ),
                  const FlexAvatar(
                    name: 'Alex Morgan',
                    gradient: FlexGradient.purplePink,
                    borderGradient: FlexGradient.fire,
                  ),
                  const FlexDivider(
                    gradient: FlexGradient.ocean,
                  ),
                  const FlexLinearProgress(
                    value: 0.7,
                    gradient: FlexGradient.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Chip'), findsOneWidget);
      expect(find.text('New'), findsOneWidget);
      expect(find.text('AM'), findsOneWidget);
      expect(find.byType(FlexDivider), findsOneWidget);
      expect(find.byType(FlexLinearProgress), findsOneWidget);
    });
  });

  group('FlexUITheme Gradient Integration Tests', () {
    test('FlexUIThemeData default constructors expose gradient palettes', () {
      final lightTheme = FlexUIThemeData.light();
      final darkTheme = FlexUIThemeData.dark();

      expect(lightTheme.primaryGradient, isNotNull);
      expect(lightTheme.secondaryGradient, isNotNull);
      expect(lightTheme.accentGradient, isNotNull);

      expect(darkTheme.primaryGradient, isNotNull);
      expect(darkTheme.secondaryGradient, isNotNull);
      expect(darkTheme.accentGradient, isNotNull);
    });

    test(
        'FlexButtonThemeData, FlexInputThemeData, FlexCardThemeData support gradients',
        () {
      final buttonTheme = FlexButtonThemeData(
        gradient: FlexGradient.primary,
        borderGradient: FlexGradient.sunset,
        labelGradient: FlexGradient.ocean,
      );
      expect(buttonTheme.gradient, FlexGradient.primary);
      expect(buttonTheme.borderGradient, FlexGradient.sunset);
      expect(buttonTheme.labelGradient, FlexGradient.ocean);

      final inputTheme = FlexInputThemeData(
        gradient: FlexGradient.glass,
        borderGradient: FlexGradient.primary,
        focusedBorderGradient: FlexGradient.sunset,
      );
      expect(inputTheme.gradient, FlexGradient.glass);
      expect(inputTheme.borderGradient, FlexGradient.primary);
      expect(inputTheme.focusedBorderGradient, FlexGradient.sunset);

      final cardTheme = FlexCardThemeData(
        gradient: FlexGradient.emerald,
        borderGradient: FlexGradient.dark,
      );
      expect(cardTheme.gradient, FlexGradient.emerald);
      expect(cardTheme.borderGradient, FlexGradient.dark);
    });
  });
}

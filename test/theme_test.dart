import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  group('FlexUITheme Tests', () {
    test('light and dark theme data initialize with correct brightness', () {
      final lightTheme = FlexUIThemeData.light();
      final darkTheme = FlexUIThemeData.dark();

      expect(lightTheme.isDark, isFalse);
      expect(darkTheme.isDark, isTrue);
      expect(lightTheme.colors.surface, const Color(0xFFFFFFFF));
      expect(darkTheme.colors.surface, const Color(0xFF1F2937));
    });

    test('theme copyWith and lerp work correctly', () {
      final base = FlexUIThemeData.light();
      final customized = base.copyWith(
        colors: base.colors.copyWith(primary: const Color(0xFFFF0000)),
      );

      expect(customized.colors.primary, const Color(0xFFFF0000));

      final lerped = base.lerp(customized, 0.5);
      expect(lerped.colors.primary, isNot(base.colors.primary));
      expect(lerped.colors.primary, isNot(customized.colors.primary));
    });

    testWidgets('FlexUITheme provides data to child context', (tester) async {
      late FlexColors colors;

      await tester.pumpWidget(
        FlexUITheme(
          data: FlexUIThemeData.light(),
          child: Builder(
            builder: (context) {
              colors = context.flexColors;
              return Container();
            },
          ),
        ),
      );

      expect(colors.primary, equals(FlexColors.light().primary));
    });
  });
}

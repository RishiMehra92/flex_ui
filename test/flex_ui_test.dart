import 'package:flutter_test/flutter_test.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  test('FlexUIThemeData default constructors work', () {
    final light = FlexUIThemeData.light();
    final dark = FlexUIThemeData.dark();

    expect(light, isNotNull);
    expect(dark, isNotNull);
    expect(light.isDark, isFalse);
    expect(dark.isDark, isTrue);
  });
}

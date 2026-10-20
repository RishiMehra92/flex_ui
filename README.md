# flex_ui

A production-ready, universal, highly customizable Flutter UI component package suitable for any Flutter application and ready for pub.dev.

Designed with clean Flutter conventions, zero unnecessary third-party dependencies, accessibility in mind, and deep theme customization.

---

## 🚀 Features

- **🛡️ Universal & App-Agnostic**: Zero references to proprietary app models or codebases. Pure Flutter SDK compatibility (`flutter: sdk: flutter`).
- **🎨 Unified Theme System**: Built with Flutter's `ThemeExtension` model. Configure once using `FlexUIThemeData`, customize light and dark palettes, and override at individual widget levels.
- **⚡ Buttons with Micro-Interactions**: Solid, outlined, text, gradient, icon, and floating action buttons with built-in loading states, smart verb inflection (`"Save"` -> `"Saving..."`), and subtle tactile animations.
- **📝 Form-First Inputs**: Comprehensive input system compatible with standard Flutter `Form` and `TextFormField` workflows. Supports labels, required asterisks, visibility toggles, formatters, and validation.
- **💎 Frosted Glass & Modern Cards**: Flat, elevated, outlined cards, and `FlexGlassContainer` with real-time backdrop blur (`BackdropFilter`).
- **🎛️ Interactive Controls**: Smooth switches, checkboxes, radios, sliders, range sliders, chips, badges, and segmented tab pills.
- **💬 Modals & Overlays**: Confirmation dialogs, modal bottom sheets, action sheets, and floating snackbars.
- **⏳ Skeletons & Loaders**: Shimmering skeleton loaders, adaptive spinners, linear progress indicators, and step indicators.
- **📱 Responsive Layouts**: Breakpoint-based layouts, spaced columns and rows.

---

## 📦 Installation

Add `flex_ui` to your `pubspec.yaml`:

```yaml
dependencies:
  flex_ui: ^0.1.0
```

Then import it in your Dart code:

```dart
import 'package:flex_ui/flex_ui.dart';
```

---

## 🎨 Global Theme Configuration

Configure `flex_ui` at the root of your application using `FlexUITheme` or register `FlexUIThemeData` into Flutter's `ThemeData`:

```dart
import 'package:flutter/material.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Create your light and dark theme configurations
    final lightTheme = FlexUIThemeData.light(
      colors: FlexColors.light().copyWith(
        primary: const Color(0xFF2563EB),
      ),
    );

    final darkTheme = FlexUIThemeData.dark(
      colors: FlexColors.dark().copyWith(
        primary: const Color(0xFF3B82F6),
      ),
    );

    return FlexUITheme(
      data: lightTheme,
      child: MaterialApp(
        title: 'My App',
        theme: ThemeData.light().withFlexUI(lightTheme),
        darkTheme: ThemeData.dark().withFlexUI(darkTheme),
        home: const HomeScreen(),
      ),
    );
  }
}
```

### Precedence Rule
Styling strictly follows this precedence hierarchy:
> **Widget-level property overrides** → **Active Flex UI theme (`FlexUIThemeData`)** → **Sensible built-in defaults**.

### BuildContext Extensions
Convenient getters on `BuildContext` make theming effortless:

```dart
final colors = context.flexColors;
final spacing = context.flexSpacing;
final radius = context.flexRadius;
final isDark = context.isFlexDark;
```

---

## 🌈 Universal Gradient & Styling System

`flex_ui` features a comprehensive gradient engine built directly on top of Flutter's native `Gradient` abstraction. Gradients, gradient borders, and gradient typography can be configured globally in `FlexUIThemeData` or applied dynamically on individual components.

### 1. Centralized Gradient Model (`FlexGradient`)
Because `FlexGradient` extends Flutter's `Gradient`, you can pass it anywhere Flutter expects a gradient (`BoxDecoration`, `ShaderMask`, or standard widgets).

```dart
// Custom linear gradient
const gradient = FlexGradient(
  colors: [Color(0xFF6750A4), Color(0xFF9C27B0)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// Radial & sweep gradients
const radial = FlexGradient.radial(
  colors: [Colors.purple, Colors.blue],
  radius: 0.8,
);

const sweep = FlexGradient.sweep(
  colors: [Colors.pink, Colors.amber],
);

// Solid color fallback
final solidGradient = FlexGradient.solid(Colors.indigo);

// Transformations
final transparent = gradient.withOpacity(0.8);
final rotated = gradient.withRotation(math.pi / 4);
```

### 2. Designer Palettes
`FlexGradient` ships with 10 high-impact designer presets:
- `FlexGradient.primary` (Modern Royal Blue)
- `FlexGradient.secondary` (Electric Indigo to Violet)
- `FlexGradient.accent` (Cyan to Deep Teal)
- `FlexGradient.sunset` (Vibrant Coral Orange into Peach)
- `FlexGradient.ocean` (Cyan into Royal Blue)
- `FlexGradient.purplePink` (Deep Magenta into Sunset Amber)
- `FlexGradient.emerald` (Vibrant Emerald into Deep Forest Teal)
- `FlexGradient.fire` (Crimson Red into Fiery Amber)
- `FlexGradient.dark` (Midnight Slate into Pitch Obsidian)
- `FlexGradient.glass` (Frosted Semi-Transparent Glassmorphic)

### 3. Gradient Border Engine (`FlexGradientBorderPainter` & `FlexGradientBorderBox`)
Render smooth gradient borders on any container or shape with perfect stroke alignment:

```dart
FlexGradientBorderBox(
  borderGradient: FlexGradient.sunset,
  borderWidth: 2.0,
  borderRadius: BorderRadius.circular(16),
  backgroundGradient: FlexGradient.glass,
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Frosted Card with Gradient Border'),
  ),
);
```

### 4. Gradient Buttons & Typography
```dart
// Gradient background + border + gradient label
FlexButton(
  label: 'Get Started',
  gradient: FlexGradient.primary,
  borderGradient: FlexGradient.ocean,
  onPressed: () {},
);

// Gradient text rendered via ShaderMask with direct typography properties
const FlexText(
  text: 'Transforming the future',
  gradient: FlexGradient.sunset,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const FlexHeading(
  'Dashboard Overview',
  gradient: FlexGradient.purplePink,
);
```

### 5. Gradient Input Fields
Style input borders with distinct gradients per state (idle, focused, error, disabled, success):

```dart
FlexInputField(
  label: 'Email',
  hintText: 'user@domain.com',
  gradient: FlexGradient.glass,
  gradientBorder: FlexGradient.primary,
  focusedGradientBorder: FlexGradient.sunset,
  errorGradientBorder: FlexGradient.fire,
);
```

### 6. Gradient Selection Controls, Avatars & Badges
```dart
FlexCheckbox(
  value: isChecked,
  gradient: FlexGradient.primary,
  borderGradient: FlexGradient.accent,
  onChanged: (val) {},
);

FlexSwitch(
  value: isSwitched,
  activeTrackGradient: FlexGradient.primary,
  thumbGradient: FlexGradient.sunset,
  onChanged: (val) {},
);

FlexBadge(
  label: 'PRO',
  gradient: FlexGradient.fire,
  child: const Icon(Icons.person),
);

FlexAvatar(
  name: 'Alex Morgan',
  gradient: FlexGradient.purplePink,
  borderGradient: FlexGradient.fire,
  borderWidth: 2.0,
);
```

---

## 🔤 Typography & Font Customization

`flex_ui` does not force any specific font family or network dependency.

### Using Local Bundled Fonts
1. Add your font assets to `pubspec.yaml`:
```yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```
2. Pass the `fontFamily` to your `FlexUIThemeData`:
```dart
final theme = FlexUIThemeData.light(
  fontFamily: 'Inter',
);
```

### Using Google Fonts
If you use the `google_fonts` package in your app:
```dart
import 'package:google_fonts/google_fonts.dart';

final theme = FlexUIThemeData.light(
  typography: FlexTypography.fromColors(
    primaryText: const Color(0xFF111827),
    secondaryText: const Color(0xFF4B5563),
    fontFamily: GoogleFonts.inter().fontFamily,
  ),
);
```

---

## 🛠️ Component Usage Guide

### 1. Buttons

#### Standard Button
```dart
FlexButton(
  label: 'Continue',
  prefixIcon: Icons.arrow_forward_rounded,
  onPressed: () => print('Pressed!'),
)
```

#### Smart Loading State
Buttons automatically inflect common action verbs into progressive loading indicators:
```dart
FlexButton(
  label: 'Sign In', // Automatically renders: [Spinner] "Signing in..."
  isLoading: true,
  onPressed: () {},
)
```

#### Button Variants
```dart
// Outlined
FlexOutlinedButton(
  label: 'Cancel',
  onPressed: () => Navigator.pop(context),
);

// Text
FlexTextButton(
  label: 'Forgot Password?',
  onPressed: () {},
);

// Gradient
FlexGradientButton(
  label: 'Upgrade to Pro',
  gradient: const LinearGradient(colors: [Colors.purple, Colors.blue]),
  onPressed: () {},
);

// Icon Button with Badge
FlexIconButton(
  icon: Icons.notifications_none_rounded,
  showBadge: true,
  badgeText: '5',
  onPressed: () {},
);
```

---

### 2. Input Fields

All input fields seamlessly integrate with Flutter's `Form` validation.

```dart
FlexInputField(
  label: 'Username',
  hintText: 'Enter your username',
  isRequired: true, // Displays styled red asterisk
  prefixIcon: Icons.person_outline,
  validator: (val) => val == null || val.isEmpty ? 'Required' : null,
)
```

#### Specialized Fields
```dart
// Email Field with built-in email formatting & validation
FlexEmailField(
  controller: emailController,
  isRequired: true,
);

// Password Field with eye toggle icon
FlexPasswordField(
  controller: passwordController,
  isRequired: true,
);

// Phone Field
FlexPhoneField(
  countryCodePrefix: '+1',
  isRequired: true,
);

// Numeric Field
FlexNumberField(
  label: 'Age',
  allowDecimals: false,
);

// Date Field with picker dialog
FlexDateField(
  label: 'Birthday',
  onDateSelected: (date) => print('Selected: $date'),
);

// Search Field with clear action
FlexSearchField(
  hintText: 'Search items...',
  onChanged: (query) => filterItems(query),
);
```

---

### 3. Extensible Validation System

`flex_ui` includes a dedicated, decoupled validation engine:

#### Built-in Validators
```dart
// Required field
FlexValidators.required(fieldName: 'Email')

// Email validation
FlexValidators.email()

// Configurable name validation
FlexValidators.name(
  rules: const FlexNameRules(allowSpaces: true, allowHyphens: true),
)

// Username / Handle
FlexValidators.username(
  rules: const FlexUsernameRules(minLength: 3, maxLength: 20),
)

// Strong Password
FlexValidators.strongPassword(
  minLength: 8,
  requireUppercase: true,
  requireLowercase: true,
  requireNumber: true,
  requireSpecialCharacter: true,
)

// Cross-field matching (Confirm Password)
FlexValidators.match(
  passwordController, // Accepts String, () => String, or TextEditingController
  message: 'Passwords do not match',
)

// International Phone
FlexValidators.phone(
  rules: const FlexPhoneRules(minLength: 10),
)

// Numeric & Range checks
FlexValidators.number(rules: const FlexNumberRules(allowNegative: false))
FlexValidators.rangeValue(18, 99)
FlexValidators.minLength(5)
FlexValidators.maxLength(100)
FlexValidators.url()
FlexValidators.lettersOnly()
FlexValidators.digitsOnly()
FlexValidators.alphanumeric()
```

#### Validator Composition & Fluent Builder
Combine multiple rules effortlessly for any field:

```dart
// Using FlexValidators.compose (stops at first error by default)
FlexInputField(
  label: 'Email Address *',
  validator: FlexValidators.compose([
    FlexValidators.required(message: 'Email cannot be blank'),
    FlexValidators.email(message: 'Invalid email address format'),
  ]),
);

// Using Fluent Builder
FlexInputField(
  label: 'Username *',
  validator: FlexValidators.builder()
      .required(fieldName: 'Username')
      .minLength(4)
      .maxLength(20)
      .alphanumeric()
      .build(),
);
```

#### Configurable Error Messages & Localization
Override messages per validator or globally for localization:
```dart
// Global localization override
FlexValidationMessages.defaultMessages = MySpanishValidationMessages();

class MySpanishValidationMessages extends FlexValidationMessages {
  @override
  String required([String? fieldName]) => '$fieldName es obligatorio';

  @override
  String email([String? fieldName]) => 'Ingrese un correo electrónico válido';
}
```

#### Autovalidation Control
Control when errors appear (on submit vs on user interaction):
```dart
FlexInputField(
  autovalidateMode: AutovalidateMode.onUserInteraction,
  validator: FlexValidators.required(),
  onSaved: (val) => model.name = val,
)
```

---

### 4. Cards & Frosted Glass

```dart
// Elevated Card
FlexElevatedCard(
  elevation: 4,
  onTap: () {},
  child: Text('Card Content'),
);

// Outlined Card
FlexOutlinedCard(
  child: Text('Outlined Content'),
);

// Frosted Glass Container
FlexGlassContainer(
  blur: 20.0,
  opacity: 0.15,
  child: Text('Glassmorphism Effect'),
);
```

---

### 5. Dialogs, Sheets & SnackBars

```dart
// Confirmation Dialog
final confirmed = await showFlexConfirmationDialog(
  context: context,
  title: 'Delete Project?',
  message: 'This action is irreversible.',
  isDestructive: true,
  confirmLabel: 'Delete',
);

// Modal Bottom Sheet
showFlexBottomSheet(
  context: context,
  child: FlexActionSheet(
    title: 'Options',
    actions: [
      FlexActionSheetItem(
        label: 'Share',
        icon: Icons.share,
        onTap: () {},
      ),
      FlexActionSheetItem(
        label: 'Delete',
        icon: Icons.delete,
        isDestructive: true,
        onTap: () {},
      ),
    ],
  ),
);

// Floating SnackBar
showFlexSnackBar(
  context: context,
  title: 'Saved',
  message: 'Your profile has been updated.',
  type: FlexSnackBarType.success,
);
```

---

### 6. Selection Controls

```dart
// Checkbox List Tile
FlexCheckboxListTile(
  title: Text('Accept Terms'),
  value: isChecked,
  onChanged: (val) => setState(() => isChecked = val!),
);

// Switch
FlexSwitch(
  value: isEnabled,
  onChanged: (val) => setState(() => isEnabled = val),
);

// Segmented Control
FlexSegmentedControl<int>(
  selectedValue: selectedIndex,
  onValueChanged: (val) => setState(() => selectedIndex = val),
  segments: const [
    FlexSegment(value: 0, label: 'Day'),
    FlexSegment(value: 1, label: 'Week'),
    FlexSegment(value: 2, label: 'Month'),
  ],
);

// Status Badge
FlexStatusBadge(
  label: 'Active',
  status: FlexStatusType.success,
);
```

---

## 🔄 Migration Guide (From `CustomButton` & `CustomInputField`)

If you are migrating existing code from custom widgets:

### 1. Button Migration
| Legacy `CustomButton` | `flex_ui` Equivalent |
|---|---|
| `CustomButton(text: 'Submit', ...)` | `FlexButton(label: 'Submit', ...)` |
| `style: CustomButtonStyle.outlined` | `FlexOutlinedButton(...)` or `variant: FlexButtonVariant.outlined` |
| `style: CustomButtonStyle.text` | `FlexTextButton(...)` or `variant: FlexButtonVariant.text` |
| `prefixWidget: ...` | `prefixWidget: ...` or `prefixIcon: Icons....` |
| `isLoading: true` | `isLoading: true` (retains automatic loading verb inflection) |

### 2. Input Migration
| Legacy `CustomInputField` | `flex_ui` Equivalent |
|---|---|
| `CustomInputField(label: 'Email*')` | `FlexEmailField(isRequired: true)` |
| `CustomInputField(obscureText: true)` | `FlexPasswordField()` |
| `CustomInputField(keyboardType: TextInputType.phone)` | `FlexPhoneField()` |
| `CustomInputField(label: 'Name *')` | `FlexInputField(label: 'Name', isRequired: true)` |

---

## 🏃 Running the Example Gallery

To run the interactive component gallery:

```bash
cd example
flutter run
```

---

## 🧪 Running Tests & Quality Verification

All components are covered by unit and widget tests:

```bash
flutter pub get
dart format .
flutter analyze
flutter test
dart pub publish --dry-run
```

---

## 📄 License

This package is licensed under the [MIT License](LICENSE).

# Changelog

All notable changes to `flex_ui` will be documented in this file.

## 0.3.0

### Direct Typography API on `FlexText`
- **Granular Direct Styling**: `FlexText` now exposes all `TextStyle` parameters directly on the widget constructor, eliminating the need to wrap properties inside a `style: TextStyle(...)`.
  - Added direct properties: `text`, `fontSize`, `color`, `fontWeight`, `fontStyle`, `letterSpacing`, `wordSpacing`, `textBaseline`, `height`, `leadingDistribution`, `locale`, `foreground`, `background`, `shadows`, `fontFeatures`, `fontVariations`, `decoration`, `decorationColor`, `decorationStyle`, `decorationThickness`, `debugLabel`, `fontFamily`, `fontFamilyFallback`, and `package`.
- **Named `text` Constructor Parameter**: Supports direct usage like `FlexText(text: 'Hello', fontSize: 12, color: AppColors.secondaryText)`.
- **Positional Constructor Alternative**: Added `FlexText.data('Hello', ...)` for developers who prefer positional text passing.
- **Backwards Compatible Merge**: Optional `style` parameter is still accepted for merging with pre-existing `TextStyle` objects where granular properties take precedence.

## 0.2.0

### Universal Gradient & Styling System
- **Centralized Gradient Engine (`FlexGradient`)**:
  - Direct extension of Flutter's native `Gradient` class, making it drop-in compatible with any Flutter widget or `BoxDecoration`.
  - Supports linear (`FlexGradient.linear`), radial (`FlexGradient.radial`), sweep (`FlexGradient.sweep`), and solid color fallback (`FlexGradient.solid`).
  - 10 pre-configured designer palettes: `primary`, `secondary`, `accent`, `sunset`, `ocean`, `purplePink`, `emerald`, `fire`, `dark`, and `glass`.
  - Gradient transformations: `.withOpacity()`, `.withRotation()`, `.scale()`, `.copyWith()`, and smooth interpolation via `FlexGradient.lerp()`.
- **Gradient Borders (`FlexGradientBorderPainter` & `FlexGradientBorderBox`)**:
  - Accurate stroke alignment for rounded rectangles and circles using `deflate(borderWidth / 2)`.
  - Clean container wrapper for combined background gradients, border gradients, and elevation shadows.
- **Universal Widget Styling**:
  - **Buttons**: `gradient`, `borderGradient`, and `labelGradient` (via `ShaderMask`) across `FlexButton`, `FlexOutlinedButton`, `FlexTextButton`, `FlexGradientButton`, `FlexIconButton`, and `FlexFloatingActionButton`.
  - **Containers & Cards**: Independent background gradients and border gradients, gradient overlays, custom blend modes, and shadow colors across `FlexContainer`, `FlexCard`, `FlexElevatedCard`, and `FlexOutlinedCard`.
  - **Text & Headings**: Rich gradient text rendering via `ShaderMask` with semantic accessibility preservation on `FlexText` and `FlexHeading`.
  - **Inputs & Form Fields**: Gradient borders (with stateful overrides: focused, error, disabled, success), gradient-filled backgrounds, and icon tinting on `FlexInputField`, `FlexEmailField`, `FlexPasswordField`, `FlexPhoneField`, `FlexNumberField`, `FlexSearchField`, `FlexTextArea`, `FlexDropdownField`, and `FlexDateField`.
  - **Selection Controls**: Gradients for checked/selected fills, track/thumb gradients on `FlexSwitch`, and gradient outlines on `FlexCheckbox` and `FlexRadio`.
  - **Badges, Chips, Indicators & Dividers**: Gradient backgrounds and border gradients on `FlexChip`, `FlexActionChip`, `FlexFilterChip`, `FlexBadge`, `FlexStatusBadge`, `FlexAvatar`, `FlexLinearProgress`, `FlexDivider`, and `FlexVerticalDivider`.
- **Theme-Level Gradient Integration**:
  - Added `primaryGradient`, `secondaryGradient`, `accentGradient`, `backgroundGradient`, and `surfaceGradient` to `FlexColors` and `FlexUIThemeData`.
  - Component themes (`FlexButtonThemeData`, `FlexInputThemeData`, `FlexCardThemeData`) now support global gradient configurations with per-widget overrides.
- **100% Backward Compatible**: All existing constructors, arguments, and theme structures continue to function seamlessly.

## 0.1.0

### Initial Release
- **Core Theming System**:
  - `FlexUITheme`, `FlexUIThemeData`, and `FlexUIConfig` supporting full customization.
  - Light and dark mode palettes (`FlexColors.light()` and `FlexColors.dark()`).
  - Scales for `FlexSpacing`, `FlexRadius`, and `FlexTypography`.
  - Seamless integration via `BuildContext` extensions (`context.flexTheme`, `context.flexColors`, etc.) and `ThemeData.withFlexUI()`.

- **Button Components**:
  - `FlexButton`: Highly customizable with loading states, automated verb inflection, gradient, custom sizes, elevation, and prefix/suffix widgets.
  - `FlexOutlinedButton`, `FlexTextButton`, `FlexGradientButton`, `FlexIconButton`, `FlexFloatingActionButton`.

- **Input Components**:
  - `FlexInputField`: Form-integrated input with validation, required asterisk indicator, custom borders, and controllers.
  - Specialized inputs: `FlexEmailField`, `FlexPasswordField` (with visibility toggle), `FlexPhoneField`, `FlexNumberField`, `FlexSearchField`, `FlexTextArea`, `FlexDropdownField`, `FlexDateField`.

- **Typography & Rich Text**:
  - `FlexText`, `FlexRichText`, `FlexHeading` (levels H1 through H6).

- **Cards & Containers**:
  - `FlexCard`, `FlexElevatedCard`, `FlexOutlinedCard`, `FlexContainer`, and `FlexGlassContainer` (frosted glass with backdrop filter).

- **Dialogs & Bottom Sheets**:
  - `FlexDialog`, `FlexConfirmationDialog`, `showFlexDialog`, `showFlexConfirmationDialog`.
  - `FlexBottomSheet`, `FlexActionSheet`, `showFlexBottomSheet`.
  - `showFlexSnackBar` with floating notifications.

- **Selection Controls**:
  - `FlexCheckbox`, `FlexCheckboxListTile`, `FlexRadio`, `FlexRadioGroup`, `FlexSwitch`, `FlexSwitchListTile`, `FlexSlider`, `FlexRangeSlider`, `FlexSegmentedControl`.
  - `FlexChip`, `FlexActionChip`, `FlexFilterChip`, `FlexBadge`, `FlexStatusBadge`.

- **Pickers & Date/Time**:
  - `FlexDatePicker`, `showFlexDatePicker`, `FlexTimePickerField`, `showFlexTimePicker`.

- **Loaders & States**:
  - `FlexSpinner`, `FlexLoadingIndicator`, `FlexSkeleton`, `FlexSkeletonList`, `FlexLinearProgress`, `FlexStepIndicator`.
  - `FlexEmptyState` and `FlexErrorState`.

- **Layouts & Navigation**:
  - `FlexAppBar`, `FlexNavigationBar`, `FlexTabBar`.
  - `FlexListTile`, `FlexSectionHeader`.
  - `FlexResponsiveLayout`, `FlexSpacedColumn`, `FlexSpacedRow`.

# Changelog

All notable changes to `flex_ui` will be documented in this file.

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

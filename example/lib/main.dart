import 'package:flutter/material.dart';
import 'package:flex_ui/flex_ui.dart';

void main() {
  runApp(const FlexUIExampleApp());
}

class FlexUIExampleApp extends StatefulWidget {
  const FlexUIExampleApp({super.key});

  @override
  State<FlexUIExampleApp> createState() => _FlexUIExampleAppState();
}

class _FlexUIExampleAppState extends State<FlexUIExampleApp> {
  bool _isDarkMode = false;
  Color _brandColor = const Color(0xFF2563EB);

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  void _updateBrandColor(Color color) {
    setState(() => _brandColor = color);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _isDarkMode
        ? FlexUIThemeData.dark(
            colors: FlexColors.dark().copyWith(primary: _brandColor),
          )
        : FlexUIThemeData.light(
            colors: FlexColors.light().copyWith(primary: _brandColor),
          );

    return FlexUITheme(
      data: themeData,
      child: MaterialApp(
        title: 'Flex UI Gallery',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
          scaffoldBackgroundColor: themeData.colors.background,
        ).withFlexUI(themeData),
        home: GalleryHomeScreen(
          isDarkMode: _isDarkMode,
          onToggleTheme: _toggleTheme,
          onBrandColorChanged: _updateBrandColor,
          brandColor: _brandColor,
        ),
      ),
    );
  }
}

class GalleryHomeScreen extends StatefulWidget {
  const GalleryHomeScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.onBrandColorChanged,
    required this.brandColor,
  });

  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final ValueChanged<Color> onBrandColorChanged;
  final Color brandColor;

  @override
  State<GalleryHomeScreen> createState() => _GalleryHomeScreenState();
}

class _GalleryHomeScreenState extends State<GalleryHomeScreen> {
  int _currentIndex = 0;

  final List<String> _titles = [
    'Buttons',
    'Inputs & Forms',
    'Typography',
    'Cards & Glass',
    'Dialogs & Sheets',
    'Selection & Badges',
    'Loaders & States',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.flexColors;

    final pages = [
      const ButtonsGalleryPage(),
      const InputsGalleryPage(),
      const TypographyGalleryPage(),
      const CardsGalleryPage(),
      const DialogsGalleryPage(),
      const SelectionGalleryPage(),
      const LoadersGalleryPage(),
    ];

    return Scaffold(
      backgroundColor: colors.background,
      appBar: FlexAppBar(
        title: 'Flex UI • ${_titles[_currentIndex]}',
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            tooltip: widget.isDarkMode ? 'Light Mode' : 'Dark Mode',
            onPressed: widget.onToggleTheme,
          ),
          PopupMenuButton<Color>(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Brand Color',
            onSelected: widget.onBrandColorChanged,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: Color(0xFF2563EB), // Blue
                child: Text('Blue (Default)'),
              ),
              const PopupMenuItem(
                value: Color(0xFF7C3AED), // Purple
                child: Text('Purple'),
              ),
              const PopupMenuItem(
                value: Color(0xFF059669), // Emerald
                child: Text('Emerald'),
              ),
              const PopupMenuItem(
                value: Color(0xFFDC2626), // Red
                child: Text('Red'),
              ),
              const PopupMenuItem(
                value: Color(0xFFEA580C), // Orange
                child: Text('Orange'),
              ),
            ],
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: FlexNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          FlexNavigationItem(
            icon: Icons.smart_button_outlined,
            activeIcon: Icons.smart_button,
            label: 'Buttons',
          ),
          FlexNavigationItem(
            icon: Icons.edit_note_outlined,
            activeIcon: Icons.edit_note,
            label: 'Inputs',
          ),
          FlexNavigationItem(
            icon: Icons.text_fields_outlined,
            activeIcon: Icons.text_fields,
            label: 'Typography',
          ),
          FlexNavigationItem(
            icon: Icons.crop_portrait_outlined,
            activeIcon: Icons.crop_portrait,
            label: 'Cards',
          ),
          FlexNavigationItem(
            icon: Icons.chat_bubble_outline_rounded,
            activeIcon: Icons.chat_bubble_rounded,
            label: 'Modals',
          ),
          FlexNavigationItem(
            icon: Icons.check_circle_outline,
            activeIcon: Icons.check_circle,
            label: 'Controls',
          ),
          FlexNavigationItem(
            icon: Icons.hourglass_empty_rounded,
            activeIcon: Icons.hourglass_full_rounded,
            label: 'States',
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. BUTTONS GALLERY
// ==========================================
class ButtonsGalleryPage extends StatefulWidget {
  const ButtonsGalleryPage({super.key});

  @override
  State<ButtonsGalleryPage> createState() => _ButtonsGalleryPageState();
}

class _ButtonsGalleryPageState extends State<ButtonsGalleryPage> {
  bool _isLoading = false;

  void _triggerLoading() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const FlexHeading(
          'Button Variants',
          subtitle: 'Comprehensive button states, sizes, and styles',
          level: FlexHeadingLevel.h4,
        ),
        const SizedBox(height: 16),
        FlexButton(
          label: 'Primary Button',
          prefixIcon: Icons.send_rounded,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        FlexButton(
          label: 'Simulate Loading State',
          isLoading: _isLoading,
          onPressed: _triggerLoading,
        ),
        const SizedBox(height: 12),
        const FlexButton(
          label: 'Disabled Button',
          isDisabled: true,
          onPressed: null,
        ),
        const SizedBox(height: 12),
        FlexOutlinedButton(
          label: 'Outlined Button',
          prefixIcon: Icons.outlined_flag_rounded,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        FlexGradientButton(
          label: 'Gradient Button',
          prefixIcon: Icons.auto_awesome,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        FlexTextButton(
          label: 'Text Only Button',
          onPressed: () {},
        ),
        const SizedBox(height: 24),
        const FlexHeading(
          'Sizes and Icons',
          level: FlexHeadingLevel.h5,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlexButton(
              label: 'Small',
              size: FlexButtonSize.small,
              isFullWidth: false,
              onPressed: () {},
            ),
            FlexButton(
              label: 'Medium',
              size: FlexButtonSize.medium,
              isFullWidth: false,
              onPressed: () {},
            ),
            FlexButton(
              label: 'Large',
              size: FlexButtonSize.large,
              isFullWidth: false,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlexIconButton(
              icon: Icons.favorite_border_rounded,
              tooltip: 'Like',
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            FlexIconButton(
              icon: Icons.notifications_none_rounded,
              tooltip: 'Notifications',
              showBadge: true,
              badgeText: '3',
              onPressed: () {},
            ),
            const SizedBox(width: 16),
            FlexIconButton(
              icon: Icons.share_rounded,
              shape: FlexIconButtonShape.roundedSquare,
              tooltip: 'Share',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 2. INPUTS GALLERY
// ==========================================
class InputsGalleryPage extends StatefulWidget {
  const InputsGalleryPage({super.key});

  @override
  State<InputsGalleryPage> createState() => _InputsGalleryPageState();
}

class _InputsGalleryPageState extends State<InputsGalleryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        FlexForm(
          formKey: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FlexHeading(
                'Extensible Form Validation',
                subtitle:
                    'Name, email, strong password, confirm password, and phone validation',
                level: FlexHeadingLevel.h4,
              ),
              const SizedBox(height: 20),
              FlexInputField(
                controller: _nameController,
                label: 'Full Name *',
                hintText: 'Jane Doe',
                prefixIcon: Icons.person_outline,
                isRequired: true,
                validator: FlexValidators.builder()
                    .required(fieldName: 'Full name')
                    .name(fieldName: 'Full name')
                    .build(),
              ),
              const SizedBox(height: 16),
              FlexEmailField(
                controller: _emailController,
                isRequired: true,
                validator: FlexValidators.compose([
                  FlexValidators.required(message: 'Email address is required'),
                  FlexValidators.email(message: 'Please provide a valid email'),
                ]),
              ),
              const SizedBox(height: 16),
              FlexPasswordField(
                controller: _passwordController,
                label: 'Password (Strong) *',
                hintText:
                    'At least 8 chars, 1 upper, 1 lower, 1 digit, 1 special',
                isRequired: true,
                onChanged: (_) {
                  // Revalidate confirm password field if user already typed in it
                  if (_confirmPasswordController.text.isNotEmpty) {
                    _formKey.currentState?.validate();
                  }
                },
                validator: FlexValidators.compose([
                  FlexValidators.required(fieldName: 'Password'),
                  FlexValidators.strongPassword(
                    minLength: 8,
                    requireUppercase: true,
                    requireLowercase: true,
                    requireNumber: true,
                    requireSpecialCharacter: true,
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              FlexPasswordField(
                controller: _confirmPasswordController,
                label: 'Confirm Password *',
                hintText: 'Re-enter your password',
                isRequired: true,
                validator: FlexValidators.compose([
                  FlexValidators.required(
                      message: 'Please confirm your password'),
                  FlexValidators.match(
                    _passwordController,
                    message: 'Passwords do not match',
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              FlexPhoneField(
                controller: _phoneController,
                isRequired: true,
                validator: FlexValidators.compose([
                  FlexValidators.required(fieldName: 'Phone number'),
                  FlexValidators.phone(
                    rules: const FlexPhoneRules(minLength: 10),
                    message: 'Please enter a valid phone number (10+ digits)',
                  ),
                ]),
              ),
              const SizedBox(height: 16),
              const FlexDateField(
                label: 'Date of Birth',
              ),
              const SizedBox(height: 16),
              FlexDropdownField<String>(
                label: 'Country',
                items: const [
                  FlexDropdownItem(value: 'us', label: 'United States'),
                  FlexDropdownItem(value: 'ca', label: 'Canada'),
                  FlexDropdownItem(value: 'uk', label: 'United Kingdom'),
                  FlexDropdownItem(value: 'in', label: 'India'),
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Autovalidate Mode:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 12),
                  DropdownButton<AutovalidateMode>(
                    value: _autovalidateMode,
                    isDense: true,
                    items: const [
                      DropdownMenuItem(
                        value: AutovalidateMode.disabled,
                        child: Text('On Submit'),
                      ),
                      DropdownMenuItem(
                        value: AutovalidateMode.onUserInteraction,
                        child: Text('On User Interaction'),
                      ),
                    ],
                    onChanged: (mode) {
                      if (mode != null) {
                        setState(() => _autovalidateMode = mode);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              FlexButton(
                label: 'Submit & Validate Form',
                onPressed: () {
                  setState(() {
                    _autovalidateMode = AutovalidateMode.onUserInteraction;
                  });
                  if (_formKey.currentState!.validate()) {
                    showFlexSnackBar(
                      context: context,
                      title: 'Validation Success',
                      message: 'All fields passed validation successfully!',
                      type: FlexSnackBarType.success,
                    );
                  } else {
                    showFlexSnackBar(
                      context: context,
                      title: 'Validation Error',
                      message:
                          'Please resolve errors in the highlighted fields.',
                      type: FlexSnackBarType.error,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 3. TYPOGRAPHY GALLERY
// ==========================================
class TypographyGalleryPage extends StatelessWidget {
  const TypographyGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        FlexHeading(
          'Typography System',
          subtitle:
              'Clean hierarchy designed for readability and accessibility',
          level: FlexHeadingLevel.h4,
        ),
        SizedBox(height: 20),
        FlexText(
            text: 'Display Large', variant: FlexTextStyleVariant.displayLarge),
        FlexText(
            text: 'Display Medium',
            variant: FlexTextStyleVariant.displayMedium),
        FlexText(
            text: 'Display Small', variant: FlexTextStyleVariant.displaySmall),
        FlexDivider(),
        FlexText(
            text: 'Headline Large',
            variant: FlexTextStyleVariant.headlineLarge),
        FlexText(
          text: 'Headline Medium',
          variant: FlexTextStyleVariant.headlineMedium,
        ),
        FlexText(
            text: 'Headline Small',
            variant: FlexTextStyleVariant.headlineSmall),
        FlexDivider(),
        FlexText(text: 'Title Large', variant: FlexTextStyleVariant.titleLarge),
        FlexText(
            text: 'Title Medium', variant: FlexTextStyleVariant.titleMedium),
        FlexText(text: 'Title Small', variant: FlexTextStyleVariant.titleSmall),
        FlexDivider(),
        FlexText(
          text: 'Body Large — Clean and crisp text for general reading.',
          variant: FlexTextStyleVariant.bodyLarge,
        ),
        SizedBox(height: 8),
        FlexText(
          text: 'Body Medium — Standard paragraph font for dense UI areas.',
          variant: FlexTextStyleVariant.bodyMedium,
        ),
        SizedBox(height: 8),
        FlexText(
          text: 'Body Small — Captions, hints, footnotes, and descriptions.',
          variant: FlexTextStyleVariant.bodySmall,
        ),
        FlexDivider.withLabel(label: 'RICH TEXT'),
        FlexRichText(
          spans: [
            TextSpan(text: 'Flex UI components support '),
            TextSpan(
              text: 'rich text formatting, ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            TextSpan(
              text: 'underlines, ',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            TextSpan(text: 'and inline custom spans.'),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 4. CARDS & GLASS GALLERY
// ==========================================
class CardsGalleryPage extends StatelessWidget {
  const CardsGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const FlexHeading(
          'Cards & Containers',
          subtitle:
              'Standard, elevated, outlined, and frosted glass containers',
          level: FlexHeadingLevel.h4,
        ),
        const SizedBox(height: 20),
        FlexCard(
          onTap: () {},
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexText(
                  text: 'Flat Card', variant: FlexTextStyleVariant.titleMedium),
              SizedBox(height: 6),
              FlexText(
                  text: 'Clean background with interactive ink touch response.',
                  variant: FlexTextStyleVariant.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FlexElevatedCard(
          elevation: 4,
          onTap: () {},
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexText(
                  text: 'Elevated Card',
                  variant: FlexTextStyleVariant.titleMedium),
              SizedBox(height: 6),
              FlexText(
                  text: 'Subtle ambient shadow elevation.',
                  variant: FlexTextStyleVariant.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        FlexOutlinedCard(
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FlexText(
                  text: 'Outlined Card',
                  variant: FlexTextStyleVariant.titleMedium),
              SizedBox(height: 6),
              FlexText(
                  text:
                      'Crisp theme border with transparent/surface background.',
                  variant: FlexTextStyleVariant.bodySmall),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blueAccent, Colors.teal],
                ),
              ),
            ),
            const Positioned.fill(
              child: FlexGlassContainer(
                child: Center(
                  child: FlexText(
                    text: 'Frosted Glass Container\n(Backdrop Blur + Tint)',
                    textAlign: TextAlign.center,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 5. DIALOGS & SHEETS GALLERY
// ==========================================
class DialogsGalleryPage extends StatelessWidget {
  const DialogsGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const FlexHeading(
          'Dialogs, Sheets & Toasts',
          subtitle: 'Modal presentations and feedback alerts',
          level: FlexHeadingLevel.h4,
        ),
        const SizedBox(height: 20),
        FlexButton(
          label: 'Show Confirmation Dialog',
          prefixIcon: Icons.help_outline,
          onPressed: () async {
            final result = await showFlexConfirmationDialog(
              context: context,
              title: 'Delete Item?',
              message:
                  'Are you sure you want to delete this item? This action cannot be undone.',
              isDestructive: true,
              confirmLabel: 'Delete',
            );
            if (context.mounted && result == true) {
              showFlexSnackBar(
                context: context,
                message: 'Item deleted.',
                type: FlexSnackBarType.error,
              );
            }
          },
        ),
        const SizedBox(height: 12),
        FlexOutlinedButton(
          label: 'Show Modal Bottom Sheet',
          prefixIcon: Icons.vertical_align_top,
          onPressed: () {
            showFlexBottomSheet(
              context: context,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const FlexHeading(
                      'Bottom Sheet Content',
                      subtitle: 'Easily customizable bottom modal',
                      level: FlexHeadingLevel.h5,
                    ),
                    const SizedBox(height: 16),
                    FlexButton(
                      label: 'Close Sheet',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        FlexOutlinedButton(
          label: 'Show Action Sheet',
          prefixIcon: Icons.list_alt,
          onPressed: () {
            showFlexBottomSheet(
              context: context,
              child: FlexActionSheet(
                title: 'Select Action',
                actions: [
                  FlexActionSheetItem(
                    label: 'Share Item',
                    icon: Icons.share,
                    onTap: () {},
                  ),
                  FlexActionSheetItem(
                    label: 'Edit Details',
                    icon: Icons.edit,
                    onTap: () {},
                  ),
                  FlexActionSheetItem(
                    label: 'Delete Forever',
                    icon: Icons.delete,
                    isDestructive: true,
                    onTap: () {},
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const FlexDivider.withLabel(label: 'SNACKBAR NOTIFICATIONS'),
        Row(
          children: [
            Expanded(
              child: FlexButton(
                label: 'Success',
                backgroundColor: Colors.green,
                size: FlexButtonSize.small,
                onPressed: () {
                  showFlexSnackBar(
                    context: context,
                    message: 'Operation finished successfully!',
                    type: FlexSnackBarType.success,
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: FlexButton(
                label: 'Error',
                backgroundColor: Colors.red,
                size: FlexButtonSize.small,
                onPressed: () {
                  showFlexSnackBar(
                    context: context,
                    message: 'An error occurred during submission.',
                    type: FlexSnackBarType.error,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 6. SELECTION & CONTROLS GALLERY
// ==========================================
class SelectionGalleryPage extends StatefulWidget {
  const SelectionGalleryPage({super.key});

  @override
  State<SelectionGalleryPage> createState() => _SelectionGalleryPageState();
}

class _SelectionGalleryPageState extends State<SelectionGalleryPage> {
  bool _switchVal = true;
  bool? _checkVal = true;
  String _radioVal = 'standard';
  double _sliderVal = 0.6;
  RangeValues _rangeVals = const RangeValues(0.2, 0.8);
  int _segmentVal = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const FlexHeading(
          'Selection Controls',
          subtitle:
              'Switches, checkboxes, radios, sliders, and segmented pills',
          level: FlexHeadingLevel.h4,
        ),
        const SizedBox(height: 20),
        FlexSegmentedControl<int>(
          selectedValue: _segmentVal,
          onValueChanged: (val) => setState(() => _segmentVal = val),
          segments: const [
            FlexSegment(value: 0, label: 'Day', icon: Icons.wb_sunny_outlined),
            FlexSegment(
                value: 1, label: 'Week', icon: Icons.calendar_view_week),
            FlexSegment(value: 2, label: 'Month', icon: Icons.calendar_month),
          ],
        ),
        const SizedBox(height: 20),
        FlexSwitchListTile(
          title: const Text('Push Notifications'),
          subtitle: const Text('Receive alerts on status changes'),
          value: _switchVal,
          onChanged: (val) => setState(() => _switchVal = val),
        ),
        const SizedBox(height: 12),
        FlexCheckboxListTile(
          title: const Text('Accept Terms and Conditions'),
          value: _checkVal,
          onChanged: (val) => setState(() => _checkVal = val),
        ),
        const SizedBox(height: 16),
        FlexRadioGroup<String>(
          groupValue: _radioVal,
          onChanged: (val) => setState(() => _radioVal = val!),
          options: const [
            FlexRadioOption(
              value: 'standard',
              label: 'Standard Delivery',
              subtitle: '3-5 business days',
            ),
            FlexRadioOption(
              value: 'express',
              label: 'Express Courier',
              subtitle: 'Next day morning delivery',
            ),
          ],
        ),
        const SizedBox(height: 20),
        const FlexHeading('Sliders', level: FlexHeadingLevel.h5),
        FlexSlider(
          value: _sliderVal,
          onChanged: (val) => setState(() => _sliderVal = val),
        ),
        FlexRangeSlider(
          values: _rangeVals,
          onChanged: (vals) => setState(() => _rangeVals = vals),
        ),
        const SizedBox(height: 20),
        const FlexHeading('Badges & Chips', level: FlexHeadingLevel.h5),
        const SizedBox(height: 12),
        const Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FlexStatusBadge(label: 'Completed', status: FlexStatusType.success),
            FlexStatusBadge(label: 'Pending', status: FlexStatusType.warning),
            FlexStatusBadge(label: 'Failed', status: FlexStatusType.error),
            FlexStatusBadge(label: 'Info', status: FlexStatusType.info),
            FlexStatusBadge(label: 'Draft', status: FlexStatusType.neutral),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FlexChip(label: 'Flutter', onDeleted: () {}),
            FlexChip(label: 'Dart', onDeleted: () {}),
            FlexActionChip(
                label: 'Action Chip', icon: Icons.flash_on, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 7. LOADERS & STATES GALLERY
// ==========================================
class LoadersGalleryPage extends StatelessWidget {
  const LoadersGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const FlexHeading(
          'Loaders & Indicators',
          subtitle: 'Spinners, skeleton loaders, progress bars, and states',
          level: FlexHeadingLevel.h4,
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlexSpinner(size: 24),
            FlexSpinner(size: 36),
            FlexSpinner(size: 48),
          ],
        ),
        const SizedBox(height: 24),
        const FlexLinearProgress(value: 0.65),
        const SizedBox(height: 24),
        const FlexStepIndicator(
          totalSteps: 4,
          currentStep: 2,
        ),
        const SizedBox(height: 24),
        const FlexHeading('Skeletons', level: FlexHeadingLevel.h5),
        const SizedBox(height: 12),
        const Row(
          children: [
            FlexSkeleton.circle(size: 48),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FlexSkeleton(height: 16, width: 140),
                  SizedBox(height: 8),
                  FlexSkeleton(height: 12),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const FlexDivider.withLabel(label: 'EMPTY & ERROR STATES'),
        FlexEmptyState(
          title: 'No Data Yet',
          description: 'Items you create will appear here.',
          actionLabel: 'Create First Item',
          onActionPressed: () {},
        ),
      ],
    );
  }
}

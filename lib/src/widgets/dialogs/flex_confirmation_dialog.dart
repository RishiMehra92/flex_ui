import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../buttons/flex_button.dart';
import 'flex_dialog.dart';

/// Convenience helper to display a preconfigured confirmation dialog.
Future<bool?> showFlexConfirmationDialog({
  required BuildContext context,
  required String title,
  required String message,
  String confirmLabel = 'Confirm',
  String cancelLabel = 'Cancel',
  bool isDestructive = false,
  IconData? icon,
}) {
  return showFlexDialog<bool>(
    context: context,
    child: FlexConfirmationDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      isDestructive: isDestructive,
      icon: icon ??
          (isDestructive
              ? Icons.warning_amber_rounded
              : Icons.help_outline_rounded),
    ),
  );
}

/// A confirmation dialog offering Cancel and Confirm actions.
class FlexConfirmationDialog extends StatelessWidget {
  const FlexConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
    this.icon,
    this.onConfirm,
    this.onCancel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;
  final IconData? icon;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final confirmColor = isDestructive ? colors.error : colors.primary;

    return FlexDialog(
      icon: icon,
      iconColor: isDestructive ? colors.error : colors.primary,
      title: title,
      content: Text(message),
      actions: [
        FlexButton(
          label: cancelLabel,
          variant: FlexButtonVariant.text,
          isFullWidth: false,
          size: FlexButtonSize.small,
          foregroundColor: colors.textSecondary,
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop(false);
          },
        ),
        FlexButton(
          label: confirmLabel,
          variant: FlexButtonVariant.filled,
          backgroundColor: confirmColor,
          isFullWidth: false,
          size: FlexButtonSize.small,
          onPressed: () {
            onConfirm?.call();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

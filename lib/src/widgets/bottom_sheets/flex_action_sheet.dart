import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import 'flex_bottom_sheet.dart';

/// An action item in [FlexActionSheet].
class FlexActionSheetItem {
  const FlexActionSheetItem({
    required this.label,
    required this.onTap,
    this.icon,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isDestructive;
}

/// An iOS/Android-styled action sheet presenting a list of choices.
class FlexActionSheet extends StatelessWidget {
  const FlexActionSheet({
    super.key,
    required this.actions,
    this.title,
    this.message,
    this.cancelLabel = 'Cancel',
    this.onCancel,
  });

  final List<FlexActionSheetItem> actions;
  final String? title;
  final String? message;
  final String cancelLabel;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    return FlexBottomSheet(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null || message != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: theme.typography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.textPrimary,
                      ),
                    ),
                  if (message != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: theme.typography.bodySmall.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Divider(color: colors.divider),
          ],
          ...actions.map((action) {
            final color =
                action.isDestructive ? colors.error : colors.textPrimary;
            return ListTile(
              leading: action.icon != null
                  ? Icon(action.icon, color: color, size: 22)
                  : null,
              title: Text(
                action.label,
                style: theme.typography.bodyLarge.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                action.onTap();
              },
            );
          }),
          Divider(color: colors.divider),
          ListTile(
            title: Text(
              cancelLabel,
              textAlign: TextAlign.center,
              style: theme.typography.bodyLarge.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
          ),
        ],
      ),
    );
  }
}

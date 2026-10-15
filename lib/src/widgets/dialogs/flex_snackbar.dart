import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';

/// Semantic type of SnackBar notification.
enum FlexSnackBarType {
  info,
  success,
  warning,
  error,
}

/// Displays a floating, themed SnackBar with semantic icons and styles.
void showFlexSnackBar({
  required BuildContext context,
  required String message,
  String? title,
  FlexSnackBarType type = FlexSnackBarType.info,
  Duration duration = const Duration(seconds: 4),
  SnackBarAction? action,
}) {
  final theme = FlexUITheme.of(context);
  final colors = theme.colors;

  Color bg;
  Color fg;
  IconData icon;

  switch (type) {
    case FlexSnackBarType.success:
      bg = colors.success;
      fg = Colors.white;
      icon = Icons.check_circle_outline_rounded;
      break;
    case FlexSnackBarType.warning:
      bg = colors.warning;
      fg = Colors.white;
      icon = Icons.warning_amber_rounded;
      break;
    case FlexSnackBarType.error:
      bg = colors.error;
      fg = Colors.white;
      icon = Icons.error_outline_rounded;
      break;
    case FlexSnackBarType.info:
      bg = colors.textPrimary;
      fg = colors.surface;
      icon = Icons.info_outline_rounded;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration,
      backgroundColor: bg,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Row(
        children: [
          Icon(icon, color: fg, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null) ...[
                  Text(
                    title,
                    style: TextStyle(
                      color: fg,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
                Text(
                  message,
                  style: TextStyle(
                    color: fg,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      action: action,
    ),
  );
}

import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../../theme/flex_theme_data.dart';

/// An avatar component supporting image URLs, initials fallback, icons,
/// and an online/presence status indicator.
class FlexAvatar extends StatelessWidget {
  const FlexAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.icon = Icons.person,
    this.size = 40.0,
    this.backgroundColor,
    this.foregroundColor,
    this.isOnline,
    this.onlineIndicatorColor,
    this.borderRadius,
    this.onTap,
  });

  final String? imageUrl;
  final String? name;
  final IconData icon;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool? isOnline;
  final Color? onlineIndicatorColor;
  final double? borderRadius;
  final VoidCallback? onTap;

  String _getInitials(String input) {
    final parts = input.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return '';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final bg = backgroundColor ?? colors.primaryContainer;
    final fg = foregroundColor ?? colors.primary;
    final radius = borderRadius ?? (size / 2);

    Widget avatarContent;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => _buildFallback(theme, fg),
      );
    } else {
      avatarContent = _buildFallback(theme, fg);
    }

    Widget avatar = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: size,
        height: size,
        color: bg,
        child: Center(child: avatarContent),
      ),
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    if (isOnline != null) {
      final dotSize = size * 0.28;
      avatar = Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: isOnline!
                    ? (onlineIndicatorColor ?? colors.success)
                    : colors.disabledText,
                shape: BoxShape.circle,
                border: Border.all(color: colors.surface, width: 2),
              ),
            ),
          ),
        ],
      );
    }

    return avatar;
  }

  Widget _buildFallback(FlexUIThemeData theme, Color fg) {
    if (name != null && name!.trim().isNotEmpty) {
      return Text(
        _getInitials(name!),
        style: TextStyle(
          color: fg,
          fontSize: size * 0.38,
          fontWeight: FontWeight.w700,
        ),
      );
    }
    return Icon(icon, color: fg, size: size * 0.55);
  }
}

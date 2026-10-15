import 'package:flutter/material.dart';
import '../../config/flex_ui_theme.dart';
import '../bottom_sheets/flex_bottom_sheet.dart';
import '../inputs/flex_dropdown_field.dart';
import '../inputs/flex_search_field.dart';

/// A dropdown selector with real-time text search filtering over large option sets.
class FlexSearchableDropdown<T> extends StatelessWidget {
  const FlexSearchableDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    this.label,
    this.hintText = 'Select an item',
    this.searchHintText = 'Search items...',
    this.disabled = false,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.width,
  });

  final List<FlexDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String hintText;
  final String searchHintText;
  final bool disabled;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;

  void _openSearchSheet(BuildContext context) {
    showFlexBottomSheet(
      context: context,
      child: _SearchSheetContent<T>(
        items: items,
        initialValue: value,
        searchHintText: searchHintText,
        onSelected: (val) {
          Navigator.of(context).pop();
          onChanged(val);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final effectiveRadius = borderRadius ?? theme.radius.sm;
    final effectiveBackground = backgroundColor ?? colors.surface;
    final effectiveBorder = borderColor ?? colors.border;

    final selectedItem = items.where((i) => i.value == value).firstOrNull;

    Widget container = InkWell(
      onTap: disabled ? null : () => _openSearchSheet(context),
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: disabled ? colors.disabled : effectiveBackground,
          borderRadius: BorderRadius.circular(effectiveRadius),
          border: Border.all(color: effectiveBorder),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedItem?.label ?? hintText,
                style: theme.typography.bodyMedium.copyWith(
                  color:
                      selectedItem != null ? colors.textPrimary : colors.hint,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: colors.hint),
          ],
        ),
      ),
    );

    if (label != null) {
      container = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.xs),
            child: Text(
              label!,
              style: theme.typography.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: disabled ? colors.disabledText : colors.textPrimary,
              ),
            ),
          ),
          container,
        ],
      );
    }

    if (width != null) {
      container = SizedBox(width: width, child: container);
    }

    return container;
  }
}

class _SearchSheetContent<T> extends StatefulWidget {
  const _SearchSheetContent({
    required this.items,
    required this.initialValue,
    required this.searchHintText,
    required this.onSelected,
  });

  final List<FlexDropdownItem<T>> items;
  final T? initialValue;
  final String searchHintText;
  final ValueChanged<T> onSelected;

  @override
  State<_SearchSheetContent<T>> createState() => _SearchSheetContentState<T>();
}

class _SearchSheetContentState<T> extends State<_SearchSheetContent<T>> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final theme = FlexUITheme.of(context);
    final colors = theme.colors;

    final filtered = widget.items.where((i) {
      return i.label.toLowerCase().contains(_query.toLowerCase().trim());
    }).toList();

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.7,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: FlexSearchField(
              hintText: widget.searchHintText,
              autofocus: true,
              onChanged: (q) => setState(() => _query = q),
            ),
          ),
          Divider(height: 1, color: colors.divider),
          Flexible(
            child: filtered.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      'No matching options',
                      style: theme.typography.bodyMedium.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      final isSelected = item.value == widget.initialValue;

                      return ListTile(
                        leading: item.icon != null
                            ? Icon(item.icon,
                                color: isSelected
                                    ? colors.primary
                                    : colors.textSecondary)
                            : null,
                        title: Text(
                          item.label,
                          style: theme.typography.bodyMedium.copyWith(
                            color: isSelected
                                ? colors.primary
                                : colors.textPrimary,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                        trailing: isSelected
                            ? Icon(Icons.check_rounded, color: colors.primary)
                            : null,
                        onTap: item.enabled
                            ? () => widget.onSelected(item.value)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

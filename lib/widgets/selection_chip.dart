import 'package:flutter/material.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';

class SelectionChip<T> extends StatelessWidget {
  const SelectionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.leading,
    this.selectedColor = AppColors.primary,
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final Widget? leading;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: AppTextStyles.labelLarge.copyWith(
          color: selected ? selectedColor : AppColors.textPrimary,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      avatar: leading,
      selected: selected,
      onSelected: (_) => onSelected(),
      showCheckmark: false,
      selectedColor: selectedColor.withValues(alpha: 0.12),
      backgroundColor: AppColors.surface,
      side: BorderSide(
        color: selected ? selectedColor : AppColors.border,
        width: selected ? 1.5 : 1,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
    );
  }
}

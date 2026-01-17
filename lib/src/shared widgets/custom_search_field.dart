import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// Custom Search Field
/// Search bar with filter button used throughout the app
class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChanged;
  final VoidCallback? onFilterPressed;
  final bool showFilter;
  final VoidCallback? onSubmitted;

  const CustomSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search for your favorite dish...',
    this.onChanged,
    this.onFilterPressed,
    this.showFilter = true,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.secondary,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Search Icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Icon(
              Icons.search_rounded,
              color: AppColors.secondary,
              size: AppSpacing.iconMd,
            ),
          ),

          // Text Field
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textLight,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),

          // Filter Button
          if (showFilter) ...[
            Container(
              width: 1,
              height: 24,
              color: AppColors.border,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            ),
            IconButton(
              onPressed: onFilterPressed,
              icon: Icon(
                Icons.tune_rounded,
                color: AppColors.primary,
                size: AppSpacing.iconMd,
              ),
              padding: const EdgeInsets.all(AppSpacing.sm),
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: AppSpacing.sm),
          ] else
            const SizedBox(width: AppSpacing.sm),
        ],
      ),
    );
  }
}

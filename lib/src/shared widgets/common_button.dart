import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// Custom Button Widget
/// Provides consistent button styling across the app with multiple variants

enum ButtonVariant {
  primary, // Filled with primary color
  secondary, // Outlined with primary color
  text, // Text only, no background
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final bool iconAtEnd;
  final double? width;
  final double? height;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.iconAtEnd = true,
    this.width,
    this.height,
    this.borderRadius = 28,
  });

  /// Factory constructor for primary button
  factory CustomButton.primary({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    bool iconAtEnd = true,
    double? height,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.primary,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      iconAtEnd: iconAtEnd,
      height: height,
    );
  }

  /// Factory constructor for secondary button
  factory CustomButton.secondary({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = false,
    IconData? icon,
    bool iconAtEnd = true,
    double? height,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.secondary,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      iconAtEnd: iconAtEnd,
      height: height,
    );
  }

  /// Factory constructor for text button
  factory CustomButton.text({
    required String text,
    VoidCallback? onPressed,
    bool isLoading = false,
    IconData? icon,
    bool iconAtEnd = true,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.text,
      isLoading: isLoading,
      icon: icon,
      iconAtEnd: iconAtEnd,
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonChild = _buildButtonChild();

    Widget button;
    switch (variant) {
      case ButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.textOnPrimary,
            disabledBackgroundColor: AppColors.textLight,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 2,
          ),
          child: buttonChild,
        );
        break;
      case ButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.secondary, width: 2),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: buttonChild,
        );
        break;
      case ButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
          ),
          child: buttonChild,
        );
        break;
    }

    if (isFullWidth) {
      return SizedBox(
        width: double.infinity,
        height: height ?? 56,
        child: button,
      );
    }

    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height ?? 56,
        child: button,
      );
    }

    return button;
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == ButtonVariant.primary ? Colors.white : AppColors.primary,
          ),
        ),
      );
    }

    if (icon != null) {
      if (iconAtEnd) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: AppTextStyles.button),
            const SizedBox(width: AppSpacing.sm),
            Icon(icon, size: AppSpacing.iconSm),
          ],
        );
      } else {
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: AppSpacing.iconSm),
            const SizedBox(width: AppSpacing.sm),
            Text(text, style: AppTextStyles.button),
          ],
        );
      }
    }

    return Text(text, style: AppTextStyles.button);
  }
}

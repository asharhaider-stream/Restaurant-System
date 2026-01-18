import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/constants.dart';

/// Custom AppBar Widget
/// Provides consistent app bar styling across the app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final double elevation;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? AppColors.textPrimary,
      elevation: elevation,
      centerTitle: centerTitle,

      // Leading
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => context.pop(),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
              ),
            )
          : null,

      // Title
      title: titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: AppTextStyles.h3.copyWith(
                    color: foregroundColor ?? AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null),

      // Actions
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Simple AppBar with just title
class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;

  const SimpleAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: title,
      centerTitle: centerTitle,
      showBackButton: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

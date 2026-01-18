import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant_management_system/src/utils/extensions.dart';
import '../../../../src/shared widgets/cutom_app_bar.dart';
import '../../../../src/utils/constants.dart'; // Adjust path to your constants
// Adjust path to your widgets

class OrdersEmptyView extends StatelessWidget {
  const OrdersEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        title: AppStrings.myOrders,
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🎨 Funny/Sad Illustration Container
              _buildIllustration(),

              const SizedBox(height: AppSpacing.xxl),

              // 📝 Text Content
              Text(
                "No orders yet",
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                "Your delicious order history will appear here once you place your first order. Don't be a sad stickman!",
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppSpacing.xxl),

              // 🚀 Primary Action Button
              _buildOrderButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Background Decorative Glow
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.rectangle,
          ),
        ),
        // Central Graphic
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            boxShadow: const [
              BoxShadow(
                color: AppColors.primary,
                blurRadius: 7,
                offset: Offset(10, 10),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Funny Network Image (Stickman/Sad figure)
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/7465/7465679.png', // A sad empty-plate/stomach-related icon
                height: 120,
                width: 120,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.sentiment_very_dissatisfied,
                  size: 80,
                  color: AppColors.textLight,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Small status indicator dots from your design
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: Colors.tealAccent, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.4),
                        shape: BoxShape.circle),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          // Navigation logic for GoRouter
          // context.push('menu');
          context.showSnackBar("Navigate to Menu");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          elevation: 4,
          shadowColor: AppColors.primary.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.restaurant, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Text(
              "Order Now",
              style: AppTextStyles.button.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

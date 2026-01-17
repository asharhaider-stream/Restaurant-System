import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'pricetag_widget.dart';
import 'rating_wdget.dart';

import 'badge_widget.dart';

/// Food Card Widget
/// Displays food item with image, name, description, rating, price
class FoodCard extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String? imageUrl;
  final bool isHot;
  final bool isNew;
  final VoidCallback onTap;
  final VoidCallback onAddPressed;

  const FoodCard({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    this.imageUrl,
    this.isHot = false,
    this.isNew = false,
    required this.onTap,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Badge
            Stack(
              children: [
                // Food Image
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.radiusLg),
                    ),
                    // TODO: Add actual image when available
                    // image: DecorationImage(
                    //   image: NetworkImage(imageUrl ?? ''),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.fastfood_rounded,
                      size: 60,
                      color: AppColors.textLight,
                    ),
                  ),
                ),

                // Rating Badge (Top Left)
                Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: RatingWidget(rating: rating),
                ),

                // HOT/NEW Badge (Top Right)
                if (isHot || isNew)
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: isHot ? BadgeWidget.hot() : BadgeWidget.newItem(),
                  ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    name,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Description
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppSpacing.sm),

                  // Price and Add Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      PriceTag(price: price),

                      // Add Button
                      GestureDetector(
                        onTap: onAddPressed,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
